--=========
-- Include
--=========


local Class = require(Lib.Class)

---@type ActionListClass
local ActionList = require('Utils.ActionList')
---@type FrameClass
local Frame = require('Frame.Frame')
local FramePublic = Class.getPublic(Frame)
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleButtonTypeClass
local SimpleButtonType = require('Frame.Type.SimpleButton')
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

---@alias SimpleMouseButtonCallback fun(instance:SimpleButton, player:player, button:mousebuttontype, event:SimpleButtonEvent)
---@alias SimpleButtonEvent number

---@type table<string, SimpleButtonEvent>
static.ActionType = {}
---@type SimpleButtonEvent
static.ActionType.MousePress = 1
---@type SimpleButtonEvent
static.ActionType.MouseDown = 2
---@type SimpleButtonEvent
static.ActionType.MouseUp = 3

---@param frame_type SimpleButtonType | nil
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

---@param event SimpleButtonEvent
---@param callback SimpleMouseButtonCallback
---@return Action | nil
function public:addAction(event, callback)
    return private.data[self].actions[event]:add(callback)
end

---@param event SimpleButtonEvent
---@param action Action
---@return boolean
function public:removeAction(event, action)
    return private.data[self].actions[event]:remove(action)
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

    local mouse_down = static.ActionType.MouseDown

    for instance, priv in pairs(private.active) do
        if priv.detector:isVisible() then
            priv.actions[mouse_down]:run(instance, player, mouse_btn, mouse_down)

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

    local mouse_up = static.ActionType.MouseUp
    local mouse_press = static.ActionType.MousePress

    for instance, priv in pairs(private.active) do
        if priv.detector:isVisible() then
            priv.actions[mouse_up]:run(instance, player, mouse_btn, mouse_up)

            if (priv.got_left_mouse_btn and is_left) or (priv.got_right_mouse_btn and is_right) then
                priv.actions[mouse_press]:run(instance, player, mouse_btn, mouse_press)
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
    for _, event in pairs(static.ActionType) do
        priv.actions[event] = ActionList.new()
    end
    private.data[self] = priv
    private.active[self] = priv

    priv.detector:setParent(self)
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