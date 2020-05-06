--=========
-- Include
--=========


local Class = require('Utils.Class.API')

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

        BlzFrameClearAllPoints(self:getObj())
        if priv.parent then
            BlzFrameSetPoint(self:getObj(), point,
                             priv.parent:getObj(), parent_point,
                             x, y)
        else
            BlzFrameSetAbsPoint(self:getObj(), point,
                                private.abs_point_x[parent_point] + x,
                                private.abs_point_y[parent_point] + y)
        end
    end
end

function public:setAllPoints()
    local priv = private.data[self]
    BlzFrameClearAllPoints(self:getObj())
    if priv.parent then
        BlzFrameSetAllPoints(self:getObj(), private.data[self].parent:getObj())
    else
        BlzFrameSetAllPoints(self:getObj(), private.game_ui_frame)
    end
end

---@param width number
---@param height number
function public:setSize(width, height)
    if type(width) ~= 'number' then
        Log.error(self, '\"width\" must be a number', 2)
    end
    if type(height) ~= 'number' then
        Log.error(self, '\"height\" must be a number', 2)
    end

    local priv = private.data[self]

    if priv.width ~= width or priv.height ~= height then
        priv.width = width
        priv.height = height

        BlzFrameSetSize(self:getObj(), width, height)
    end
end

function public:setParent(parent)
    local priv = private.data[self]

    if priv.parent ~= parent then
        priv.parent = parent

        BlzFrameSetParent(self:getObj(), parent and parent:getObj())
        self:setLevel(parent and parent:getLevel() or 0)
        self:setPoint(priv.point, priv.parent_point, priv.x, priv.y)
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

    private.abs_point_x = {
        [FRAMEPOINT_TOPLEFT] = 0,
        [FRAMEPOINT_TOP] = 0.4,
        [FRAMEPOINT_TOPRIGHT] = 0.8,
        [FRAMEPOINT_LEFT] = 0,
        [FRAMEPOINT_CENTER] = 0.4,
        [FRAMEPOINT_RIGHT] = 0.8,
        [FRAMEPOINT_BOTTOMLEFT] = 0,
        [FRAMEPOINT_BOTTOM] = 0.4,
        [FRAMEPOINT_BOTTOMRIGHT] = 0.8,
    }

    private.abs_point_y = {
        [FRAMEPOINT_TOPLEFT] = 0.6,
        [FRAMEPOINT_TOP] = 0.6,
        [FRAMEPOINT_TOPRIGHT] = 0.6,
        [FRAMEPOINT_LEFT] = 0.3,
        [FRAMEPOINT_CENTER] = 0.3,
        [FRAMEPOINT_RIGHT] = 0.3,
        [FRAMEPOINT_BOTTOMLEFT] = 0,
        [FRAMEPOINT_BOTTOM] = 0,
        [FRAMEPOINT_BOTTOMRIGHT] = 0,
    }
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