--=========
-- Include
--=========

---@type ActionClass
local Action = require('Class.Action')
---@type DataBaseClass
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

---@type TriggerClass
local Trigger = newClass('Trigger')

---@class TriggerClass
local static = Trigger.static
---@type table
local override = Trigger.override
---@class Trigger
local public = Trigger.public
---@type table(Trigger, table)
local private = {}

local db = DataBase.new('userdata', getClassName(Trigger))

--=========
-- Methods
--=========

---@param self Trigger
 function runActions(self)
    local priv = private[self]

    for i = 1, #priv.actions do
        priv.actions[i]:run()
    end
end

---@param instance_data table | nil
---@return Trigger
function static.new(instance_data)
    local instance = instance_data or newInstanceData(Trigger)
    local priv = {
        wc3_trigger = CreateTrigger(),
        actions = {}
    }
    private[instance] = priv

    db:add(priv.wc3_trigger, instance)
    TriggerAddAction(priv.wc3_trigger, function() runActions(instance) end)

    return instance
end

function public:free()
    DestroyTrigger(private[self].wc3_trigger)
    private[self] = nil
    freeInstanceData(self)
end

---@return Trigger
function static.getTriggering()
    local wc3_trigger = GetTriggeringTrigger()
    return db:get(wc3_trigger)
end

---@param callback fun(data:any):nil
---@return Action
function public:addAction(callback)
    local priv = private[self]

    local action = Action.new(callback)
    table.insert(priv.actions, #priv.actions + 1, action)

    return action
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private[self]

    for i = 1, #priv.actions do
        if priv.actions[i] == action then
            table.remove(priv.actions, i)
            return true
        end
    end

    return false
end

---Function removes all actions from trigger without removing trigger.
function public:clearActions()
    local priv = private[self]

    while #priv.actions > 0 do
        table.remove(priv.actions, 1)
    end
end

---Function executes trigger like event do.
function public:execute()
    local priv = private[self]

    -- Set active trigger
    local original = GetTriggeringTrigger
    GetTriggeringTrigger = function() return priv.wc3_trigger end
    -- Run trigger
    TriggerExecute(priv.wc3_trigger)
    -- Restore active trigger
    GetTriggeringTrigger = original
end

---@param var_name string
---@param opcode limitop
---@param limitval number
function public:addVariableEvent(var_name, opcode, limitval)
    local priv = private[self]
    TriggerRegisterVariableEvent(priv.wc3_trigger, var_name, opcode, limitval)
end

---@param timeout number
---@param periodic boolean
function public:addTimerEvent(timeout, periodic)
    local priv = private[self]
    TriggerRegisterTimerEvent(priv.wc3_trigger, timeout, periodic)
end

---@param timer timer
function public:addTimerExpireEvent(timer)
    local priv = private[self]
    TriggerRegisterTimerExpireEvent(priv.wc3_trigger, timer)
end

---@param game_state gamestate
---@param opcode limitop
---@param limitval number
function public:addGameStateEvent(game_state, opcode, limitval)
    local priv = private[self]
    TriggerRegisterGameStateEvent(priv.wc3_trigger, game_state, opcode, limitval)
end

---@param dialog dialog
function public:addDialogEvent(dialog)
    local priv = private[self]
    TriggerRegisterDialogEvent(priv.wc3_trigger, dialog)
end

---@param button button
function public:addDialogButtonEvent(button)
    local priv = private[self]
    TriggerRegisterDialogButtonEvent(priv.wc3_trigger, button)
end

---@param game_event gameevent
function public:addGameEvent(game_event)
    local priv = private[self]
    TriggerRegisterGameEvent(priv.wc3_trigger, game_event)
end

---@param region region
function public:addEnterRegion(region)
    local priv = private[self]
    TriggerRegisterEnterRegion(priv.wc3_trigger, region)
end

---@param region region
function public:addLeaveRegion(region)
    local priv = private[self]
    TriggerRegisterLeaveRegion(priv.wc3_trigger, region)
end

---@param trackable trackable
function public:addTrackableHitEvent(trackable)
    local priv = private[self]
    TriggerRegisterTrackableHitEvent(priv.wc3_trigger, trackable)
end

---@param trackable trackable
function public:addTrackableTrackEvent(trackable)
    local priv = private[self]
    TriggerRegisterTrackableTrackEvent(priv.wc3_trigger, trackable)
end

---@param player_event_type playerevent
---@param player player
function public:addPlayerEvent(player_event_type, player)
    local priv = private[self]
    TriggerRegisterPlayerEvent(priv.wc3_trigger, player_event_type, player)
end

---@param player_unit_event playerunitevent
---@param player player
function public:addPlayerUnitEvent(player_unit_event, player)
    local priv = private[self]
    TriggerRegisterPlayerUnitEvent(priv.wc3_trigger, player, player_unit_event, nil)
end

---@param player player
---@param alliancetype alliancetype
function public:addPlayerAllianceChange(player, alliancetype)
    local priv = private[self]
    TriggerRegisterPlayerAllianceChange(priv.wc3_trigger, player, alliancetype)
end

---@param player player
---@param player_state playerstate
---@param opcode limitop
---@param limitval number
function public:addPlayerStateEvent(player, player_state, opcode, limitval)
    local priv = private[self]
    TriggerRegisterPlayerStateEvent(priv.wc3_trigger, player, player_state, opcode, limitval)
end

---@param player player
---@param message string
---@param exact_match boolean
function public:addPlayerChatEvent(player, message, exact_match)
    local priv = private[self]
    TriggerRegisterPlayerChatEvent(priv.wc3_trigger, player, message, exact_match)
end

---@param widget widget
function public:addDeathEvent(widget)
    local priv = private[self]
    TriggerRegisterDeathEvent(priv.wc3_trigger, widget)
end

---@param unit unit
---@param unit_state unitstate
---@param opcode limitop
---@param limitval number
function public:addUnitStateEvent(unit, unit_state, opcode, limitval)
    local priv = private[self]
    TriggerRegisterUnitStateEvent(priv.wc3_trigger, unit, unit_state, opcode, limitval)
end

---@param unit_event unitevent
---@param unit unit
function public:addUnitEvent(unit_event, unit)
    local priv = private[self]
    TriggerRegisterUnitEvent(priv.wc3_trigger, unit_event, unit)
end

---@param unit unit
---@param range number
function public:addUnitInRange(unit, range)
    local priv = private[self]
    TriggerRegisterUnitInRange(priv.wc3_trigger, unit, range)
end

---@param frame framehandle
---@param frame_event frameeventtype
function public:addFrameEvent(frame, frame_event)
    local priv = private[self]
    BlzTriggerRegisterFrameEvent(priv.wc3_trigger, frame, frame_event)
end

---@param player player
---@param prefix string
---@param from_server boolean
function public:addPlayerSyncEvent(player, prefix, from_server)
    local priv = private[self]
    BlzTriggerRegisterPlayerSyncEvent(priv.wc3_trigger, player, prefix, from_server)
end

---@param player player
---@param key oskeytype
---@param meta_key integer
---@param key_down boolean
function public:addPlayerKeyEvent(player, key, meta_key, key_down)
    local priv = private[self]
    BlzTriggerRegisterPlayerKeyEvent(priv.wc3_trigger, player, key, meta_key, key_down)
end

return Trigger