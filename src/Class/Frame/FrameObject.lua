--=========
-- Include
--=========

local Frame = require('Class.Frame.FrameObject')

--=======
-- Class
--=======

---@type FrameObjectClass
local FrameObject = newClass('FrameObject', Frame)

---@class FrameObject
local public = FrameObject.public
---@class FrameObjectClass
local static = FrameObject.static
---@type table
local override = FrameObject.override
---@type table(FrameObject, table)
local private = {}

--=========
-- Methods
--=========

---@oaram framehandle FrameType
---@param instance_data table | nil
---@return Frame
function static.new(framehandle, instance_data)
    if not instance_data then
        Log(Log.Err, getClassName(FrameObject), 'can not create instance of abstract class')
        return nil
    end
    local instance = instance_data
    local priv = {
        wc3_frame = framehandle,
        parent = nil,
        x = 0,
        y = 0,
        width,
        height,
        level = 0
    }
    private[instance] = priv
    private.DB:set(framehandle, instance)

    return instance
end

---@param framehandle framehandle
---@return FrameObject
function static.get(framehandle)
    return private.DB:get(framehandle)
end

function public:free()
    local priv = private[self]
    private.DB:remove(priv.wc3_frame)
    BlzDestroyFrame(priv.wc3_frame)

    private[self] = nil
    freeInstanceData(self)
end

---@return framehandle
function public:getWc3Frame()
    return private[self].wc3_frame
end

--- Default update function.
function public:update()
    local priv = private[self]

    if priv.parent then
        BlzFrameSetPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                         priv.parent, FRAMEPOINT_BOTTOMLEFT,
                         priv.x, priv.y)
    else
        BlzFrameSetAbsPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                            priv.x, priv.y)
    end

    BlzFrameSetSize(priv.wc3_frame, priv.width, priv.height)
end

---@param parent Frame
function public:setParent(parent)
    private[self].parent = parent
    self:update()
end

---@return Frame
function public:getParent()
    return private[self].parent
end

---@param x number
function public:setX(x)
    private[self].x = x
    self:update()
end

---@return number
function public:getX()
    return private[self].x
end

---@param y number
function public:setY(y)
    private[self].y = y
    self:update()
end

---@return number
function public:getY()
    return private[self].y
end

---@param width number
function public:setWidth(width)
    private[self].width = width
    self:update()
end

---@return number
function public:getWidth()
    return private[self].width
end

---@param height number
function public:setHeight(height)
    private[self].height = height
    self:update()
end

---@reutrn number
function public:getHeight()
    return private[self].height
end

---@param lvl number
function public:setLevel(lvl)
    private[self].level = lvl
    BlzFrameSetLevel(private[self].wc3_frame, lvl)
end

---@return number
function public:setLevel(lvl)
    return private[self].level
end

return FrameObject