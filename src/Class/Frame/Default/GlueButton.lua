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
---@param child_instance GlueButton
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

function public:setTexture(texture)
    local priv = private[self]
    priv.textures.enabled = texture
    BlzFrameSetTexture(priv.framehandles.backdrop_enabled, texture, 0, true)
end

function public:setPushedTexture(texture)
    local priv = private[self]
    priv.textures.pushed = texture
    BlzFrameSetTexture(priv.framehandles.backdrop_pushed, texture, 0, true)
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

---@param self GlueButton
---@param button_type FrameType
---@return table
function private.newData(self, button_type)
    local priv = {
        framehandles = {
            backdrop_enabled = BlzGetFrameByName(button_type:getControlName(), 0),
            backdrop_disabled = BlzGetFrameByName(button_type:getControlDisabledName(), 0),
            backdrop_pushed = BlzGetFrameByName(button_type:getControlPushedName(), 0),
            backdrop_disabled_pushed = BlzGetFrameByName(button_type:getControlDisabledPushedName(), 0),
            highlight_mouse_over = BlzGetFrameByName(button_type:getControlMouseOverName(), 0),
            highlight_focus = BlzGetFrameByName(button_type:getControlFocusName(), 0),
        },

        textures = {
            enabled = '',
            disabled = '',
            pushed = '',
            disabled_pushed = '',
            mouse_over = '',
            focus = '',
        }
    }

    private[self] = priv
    return priv
end

---@param self GlueButton
function private.freeData(self)
    private[self] = nil
end

return static