--=========
-- Include
--=========


local Class = require(Lib.Class)

---@type FrameClass
local Frame = require('Frame.Frame')
---@type SimpleFrame1TypeClass
local SimpleFrame1Type = require('Frame.Type.SimpleFrame1')

--=======
-- Class
--=======

local SimpleFrame1 = Class.new('SimpleFrame1', Frame)
---@class SimpleFrame1 : Frame
local public = SimpleFrame1.public
---@class SimpleFrame1Class : FrameClass
local static = SimpleFrame1.static
---@type SimpleFrame1Class
local override = SimpleFrame1.override
local private = {}

--=========
-- Static
--=========

---@param frame_type SimpleFrame1Type
---@param child_instance SimpleFrame1
---@return SimpleFrame1
function override.new(frame_type, child_instance)
    if not Class.type(frame_type, SimpleFrame1Type) then
        Log.error(SimpleFrame1, '\"frame_type\" must be SimpleFrame1Type', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleFrame1) then
        Log.error(SimpleFrame1, '\"child_instance\" must be SimpleFrame1 or nil', 2)
    end

    local instance = child_instance or Class.allocate(SimpleFrame1)
    instance = Frame.new(frame_type, instance)

    return instance
end

return static