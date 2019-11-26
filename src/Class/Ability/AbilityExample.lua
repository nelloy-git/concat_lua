--=========
-- Include
--=========

---@type AbilityTypeClass
local AbilityType = require('Class.Ability.AbilityType')
---@type AbilityInstanceClass
local AbilityInstance = require('Class.Ability.AbilityInstance')
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
local Wc3Type = compiletime(AbilityType.createDummy('point', abil_name))

--- Ability type for using in casting system.
local ExampleAbility = AbilityType.new(Wc3Type.id)
--- Callbacks container. Set Start, Casting, Cancel, Finish and Interrupt actions here.
local callbacks = ExampleAbility.callbacks
--- Flags container. Move and attack while casting can be enabled with it.
local flags = ExampleAbility.flags

--- Set function for casting time calculating.
ExampleAbility:setCastingTime(function()
    local caster = AbilityInstance.getCaster()
    local full_time = GetUnitState(caster, UNIT_STATE_MAX_LIFE) / 100
    Debug(fmt('%s message: full casting time = %f (hp / 100)', abil_name, full_time))
    return full_time
end)

--- Set callback for casting start. Should return true(default) if started successfully.
local state = "normal"
callbacks:setStart(function()
    Debug(fmt('%s message: got casting started event. Use more times for different tests.', abil_name))

    local caster = AbilityInstance.getCaster()
    Debug(fmt('%s message: caster %s', abil_name, caster))
    if state == 'normal' then
        Debug(fmt('%s message: casting have to start nolmally.', abil_name))
        state = 'failed'
        return true
    elseif state == 'failed' then
        Debug(fmt('%s message: casting have not to start.', abil_name))
        state = 'interrupt'
        return false
    elseif state == 'interrupt' then
        local interrupt_time = AbilityInstance.getFullCastingTime(caster) / 2
        Debug(fmt('%s message: casting have to be interrupted at %.2f.', abil_name, interrupt_time))
        --- Save current ability instance to make sure we are interrupting right one.
        local cur_instance = AbilityInstance.get(caster)
        BetterTimer.getGlobalTimer():addAction(interrupt_time, function()
            if cur_instance == AbilityInstance.get(caster) then
                AbilityInstance.interruptCurrent(caster)
            end
        end)
        state = 'cancel'
        return true
    else
        local cancel_time = AbilityInstance.getFullCastingTime(caster) / 2
        Debug(fmt('%s message: casting have to be canceled at %.2f.', abil_name, cancel_time))
        --- Save current ability instance to make sure we are canceling right one.
        local cur_instance = AbilityInstance.get(caster)
        BetterTimer.getGlobalTimer():addAction(cancel_time, function()
            if cur_instance == AbilityInstance.get(caster) then
                AbilityInstance.cancelCurrent(caster)
            end
        end)
        state = 'normal'
        return true
    end
end)

local prev = -1
callbacks:setCasting(function()
    local caster = AbilityInstance.getCaster()
    local cur = AbilityInstance.getCastingTimeLeft(caster)
    if math.floor(cur) ~= prev then
        Debug(string.format("Casting time: %0.2f", cur))
        prev = math.floor(cur)
    end
end)

callbacks:setFinish(function()
    Debug('Casting finished')
end)

callbacks:setCancel(function()
    Debug('Casting canceled')
end)

callbacks:setInterrupt(function()
    Debug('Casting interrupted')
end)

return ExampleAbility