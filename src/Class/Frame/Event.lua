--=========
-- Include
--=========

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Frame
local Frame = require('Class.Frame.Main')
---@type Trigger
local Trigger = require('Include.Trigger')

--========
-- Module
--========

---@class FrameEvent
local FrameEvent = newClass('FrameEvent')
local FrameEvent_meta = newMeta(FrameEvent)
__frame2triggers = DataBase.new('Frame', 'table')
__triggers_db = DataBase.new('FrameEvent', 'Trigger')

function FrameEvent.init()
    FrameEvent.CONTROL_CLICK = FrameEvent.new(FRAMEEVENT_CONTROL_CLICK)
    FrameEvent.MOUSE_ENTER = FrameEvent.new(FRAMEEVENT_MOUSE_ENTER)
    FrameEvent.MOUSE_LEAVE = FrameEvent.new(FRAMEEVENT_MOUSE_LEAVE)
    FrameEvent.MOUSE_UP = FrameEvent.new(FRAMEEVENT_MOUSE_UP)
    FrameEvent.MOUSE_DOWN = FrameEvent.new(FRAMEEVENT_MOUSE_DOWN)
    FrameEvent.MOUSE_WHEEL = FrameEvent.new(FRAMEEVENT_MOUSE_WHEEL)
    FrameEvent.CHECKBOX_CHECKED = FrameEvent.new(FRAMEEVENT_CHECKBOX_CHECKED)
    FrameEvent.CHECKBOX_UNCHECKED = FrameEvent.new(FRAMEEVENT_CHECKBOX_UNCHECKED)
    FrameEvent.EDITBOX_TEXT_CHANGED = FrameEvent.new(FRAMEEVENT_EDITBOX_TEXT_CHANGED)
    FrameEvent.POPUPMENU_ITEM_CHANGED = FrameEvent.new(FRAMEEVENT_POPUPMENU_ITEM_CHANGED)
    FrameEvent.MOUSE_DOUBLECLICK = FrameEvent.new(FRAMEEVENT_MOUSE_DOUBLECLICK)
    FrameEvent.SPRITE_ANIM_UPDATE = FrameEvent.new(FRAMEEVENT_SPRITE_ANIM_UPDATE)
    FrameEvent.SLIDER_VALUE_CHANGED = FrameEvent.new(FRAMEEVENT_SLIDER_VALUE_CHANGED)
    FrameEvent.DIALOG_CANCEL = FrameEvent.new(FRAMEEVENT_DIALOG_CANCEL)
    FrameEvent.DIALOG_ACCEPT = FrameEvent.new(FRAMEEVENT_DIALOG_ACCEPT)
    FrameEvent.EDITBOX_ENTER = FrameEvent.new(FRAMEEVENT_EDITBOX_ENTER)
end


---@param event frameeventtype|string
---@return FrameEvent
function FrameEvent.new(event)
    local unit_event = {
        __event_obj = event
    }
    setmetatable(unit_event, FrameEvent_meta)

    return unit_event
end

---@return boolean
function FrameEvent:isDefault()
    return self.__event_obj == 'userdata'
end

---@param frame Frame
---@return table(FrameEvent,Trigger)
local function getAllFrameEvents(frame)
    local events = __frame2triggers:get(frame)
    if not events then
        events = {}
        __frame2triggers:add(frame, events)
    end
    return events
end

---@param frame Frame
---@param event FrameEvent
---@return Trigger
local function getEventTrigger(frame, event)
    local frame_events = getAllFrameEvents(frame)
    ---@type Trigger
    local trigger = frame_events[event]
    if not trigger then
        trigger = Trigger.new()
        if event:isDefault() then
            trigger:addFrameEvent(frame:getObj(), event.__event_obj)
        end
    end
    return trigger
end

---@param event FrameEvent
---@param action fun():nil
function Frame:addEventAction(event, action)
    local trigger = getEventTrigger(self, event)
    trigger:addAction(action)
end

---@param event FrameEvent
---@param action fun():nil
function Frame:removeEventAction(event, action)
    local trigger = getEventTrigger(self, event)
    trigger:removeAction(action)
end

---@param event FrameEvent
function Frame:runEvent(event)
    local trigger = getEventTrigger(self, event)
    trigger:execute()
end

return FrameEvent