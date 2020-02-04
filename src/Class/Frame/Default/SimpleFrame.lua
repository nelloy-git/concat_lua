--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

---@type FrameClass
local Frame = require('Class.Frame.Frame')
---@type TriggerClass
local Trigger = require('Class.Trigger')

--=======
-- Class
--=======

local FrameSimpleFrame = Class.new('FrameSimpleFrame', Frame)
---@class FrameSimpleFrame : Frame
local public = FrameSimpleFrame.public
---@class FrameSimpleFrameClass : FrameClass
local static = FrameSimpleFrame.static
---@type FrameSimpleFrameClass
local override = FrameSimpleFrame.override
local private = {}

--=========
-- Static
--=========

---@param simple_frame_type SimpleButtonType
---@param child_instance FrameSimpleFrame
---@return FrameSimpleFrame
function override.new(simple_frame_type, child_instance)
    local instance = child_instance or Class.allocate(FrameSimpleFrame)
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
    BlzFrameSetTexture(priv.texture_framehandle, texture, 0, true)
end

---@return string
function public:getTexture()
    return private.data[self].texture
end

---@param simple_frame Frame
function public:setTooltip(simple_frame)
    if not simple_frame:isSimpleFrame() then
        Log.error(self, 'normal frames can not be tooltip of simple frames.', 2)
    end

    BlzFrameSetVisible(simple_frame:getFramehandle(), false)
    BlzFrameSetTooltip(self:getFramehandle(), simple_frame:getFramehandle())
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FrameSimpleFrame
---@param simple_frame_type SimpleButtonType
function private.newData(self, simple_frame_type)
    local priv = {
        texture_framehandle = BlzGetFrameByName(simple_frame_type:getTextureName(), 0),
        texture = simple_frame_type:getDefaultTexture(),
    }
    private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(priv) end
}

return static