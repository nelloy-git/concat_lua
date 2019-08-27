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
    __type = 'class Trigger'
}
local Trigger_meta = {
    __type = 'Trigger',
    __index = Trigger,
    __gc = Trigger.destroy
}

---wc3_Trigger -> Trigger
local TriggerDB = DataBase.new('userdata', 'table')

---@param self Trigger
function Trigger_meta.__tostring(self)
    local events = " "
    for i = 1, #self.__events do
        events = events..self.__events[i].." "
    end
    return string.format("Trigger with events: %s\nHas %d action(s).", events, #self.__actions)
end

local function runTriggerActions()
    local self = TriggerDB:get(GetTriggeringTrigger())
    for i = 1, #self.__actions do
        ---@type TriggerAction
        local action = self.__actions[i]
        if Settings.debug then
            local succes, result = pcall(action.run, action)
            if not succes then
                Debug("Error in trigger")
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
        __wc3_trigger = wc3_trigger,
        __wc3_action = TriggerAddAction(wc3_trigger, runTriggerActions),
        __actions = {},
        __events = {}
    }
    setmetatable(trigger, Trigger_meta)
    TriggerDB:add(trigger.__wc3_trigger, trigger)

    return trigger
end

---@return nil
function Trigger:destroy()
    self:clearActions()
    DestroyTrigger(self.__wc3_trigger)
    self.__wc3_trigger = nil
end

---@return wc3_Trigger
function Trigger:getObj()
    return self.__wc3_trigger
end

---@return TriggerAction[]
function Trigger:getActions()
    return self.__actions
end

---@param callback function
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
    TriggerExecute(self.__wc3_trigger)
end

---@param event TriggerGameEvent
function Trigger:addEvent_Game(event)
    TriggerEvent.Game[event](self.__wc3_trigger)
    table.insert(self.__events, 1, "Game_"..event)
end

---@param event TriggerPlayerEvent
---@param wc3_player wc3_Player
function Trigger:addEvent_Player(event, wc3_player)
    TriggerEvent.Player[event](self.__wc3_trigger, wc3_player)
    table.insert(self.__events, 1, "Player_"..event)
end

---@param event TriggerUnitEvent
---@param wc3_unit wc3_Unit
function Trigger:addEvent_Unit(event, wc3_unit)
    TriggerEvent.Unit[event](self.__wc3_trigger, wc3_unit)
    table.insert(self.__events, 1, "Unit_"..event)
end

---@param event TriggerPlayerUnitEvent
---@param wc3_player wc3_Player
function Trigger:addEvent_PlayerUnit(event, wc3_player)
    TriggerEvent.PlayerUnit[event](self.__wc3_trigger, wc3_player)
    table.insert(self.__events, 1, "PlayerUnit_"..event)
end

---@param event TriggerAnyUnitEvent
function Trigger:addEvent_AnyUnit(event)
    TriggerEvent.AnyUnit[event](self.__wc3_trigger)
    table.insert(self.__events, 1, "AnyUnit_"..event)
end

return Trigger