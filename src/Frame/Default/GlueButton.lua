--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameClass
local Frame = require('Frame.Frame')
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

---@alias GlueButtonActionTypeEnum number

---@type table<string, GlueButtonActionTypeEnum>
static.ActionType = {}
---@type GlueButtonActionTypeEnum
static.ActionType.Press = 1
---@type GlueButtonActionTypeEnum
static.ActionType.MouseEnter = 2
---@type GlueButtonActionTypeEnum
static.ActionType.MouseLeave = 3
---@type GlueButtonActionTypeEnum
static.ActionType.MouseDown = 4
---@type GlueButtonActionTypeEnum
static.ActionType.MouseUp = 5
---@type GlueButtonActionTypeEnum
static.ActionType.MouseWheel = 6

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

---@param simple_frame Frame
function public:setTooltip(simple_frame)
    if simple_frame:isSimpleframe() then
        Log.error(self, 'simple frames can not be tooltip of normal frames.', 2)
    end

    BlzFrameSetTooltip(self:getObj(), simple_frame:getObj())
end

---@param action_type GlueButtonActionTypeEnum
---@param callback Callback
---@return Action
function public:addAction(action_type, callback)
    local priv = private.data[self]

    if not private.isActionType(action_type) then
        Log.error(self, 'unknown GlueButtonAction.', 2)
    end

    if not priv.trigger[action_type] then
        priv.trigger[action_type] = Trigger.new()
        priv.trigger[action_type]:addFrameEvent(self:getObj(), private.ActionEvent[action_type])
    end

    return priv.trigger[action_type]:addAction(callback)
end

---@param action_type GlueButtonActionTypeEnum
---@param action Action
---@return boolean
function public:removeAction(action_type, action)
    local priv = private.data[self]
    if not priv.trigger[action_type] then
        Log.error(self, 'can not remove action from empty trigger.', 2)
    end

    local res = priv.trigger[action_type]:removeAction(action)
    if priv.trigger[action_type]:countActions() <= 0 then
        priv.trigger[action_type]:destroy()
        priv.trigger[action_type] = nil
    end

    return res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.ActionEvent = {
    [static.ActionType.Press] = FRAMEEVENT_CONTROL_CLICK,
    [static.ActionType.MouseEnter] = FRAMEEVENT_MOUSE_ENTER,
    [static.ActionType.MouseLeave] = FRAMEEVENT_MOUSE_LEAVE,
    [static.ActionType.MouseDown] = FRAMEEVENT_MOUSE_DOWN,
    [static.ActionType.MouseUp] = FRAMEEVENT_MOUSE_UP,
    [static.ActionType.MouseWheel] = FRAMEEVENT_MOUSE_WHEEL,
}

function private.mouseDownCallback()
    for _, priv in pairs(private.data) do
        priv.got_mouse_down = not (not priv.framehandle.hover or not BlzFrameIsVisible(priv.framehandle.hover))
    end
end

function private.mouseUpCallback()
    for _, priv in pairs(private.data) do
        if priv.got_mouse_down and priv.trigger[static.ActionType.Press] then
            priv.trigger[static.ActionType.Press]:execute()
        end
        priv.got_mouse_down = false
    end
end

if not IsCompiletime() then
    private.trigger_mouse_down = Trigger.new()
    private.trigger_mouse_up = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        private.trigger_mouse_down:addPlayerEvent(EVENT_PLAYER_MOUSE_DOWN, Player(i))
        private.trigger_mouse_up:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, Player(i))
    end
    private.trigger_mouse_down:addAction(private.mouseDownCallback)
    private.trigger_mouse_up:addAction(private.mouseUpCallback)
end

---@param action_type any
---@return boolean
function private.isActionType(action_type)
    for _, t in pairs(static.ActionType) do
        if action_type == t then
            return true
        end
    end
    return false
end

---@param self GlueButton
---@param button_type GlueButtonType
function private.newData(self, button_type)
    local priv = {}

    priv.framehandle = {}
    priv.texture = {}
    if button_type:getEnabledBackdrop() then
        priv.framehandle.enabled = BlzGetFrameByName(button_type:getEnabledBackdrop():getName(), 0)
        priv.texture.enabled = button_type:getEnabledBackdrop():getBackground()
    end
    if button_type:getPressedBackdrop() then
        priv.framehandle.pressed = BlzGetFrameByName(button_type:getPressedBackdrop():getName(), 0)
        priv.texture.pressed = button_type:getPressedBackdrop():getBackground()
    end
    if button_type:getDisabledBackdrop() then
        priv.framehandle.disabled = BlzGetFrameByName(button_type:getDisabledBackdrop():getName(), 0)
        priv.texture.disabled = button_type:getDisabledBackdrop():getBackground()
    end
    if button_type:getHoverHighlight() then
        priv.framehandle.hover = BlzGetFrameByName(button_type:getHoverHighlight():getName(), 0)
        priv.texture.hover = button_type:getHoverHighlight():getTexture()
    end
    if button_type:getFocusedHighlight() then
        priv.framehandle.focus = BlzGetFrameByName(button_type:getFocusedHighlight():getName(), 0)
        priv.texture.focus = button_type:getFocusedHighlight():getTexture()
    end

    priv.trigger = {}
    priv.got_mouse_down = false

    private.data[self] = priv
end

return static