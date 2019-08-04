---@type Utils
local utils = require('utils.utils')

---@alias FrameObject userdata
---@alias OriginFrame userdata

---@class InterfaceFrame
---@field frame_obj FrameObject
local InterfaceFrame = {}
local InterfaceFrame_meta = {__index = InterfaceFrame}

---@alias EventHandle integer

---@type table<EventHandle, InterfaceFrame>
local FrameDB = {}
function FrameDB.add(frame_obj, frame) FrameDB[frame_obj] = frame end
function FrameDB.get(frame_obj) return FrameDB[frame_obj] end
function FrameDB.rm(frame_obj) FrameDB[frame_obj] = nil end

if not is_compiletime then
    local trigger = CreateTrigger()
    local action = function()
            local frame_obj = nil
        end
end

---@param base_name string
---@param parent InterfaceFrame
---@param priority integer
---@param context integer
---@return InterfaceFrame
function InterfaceFrame.new(base_name, parent, priority, context)
    local obj = BlzCreateFrame(base_name, parent.frame_obj, priority, context)
    if type(obj) ~= 'userdata' then
        print('InterfaceFrame: can not create frame')
        print(getErrorPos())
        return nil
    end

    local frame = {
        frame_obj = obj
    }
    setmetatable(frame, InterfaceFrame_meta)
    FrameDB.add(obj, frame)

    return frame
 end

---@param frame_name_or_handle string|OriginFrame
---@param index integer
---@return InterfaceFrame
function InterfaceFrame.get(frame_name_or_handle, index)
    local obj = nil
    if type(frame_name_or_handle) == 'string' then
        obj = BlzGetFrameByName(frame_name_or_handle, index)
    else
        obj = BlzGetOriginFrame(frame_name_or_handle, index)
    end
    if type(obj) ~= 'userdata' then
        print('InterfaceFrame: can not create frame')
        print(getErrorPos())
    end

    local frame = {
        frame_obj = obj
    }
    setmetatable(frame, InterfaceFrame_meta)
    return frame
end

function InterfaceFrame:scale(value)
    BlzFrameSetScale(self.frame_obj, value)
end

function InterfaceFrame:height()
    return BlzFrameGetHeight(self.frame_obj)
end

function InterfaceFrame:width()
    return BlzFrameGetWidth(self.frame_obj)
end

function InterfaceFrame:setSize(width, height)
    BlzFrameSetSize(self.frame_obj, width, height)
end

function InterfaceFrame:clearAllPoints()
    BlzFrameClearAllPoints(self.frame_obj)
end

function InterfaceFrame:setAbsPoint(point, x, y)
    BlzFrameSetAbsPoint(self.frame_obj, point, x, y)
end

function InterfaceFrame:hide()
    BlzFrameSetVisible(self.frame_obj, false)
end

function InterfaceFrame:show()
    BlzFrameSetVisible(self.frame_obj, true)
end

function InterfaceFrame:getParent()
    local obj = BlzFrameGetParent(self.frame_obj) 

    if type(obj) ~= 'userdata' then
        print('InterfaceFrame: can not create frame')
        print(getErrorPos())
    end

    local frame = {
        frame_obj = obj
    }
    setmetatable(frame, InterfaceFrame_meta)
    return frame
end

return InterfaceFrame