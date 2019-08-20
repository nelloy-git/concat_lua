---@type Settings
local Settings = require('utils.Settings')
---@type TriggerDB
local TriggerDB = require('trigger.TriggerDB')
---@type TriggerAction
local TriggerAction = require('trigger.TriggerAction')
---@type TriggerEvent
local TriggerEvent = require('trigger.TriggerEvent')

---@class Trigger
local Trigger = {}
local Trigger_meta = {
    __index = Trigger,
    __gc = Trigger.destroy
}

---@param self Trigger
function Trigger_meta.__tostring(self)
    return string.format("Trigger with %d action(s).", #self.__actions)
end

local function runTriggerActions()
    local self = TriggerDB.get(GetTriggeringTrigger())
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
    local trigger_obj = CreateTrigger()
    ---@type Trigger
    local trigger = {
        __trigger_obj = trigger_obj,
        __action_obj = TriggerAddCondition(trigger_obj, runTriggerActions),
        __actions = {}
    }
    setmetatable(trigger, Trigger_meta)
    TriggerDB.add(trigger.__trigger_obj, trigger)

    return trigger
end

---@return nil
function Trigger:destroy()
    self:clearActions()
    DestroyTrigger(self.__trigger_obj)
    self.__trigger_obj = nil
end

---@return userdata
function Trigger:getObj()
    return self.__trigger_obj
end

---@return userdata
function Trigger:getActionObj()
    return self.__action_obj
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
    TriggerExecute(self.__trigger_obj)
end

---@param event TriggerGameEvent
function Trigger:addEvent_Game(event)
    TriggerEvent.Game[event](self)
end

---@param event TriggerPlayerEvent
---@param player Player
function Trigger:addEvent_Player(event, player)
    TriggerEvent.Player[event](self, player)
end

---@param event TriggerUnitEvent
---@param unit Unit
function Trigger:addEvent_Unit(event, unit)
    TriggerEvent.Unit[event](self, unit)
end

---@param event TriggerPlayerUnitEvent
---@param player Player
function Trigger:addEvent_PlayerUnit(event, player)
    TriggerEvent.PlayerUnit[event](self, player)
end

---@param event TriggerAnyUnitEvent
function Trigger:addEvent_AnyUnit(event)
    TriggerEvent.AnyUnit[event](self)
end

return Trigger