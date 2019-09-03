---@type Ability
local Ability = require('ability.Ability')
---@type UnitEvent
local UnitEvent = require('utils.trigger.events.UnitEvents')
---@type SpellData
local SpellData = require('ability.SpellData')
---@type DataBase
local DataBase = require('utils.DataBase')

local OrderId = require('assets.orderId')

---@alias AbilityEventName string
---| '"startTargeting"'     #Callback is called when player starts targeting ability.
---| '"finishTargeting"'    #Callback is called when player finishes targeting ability.
---| '"start"'              #Callback is called when unit starts casting.
---| '"casting"'            #Callback is called every loop of timer while unit is casting an ability.
---| '"cancel"'             #Callback is called when player cancels ability.
---| '"interrupt"'          #Callback is called when unit interrupted casting.
---| '"finish"'             #Callback is called if casting was not interrupted and cast time passed.

---@class AbilityEvent
local AbilityEvent = {
    __targeting_db = DataBase.new('userdata', 'Ability')
}

local initialized = false
function AbilityEvent.init()
    if initialized then return nil end
    UnitEvent.init()
    UnitEvent.getTrigger("AnyUnitStartChannelAbility"):addAction(AbilityEvent.startCast)
    UnitEvent.getTrigger("AnyUnitIssuedAnyOrder"):addAction(AbilityEvent.unitIssuedOrder)

    AbilityEvent.__cast_timer = glTimer
    AbilityEvent.__cast_timer_period = glTimer:getPeriod()
    initialized = true
end

---Calls this function when any unit starts casting ability.
function AbilityEvent.startCast()
    local id = GetSpellAbilityId()
    local caster = GetSpellAbilityId()
    local ability = Ability.getUIAbility(id)

    ---Unit used targeting instance ability.
    if ability then
        AbilityEvent.startTargetingAbility(caster, ability)
        return nil
    end

    ---Finish saved targeting.
    ability = AbilityEvent.__targeting_db:get(caster)
    if ability then
        AbilityEvent.finishTargetingAbility(caster, ability)
    end

    ability = Ability.get(id)
    if ability == nil then return nil end

    ---Unit used normal ability.
    local spell_data = SpellData.new(ability,
                                     caster,
                                     AbilityEvent.getSpellTarget(),
                                     GetSpellTargetPos())

    local continue = ability:runCallback("start", spell_data)
    if not continue then
        spell_data:destroy()
        return nil
    end

    AbilityEvent.__cast_timer:addAction(0, AbilityEvent.timerPeriod, spell_data)
end

---Global timer calls this function every loop for every casting ability.
---@param spell_data SpellData
function AbilityEvent.timerPeriod(spell_data)
    ---Gets unit current casting data.
    local caster_data = SpellData.get(spell_data:getCaster())
    if caster_data ~= spell_data then
        --Debug('AbilityEvent error: caster data != spell instance data.')
        return nil
    end

    ---Is casting time passed?
    spell_data:addTime(AbilityEvent.__cast_timer_period)
    if spell_data:isFinished() then
        spell_data:getAbility():runCallback("finish", spell_data)
        spell_data:destroy()
        return nil
    end

    ---Should unit continue casting or its interrupted.
    local continue = spell_data:getAbility():runCallback('casting', spell_data)
    if continue then
        AbilityEvent.__cast_timer:addAction(0, AbilityEvent.timerPeriod, spell_data)
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

---@param caster unit
---@param ability Ability
function AbilityEvent.startTargetingAbility(caster, ability)
    AbilityEvent.__targeting_db:add(caster, ability)
    UnitRemoveAbility(caster, ability:getUI_Id())
    UnitAddAbility(caster, ability:getId())
    ForceUIKeyBJ(GetOwningPlayer(caster), ability:getHotkey())
    ability:runCallback('startTargeting')
end

function AbilityEvent.finishTargetingAbility(caster, ability)
    AbilityEvent.__targeting_db:remove(caster)
    UnitRemoveAbility(caster, ability:getId())
    UnitAddAbility(caster, ability:getUI_Id())
    ability:runCallback('finishTargeting')
end

---@return unit|item|destructable|nil
function AbilityEvent.getSpellTarget()
    local target = GetSpellTargetUnit()
    if not target then target = GetSpellTargetItem() end
    if not target then target = GetSpellTargetDestructable() end
    return target
end

return AbilityEvent