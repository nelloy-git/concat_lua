--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')
---@type TriggerClass
local Trigger = require('Utils.Trigger')

--=======
-- Class
--=======

local SimpleButton = Class.new('SimpleButton', Frame)
---@class SimpleButton : Frame
local public = SimpleButton.public
---@class SimpleButtonClass : FrameClass
local static = SimpleButton.static
---@type SimpleButtonClass
local override = SimpleButton.override
local private = {}

--=========
-- Static
--=========

---@param simple_button_type SimpleButtonType
---@param child_instance SimpleButton
---@return SimpleButton
function override.new(simple_button_type, child_instance)
    local instance = child_instance or Class.allocate(SimpleButton)
    instance = Frame.new(simple_button_type, instance)
    private.newData(instance, simple_button_type)

    return instance
end

--========
-- Public
--========

---@param texture string
function public:setTexture(texture)
    local priv = private.data[self]
    priv.texture = texture
    BlzFrameSetTexture(self:getObj(), texture, 0, true)
    BlzFrameSetTexture(priv.texture_frame, texture, 0, true)
end

---@return string
function public:getTexture()
    return private.data[self].texture
end

---@param simple_frame Frame
function public:setTooltip(simple_frame)
    if not simple_frame:isSimpleframe() then
        Log.error(self, 'normal frames can not be tooltip of simple frames.', 2)
    end

    BlzFrameSetTooltip(self:getObj(), simple_frame:getObj())
    BlzFrameSetVisible(simple_frame:getObj(), false)
end

---@param callback Callback
---@return Action | nil
function public:addPressedAction(callback)
    local priv = private.data[self]

    if not priv.trigger then
        priv.trigger = Trigger.new()
        priv.trigger:addFrameEvent(self:getObj(), FRAMEEVENT_CONTROL_CLICK)
    end

    return priv.trigger:addPressedAction(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]
    if not priv.trigger then
        Log.error(self, 'can not remove action from empty trigger.', 2)
    end

    local res = priv.trigger:removeAction(action)
    if priv.trigger:countActions() <= 0 then
        priv.trigger:destroy()
        priv.trigger = nil
    end

    return res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleButton
---@param simple_button_type SimpleButtonType
function private.newData(self, simple_button_type)
    local priv = {
        texture_frame = BlzGetFrameByName(simple_button_type:getTextureFrameName(), 0),
        texture = simple_button_type:getTexture(),

        trigger = nil,
    }
    private.data[self] = priv
end

return static