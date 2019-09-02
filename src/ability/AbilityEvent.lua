---@type Ability
local Ability = require('ability.Ability')
---@type UnitEvent
local UnitEvent = require('utils.trigger.events.UnitEvents')
---@type SpellData
local SpellData = require('ability.SpellData')
---@type Timer
local CastTimer = glTimer
local OrderId = require('assets.orderId')

---@alias AbilityEventName string
---| '"start"'       #Callback is called when unit starts casting.
---| '"casting"'     #Callback is called every loop of timer while unit is casting an ability.
---| '"cancel"'      #Callback is called when player cancels ability.
---| '"interrupt"'   #Callback is called when unit interrupted casting.
---| '"finish"'      #Callback is called if casting was not interrupted and cast time passed.

---@class AbilityEvent
local AbilityEvent = {}

local initialized = false
function AbilityEvent.init()
    if initialized then return nil end
    UnitEvent.init()
    UnitEvent.getTrigger("AnyUnitStartChannelAbility"):addAction(AbilityEvent.startCast)
    UnitEvent.getTrigger("AnyUnitIssuedAnyOrder"):addAction(AbilityEvent.unitIssuedOrder)
    initialized = true
end

---Calls this function when any unit starts casting ability.
function AbilityEvent.startCast()
    local ability = Ability.get(GetSpellAbilityId())
    if ability == nil then return nil end

    local spell_data = SpellData.new(ability,
                                     GetSpellAbilityUnit(),
                                     AbilityEvent.getSpellTarget(),
                                     GetSpellTargetPos())

    local continue = ability:runCallback("start", spell_data)
    if not continue then
        IssueImmediateOrderById(GetSpellAbilityUnit(), OrderId.Stop)
        return nil
    end

    CastTimer:addAction(0, AbilityEvent.timerPeriod, spell_data)
end

---Global timer calls this function every loop for every casting ability.
---@param spell_data SpellData
function AbilityEvent.timerPeriod(spell_data)
    ---Gets unit last casting data.
    local caster_data = SpellData.get(spell_data:getCaster())
    if caster_data ~= spell_data then
        --Debug('AbilityEvent error: caster data != spell instance data.')
        return nil
    end

    ---Is casting time passed?
    spell_data:addTime(CastTimer:getPeriod())
    if spell_data:isFinished() then
        spell_data:getAbility():runCallback("finish", spell_data)
        spell_data:destroy()
        return nil
    end

    ---Should unit continue casting or its interrupted.
    local continue = spell_data:getAbility():runCallback('casting', spell_data)
    if continue then
        CastTimer:addAction(0, AbilityEvent.timerPeriod, spell_data)
    else
        spell_data:getAbility():runCallback("interrupt", spell_data)
        spell_data:destroy()
    end
end

function AbilityEvent.unitIssuedOrder()
    local caster = GetSpellAbilityUnit()
    local caster_data = SpellData.get(caster)
    if not caster_data then return nil end
    local ability = caster_data:getAbility()

    if ability:getFlag("CanBeCanceled") and
            GetIssuedOrderId() == OrderId.Stop then
        SpellData.get(caster):destroy()
    end

    if ability:getFlag("CanBeCanceled") and
            ability:getFlag("CancelWithAnyOrder") then
        AbilityEvent.stopCasting(caster)
        ability:runCallback("cancel", caster_data)
    end
end

---@return unit|item|destructable|nil
function AbilityEvent.getSpellTarget()
    local target = GetSpellTargetUnit()
    if not target then target = GetSpellTargetItem() end
    if not target then target = GetSpellTargetDestructable() end
    return target
end

return AbilityEvent