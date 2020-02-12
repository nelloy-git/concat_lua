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

local FrameGlueButton = Class.new('FrameGlueButton', Frame)
---@class FrameGlueButton : Frame
local public = FrameGlueButton.public
---@class FrameGlueButtonClass : FrameClass
local static = FrameGlueButton.static
---@type FrameGlueButtonClass
local override = FrameGlueButton.override

local private = {}

--========
-- Static
--========

--- SimpleFrame by default
---@param button_type GlueButtonType
---@param child_instance FrameGlueButton
---@return FrameGlueButton
function override.new(button_type, child_instance)
    local instance = child_instance or Class.allocate(FrameGlueButton)
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

---@param self FrameGlueButton
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

---@param self FrameGlueButton
function private.freeData(self)
    private[self] = nil
end

return static