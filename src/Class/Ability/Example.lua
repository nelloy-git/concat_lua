--=========
-- Include
--=========

local Log = require('utils.Log')

---@type AbilityAPI
local Ability = require('Class.Ability.Api')
local TargetType = Ability.TargetType
local CallbackType = Ability.CallbackType
local Status = Ability.Status

---@type BetterTimerClass
local Timer = require('Class.Timer.BetterTimer')

local fmt = string.format

--=========
-- Ability
--=========

-- Ability type for using in casting system.
local ExampleAbility = Ability.newType('Example ability', TargetType.None)

-- ===========
--  Callbacks
-- ===========

local state = 0
local count = 11
local gl_timer = Timer.getGlobalTimer()
ExampleAbility:setCallback(CallbackType.START, function(data)
    local res = Status.OK

    if state % count == 0 then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to start normally.')
        res = Status.OK

    elseif state % count == 1 then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to be cancelled right now.')
        res = Status.CANCEL

    elseif state % count == 2 then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to be interrupted right now.')
        res = Status.INTERRUPT

    elseif state % count == 3 then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to be finished right now.')
        res = Status.FINISH

    elseif state % count == 4 then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to be removed right now.')
        res = Status.REMOVE

    elseif state % count == 5 then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to be cancelled after 1 sec.')
        gl_timer:addAction(1, function() data:cancel() end)
        res = Status.OK

    elseif state % count == 6 then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to be interrupted after 1 sec.')
        gl_timer:addAction(1, function() data:interrupt() end)
        res = Status.OK

    elseif state % count == 7 then
        Log(Log.Msg, ExampleAbility:getName(), 'casting have to be finished after 1 sec.')
        gl_timer:addAction(1, function() data:finish() end)
        res = Status.OK

    elseif state % count == 8 then
        Log(Log.Msg, ExampleAbility:getName(), 'caster can move while casting.')
        res = Status.OK

    elseif state % count == 9 then
        Log(Log.Msg, ExampleAbility:getName(), 'caster can attack while casting.')
        res = Status.OK

    elseif state % count == 10 then
        Log(Log.Msg, ExampleAbility:getName(), 'double casting is enabled.')
        res = Status.OK
    end

    state = state + 1
    return res
end)

ExampleAbility:setCallback(CallbackType.CASTING, function(data)
    local time_left = data:getTimeLeft()
    --Log(Log.Msg, ExampleAbility:getName(), fmt('Time left: %.1f', time_left))
    return Status.OK
end)

ExampleAbility:setCallback(CallbackType.CANCEL, function(data)
    Log(Log.Msg, ExampleAbility:getName(), fmt('casting cancelled. Time left: %.1f', data:getTimeLeft()))
end)

ExampleAbility:setCallback(CallbackType.INTERRUPT, function(data)
    Log(Log.Msg, ExampleAbility:getName(), fmt('casting interrupted. Time left: %.1f', data:getTimeLeft()))
end)

ExampleAbility:setCallback(CallbackType.FINISH, function(data)
    Log(Log.Msg, ExampleAbility:getName(), fmt('casting finished. Time left: %.1f', data:getTimeLeft()))
end)

ExampleAbility:setCallback(CallbackType.GET_TIME, function(data)
    local caster = data:getCaster()
    local full_time = BlzGetUnitMaxHP(caster) / 100
    if full_time < 3 then
        full_time = 3
    end
    return full_time
end)

ExampleAbility:setCallback(CallbackType.CASTER_CAN_MOVE, function(data)
    if state == 9 then
        return true
    end
    return false
end)

ExampleAbility:setCallback(CallbackType.CASTER_CAN_ATTACK, function(data)
    if state == 10 then
        return true
    end
    return false
end)

ExampleAbility:setCallback(CallbackType.IGNORE_CANCEL_BY_OTHER_CASTS, function(data)
    if state == 11 then
        return true
    end
    return false
end)

return ExampleAbility