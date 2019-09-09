---@type Ability
local Ability = require('ability.Ability')
---@type UnitEvent
local UnitEvent = require('utils.trigger.events.UnitEvents')
---@type PlayerEvent
local PlayerEvent = require('utils.trigger.events.PlayerEvents')
---@type SpellCastingData
local SpellData = require('ability.events.SpellData')
---@type Settings
local Settings = require('utils.Settings')

---@class AbilityEvent
local AbilityEvent = {}

--- Predefined
local mainLoop
local cancelCasting
local getSpellTarget
local getSpellTargetPos
local unitIssuedAnyOrder

local initialized = false
function AbilityEvent.init()
    if initialized then return nil end

    UnitEvent.init()
    UnitEvent.getTrigger("AnyUnitStartCastingAbility"):addAction(AbilityEvent.unitStartsCasting)
    UnitEvent.getTrigger("AnyUnitIssuedAnyOrder"):addAction(unitIssuedAnyOrder)

    AbilityEvent.__cast_timer = glTimer
    AbilityEvent.__cast_timer_period = glTimer:getPeriod()

    initialized = true
end

function AbilityEvent.unitStartsCasting()
    local id = GetSpellAbilityId()
    local ability = Ability.get(id)
    if not ability then return nil end
    if id == ability:getDummyId() then return nil end

    local caster = GetSpellAbilityUnit()
    local data = SpellData.get(caster)
    if data then cancelCasting(data) end

    data = SpellData.new(ability, caster, getSpellTarget, getSpellTargetPos)
    ability:runCallback("Start", data)

    if not ability:getFlag("CanMoveWhileCasting") then
        data.__move_speed = GetUnitMoveSpeed(caster)
        SetUnitMoveSpeed(caster, 1)
    end

    AbilityEvent.__cast_timer:addAction(0, mainLoop, data)

    if Settings.Events.VerboseAbility then
        Debug("Casting started.")
    end
end

---@param caster_data SpellCastingData
---@return SpellCastingData | nil
mainLoop = function(caster_data)
    --- Is casting time passed?
    caster_data:addElapsedTime(AbilityEvent.__cast_timer_period)
    if caster_data:isFinished() then
        caster_data:getAbility():runCallback("Finish", caster_data)
        caster_data:destroy()

        if Settings.Events.VerboseAbility then
            Debug("Casting finished.")
        end
        return nil
    end

    --- Should unit continue casting or its interrupted.
    local continue = caster_data:getAbility():runCallback('Casting', caster_data)
    if continue then
        AbilityEvent.__cast_timer:addAction(0, AbilityEvent.castingLoop, caster_data)
    else
        caster_data:getAbility():runCallback("Interrupt", caster_data)
        caster_data:destroy()

        if Settings.Events.VerboseAbility then
            Debug("Casting interrupted.")
        end
    end
end

---@param data SpellCastingData
cancelCasting = function(data)
    data:getAbility():runCallback("Cancel", data)
    data:cancel()

    if not data:getAbility():getFlag("CanMoveWhileCasting") then
        SetUnitMoveSpeed(data:getCaster(), data.__move_speed)
    end

    if Settings.Events.VerboseAbility then
        Debug("Casting canceled.")
    end
end

unitIssuedAnyOrder = function()
    local data = SpellData.get(GetOrderedUnit())
    if not data then return nil end
    if data:getAbility():getFlag("CancelWithAnyOrder") then
        cancelCasting(data)
    end
end

---@return unit|item|destructable|nil
getSpellTarget = function()
    local target = GetSpellTargetUnit()
    if not target then target = GetSpellTargetItem() end
    if not target then target = GetSpellTargetDestructable() end
    return target
end

return AbilityEvent