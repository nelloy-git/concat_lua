--=========
-- Include
--=========

---@type DataBase
local DataBase = require('Class.DataBase.Main')

--=======
-- Class
--=======

---@class Trigger
---@type Trigger
local Trigger = Class('Trigger')
---@type fun():Trigger
Trigger.new = Trigger.new-- Function override for emmy annotation.

--========
-- Static
--========

local db = DataBase:new('userdata', 'instance of '..tostring(Trigger))

--=========
-- Methods
--=========

---@type fun():nil
local runTriggerActions -- Predefined


--- Hiden constructor. Do not use this function manually.
function Trigger:initialize()
    self._obj = CreateTrigger()
    db:set(self._obj, self)
end

---@param callback fun(data:any):nil
---@param data any
---@return TriggerAction
function Trigger:addAction(callback, data)
    local action = {
        __callback = callback,
        __data = data
    }
    table.insert(self.__actions, #self.__actions + 1, action)
    return action
end

---@return number
function Trigger:countActions()
    return #self.__actions
end

---return number
function Trigger:isValid()
    return self.__trigger_obj ~= nil
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

---Function removes all actions from trigger without removing trigger.
---@return nil
function Trigger:clearActions()
    while #self.__actions > 0 do
        table.remove(self.__actions, #self.__actions)
    end
end

---Function executes all callbacks of function.
function Trigger:execute()
    if not self.__trigger_obj then
        Debug("Trigger error: triing execute destroyed trigger.")
        return nil
    end

    local original = _G.GetTriggeringTrigger
    GetTriggeringTrigger = function() return self.__trigger_obj end
    runFuncInDebug(TriggerExecute, self.__trigger_obj)
    GetTriggeringTrigger = original
end

---@param var_name string
---@param opcode limitop
---@param limitval number
function Trigger:addVariableEvent(var_name, opcode, limitval)
    TriggerRegisterVariableEvent(self.__trigger_obj, var_name, opcode, limitval)
end

---@param timeout number
---@param periodic boolean
function Trigger:addTimerEvent(timeout, periodic)
    TriggerRegisterTimerEvent(self.__trigger_obj, timeout, periodic)
end

---@param timer timer
function Trigger:addTimerExpireEvent(timer)
    TriggerRegisterTimerExpireEvent(self.__trigger_obj, timer)
end

---@param game_state gamestate
---@param opcode limitop
---@param limitval number
function Trigger:addGameStateEvent(game_state, opcode, limitval)
    TriggerRegisterGameStateEvent(self.__trigger_obj, game_state, opcode, limitval)
end

---@param dialog dialog
function Trigger:addDialogEvent(dialog)
    TriggerRegisterDialogEvent(self.__trigger_obj, dialog)
end

---@param button button
function Trigger:addDialogButtonEvent(button)
    TriggerRegisterDialogButtonEvent(self.__trigger_obj, button)
end

---@param game_event gameevent
function Trigger:addGameEvent(game_event)
    TriggerRegisterGameEvent(self.__trigger_obj, game_event)
end

---@param region region
function Trigger:addEnterRegion(region)
    TriggerRegisterEnterRegion(self.__trigger_obj, region)
end

---@param region region
function Trigger:addLeaveRegion(region)
    TriggerRegisterLeaveRegion(self.__trigger_obj, region)
end

---@param trackable trackable
function Trigger:addTrackableHitEvent(trackable)
    TriggerRegisterTrackableHitEvent(self.__trigger_obj, trackable)
end

---@param trackable trackable
function Trigger:addTrackableTrackEvent(trackable)
    TriggerRegisterTrackableTrackEvent(self.__trigger_obj, trackable)
end

---@param player_event_type playerevent
---@param player player
function Trigger:addPlayerEvent(player_event_type, player)
    TriggerRegisterPlayerEvent(self.__trigger_obj, player_event_type, player)
end

---@param player_unit_event playerunitevent
---@param player player
function Trigger:addPlayerUnitEvent(player_unit_event, player)
    TriggerRegisterPlayerUnitEvent(self.__trigger_obj, player, player_unit_event, nil)
end

---@param player player
---@param alliancetype alliancetype
function Trigger:addPlayerAllianceChange(player, alliancetype)
    TriggerRegisterPlayerAllianceChange(self.__trigger_obj, player, alliancetype)
end

---@param player player
---@param player_state playerstate
---@param opcode limitop
---@param limitval number
function Trigger:addPlayerStateEvent(player, player_state, opcode, limitval)
    TriggerRegisterPlayerStateEvent(self.__trigger_obj, player, player_state, opcode, limitval)
end

---@param player player
---@param message string
---@param exact_match boolean
function Trigger:addPlayerChatEvent(player, message, exact_match)
    TriggerRegisterPlayerChatEvent(self.__trigger_obj, player, message, exact_match)
end

---@param widget widget
function Trigger:addDeathEvent(widget)
    TriggerRegisterDeathEvent(self.__trigger_obj, widget)
end

---@param unit unit
---@param unit_state unitstate
---@param opcode limitop
---@param limitval number
function Trigger:addUnitStateEvent(unit, unit_state, opcode, limitval)
    TriggerRegisterUnitStateEvent(self.__trigger_obj, unit, unit_state, opcode, limitval)
end

---@param unit_event unitevent
---@param unit unit
function Trigger:addUnitEvent(unit_event, unit)
    TriggerRegisterUnitEvent(self.__trigger_obj, unit_event, unit)
end

---@param unit unit
---@param range number
function Trigger:addUnitInRange(unit, range)
    TriggerRegisterUnitInRange(self.__trigger_obj, unit, range)
end

---@param frame framehandle
---@param frame_event frameeventtype
function Trigger:addFrameEvent(frame, frame_event)
    BlzTriggerRegisterFrameEvent(self.__trigger_obj, frame, frame_event)
end

---@param player player
---@param prefix string
---@param from_server boolean
function Trigger:addPlayerSyncEvent(player, prefix, from_server)
    BlzTriggerRegisterPlayerSyncEvent(self.__trigger_obj, player, prefix, from_server)
end

---@param player player
---@param key oskeytype
---@param meta_key integer
---@param key_down boolean
function Trigger:addPlayerKeyEvent(player, key, meta_key, key_down)
    BlzTriggerRegisterPlayerKeyEvent(self.__trigger_obj, player, key, meta_key, key_down)
end

runTriggerActions = function()
    runFuncInDebug(function()
        local self = Trigger.__db:get(GetTriggeringTrigger())

        for i = 1, #self.__actions do
            local action = self.__actions[i]
            action.__callback(action.__data)
        end
    end)
end

return Trigger