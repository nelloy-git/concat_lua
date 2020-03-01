--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')
local fmt = string.format

---@type Action
local Action = require('Utils.Action')
---@type FrameClass
local Frame = require('Frame.Frame')
local FramePublic = Class.getPublic(Frame)
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleButtonTypeClass
local SimpleButtonType = require('Frame.Type.SimpleButton')
---@type SimpleTextureTypeClass
local SimpleTextureType = require('Frame.Type.SimpleTexture')
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

---@param frame_type SimpleButtonType
---@param child_instance SimpleButton | nil
---@return SimpleButton
function override.new(frame_type, child_instance)
    if not Class.type(frame_type, SimpleButtonType) then
        Log.error(SimpleButton, '\"frame_type\" must be SimpleButtonType', 2)
    end

    if child_instance and not Class.type(child_instance, SimpleButton) then
        Log.error(SimpleButton, '\"child_instance\" must be SimpleButton or nil', 2)
    end

    local instance = child_instance or Class.allocate(SimpleButton)
    instance = Frame.new(frame_type, instance)
    private.newData(instance, frame_type)

    return instance
end

--========
-- Public
--========

---@param flag boolean
function public:setVisible(flag)
    local priv = private.data[self]

    if flag and priv.active then
        private.active[self] = priv
    else
        private.active[self] = nil
    end
    FramePublic.setVisible(self, flag)
end

---@param frame Frame
function public:setTooltip(frame)
    local priv = private.data[self]

    if priv.detector:getType() == private.detector_type then
        priv.detector:destroy()
    end

    if not frame then
        frame = SimpleFrameType.new(private.detector_type)
        frame:setParent(self)
    end

    frame:setVisible(false)
    BlzFrameSetVisible(frame:getObj(), false)
    priv.detector = frame
end

function public:enableActions(flag)
    local priv = private.data[self]
    priv.active = flag

    if self:isVisible() and priv.active then
        private.active[self] = priv
    else
        private.active[self] = nil
    end
end

---@param action_type SimpleButtonActionTypeEnum
---@param callback Callback
---@return Action | nil
function public:addAction(action_type, callback)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.actions[action_type], action)

    return action
end

---@param action_type SimpleButtonActionTypeEnum
---@param action Action
---@return boolean
function public:removeAction(action_type, action)
    local priv = private.data[self]

    local actions = priv.actions[action_type]
    for i = 1, #actions do
        if actions[i] == action then
            table.remove(actions, i)
            return true
        end
    end
    return false
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.active = setmetatable({}, {__mode = 'k'})

private.detector_type = SimpleFrameType.new('SimpleButtonMouseDetector', true)

function private.mouseDownCallback()
    local player = GetTriggerPlayer()
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for instance, priv in pairs(private.active) do
        if priv.detector:isVisible() then
            local actions = priv.actions[static.ActionType.MouseDown]
            for i = 1, #actions do
                actions[i]:run(instance, player, mouse_btn)
            end

            priv.got_left_mouse_btn = priv.got_left_mouse_btn or is_left
            priv.got_right_mouse_btn = priv.got_right_mouse_btn or is_right
        end
    end
end

function private.mouseUpCallback()
    local player = GetTriggerPlayer()
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for instance, priv in pairs(private.active) do
        if priv.detector:isVisible() then
            local actions = priv.actions[static.ActionType.MouseUp]
            for i = 1, #actions do
                actions[i]:run(instance, player, mouse_btn)
            end

            if (priv.got_left_mouse_btn and is_left) or (priv.got_right_mouse_btn and is_right) then
                actions = priv.actions[static.ActionType.MousePress]
                for i = 1, #actions do
                    actions[i]:run(instance, player, mouse_btn)
                end
            end
        end

        priv.got_left_mouse_btn = not is_left and priv.got_left_mouse_btn
        priv.got_right_mouse_btn = not is_right and priv.got_right_mouse_btn
    end
end

---@param self SimpleButton
function private.newData(self)
    local priv = {
        detector = Frame.new(private.detector_type),

        active = true,
        actions = {},

        got_left_mouse_btn = false,
        got_right_mouse_btn = false,
    }
    for _, action_type in pairs(static.ActionType) do
        priv.actions[action_type] = {}
    end
    private.data[self] = priv
    private.active[self] = priv

    --priv.detector:setParent(self)
    priv.detector:setPoint(FRAMEPOINT_CENTER, FRAMEPOINT_CENTER, 0.2, 0.2)
    priv.detector:setVisible(false)
    BlzFrameSetTooltip(self:getObj(), priv.detector:getObj())
end

if not IsCompiletime() then
    private.local_player = GetLocalPlayer()

    private.trigger_mouse_down = Trigger.new()
    private.trigger_mouse_up = Trigger.new()
    private.trigger_mouse_down:addPlayerEvent(EVENT_PLAYER_MOUSE_DOWN, private.local_player)
    private.trigger_mouse_up:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, private.local_player)
    private.trigger_mouse_down:addAction(private.mouseDownCallback)
    private.trigger_mouse_up:addAction(private.mouseUpCallback)
end

return static