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
    return private[self].frame_type:isSimple()
end

---@param x number
function public:setX(x)
    local priv = private[self]
    priv.x = x

    private.updatePos(self)
end

---@param y number
function public:setY(y)
    local priv = private[self]
    priv.y = y

    private.updatePos(self)
end

---@param width number
function public:setWidth(width)
    local priv = private[self]
    priv.width = width

    BlzFrameSetSize(priv.framehandle, priv.width, priv.height)
    private.updatePos(self)
end

---@param height number
function public:setHeight(height)
    local priv = private[self]
    priv.height = height

    BlzFrameSetSize(priv.framehandle, priv.width, priv.height)
    private.updatePos(self)
end

---@param level number
function public:setLevel(level)
    local priv = private[self]
    priv.level = level

    BlzFrameSetLevel(priv.framehandle, priv.level)
    for child, _ in pairs(priv.illigal_childrens) do
        child:setLevel(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3)
    end
end

---@param alpha number
function public:setAlpha(alpha)
    local priv = private[self]

    priv.alpha = alpha
    BlzFrameSetAlpha(priv.framehandle, priv.alpha)

    for child, _ in pairs(priv.illigal_childrens) do
        child:setAlpha(alpha)
    end
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private[self]

    priv.visible = flag
    BlzFrameSetVisible(priv.framehandle, priv.visible)
    for child, _ in pairs(priv.illigal_childrens) do
        child:setVisible(flag)
    end
end

---@param parent Frame
function public:setParent(parent)
    local priv = private[self]
    local old_parent = priv.parent
    priv.parent = parent

    -- Remove from old parent
    private[old_parent].illigal_childrens[self] = nil

    -- Add to new one
    if self:isSimpleframe() ~= parent:isSimpleframe() then
        private[parent].illigal_childrens[self] = true
        self:setVisible(parent:isVisible())
        self:setAlpha(parent:getAlpha())
        self:setLevel(parent:getLevel())
        private.updatePos(self)
    else
        BlzFrameSetParent(priv.framehandle, private[parent].framehandle)
    end
end

---@return number
function public:getX()
    return private[self].x
end

---@return number
function public:getAbsX()
    local priv = private[self]
    if priv.parent then
        return priv.x
    else
        return priv.parent:getAbsX() + priv.x
    end
end

---@return number
function public:getY()
    return private[self].y
end

---@return number
function public:getAbsY()
    local priv = private[self]
    if priv.parent then
        return priv.y
    else
        return priv.parent:getAbsY() + priv.y
    end
end

---@return framehandle
function public:getFramehandle()
    return private[self].framehandle
end

---@return framehandle
function public:getSubFramehandle()
    return private[self].subframehandle
end

---@return Frame | nil
function public:getParent()
    return private[self].parent
end


---@return number
function public:getWidth()
    return private[self].width
end

---@return number
function public:getHeight()
    return private[self].height
end

---@return number
function public:getLevel()
    return private[self].level
end

---@return number
function public:getAlpha()
    return private[self].alpha
end

---@return boolean
function public:isVisible()
    return private[self].visible
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

local fmt = string.format

private.DB = DataBase.new('userdata', Frame)
if not IsCompiletime() then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

---@param self Frame
function private.updatePos(self)
    private.correctPosition(self)

    local priv = private[self]
    if priv.parent then
        BlzFrameSetPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                         priv.parent, FRAMEPOINT_BOTTOMLEFT,
                         priv.x, priv.y)
    else
        BlzFrameSetAbsPoint(priv.framehandle, FRAMEPOINT_BOTTOMLEFT,
                            priv.x, priv.y)
    end
end

private.warn_normal_rect = 'simple frames only can be outside of [0:0.8, 0:0.6] rectangle. Setting x = %.3f, y = %.3f'
---@param self Frame
function private.correctPosition(self)
    local priv = private[self]
    if not priv.frame_type:isSimple() then
        local abs_x = self:getAbsX()
        local abs_y = self:getAbsY()

        if abs_x < 0 then
            priv.x = priv.x - abs_x
            Log(Log.Wrn, self, fmt(private.warn_normal_rect, priv.x, priv.y))
        end
        if (abs_x + priv.width) > 0.8 then
            priv.x = priv.x - (abs_x + priv.width - 0.8)
            Log(Log.Wrn, self, fmt(private.warn_normal_rect, priv.x, priv.y))
        end
        if abs_y < 0 then
            priv.y = priv.y - abs_y
            Log(Log.Wrn, self, fmt(private.warn_normal_rect, priv.x, priv.y))
        end
        if (priv.y + priv.height) > 0.6 then
            priv.y = priv.y - (abs_y + priv.height - 0.6)
            Log(Log.Wrn, self, fmt(private.warn_normal_rect, priv.x, priv.y))
        end
    end
end

---@param self Frame
---@param frame_type FrameType
---@return table
function private.newData(self, frame_type)
    local framehandle
    local subframehandle
    if frame_type:isSimple() then
        framehandle = BlzCreateSimpleFrame(frame_type:getName(), private.game_ui_frame, 0)
        subframehandle = BlzGetFrameByName(frame_type:getSubElementName(), 0)
    else
        framehandle = BlzCreateFrameByType(frame_type:getName(), frame_type:getName(), private.game_ui_frame, '', 0)
    end

    local priv = {
        framehandle = framehandle,
        subframehandle = subframehandle,
        frame_type = frame_type,

        x = 0,
        y = 0,
        width = 0,
        height = 0,
        level = 0,
        alpha = 255,
        visible = true,
        parent = nil,
        illigal_childrens = {}
    }

    private[self] = priv
    private.DB:set(framehandle, self)

    return priv
end

---@param self Frame
function private.freeData(self)
    local priv = private[self]
    BlzDestroyFrame(priv.framehandle)
    private.DB:remove(priv.framehandle)

    private[self] = nil
end

return Frame