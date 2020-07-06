--=========
-- Include
--=========


local Class = require(Lib.Class)

---@type FrameClass
local Frame = require('Frame.Frame')
---@type SimpleStatusBar1TypeClass
local SimpleStatusBar1Type = require('Frame.Type.SimpleStatusBar1')

--=======
-- Class
--=======

local SimpleStatusBar1 = Class.new('SimpleStatusBar1', Frame)
---@class SimpleStatusBar1 : Frame
local public = SimpleStatusBar1.public
---@class SimpleStatusBar1Class : FrameClass
local static = SimpleStatusBar1.static
---@type SimpleStatusBar1Class
local override = SimpleStatusBar1.override
local private = {}

--=========
-- Static
--=========

---@param frame_type SimpleStatusBar1
---@param child_instance SimpleStatusBar1 | nil
---@return SimpleStatusBar1
function override.new(frame_type, child_instance)
    if not Class.type(frame_type, SimpleStatusBar1Type) then
        Log.error(SimpleStatusBar1, '\"simple_button_type\" must be SimpleStatusBar1', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleStatusBar1) then
        Log.error(SimpleStatusBar1, '\"child_instance\" must be SimpleStatusBar1 or nil', 2)
    end

    local instance = child_instance or Class.allocate(SimpleStatusBar1)
    instance = Frame.new(frame_type, instance)
    BlzFrameSetMinMaxValue(instance:getObj(), 0, 100)

    return instance
end

--========
-- Public
--========

---@param texture string
function public:setTexture(texture)
    BlzFrameSetTexture(self:getObj(), texture, 0, true)
end

---@param percent number
function public:setPercent(percent)
    BlzFrameSetValue(self:getObj(), percent)
end


return static