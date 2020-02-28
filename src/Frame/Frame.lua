--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type FrameObjClass
local FrameObj = require('Object.Frame')
---@type FrameType
local FrameType = require('Frame.Type')

--=======
-- Class
--=======

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
---@param child_instance Frame | nil
---@return Frame
function override.new(frame_type, child_instance)
    if not Class.type(frame_type, FrameType) then
        Log.error(Frame, '\"frame_type\" must be FrameType.', 2)
    end

    if child_instance and not Class.type(child_instance, Frame) then
        Log.error(Frame, '\"child_instance\" must be Frame', 2)
    end

    local instance = child_instance or Class.allocate(Frame)
    instance = FrameObj.new(frame_type:getName(), true, instance)
    private.newData(instance, frame_type)

    return instance
end

--========
-- Public
--========

--- Virtual function
function public:update()
end

---@param point framepointtype
---@param parent_point framepointtype
---@param x number
---@param y number
function public:setPoint(point, parent_point, x, y)
    local priv = private.data[self]

    if priv.point ~= point or priv.parent_point ~= parent_point or priv.x ~= x or priv.y ~= y then
        priv.point = point
        priv.parent_point = parent_point
        priv.x = x
        priv.y = y

        if priv.parent then
            BlzFrameSetPoint(self:getObj(), point,
                             priv.parent:getObj(), parent_point,
                             x, y)
        else
            BlzFrameSetAbsPoint(self:getObj(), point,
                                x, y)
        end

        self:update()
    end
end

---@param width number
---@param height number
function public:setSize(width, height)
    priv = private.data[self]

    if priv.width ~= width or priv.height ~= height then
        priv.width = width
        priv.height = height

        BlzFrameSetSize(self:getObj(), priv.width, priv.height)
        self:update()
    end
end

function public:setParent(parent)
    local priv = private.data[self]

    if priv.parent ~= parent then
        priv.parent = parent

        if priv.parent then
            BlzFrameSetPoint(self:getObj(), priv.point,
                             priv.parent:getObj(), priv.parent_point,
                             priv.x, priv.y)
        else
            BlzFrameSetParent(self:getObj(), private.game_ui_frame)
            BlzFrameSetAbsPoint(self:getObj(), priv.point,
                                priv.x, priv.y)
        end

        self:update()
    end
end

---@param level number
function public:setLevel(level)
    private.data[self].level = level
    BlzFrameSetLevel(self:getObj(), level)
end

---@param alpha number
function public:setAlpha(alpha)
    private.data[self].alpha = alpha
    BlzFrameSetAlpha(self:getObj(), alpha)
end

---@param flag boolean
function public:setVisible(flag)
    BlzFrameSetVisible(self:getObj(), flag)
end

---@return FrameType
function public:getType()
    return private.data[self].frame_type
end

---@return number
function public:getX()
    return private.data[self].x
end

---@return number
function public:getAbsX()
    local priv = private.data[self]

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
        parent = nil,
    }
    private.data[self] = priv

    BlzFrameSetLevel(self:getObj(), 0)
end

return static