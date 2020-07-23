--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkTypeErr = Functions.checkTypeErr
---@type ActionClass
local Action = require(lib_modname..'.Action')
---@type ActionListClass
local ActionList = require(lib_modname..'.ActionList')
--endregion

--=======
-- Class
--=======

local Trigger = Class.new('Trigger', Handle)
--region Class
---@class Trigger : Handle
local public = Trigger.public
---@class TriggerClass : HandleClass
local static = Trigger.static
---@type TriggerClass
local override = Trigger.override
local private = {}
--endregion

--========
-- Static
--========

---@param child_instance Trigger | nil
---@return Trigger
function override.new(child_instance)
    if child_instance then
        checkTypeErr(child_instance, Trigger, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Trigger)
    instance = Handle.new(CreateTrigger(), DestroyTrigger, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param callback Callback
---@return Action
function public:addAction(callback)
    return private.data[self].action_list:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    return private.data[self].action_list:remove(action)
end

---@return number
function public:countActions()
    return private.data[self].action_list:count()
end

---Function removes all actions from trigger without removing trigger.
function public:clearActions()
    private.data[self].action_list:clear()
end

---Function executes trigger like event do.
function public:execute()
    TriggerExecute(self:getHandleData())
end

---@param var_name string
---@param opcode limitop
---@param limitval number
function public:addVariableEvent(var_name, opcode, limitval)
    checkTypeErr(var_name, 'string', 'var_name')
    checkTypeErr(opcode, 'limitop', 'opcode')
    checkTypeErr(limitval, 'number', 'limitval')
    TriggerRegisterVariableEvent(self:getHandleData(), var_name, opcode, limitval)
end

---@param timeout number
---@param periodic boolean
function public:addTimerEvent(timeout, periodic)
    TriggerRegisterTimerEvent(self:getHandleData(), timeout, periodic)
end

---@param timer timer
function public:addTimerExpireEvent(timer)
    TriggerRegisterTimerExpireEvent(self:getHandleData(), timer)
end

---@param game_state gamestate
---@param opcode limitop
---@param limitval number
function public:addGameStateEvent(game_state, opcode, limitval)
    TriggerRegisterGameStateEvent(self:getHandleData(), game_state, opcode, limitval)
end

---@param dialog dialog
function public:addDialogEvent(dialog)
    TriggerRegisterDialogEvent(self:getHandleData(), dialog)
end

---@param button button
function public:addDialogButtonEvent(button)
    TriggerRegisterDialogButtonEvent(self:getHandleData(), button)
end

---@param game_event gameevent
function public:addGameEvent(game_event)
    TriggerRegisterGameEvent(self:getHandleData(), game_event)
end

---@param region region
function public:addEnterRegion(region)
    TriggerRegisterEnterRegion(self:getHandleData(), region)
end

---@param region region
function public:addLeaveRegion(region)
    TriggerRegisterLeaveRegion(self:getHandleData(), region)
end

---@param trackable trackable
function public:addTrackableHitEvent(trackable)
    TriggerRegisterTrackableHitEvent(self:getHandleData(), trackable)
end

---@param trackable trackable
function public:addTrackableTrackEvent(trackable)
    TriggerRegisterTrackableTrackEvent(self:getHandleData(), trackable)
end

---@param player_event_type playerevent
---@param player player
function public:addPlayerEvent(player_event_type, player)
    TriggerRegisterPlayerEvent(self:getHandleData(), player, player_event_type)
end

---@param player_unit_event playerunitevent
---@param player player
function public:addPlayerUnitEvent(player_unit_event, player)
    TriggerRegisterPlayerUnitEvent(self:getHandleData(), player, player_unit_event, nil)
end

---@param player player
---@param alliancetype alliancetype
function public:addPlayerAllianceChange(player, alliancetype)
    TriggerRegisterPlayerAllianceChange(self:getHandleData(), player, alliancetype)
end

---@param player player
---@param player_state playerstate
---@param opcode limitop
---@param limitval number
function public:addPlayerStateEvent(player, player_state, opcode, limitval)
    TriggerRegisterPlayerStateEvent(self:getHandleData(), player, player_state, opcode, limitval)
end

---@param player player
---@param message string
---@param exact_match boolean
function public:addPlayerChatEvent(player, message, exact_match)
    TriggerRegisterPlayerChatEvent(self:getHandleData(), player, message, exact_match)
end

---@param widget widget
function public:addDeathEvent(widget)
    TriggerRegisterDeathEvent(self:getHandleData(), widget)
end

---@param unit unit
---@param unit_state unitstate
---@param opcode limitop
---@param limitval number
function public:addUnitStateEvent(unit, unit_state, opcode, limitval)
    TriggerRegisterUnitStateEvent(self:getHandleData(), unit, unit_state, opcode, limitval)
end

---@param unit_event unitevent
---@param unit unit
function public:addUnitEvent(unit_event, unit)
    TriggerRegisterUnitEvent(self:getHandleData(), unit_event, unit)
end

---@param unit unit
---@param range number
function public:addUnitInRange(unit, range)
    TriggerRegisterUnitInRange(self:getHandleData(), unit, range)
end

---@param frame framehandle
---@param frame_event frameeventtype
function public:addFrameEvent(frame, frame_event)
    BlzTriggerRegisterFrameEvent(self:getHandleData(), frame, frame_event)
end

---@param player player
---@param prefix string
---@param from_server boolean
function public:addPlayerSyncEvent(player, prefix, from_server)
    BlzTriggerRegisterPlayerSyncEvent(self:getHandleData(), player, prefix, from_server)
end

---@param player player
---@param key oskeytype
---@param meta_key integer
---@param key_down boolean
function public:addPlayerKeyEvent(player, key, meta_key, key_down)
    BlzTriggerRegisterPlayerKeyEvent(self:getHandleData(), player, key, meta_key, key_down)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Trigger
function private.newData(self)
    local priv = {
        action_list = ActionList.new()
    }
    private.data[self] = priv

    TriggerAddAction(self:getHandleData(), function() priv.action_list:run() end)
end

return static