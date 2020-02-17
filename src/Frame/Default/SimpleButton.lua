--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type Action
local Action = require('Utils.Action')
---@type Import
local Import = require('Resources.Import')
---@type FrameClass
local Frame = require('Frame.Frame')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleFrameClass
local SimpleFrame = require('Frame.Default.SimpleFrame')
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

---@alias SimpleMouseButtonCallback fun(instance:SimpleButton, player:player, button:mousebuttontype)
---@alias SimpleButtonActionTypeEnum number

---@type table<string, SimpleButtonActionTypeEnum>
static.ActionType = {}
---@type SimpleButtonActionTypeEnum
static.ActionType.MousePress = 1
---@type SimpleButtonActionTypeEnum
static.ActionType.MouseDown = 2
---@type SimpleButtonActionTypeEnum
static.ActionType.MouseUp = 3

---@param simple_button_type SimpleButtonType
---@param child_instance SimpleButton | nil
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
function public:addAction(action_type, callback)
    local priv = private.data[self]
    local action = Action.new(callback, self)
    table.insert(priv.actions[action_type], action)

    return action
end

---@param action Action
---@return boolean
function public:removeAction(action_type, action)
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

private.invisible_simpleframe_type = SimpleFrameType.new('SimpleButtonMouseDetector', true)
private.invisible_simpleframe_type:setWidth(0.01)
private.invisible_simpleframe_type:setHeight(0.01)
private.invisible_simpleframe_type:setTexture(Import.TransparentTexture)

function private.mouseDownCallback()
    local player = GetTriggerPlayer()
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for instance, priv in pairs(private.data) do
        if BlzFrameIsVisible(priv.detector:getObj()) then
            local actions = priv.actions[static.ActionType.MouseDown]
            for i = 1, #actions do
                actions[i]:run(instance, player, mouse_btn)
            end

            priv.got_left_mouse_btn = is_left
            priv.got_right_mouse_btn = is_right
        end
    end
end

function private.mouseUpCallback()
    local player = GetTriggerPlayer()
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for instance, priv in pairs(private.data) do
        print(BlzFrameIsVisible(priv.detector:getObj()))
        if BlzFrameIsVisible(priv.detector:getObj()) then
            local actions = priv.actions[static.ActionType.MouseDown]
            for i = 1, #actions do
                actions[i]:run(instance, player, mouse_btn)
            end

            print(#priv.got_left_mouse_btn, is_left, priv.got_right_mouse_btn, is_right)
            if (priv.got_left_mouse_btn and is_left) or (priv.got_right_mouse_btn and is_right) then
                actions = priv.actions[static.ActionType.MousePress]
                for i = 1, #actions do
                    actions[i]:run(instance, player, mouse_btn)
                end
            end
        end

        priv.got_left_mouse_btn = not is_left
        priv.got_right_mouse_btn = not is_right
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

---@param self SimpleButton
---@param simple_button_type SimpleButtonType
function private.newData(self, simple_button_type)
    local priv = {
        texture_frame = BlzGetFrameByName(simple_button_type:getTextureFrameName(), 0),
        detector = SimpleFrame.new(private.invisible_simpleframe_type),
        texture = simple_button_type:getTexture(),

        actions = {},
        got_left_mouse_btn = false,
        got_right_mouse_btn = false,
    }
    private.data[self] = priv

    self:setTooltip(priv.detector)

    for _, action_type in pairs(static.ActionType) do
        priv.actions[action_type] = {}
    end
end

return static