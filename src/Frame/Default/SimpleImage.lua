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
---@type TriggerClass
local Trigger = require('Utils.Trigger')

--=======
-- Class
--=======

local SimpleImage = Class.new('SimpleImage', Frame)
---@class SimpleFrame : Frame
local public = SimpleImage.public
---@class SimpleFrameClass : FrameClass
local static = SimpleImage.static
---@type SimpleFrameClass
local override = SimpleImage.override
local private = {}

--=========
-- Static
--=========

---@param frame_type SimpleFrameType
---@param child_instance SimpleFrame | nil
---@return SimpleFrame
function override.new(frame_type, child_instance)
    if not Class.type(frame_type, SimpleFrameType) then
        Log.error(SimpleImage, fmt('\"simple_button_type\" must be %s', tostring(SimpleFrameType)), 2)
    end

    if child_instance and not Class.type(child_instance, SimpleImage) then
        Log.error(SimpleImage, fmt('\"child_instance\" must be %s or nil', tostring(SimpleImage)), 2)
    end

    local instance = child_instance or Class.allocate(SimpleImage)
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

    if flag then
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

    priv.detector = frame
    FramePublic.setTooltip(self, frame)
end

---@param action_type SimpleFrameActionTypeEnum
---@param callback Callback
---@return Action | nil
function public:addAction(action_type, callback)
    local priv = private.data[self]

    local action = Action.new(callback, self)
    table.insert(priv.actions[action_type], action)

    return action
end

---@param action_type SimpleFrameActionTypeEnum
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

private.detector_type = SimpleFrameType.new('ButtonMouseDetector', true)
private.detector_type:setWidth(0.0001)
private.detector_type:setHeight(0.0001)

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
            local actions = priv.actions[static.ActionType.MouseDown]
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

---@param self SimpleFrame
function private.newData(self)
    local priv = {
        detector = Frame.new(private.detector_type),

        actions = {},

        got_left_mouse_btn = false,
        got_right_mouse_btn = false,
    }
    for _, action_type in pairs(static.ActionType) do
        priv.actions[action_type] = {}
    end
    private.data[self] = priv
    private.active[self] = priv

    priv.detector:setParent(self)
    self:setTooltip(priv.detector)
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