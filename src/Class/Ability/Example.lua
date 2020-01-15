--=========
-- Include
--=========

local Class = require('utils.Class.Class')

local Log = require('utils.Log')
---@type AbilityClass
local AbilityType = require('Class.Ability')
---@type AbilityCastInstanceClass
local AbilityInstance = require('Class.Ability.CastInstance')
---@type BetterTimerClass
local BetterTimer = require('Class.Timer.BetterTimer')

local fmt = string.format

--=========
-- Ability
--=========

local abil_name = 'Example ability'

--- Dummy wc3 ability type. createDummy returns table with changed
--- ability data and creates WeAbility object without animations and effects
--- in compiletime.
local Wc3Type = Compiletime(AbilityType.createDummy('point', abil_name))

--- Ability type for using in casting system.
local ExampleAbility = AbilityType.new(Wc3Type.id)
--- Callbacks container. Set Start, Casting, Cancel, Finish and Interrupt actions here.
local callbacks = ExampleAbility.callbacks
--- Flags container. Move and attack while casting can be enabled with it.
local flags = ExampleAbility.flags

--- Set function for casting time calculating.
callbacks:setCastingTime(function(cast_data)
    --local caster = AbilityInstance.getCaster()
    local full_time = 3
    Log(Log.Msg, abil_name, fmt('full casting time = %.2f', 3))
    return full_time
end)

--- Set callback for casting start. Should return true(default) if started successfully.
local state = "normal"
callbacks:setStart(function(cast_data)
    Log(Log.Msg, abil_name, 'got casting started event. Use more times for different tests.')

    local caster = cast_data:getCaster()
    Log(Log.Msg, abil_name, fmt('caster %s.', caster))
    if state == 'normal' then
        Log(Log.Msg, abil_name, 'casting have to start normally.')
        state = 'failed'
        return true
    elseif state == 'failed' then
        Log(Log.Msg, abil_name, 'casting have not to start.')
        state = 'interrupt'
        return false
    elseif state == 'interrupt' then
        local interrupt_time = cast_data:getFullCastingTime() / 2
        Log(Log.Msg, abil_name, fmt('casting have to be interrupted after %.2f sec.', interrupt_time))
        BetterTimer.getGlobalTimer():addAction(interrupt_time, function()
            if cast_data == AbilityInstance.get(caster) then
                cast_data:interrupt()
            end
        end)
        state = 'cancel'
        return true
    else
        local cancel_time = cast_data:getFullCastingTime() / 2
        Log(Log.Msg, abil_name, fmt('casting have to be canceled after %.2f sec.', cancel_time))
        BetterTimer.getGlobalTimer():addAction(cancel_time, function()
            if cast_data == AbilityInstance.get(caster) then
                cast_data:cancel()
            end
        end)
        state = 'normal'
        return true
    end
end)

local prev = -1
callbacks:setCasting(function(cast_data)
    local cur = cast_data:getCastingTimeLeft()
    if math.floor(cur) ~= prev then
        Log(Log.Msg, abil_name, fmt('casting time - %0.2f', cur))
        prev = math.floor(cur)
    end
end)

callbacks:setFinish(function()
    Log(Log.Msg, abil_name, 'casting finished')
end)

callbacks:setCancel(function()
    Log(Log.Msg, abil_name, 'casting canceled')
end)

callbacks:setInterrupt(function()
    Log(Log.Msg, abil_name, 'casting interrupted')
end)

return ExampleAbility