--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

--=======
-- Class
--=======

local Trigger = Class.new('Trigger', Handle)
---@class Trigger : Handle
local public = Trigger.public
---@class TriggerClass : HandleClass
local static = Trigger.static
---@type TriggerClass
local override = Trigger.override
local private = {}

--========
-- Static
--========

---@param child Trigger | nil
---@return Trigger
function override.new(child)
    if child then isTypeErr(child, Trigger, 'child') end

    local instance = child or Class.allocate(Trigger)
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
    TriggerExecute(self:getData())
end

---@param var_name string
---@param opcode limitop
---@param limitval number
function public:addVariableEvent(var_name, opcode, limitval)
    isTypeErr(var_name, 'string', 'var_name')
    isTypeErr(opcode, 'limitop', 'opcode')
    isTypeErr(limitval, 'number', 'limitval')
    TriggerRegisterVariableEvent(self:getData(), var_name, opcode, limitval)
end

---@param timeout number
---@param periodic boolean
function public:addTimerEvent(timeout, periodic)
    TriggerRegisterTimerEvent(self:getData(), timeout, periodic)
end

---@param timer timer
function public:addTimerExpireEvent(timer)
    TriggerRegisterTimerExpireEvent(self:getData(), timer)
end

---@param game_state gamestate
---@param opcode limitop
---@param limitval number
function public:addGameStateEvent(game_state, opcode, limitval)
    TriggerRegisterGameStateEvent(self:getData(), game_state, opcode, limitval)
end

---@param dialog dialog
function public:addDialogEvent(dialog)
    TriggerRegisterDialogEvent(self:getData(), dialog)
end

---@param button button
function public:addDialogButtonEvent(button)
    TriggerRegisterDialogButtonEvent(self:getData(), button)
end

---@param game_event gameevent
function public:addGameEvent(game_event)
    TriggerRegisterGameEvent(self:getData(), game_event)
end

---@param region region
function public:addEnterRegion(region)
    TriggerRegisterEnterRegion(self:getData(), region)
end

---@param region region
function public:addLeaveRegion(region)
    TriggerRegisterLeaveRegion(self:getData(), region)
end

---@param trackable trackable
function public:addTrackableHitEvent(trackable)
    TriggerRegisterTrackableHitEvent(self:getData(), trackable)
end

---@param trackable trackable
function public:addTrackableTrackEvent(trackable)
    TriggerRegisterTrackableTrackEvent(self:getData(), trackable)
end

---@param player_event_type playerevent
---@param player player
function public:addPlayerEvent(player_event_type, player)
    TriggerRegisterPlayerEvent(self:getData(), player, player_event_type)
end

---@param player_unit_event playerunitevent
---@param player player
function public:addPlayerUnitEvent(player_unit_event, player)
    TriggerRegisterPlayerUnitEvent(self:getData(), player, player_unit_event, nil)
end

---@param player player
---@param alliancetype alliancetype
function public:addPlayerAllianceChange(player, alliancetype)
    TriggerRegisterPlayerAllianceChange(self:getData(), player, alliancetype)
end

---@param player player
---@param player_state playerstate
---@param opcode limitop
---@param limitval number
function public:addPlayerStateEvent(player, player_state, opcode, limitval)
    TriggerRegisterPlayerStateEvent(self:getData(), player, player_state, opcode, limitval)
end

---@param player player
---@param message string
---@param exact_match boolean
function public:addPlayerChatEvent(player, message, exact_match)
    TriggerRegisterPlayerChatEvent(self:getData(), player, message, exact_match)
end

---@param widget widget
function public:addDeathEvent(widget)
    TriggerRegisterDeathEvent(self:getData(), widget)
end

---@param unit unit
---@param unit_state unitstate
---@param opcode limitop
---@param limitval number
function public:addUnitStateEvent(unit, unit_state, opcode, limitval)
    TriggerRegisterUnitStateEvent(self:getData(), unit, unit_state, opcode, limitval)
end

---@param unit_event unitevent
---@param unit unit
function public:addUnitEvent(unit_event, unit)
    TriggerRegisterUnitEvent(self:getData(), unit_event, unit)
end

---@param unit unit
---@param range number
function public:addUnitInRange(unit, range)
    TriggerRegisterUnitInRange(self:getData(), unit, range)
end

---@param frame framehandle
---@param frame_event frameeventtype
function public:addFrameEvent(frame, frame_event)
    BlzTriggerRegisterFrameEvent(self:getData(), frame, frame_event)
end

---@param player player
---@param prefix string
---@param from_server boolean
function public:addPlayerSyncEvent(player, prefix, from_server)
    BlzTriggerRegisterPlayerSyncEvent(self:getData(), player, prefix, from_server)
end

---@param player player
---@param key oskeytype
---@param meta_key integer
---@param key_down boolean
function public:addPlayerKeyEvent(player, key, meta_key, key_down)
    BlzTriggerRegisterPlayerKeyEvent(self:getData(), player, key, meta_key, key_down)
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

    TriggerAddAction(self:getData(), function() priv.action_list:run() end)
end

return static