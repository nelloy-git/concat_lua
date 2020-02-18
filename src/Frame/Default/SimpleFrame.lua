--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')
---@type FrameObj
local FrameObj = require('Object.Frame')

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

---@param simple_frame_type SimpleButtonType
---@param child_instance SimpleFrame | nil
---@return SimpleFrame
function override.new(simple_frame_type, child_instance)
    local instance = child_instance or Class.allocate(SimpleFrame)
    instance = Frame.new(simple_frame_type, instance)
    private.newData(instance, simple_frame_type)

    return instance
end

--========
-- Public
--========

---@param texture string
function public:setTexture(texture)
    local priv = private.data[self]
    priv.texture = texture
    BlzFrameSetTexture(priv.texture_frame, texture, 0, true)
end

---@return string
function public:getTexture()
    return private.data[self].texture
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleFrame
---@param simple_frame_type SimpleButtonType
function private.newData(self, simple_frame_type)
    local priv = {
        texture_frame = BlzGetFrameByName(simple_frame_type:getTextureFrameName(), 0),
        texture = simple_frame_type:getTexture(),
    }
    private.data[self] = priv
end

return static