--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ActionClass
local Action = require('Utils.Action')
---@type TriggerObjClass
local TriggerObj = require('Object.Trigger')

--=======
-- Class
--=======

local Trigger = Class.new('Trigger', TriggerObj)
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
function override.new(child_instance)
    local instance = child_instance or Class.allocate(Trigger)
    instance = TriggerObj.new(instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param callback Callback
---@return Action
function public:addAction(callback)
    local priv = private.data[self]

    local action = Action.new(callback)
    table.insert(priv.actions, #priv.actions + 1, action)

    return action
end

---@param action Action
---@return boolean
function public:removeAction(action)
    local priv = private.data[self]

    for i = 1, #priv.actions do
        if priv.actions[i] == action then
            table.remove(priv.actions, i)
            return true
        end
    end

    return false
end

---@return number
function public:countActions()
    return #private.data[self].actions
end

---Function removes all actions from trigger without removing trigger.
function public:clearActions()
    private.data[self].actions = {}
end

---Function executes trigger like event do.
function public:execute()
    TriggerExecute(self:getObj())
end

---@param var_name string
---@param opcode limitop
---@param limitval number
function public:addVariableEvent(var_name, opcode, limitval)
    TriggerRegisterVariableEvent(self:getObj(), var_name, opcode, limitval)
end

---@param timeout number
---@param periodic boolean
function public:addTimerEvent(timeout, periodic)
    TriggerRegisterTimerEvent(self:getObj(), timeout, periodic)
end

---@param timer timer
function public:addTimerExpireEvent(timer)
    TriggerRegisterTimerExpireEvent(self:getObj(), timer)
end

---@param game_state gamestate
---@param opcode limitop
---@param limitval number
function public:addGameStateEvent(game_state, opcode, limitval)
    TriggerRegisterGameStateEvent(self:getObj(), game_state, opcode, limitval)
end

---@param dialog dialog
function public:addDialogEvent(dialog)
    TriggerRegisterDialogEvent(self:getObj(), dialog)
end

---@param button button
function public:addDialogButtonEvent(button)
    TriggerRegisterDialogButtonEvent(self:getObj(), button)
end

---@param game_event gameevent
function public:addGameEvent(game_event)
    TriggerRegisterGameEvent(self:getObj(), game_event)
end

---@param region region
function public:addEnterRegion(region)
    TriggerRegisterEnterRegion(self:getObj(), region)
end

---@param region region
function public:addLeaveRegion(region)
    TriggerRegisterLeaveRegion(self:getObj(), region)
end

---@param trackable trackable
function public:addTrackableHitEvent(trackable)
    TriggerRegisterTrackableHitEvent(self:getObj(), trackable)
end

---@param trackable trackable
function public:addTrackableTrackEvent(trackable)
    TriggerRegisterTrackableTrackEvent(self:getObj(), trackable)
end

---@param player_event_type playerevent
---@param player player
function public:addPlayerEvent(player_event_type, player)
    TriggerRegisterPlayerEvent(self:getObj(), player, player_event_type)
end

---@param player_unit_event playerunitevent
---@param player player
function public:addPlayerUnitEvent(player_unit_event, player)
    TriggerRegisterPlayerUnitEvent(self:getObj(), player, player_unit_event, nil)
end

---@param player player
---@param alliancetype alliancetype
function public:addPlayerAllianceChange(player, alliancetype)
    TriggerRegisterPlayerAllianceChange(self:getObj(), player, alliancetype)
end

---@param player player
---@param player_state playerstate
---@param opcode limitop
---@param limitval number
function public:addPlayerStateEvent(player, player_state, opcode, limitval)
    TriggerRegisterPlayerStateEvent(self:getObj(), player, player_state, opcode, limitval)
end

---@param player player
---@param message string
---@param exact_match boolean
function public:addPlayerChatEvent(player, message, exact_match)
    TriggerRegisterPlayerChatEvent(self:getObj(), player, message, exact_match)
end

---@param widget widget
function public:addDeathEvent(widget)
    TriggerRegisterDeathEvent(self:getObj(), widget)
end

---@param unit unit
---@param unit_state unitstate
---@param opcode limitop
---@param limitval number
function public:addUnitStateEvent(unit, unit_state, opcode, limitval)
    TriggerRegisterUnitStateEvent(self:getObj(), unit, unit_state, opcode, limitval)
end

---@param unit_event unitevent
---@param unit unit
function public:addUnitEvent(unit_event, unit)
    TriggerRegisterUnitEvent(self:getObj(), unit_event, unit)
end

---@param unit unit
---@param range number
function public:addUnitInRange(unit, range)
    TriggerRegisterUnitInRange(self:getObj(), unit, range)
end

---@param frame framehandle
---@param frame_event frameeventtype
function public:addFrameEvent(frame, frame_event)
    BlzTriggerRegisterFrameEvent(self:getObj(), frame, frame_event)
end

---@param player player
---@param prefix string
---@param from_server boolean
function public:addPlayerSyncEvent(player, prefix, from_server)
    BlzTriggerRegisterPlayerSyncEvent(self:getObj(), player, prefix, from_server)
end

---@param player player
---@param key oskeytype
---@param meta_key integer
---@param key_down boolean
function public:addPlayerKeyEvent(player, key, meta_key, key_down)
    BlzTriggerRegisterPlayerKeyEvent(self:getObj(), player, key, meta_key, key_down)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Trigger
function private.newData(self)
    local priv = {
        actions = {}
    }
    private.data[self] = priv

    TriggerAddAction(self:getObj(), function() private.runActions(priv.actions) end)
end

---@param actions Action[]
function private.runActions(actions)
    for i = 1, #actions do
        actions[i]:run()
    end
end

return static