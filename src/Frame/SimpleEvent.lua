--=========
-- Include
--=========

---@type ActionClass
local Action = require('Utils.Action')
---@type TriggerClass
local Trigger = require('Utils.Trigger')

--===========
-- Functions
--===========

---@alias SimpleEventCallback fun(simple_frame:Frame, player:player, btn:mousebuttontype, is_down:boolean)

local SimpleEvent = {}

---@alias SimpleEventEnum number
---type table<string, SimpleEventCallback>
SimpleEvent.Type = {}
---@type SimpleEventEnum
SimpleEvent.Type.OnMouseDown = 1
---@type SimpleEventEnum
SimpleEvent.Type.OnMouseUp = 2
---@type SimpleEventEnum
SimpleEvent.Type.OnMousePress = 3

local frame2tooltip = setmetatable({}, {__mode = 'kv'})
local actions = {
    [SimpleEvent.Type.OnMouseDown] = setmetatable({}, {__mode = 'k'}),
    [SimpleEvent.Type.OnMouseUp] = setmetatable({}, {__mode = 'k'}),
    [SimpleEvent.Type.OnMousePress] = setmetatable({}, {__mode = 'k'}),
}
local got_left_mouse_btn = setmetatable({}, {__mode = 'k'})
local got_right_mouse_btn = setmetatable({}, {__mode = 'k'})

---@param frame Frame
---@param tooltip_framehandle framehandle
function SimpleEvent.setMouseDetector(frame, tooltip_framehandle)
    frame2tooltip[frame] = tooltip_framehandle
end

---@param event_type SimpleEventEnum
---@param frame Frame
---@param callback SimpleEventCallback
---@return Action
function SimpleEvent.addAction(event_type, frame, callback)
    local action = Action.new(callback, frame)
    if not actions[event_type][frame] then
        actions[event_type][frame] = {}
    end
    table.insert(actions[event_type][frame], action)

    return action
end

---@param event_type SimpleEventEnum
---@param action Action
---@return boolean
function SimpleEvent:removeAction(event_type, action)
    local list = actions[event_type][action:getOwner()]

    for i = 1, #list do
        if list[i] == action then
            table.remove(list, i)
            return true
        end
    end
    return false
end

function SimpleEvent.mouseDownCallback()
    local player = GetTriggerPlayer()
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for frame, tooltip in pairs(frame2tooltip) do
        print(BlzFrameIsVisible(tooltip))
        if BlzFrameIsVisible(tooltip) then
            local list = actions[SimpleEvent.Type.OnMouseDown][frame]
            if list then
                for i = 1, #list do
                    list[i]:run(frame, player, mouse_btn, true)
                end
            end

            got_left_mouse_btn[frame] = is_left
            got_right_mouse_btn[frame] = is_right
        end
    end
end

function SimpleEvent.mouseUpCallback()
    local player = GetTriggerPlayer()
    local mouse_btn = BlzGetTriggerPlayerMouseButton()
    local is_left = mouse_btn == MOUSE_BUTTON_TYPE_LEFT
    local is_right = mouse_btn == MOUSE_BUTTON_TYPE_RIGHT

    for frame, tooltip in pairs(frame2tooltip) do
        if BlzFrameIsVisible(tooltip) then
            local list = actions[SimpleEvent.Type.OnMouseUp][frame]
            if list then
                for i = 1, #list do
                    list[i]:run(frame, player, mouse_btn, false)
                end
            end

            if (got_left_mouse_btn[frame] and is_left) or (got_right_mouse_btn[frame] and is_right) then
                list = actions[SimpleEvent.Type.OnMousePress][frame]
                if list then
                    for i = 1, #list do
                        list[i]:run(frame, player, mouse_btn, false)
                    end
                end
            end

            got_left_mouse_btn[frame] = not (is_left and got_left_mouse_btn)
            got_right_mouse_btn[frame] = not (is_right and got_right_mouse_btn)
        end
    end
end

if not IsCompiletime() then
    local down_trigger = Trigger.new()
    local up_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS do
        down_trigger:addPlayerEvent(EVENT_PLAYER_MOUSE_DOWN, Player(i))
        up_trigger:addPlayerEvent(EVENT_PLAYER_MOUSE_UP, Player(i))
    end
    down_trigger:addAction(SimpleEvent.mouseDownCallback)
    up_trigger:addAction(SimpleEvent.mouseUpCallback)
end

return SimpleEvent