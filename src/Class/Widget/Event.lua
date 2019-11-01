--=========
-- Include
--=========

---@type Widget
local Widget = require('Class.Widget.Main')

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Trigger
local Trigger = require('Include.Trigger')

--========
-- Module
--========

---@class WidgetEvent : Class
local WidgetEvent = newClass('WidgetEvent')

__frame_events_db = DataBase.new('Widget', 'table')

function WidgetEvent.init()
    WidgetEvent.CONTROL_CLICK = WidgetEvent.new(FRAMEEVENT_CONTROL_CLICK)
    WidgetEvent.MOUSE_ENTER = WidgetEvent.new(FRAMEEVENT_MOUSE_ENTER)
    WidgetEvent.MOUSE_LEAVE = WidgetEvent.new(FRAMEEVENT_MOUSE_LEAVE)
    WidgetEvent.MOUSE_UP = WidgetEvent.new(FRAMEEVENT_MOUSE_UP)
    WidgetEvent.MOUSE_DOWN = WidgetEvent.new(FRAMEEVENT_MOUSE_DOWN)
    WidgetEvent.MOUSE_WHEEL = WidgetEvent.new(FRAMEEVENT_MOUSE_WHEEL)
    WidgetEvent.CHECKBOX_CHECKED = WidgetEvent.new(FRAMEEVENT_CHECKBOX_CHECKED)
    WidgetEvent.CHECKBOX_UNCHECKED = WidgetEvent.new(FRAMEEVENT_CHECKBOX_UNCHECKED)
    WidgetEvent.EDITBOX_TEXT_CHANGED = WidgetEvent.new(FRAMEEVENT_EDITBOX_TEXT_CHANGED)
    WidgetEvent.POPUPMENU_ITEM_CHANGED = WidgetEvent.new(FRAMEEVENT_POPUPMENU_ITEM_CHANGED)
    WidgetEvent.MOUSE_DOUBLECLICK = WidgetEvent.new(FRAMEEVENT_MOUSE_DOUBLECLICK)
    WidgetEvent.SPRITE_ANIM_UPDATE = WidgetEvent.new(FRAMEEVENT_SPRITE_ANIM_UPDATE)
    WidgetEvent.SLIDER_VALUE_CHANGED = WidgetEvent.new(FRAMEEVENT_SLIDER_VALUE_CHANGED)
    WidgetEvent.DIALOG_CANCEL = WidgetEvent.new(FRAMEEVENT_DIALOG_CANCEL)
    WidgetEvent.DIALOG_ACCEPT = WidgetEvent.new(FRAMEEVENT_DIALOG_ACCEPT)
    WidgetEvent.EDITBOX_ENTER = WidgetEvent.new(FRAMEEVENT_EDITBOX_ENTER)
end


---@param eventtype frameeventtype|string
---@return WidgetEvent
function WidgetEvent.new(eventtype)
    ---@type WidgetEvent
    local widget_event = WidgetEvent:newInstance()
    widget_event.__eventtype = eventtype

    return widget_event
end

---@return boolean
function WidgetEvent:isDefault()
    return self.__eventtype == 'userdata'
end

---@param widget Widget
---@param event WidgetEvent
---@return Trigger
local function getEventTrigger(widget, event)
    local all_events = __frame_events_db:get(widget)
    if not all_events then
        all_events = {}
        __frame_events_db:add(widget, all_events)
    end

    ---@type Trigger
    local trigger = all_events[event]
    if not trigger then
        trigger = Trigger.new()
        all_events[event] = trigger

        if event:isDefault() then
            trigger:addFrameEvent(widget:getObj(), event.__eventtype)
        end
    end
    return trigger
end

---@param event WidgetEvent
---@param func fun(data:any):nil
---@return TriggerAction
function Widget:addEventAction(event, func, data)
    return getEventTrigger(self, event):addAction(func, data)
end

---@param event WidgetEvent
---@param action TriggerAction
---@return boolean
function Widget:removeEventAction(event, action)
    return getEventTrigger(self, event):removeAction(action)
end

---@param event WidgetEvent
function Widget:runEvent(event)
    getEventTrigger(self, event):execute()
end

return WidgetEvent