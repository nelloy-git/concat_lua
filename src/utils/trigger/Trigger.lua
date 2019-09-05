---@type Settings
local Settings = require('utils.Settings')
---@type DataBase
local DataBase = require('utils.DataBase')
---@type TriggerAction
local TriggerAction = require('utils.trigger.TriggerAction')
---@type TriggerEvent
local TriggerEvent = require('utils.trigger.TriggerEvent')

---@class Trigger
local Trigger = {
    __type = 'TriggerClass'
}
local Trigger_meta = {
    __type = 'Trigger',
    __index = Trigger,
    __gc = Trigger.destroy
}

--- trigger -> Trigger
local TriggerDB = DataBase.new('userdata', type(Trigger_meta))

---@param self Trigger
function Trigger_meta.__tostring(self)
    local events = " "
    for i = 1, #self.__events do
        events = events..self.__events[i].." "
    end
    return string.format("Trigger with events: %s. Has %d action(s).", events, #self.__actions)
end

local function runTriggerActions()
    local self = TriggerDB:get(GetTriggeringTrigger())
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

---@return Trigger
function Trigger.new()
    local wc3_trigger = CreateTrigger()
    ---@type Trigger
    local trigger = {
        __trigger = wc3_trigger,
        __action_runner = TriggerAddAction(wc3_trigger, runTriggerActions),
        __actions = {},
        __events = {}
    }
    setmetatable(trigger, Trigger_meta)
    TriggerDB:add(trigger.__trigger, trigger)

    return trigger
end

---@return nil
function Trigger:destroy()
    self:clearActions()
    DestroyTrigger(self.__trigger)
    self.__trigger = nil
end

---@return trigger
function Trigger:getObj()
    return self.__trigger
end

---@return TriggerAction[]
function Trigger:getActions()
    return self.__actions
end

---@return string[]
function Trigger:getEvents()
    return self.__events
end

---@param callback fun(data:any)
---@param data any
---@return TriggerAction
function Trigger:addAction(callback, data)
    local action = TriggerAction.new(callback, data)
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
        table.remove(self.__actions, 1)
    end
end

---Function executes all callbacks of function.
---@return nil
function Trigger:execute()
    TriggerExecute(self.__trigger)
end

---@param event_type TriggerEventType
---@param event_name string
---| TriggerGameEvent
---| TriggerPlayerEvent
---| TriggerAnyPlayerEvent
---| TriggerUnitEvent
---| TriggerPlayerUnitEvent
---| TriggerAnyUnitEvent
function Trigger:addEvent(event_type, event_name, player_or_unit)
    TriggerEvent[event_type][event_name](self.__trigger, player_or_unit)
    table.insert(self.__events, 1, event_type..event_name)
end

---@param event TriggerGameEvent
function Trigger:addEvent_Game(event)
    TriggerEvent.Game[event](self.__trigger)
    table.insert(self.__events, 1, "Game_"..event)
end

---@param event TriggerPlayerEvent
---@param player player
function Trigger:addEvent_Player(event, player)
    TriggerEvent.Player[event](self.__trigger, player)
    table.insert(self.__events, 1, "Player_"..event)
end

---@param event TriggerAnyPlayerEvent
function Trigger:addEvent_AnyPlayer(event)
    TriggerEvent.AnyPlayer[event](self.__trigger)
    table.insert(self.__events, 1, "AnyPlayer_"..event)
end

---@param event TriggerUnitEvent
---@param unit unit
function Trigger:addEvent_Unit(event, wc3_unit)
    TriggerEvent.Unit[event](self.__trigger, wc3_unit)
    table.insert(self.__events, 1, "Unit_"..event)
end

---@param event TriggerPlayerUnitEvent
---@param player player
function Trigger:addEvent_PlayerUnit(event, player)
    TriggerEvent.PlayerUnit[event](self.__trigger, player)
    table.insert(self.__events, 1, "PlayerUnit_"..event)
end

---@param event TriggerAnyUnitEvent
function Trigger:addEvent_AnyUnit(event)
    TriggerEvent.AnyUnit[event](self.__trigger)
    table.insert(self.__events, 1, "AnyUnit_"..event)
end

---@param event TriggerAnyUnitEvent
---@param player player
---@param key oskeytype
function Trigger:addEvent_Keyboard(event, player, key)
    TriggerEvent.Keyboard[event](self.__trigger, player, key)
    table.insert(self.__events, 1, "AnyUnit_"..event)
end

return Trigger