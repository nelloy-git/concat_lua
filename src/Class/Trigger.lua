--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ActionClass
local Action = require('Class.Action')
---@type DataBaseClass
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

local Trigger = Class.new('Trigger')
---@class Trigger
local public = Trigger.public
---@class TriggerClass
local static = Trigger.static
---@type TriggerClass
local override = Trigger.override
local private = {}

--========
-- Static
--========

---@param child_instance Trigger | nil
---@return Trigger
function static.new(child_instance)
    local instance = child_instance or Class.allocate(Trigger)
    private.newData(instance)

    return instance
end

---@param wc3_trigger trigger
---@return Trigger
function static.get(wc3_trigger)
    return private.DB:get(wc3_trigger)
end

---@return Trigger
function static.getTriggering()
    return private.DB:get(GetTriggeringTrigger())
end

--========
-- Public
--========

---@param callback Callback
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
            action:free()
            return true
        end
    end

    return false
end

---Function removes all actions from trigger without removing trigger.
function public:clearActions()
    local priv = private[self]

    while #priv.actions > 0 do
        local cur = table.remove(priv.actions, 1)
        cur:free()
    end
end

---Function executes trigger like event do.
function public:execute()
    local priv = private[self]

    -- Set active trigger
    local original = _G.GetTriggeringTrigger
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
    TriggerRegisterVariableEvent(private[self].wc3_trigger, var_name, opcode, limitval)
end

---@param timeout number
---@param periodic boolean
function public:addTimerEvent(timeout, periodic)
    TriggerRegisterTimerEvent(private[self].wc3_trigger, timeout, periodic)
end

---@param timer timer
function public:addTimerExpireEvent(timer)
    TriggerRegisterTimerExpireEvent(private[self].wc3_trigger, timer)
end

---@param game_state gamestate
---@param opcode limitop
---@param limitval number
function public:addGameStateEvent(game_state, opcode, limitval)
    TriggerRegisterGameStateEvent(private[self].wc3_trigger, game_state, opcode, limitval)
end

---@param dialog dialog
function public:addDialogEvent(dialog)
    TriggerRegisterDialogEvent(private[self].wc3_trigger, dialog)
end

---@param button button
function public:addDialogButtonEvent(button)
    TriggerRegisterDialogButtonEvent(private[self].wc3_trigger, button)
end

---@param game_event gameevent
function public:addGameEvent(game_event)
    TriggerRegisterGameEvent(private[self].wc3_trigger, game_event)
end

---@param region region
function public:addEnterRegion(region)
    TriggerRegisterEnterRegion(private[self].wc3_trigger, region)
end

---@param region region
function public:addLeaveRegion(region)
    TriggerRegisterLeaveRegion(private[self].wc3_trigger, region)
end

---@param trackable trackable
function public:addTrackableHitEvent(trackable)
    TriggerRegisterTrackableHitEvent(private[self].wc3_trigger, trackable)
end

---@param trackable trackable
function public:addTrackableTrackEvent(trackable)
    TriggerRegisterTrackableTrackEvent(private[self].wc3_trigger, trackable)
end

---@param player_event_type playerevent
---@param player player
function public:addPlayerEvent(player_event_type, player)
    TriggerRegisterPlayerEvent(private[self].wc3_trigger, player_event_type, player)
end

---@param player_unit_event playerunitevent
---@param player player
function public:addPlayerUnitEvent(player_unit_event, player)
    TriggerRegisterPlayerUnitEvent(private[self].wc3_trigger, player, player_unit_event, nil)
end

---@param player player
---@param alliancetype alliancetype
function public:addPlayerAllianceChange(player, alliancetype)
    TriggerRegisterPlayerAllianceChange(private[self].wc3_trigger, player, alliancetype)
end

---@param player player
---@param player_state playerstate
---@param opcode limitop
---@param limitval number
function public:addPlayerStateEvent(player, player_state, opcode, limitval)
    TriggerRegisterPlayerStateEvent(private[self].wc3_trigger, player, player_state, opcode, limitval)
end

---@param player player
---@param message string
---@param exact_match boolean
function public:addPlayerChatEvent(player, message, exact_match)
    TriggerRegisterPlayerChatEvent(private[self].wc3_trigger, player, message, exact_match)
end

---@param widget widget
function public:addDeathEvent(widget)
    TriggerRegisterDeathEvent(private[self].wc3_trigger, widget)
end

---@param unit unit
---@param unit_state unitstate
---@param opcode limitop
---@param limitval number
function public:addUnitStateEvent(unit, unit_state, opcode, limitval)
    TriggerRegisterUnitStateEvent(private[self].wc3_trigger, unit, unit_state, opcode, limitval)
end

---@param unit_event unitevent
---@param unit unit
function public:addUnitEvent(unit_event, unit)
    TriggerRegisterUnitEvent(private[self].wc3_trigger, unit_event, unit)
end

---@param unit unit
---@param range number
function public:addUnitInRange(unit, range)
    TriggerRegisterUnitInRange(private[self].wc3_trigger, unit, range)
end

---@param frame framehandle
---@param frame_event frameeventtype
function public:addFrameEvent(frame, frame_event)
    BlzTriggerRegisterFrameEvent(private[self].wc3_trigger, frame, frame_event)
end

---@param player player
---@param prefix string
---@param from_server boolean
function public:addPlayerSyncEvent(player, prefix, from_server)
    BlzTriggerRegisterPlayerSyncEvent(private[self].wc3_trigger, player, prefix, from_server)
end

---@param player player
---@param key oskeytype
---@param meta_key integer
---@param key_down boolean
function public:addPlayerKeyEvent(player, key, meta_key, key_down)
    BlzTriggerRegisterPlayerKeyEvent(private[self].wc3_trigger, player, key, meta_key, key_down)
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('userdata', Trigger)

---@param instance Trigger
function private.newData(instance)
    local priv = {
        wc3_trigger = CreateTrigger(),
        actions = {}
    }
    private[instance] = priv
    private.DB:set(priv.wc3_trigger, instance)

    TriggerAddAction(priv.wc3_trigger, function() private.runActions(instance) end)
end

---@param self Trigger
function private.freeData(self)
    local priv = private[self]
    self:clearActions()
    DestroyTrigger(priv.wc3_trigger)
    private.DB:remove(priv.wc3_trigger)
    private[self] = nil
end

---@param self Trigger
function private.runActions(self)
    local priv = private[self]

    for i = 1, #priv.actions do
        priv.actions[i]:run()
    end
end

return static