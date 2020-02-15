--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')
---@type Backdrop
local Backdrop = require('Frame.Default.Backdrop')
---@type TriggerClass
local Trigger = require('Utils.Trigger')

--=======
-- Class
--=======

local GlueButton = Class.new('GlueButton', Frame)
---@class GlueButton : Frame
local public = GlueButton.public
---@class GlueButtonClass : FrameClass
local static = GlueButton.static
---@type GlueButtonClass
local override = GlueButton.override

local private = {}

--========
-- Static
--========

--- SimpleFrame by default
---@param button_type GlueButtonType
---@param child_instance GlueButton | nil
---@return GlueButton
function override.new(button_type, child_instance)
    local instance = child_instance or Class.allocate(GlueButton)
    instance = Frame.new(button_type, instance)
    private.newData(instance, button_type)

    return instance
end

--========
-- Public
--========

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self GlueButton
---@param button_type GlueButtonType
function private.newData(self, button_type)
    local priv = {
        framehandle_enabled = BlzGetFrameByName(button_type:getEnabledBackdrop():getName(), 0),
        framehandle_pressed = BlzGetFrameByName(button_type:getPressedBackdrop():getName(), 0),
        framehandle_disabled = BlzGetFrameByName(button_type:getDisabledBackdrop():getName(), 0),
        --framehandle_hover = BlzGetFrameByName(button_type:getControlMouseOverName(), 0),
        --framehandle_focus = BlzGetFrameByName(button_type:getControlFocusName(), 0),
    }

    private.data[self] = priv
end

return static