--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameTypeClass
local FrameType = require('Frame.FrameType')
---@type FrameObjClass
local FrameObj = require('Object.Frame')

--================
-- Abstract Class
--================

local Frame = Class.new('Frame', FrameObj)
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
function override.new(frame_type, child_instance)
    if not child_instance then
        Log.error(Frame, 'can not create instance of abstract class', 2)
    end
    --print(frame_type)
    --print(frame_type:getName())
    local instance = FrameObj.new(frame_type:getName(), frame_type:isSimple(), child_instance)
    private.newData(instance, frame_type)

    return instance
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
    if priv.x ~= x then
        priv.x = x
        private.updatePos(self)
    end
end

---@param y number
function public:setY(y)
    local priv = private.data[self]
    if priv.y ~= y then
        priv.y = y
        private.updatePos(self)
    end
end

---@param width number
function public:setWidth(width)
    local priv = private.data[self]
    if priv.width ~= width then
        priv.width = width
        BlzFrameSetSize(self:getObj(), priv.width, priv.height)
        private.updatePos(self)
    end
end

---@param height number
function public:setHeight(height)
    local priv = private.data[self]
    if priv.height ~= height then
        priv.height = height
        BlzFrameSetSize(self:getObj(), priv.width, priv.height)
        private.updatePos(self)
    end
end

---@param level number
function public:setLevel(level)
    local priv = private.data[self]
    priv.level = level

    BlzFrameSetLevel(self:getObj(), priv.level)
    for child, _ in pairs(priv.illigal_childrens) do
        child:setLevel(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3)
    end
end

---@param alpha number
function public:setAlpha(alpha)
    local priv = private.data[self]

    priv.alpha = alpha
    BlzFrameSetAlpha(self:getObj(), priv.alpha)

    for child, _ in pairs(priv.illigal_childrens) do
        child:setAlpha(alpha)
    end
end

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]

    priv.visible = flag
    BlzFrameSetVisible(self:getObj(), priv.visible)
    for child, _ in pairs(priv.illigal_childrens) do
        child:setVisible(flag)
    end
end

---@param parent Frame
function public:setParent(parent)
    if not parent then
        Log.error(self, 'got nil.', 2)
    end

    print(self, parent)

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
        BlzFrameSetParent(self:getObj(), parent:getObj())
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
    --print(priv.parent)
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
    return BlzFrameIsVisible(self:getObj())
end

--=========
-- Private
--=========


private.data = setmetatable({}, {__mode = 'k'})

if not IsCompiletime() then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
end

---@param self Frame
function private.updatePos(self)
    private.correctPosition(self)

    local priv = private.data[self]
    if priv.parent then
        --print(priv.parent)
        BlzFrameSetPoint(self:getObj(), FRAMEPOINT_BOTTOMLEFT,
                         priv.parent:getObj(), FRAMEPOINT_BOTTOMLEFT,
                         priv.x, priv.y)
    else
        BlzFrameSetAbsPoint(self:getObj(), FRAMEPOINT_BOTTOMLEFT,
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
    local priv = {
        frame_type = frame_type,

        x = 0,
        y = 0,
        width = frame_type:getWidth(),
        height = frame_type:getHeight(),
        level = 0,
        alpha = 255,
        visible = true,
        parent = nil,
        illigal_childrens = {}
    }
    private.data[self] = priv
end

return static