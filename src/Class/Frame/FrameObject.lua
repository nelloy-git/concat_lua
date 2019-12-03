--=========
-- Include
--=========

---@type DataBase
local DataBase = require('Class.DataBase')
---@type Frame
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

private.DB = DataBase.new('userdata', getClassName(FrameObject))

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

    if self:getParent() then
        BlzFrameSetPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                         self:getParent(), FRAMEPOINT_BOTTOMLEFT,
                         self:getX(), self:getY())
    else
        BlzFrameSetAbsPoint(priv.wc3_frame, FRAMEPOINT_BOTTOMLEFT,
                            self:getX(), self:getY())
    end

    BlzFrameSetSize(priv.wc3_frame, self:getWidth(), self:getHeight())
    BlzFrameSetLevel(priv.wc3_frame, self:getLevel())
end

return FrameObject