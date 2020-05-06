--=========
-- Include
--=========


local Class = require('Utils.Class.API')

---@type FrameClass
local Frame = require('Frame.Frame')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')

--=======
-- Class
--=======

local SimpleFrame = Class.new('SimpleFrame', Frame)
---@class SimpleFrame : Frame
local public = SimpleFrame.public
---@class SimpleFrameClass : FrameClass
local static = SimpleFrame.static
---@type SimpleFrameClass
local override = SimpleFrame.override
local private = {}

--=========
-- Static
--=========

---@param frame_type SimpleFrameType
---@param child_instance SimpleFrame
---@return SimpleFrame
function override.new(frame_type, child_instance)
    if not Class.type(frame_type, SimpleFrameType) then
        Log.error(SimpleFrame, '\"frame_type\" must be SimpleFrameType', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleFrame) then
        Log.error(SimpleFrame, '\"child_instance\" must be SimpleFrame or nil', 2)
    end

    local instance = child_instance or Class.allocate(SimpleFrame)
    instance = Frame.new(frame_type, instance)

    return instance
end

return static