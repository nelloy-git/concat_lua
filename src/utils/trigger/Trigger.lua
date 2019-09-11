---@type Settings
local Settings = require('utils.Settings')
---@type DataBase
local DataBase = require('utils.DataBase')

---@class Trigger
local Trigger = {
    __type = 'TriggerClass',
    __db = DataBase.new('userdata', 'Trigger')
}
local Trigger_meta = {
    __type = 'Trigger',
    __index = Trigger,
    __gc = Trigger.destroy
}

-- ============
--  Predefined
-- ============
---@type fun():nil
local runTriggerActions

---@param self Trigger
function Trigger_meta.__tostring(self)
    return string.format("%s", type(self))
end

---@return Trigger
function Trigger.new()
    local trigger_obj = CreateTrigger()
    ---@type Trigger
    local trigger = {
        __trigger_obj = trigger_obj,
        __action_runner = TriggerAddAction(trigger_obj, runTriggerActions),
        __actions = {},
        __events = {}
    }
    setmetatable(trigger, Trigger_meta)
    Trigger.__db:add(trigger.__trigger_obj, trigger)

    return trigger
end

---@return nil
function Trigger:destroy()
    self:clearActions()
    DestroyTrigger(self.__trigger_obj)
    self.__trigger_obj = nil
end

---@param callback fun(data:any):nil
---@param data any
---@return TriggerAction
function Trigger:addAction(callback, data)
    ---@class TriggerAction
    local action = {
        __callback = callback,
        __data = data
    }
    table.insert(self.__actions, #self.__actions + 1, action)
    return action
end

---@param action TriggerAction
---@return boolean
function Trigger:removeAction(action)
    local pos = -1
    for i = 1, #self.__actions do
        if self.__actions[i] == action then
            pos = i
            break
        end
    end

    if pos > 0 then
        table.remove(self.__actions, pos)
        return true
    end
    return false
end

---Function removes all callbacks from trigger.
---@return nil
function Trigger:clearActions()
    while #self.__actions > 0 do
        table.remove(self.__actions, #self.__actions)
    end
end

---Function executes all callbacks of function.
---@return nil
function Trigger:execute()
    TriggerExecute(self.__trigger_obj)
end

---@alias TriggerEventType string
---| '"PlayerEvent"'

---@param player player
---@param event_type playerevent
---@return TriggerEvent
function Trigger:addPlayerEvent(player, event_type)
    ---@class TriggerEvent
    local event = {
        __type = "PlayerEvent",
        __player = player,
        __event = event_type
    }
    TriggerRegisterPlayerEvent(self.__trigger_obj, player, event_type)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

function Trigger:refreshEvents()
    DestroyTrigger(self.__trigger_obj)
    self.__trigger_obj = CreateTrigger()
    self.__action_runner = TriggerAddAction(self.__trigger_obj, runTriggerActions)
    Trigger.__db:add(self.__trigger_obj, self)

    for i = 1, #self.__events do
        local event = self.__events[i]
        if event.__type == "PlayerEvent" then
            TriggerRegisterPlayerEvent(self.__trigger_obj, self.__player, self.__event)
        else
            -- TODO
            Debug("Trigger refresh error: undeclared event type")
        end
    end
end

---@param event TriggerEvent
function Trigger:removeEvent(event)
    local pos = -1
    for i = 1, #self.__events do
        if self.__events[i] == event then
            pos = i
            break
        end
    end

    if pos > 0 then
        table.remove(self.__events, pos)
        self:refreshEvents()
        return true
    end
    return false
end

runTriggerActions = function()
    local self = Trigger.__db:get(GetTriggeringTrigger())

    for i = 1, #self.__actions do
        ---@type TriggerAction
        local action = self.__actions[i]
        if Settings.debug then
            local success, result = pcall(action.run, action)
            if not success then
                Debug("Error in "..tostring(self))
                Debug(result)
            end
        else
            action:run()
        end
    end
    return true
end

return Trigger