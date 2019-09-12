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
---@type table<TriggerEventType,fun>
local registerEvent

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


---@class TriggerEvent
---@field __type string

---@param var_name string
---@param opcode limitop
---@param limitval number
---@return TriggerEvent
function Trigger:addVariableEvent(var_name, opcode, limitval)
    ---@type TriggerEvent
    local event = {
        __type = "VariableEvent",
        __var_name = var_name,
        __opcode = opcode,
        __limitval = limitval
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param timeout number
---@param periodic boolean
---@return TriggerEvent
function Trigger:addTimerEvent(timeout, periodic)
    ---@type TriggerEvent
    local event = {
        __type = "TimerEvent",
        __timeout = timeout,
        __periodic = periodic
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param timer timer
---@return TriggerEvent
function Trigger:addTimerExpireEvent(timer)
    ---@type TriggerEvent
    local event = {
        __type = "TimerExpireEvent",
        __timer = timer
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param game_state gamestate
---@param opcode limitop
---@param limitval number
---@return TriggerEvent
function Trigger:addGameStateEvent(game_state, opcode, limitval)
    ---@type TriggerEvent
    local event = {
        __type = "GameStateEvent",
        __game_state = game_state,
        __opcode = opcode,
        __limitval = limitval
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param dialog dialog
---@return TriggerEvent
function Trigger:addDialogEvent(dialog)
    ---@type TriggerEvent
    local event = {
        __type = "DialogEvent",
        __dialog = dialog
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param button button
---@return TriggerEvent
function Trigger:addDialogButtonEvent(button)
    ---@type TriggerEvent
    local event = {
        __type = "DialogButtonEvent",
        __button = button
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param game_event gameevent
---@return TriggerEvent
function Trigger:addGameEvent(game_event)
    ---@type TriggerEvent
    local event = {
        __type = "GameEvent",
        __game_event = game_event
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param region region
---@return TriggerEvent
function Trigger:addEnterRegion(region)
    ---@type TriggerEvent
    local event = {
        __type = "EnterRegion",
        __region = region
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param region region
---@return TriggerEvent
function Trigger:addLeaveRegion(region)
    ---@type TriggerEvent
    local event = {
        __type = "LeaveRegion",
        __region = region
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param trackable trackable
---@return TriggerEvent
function Trigger:addTrackableHitEvent(trackable)
    ---@type TriggerEvent
    local event = {
        __type = "TrackableHitEvent",
        __trackable = trackable
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param trackable trackable
---@return TriggerEvent
function Trigger:addTrackableTrackEvent(trackable)
    ---@type TriggerEvent
    local event = {
        __type = "TrackableTrackEvent",
        __trackable = trackable
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param player_event_type playerevent
---@param player player
---@return TriggerEvent
function Trigger:addPlayerEvent(player_event_type, player)
    ---@type TriggerEvent
    local event = {
        __type = "PlayerEvent",
        __player = player,
        __event = player_event_type
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param player_unit_event playerunitevent
---@param player player
---@return TriggerEvent
function Trigger:addPlayerUnitEvent(player_unit_event, player)
    ---@type TriggerEvent
    local event = {
        __type = "PlayerUnitEvent",
        __player_unit_event = player_unit_event,
        __player = player
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param player player
---@param alliancetype alliancetype
---@return TriggerEvent
function Trigger:addPlayerAllianceChange(player, alliancetype)
    ---@type TriggerEvent
    local event = {
        __type = "PlayerAllianceChange",
        __player = player,
        __alliancetype = alliancetype
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param player player
---@param player_state playerstate
---@param opcode limitop
---@param limitval number
---@return TriggerEvent
function Trigger:addPlayerStateEvent(player, player_state, opcode, limitval)
    ---@type TriggerEvent
    local event = {
        __type = "PlayerStateEvent",
        __player = player,
        __player_state = player_state,
        __opcode = opcode,
        __limitval = limitval
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param player player
---@param message string
---@param exact_match boolean
---@return TriggerEvent
function Trigger:addPlayerChatEvent(player, message, exact_match)
    ---@type TriggerEvent
    local event = {
        __type = "PlayerChatEvent",
        __player = player,
        __message = message,
        __exact_match = exact_match
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param widget widget
---@return TriggerEvent
function Trigger:addDeathEvent(widget)
    ---@type TriggerEvent
    local event = {
        __type = "DeathEvent",
        __widget = widget
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param unit unit
---@param unit_state unitstate
---@param opcode limitop
---@param limitval number
---@return TriggerEvent
function Trigger:addUnitStateEvent(unit, unit_state, opcode, limitval)
    ---@type TriggerEvent
    local event = {
        __type = "UnitStateEvent",
        __unit = unit,
        __unti_state = unit_state,
        __opcode = opcode,
        __limitval = limitval
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param unit_event unitevent
---@param unit unit
---@return TriggerEvent
function Trigger:addUnitEvent(unit_event, unit)
    ---@type TriggerEvent
    local event = {
        __type = "UnitEvent",
        __unit = unit,
        __unit_event = unit_event
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param unit unit
---@param range number
---@return TriggerEvent
function Trigger:addUnitInRange(unit, range)
    ---@type TriggerEvent
    local event = {
        __type = "UnitInRange",
        __unit = unit,
        __range = range
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param frame framehandle
---@param frame_event frameeventtype
function Trigger:addFrameEvent(frame, frame_event)
    ---@type TriggerEvent
    local event = {
        __type = "FrameEvent",
        __frame = frame,
        __frame_event = frame_event
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param player player
---@param prefix string
---@param from_server boolean
---@return TriggerEvent
function Trigger:addPlayerSyncEvent(player, prefix, from_server)
    ---@type TriggerEvent
    local event = {
        __type = "PlayerSyncEvent",
        __player = player,
        __prefix = prefix,
        __from_server = from_server
    }
    registerEvent(self, event.__type, event)
    table.insert(self.__events, #self.__events + 1, event)

    return event
end

---@param player player
---@param key oskeytype
---@param meta_key integer
---@param key_down boolean
---@return TriggerEvent
function Trigger:addPlayerKeyEvent(player, key, meta_key, key_down)
    ---@type TriggerEvent
    local event = {
        __type = "PlayerKeyEvent",
        __player = player,
        __key = key,
        __meta_key = meta_key,
        __key_down = key_down
    }
    registerEvent(self, event.__type, event)
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
        local result = runFuncInDebug(registerEvent, self, event.__type, event)
        if not result then
            Debug("Trigger error: got wrong event type")
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

---@alias TriggerEventType string
---| '"VariableEvent"'
---| '"TimerEvent"'
---| '"TimerExpireEvent"'
---| '"GameStateEvent"'
---| '"DialogEvent"'
---| '"DialogButtonEvent"'
---| '"GameEvent"'
---| '"EnterRegion"'
---| '"LeaveRegion"'
---| '"TrackableHitEvent"'
---| '"TrackableTrackEvent"'
---| '"PlayerEvent"'
---| '"PlayerUnitEvent"'
---| '"PlayerAllianceChange"'
---| '"PlayerStateEvent"'
---| '"PlayerChatEvent"'
---| '"DeathEvent"'
---| '"UnitStateEvent"'
---| '"UnitEvent"'
---| '"FilterUnitEvent"'
---| '"UnitInRange"'
---| '"FrameEvent"'
---| '"PlayerSyncEvent"'
---| '"PlayerKeyEvent"'

---@param trigger Trigger
---@param event_type TriggerEventType
---@param event_data TriggerEvent
registerEvent = function(trigger, event_type, event_data)
    if event_type == "VariableEvent" then
        TriggerRegisterVariableEvent(trigger.__trigger_obj, event_data.__var_name, event_data.__opcode, event_data.__limitval)
        return true
    elseif event_type == "TimerEvent" then
        TriggerRegisterTimerEvent(trigger.__trigger_obj, event_data.__timeout, event_data.__periodic)
        return true
    elseif event_type == "TimerExpireEvent" then
        TriggerRegisterTimerExpireEvent(trigger.__trigger_obj, event_data.__timer)
        return true
    elseif event_type == "GameStateEvent" then
        TriggerRegisterGameStateEvent(trigger.__trigger_obj, event_data.__game_state, event_data.__opcode, event_data.__limitval)
        return true
    elseif event_type == "DialogEvent" then
        TriggerRegisterDialogEvent(trigger.__trigger_obj, event_data.__dialog)
        return true
    elseif event_type == "DialogButtonEvent" then
        TriggerRegisterDialogButtonEvent(trigger.__trigger_obj, event_data.__button)
        return true
    elseif event_type == "GameEvent" then
        TriggerRegisterGameEvent(trigger.__trigger_obj, event_data.__game_event)
        return true
    elseif event_type == "EnterRegion" then
        TriggerRegisterEnterRegion(trigger.__trigger_obj, event_data.__region, nil)
        return true
    elseif event_type == "LeaveRegion" then
        TriggerRegisterLeaveRegion(trigger.__trigger_obj, event_data.__region, nil)
        return true
    elseif event_type == "TrackableHitEvent" then
        TriggerRegisterTrackableHitEvent(trigger.__trigger_obj, event_data.__trackable)
        return true
    elseif event_type == "TrackableTrackEvent" then
        TriggerRegisterTrackableTrackEvent(trigger.__trigger_obj, event_data.__trackable)
        return true
    elseif event_type == "PlayerEvent" then
        TriggerRegisterPlayerEvent(trigger.__trigger_obj, event_data.__player, event_data.__player_event)
        return true
    elseif event_type == "PlayerUnitEvent" then
        TriggerRegisterPlayerUnitEvent(trigger.__trigger_obj, event_data.__player, event_data.__player_unit_event, nil)
        return true
    elseif event_type == "PlayerAllianceChange" then
        TriggerRegisterPlayerAllianceChange(trigger.__trigger_obj, event_data.__player, event_data.__alliancetype)
        return true
    elseif event_type == "PlayerStateEvent" then
        TriggerRegisterPlayerStateEvent(trigger.__trigger_obj, event_data.__player, event_data.__player_state, event_data.__opcode, event_data.__limitval)
        return true
    elseif event_type == "PlayerChatEvent" then
        TriggerRegisterPlayerChatEvent(trigger.__trigger_obj, event_data.__player, event_data.__message, event_data.__exact_match)
        return true
    elseif event_type == "DeathEvent" then
        TriggerRegisterDeathEvent(trigger.__trigger_obj, event_data.__widget)
        return true
    elseif event_type == "UnitStateEvent" then
        TriggerRegisterUnitStateEvent(trigger.__trigger_obj, event_data.__unit, event_data.__unti_state, event_data.__opcode, event_data.__limitval)
        return true
    elseif event_type == "UnitEvent" then
        TriggerRegisterUnitEvent(trigger.__trigger_obj, event_data.__unit, event_data.__unit_event)
        return true
    elseif event_type == "UnitInRange" then
        TriggerRegisterUnitInRange(trigger.__trigger_obj, event_data.__unit, event_data.__range, nil)
        return true
    elseif event_type == "FrameEvent" then
        BlzTriggerRegisterFrameEvent(trigger.__trigger_obj, event_data.__frame, event_data.__frame_event)
        return true
    elseif event_type == "PlayerSyncEvent" then
        BlzTriggerRegisterPlayerSyncEvent(trigger.__trigger_obj, event_data.__player, event_data.__prefix, event_data.__from_server)
        return true
    elseif event_type == "PlayerKeyEvent" then
        BlzTriggerRegisterPlayerKeyEvent(trigger.__trigger_obj, event_data.__player, event_data.__key, event_data.__meta_key, event_data.__key_down)
        return true
    end
    return false
end

return Trigger