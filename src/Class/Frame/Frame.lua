--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type FrameTypeClass
local FrameType = require('Class.Frame.FrameType')

--================
-- Abstract Class
--================

local Frame = Class.new('Frame')
---@class Frame
local public = Frame.public
---@class FrameClass
local static = Frame.static
local override = Frame.override
local private = {}

--========
-- Static
--========

---@param frame_type FrameType
---@param child_instance Frame
---@return Frame
function static.new(frame_type, child_instance)
    if not child_instance then
        Log.error(Frame, 'can not create instance of abstract class', 2)
    end
    local instance = child_instance
    private.newData(instance, frame_type)

    return instance
end

---@param framehandle framehandle
---@return Frame
function static.get(framehandle)
    return private.DB:get(framehandle)
end

--========
-- Public
--========

---@return boolean
function public:isSimpleframe()
    return private.data[self].frame_type:isSimple()
end

---@param x number
function public:setX(x)
    local priv = private.data[self]
    priv.x = x

    private.updatePos(self)
end

---@param y number
function public:setY(y)
    local priv = private.data[self]
    priv.y = y

    private.updatePos(self)
end

---@param width number
function public:setWidth(width)
    local priv = private.data[self]
    priv.width = width

    BlzFrameSetSize(priv.framehandle, priv.width, priv.height)
    private.updatePos(self)
end

---@param height number
function public:setHeight(height)
    local priv = private.data[self]
    priv.height = height

    BlzFrameSetSize(priv.framehandle, priv.width, priv.height)
    private.updatePos(self)
end

---@param level number
function public:setLevel(level)
    local priv = private.data[self]
    priv.level = level

    BlzFrameSetLevel(priv.framehandle, priv.level)
    for child, _ in pairs(priv.illigal_childrens) do
        child:setLevel(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3)
    end
end

---@param alpha number
function public:setAlpha(alpha)
    local priv = private.data[self]

    priv.alpha = alpha
    BlzFrameSetAlpha(priv.framehandle, priv.alpha)

    for child, _ in pairs(priv.illigal_childrens) do
        child:setAlpha(alpha)
    end
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]

    priv.visible = flag
    BlzFrameSetVisible(priv.framehandle, priv.visible)
    for child, _ in pairs(priv.illigal_childrens) do
        child:setVisible(flag)
    end
end

---@param parent Frame
function public:setParent(parent)
    local priv = private.data[self]
    local old_parent = priv.parent
    priv.parent = parent

    -- Remove from old parent
    if old_parent then
        private[old_parent].illigal_childrens[self] = nil
    end

    -- Add to new one
    if self:isSimpleframe() ~= parent:isSimpleframe() then
        private[parent].illigal_childrens[self] = true
        self:setVisible(parent:isVisible())
        self:setAlpha(parent:getAlpha())
        self:setLevel(parent:getLevel())
    else
        BlzFrameSetParent(priv.framehandle, private[parent].framehandle)
    end
    private.updatePos(self)
end

---@return number
function public:getX()
    return private.data[self].x
end

---@return number
function public:getAbsX()
    local priv = private.data[self]
    print(priv.parent)
    if priv.parent then
        return priv.parent:getAbsX() + priv.x
    else
        return priv.x
    end
end

---@return number
function public:getY()
    return private.data[self].y
end

---@return number
function public:getAbsY()
    local priv = private.data[self]
    if priv.parent then
        return priv.parent:getAbsY() + priv.y
    else
        return priv.y
    end
end

---@return framehandle
function public:getFramehandle()
    return private.data[self].framehandle
end

---@return Frame | nil
function public:getParent()
    return private.data[self].parent
end

---@return number
function public:getWidth()
    return private.data[self].width
end

---@return number
function public:getHeight()
    return private.data[self].height
end

---@return number
function public:getLevel()
    return private.data[self].level
end

---@return number
function public:getAlpha()
    return private.data[self].alpha
end

---@return boolean
function public:isVisible()
    return private.data[self].visible
end

--=========
-- Private
--=========


private.data = setmetatable({}, {__mode = 'k'})
private.DB = DataBase.new('userdata', Frame)
if not IsCompiletime() then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

---@param self Frame
function private.updatePos(self)
    private.correctPosition(self)

    local priv = private.data[self]
    if priv.parent then
        BlzFrameSetPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                         priv.parent:getFramehandle(), FRAMEPOINT_BOTTOMLEFT,
                         priv.x, priv.y)
    else
        BlzFrameSetAbsPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                            priv.x, priv.y)
    end
end

local fmt = string.format
local warn_normal_rect = 'simple frames only can be outside of [0:0.8, 0:0.6] rectangle. Setting x = %.3f, y = %.3f'
---@param self Frame
function private.correctPosition(self)
    local priv = private.data[self]
    if not priv.frame_type:isSimple() then
        local abs_x = self:getAbsX()
        local abs_y = self:getAbsY()

        if abs_x < 0 then
            priv.x = priv.x - abs_x
            Log(Log.Wrn, self, fmt(warn_normal_rect, priv.x, priv.y))
        end
        if (abs_x + priv.width) > 0.8 then
            priv.x = priv.x - (abs_x + priv.width - 0.8)
            Log(Log.Wrn, self, fmt(warn_normal_rect, priv.x, priv.y))
        end
        if abs_y < 0 then
            priv.y = priv.y - abs_y
            Log(Log.Wrn, self, fmt(warn_normal_rect, priv.x, priv.y))
        end
        if (priv.y + priv.height) > 0.6 then
            priv.y = priv.y - (abs_y + priv.height - 0.6)
            Log(Log.Wrn, self, fmt(warn_normal_rect, priv.x, priv.y))
        end
    end
end

---@param self Frame
---@param frame_type FrameType
---@return table
function private.newData(self, frame_type)
    local framehandle
    if frame_type:isSimple() then
        framehandle = BlzCreateSimpleFrame(frame_type:getName(), private.game_ui_frame, 0)
    else
        framehandle = BlzCreateFrame(frame_type:getName(), private.game_ui_frame, 0, 0)
    end

    local priv = {
        framehandle = framehandle,
        frame_type = frame_type,

        x = 0,
        y = 0,
        width = frame_type:getDefaultWidth(),
        height = frame_type:getDefaultHeight(),
        level = 0,
        alpha = 255,
        visible = true,
        parent = nil,
        illigal_childrens = {}
    }

    private.data[self] = setmetatable(priv, private.metatable)
    private.DB:set(framehandle, self)
end

private.metatable = {
    __gc = function(priv)
        BlzDestroyFrame(priv.framehandle)
    end
}

return static