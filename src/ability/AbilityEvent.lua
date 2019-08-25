---@type AbilityDB
local AbilityDB = require('ability.AbilityDB')
---@type UnitEvent
local UnitEvent = require('trigger.events.unitEvent')
---@type CasterDB
local CasterDB = require('ability.CasterDB')
---@type SpellData
local SpellData = require('ability.SpellData')
---@type Timer
local CastTimer = glTimer

---@alias AbilityEventName string
---| '"start"'       #Callback is called when unit starts casting.
---| '"casting"'     #Callback is called every loop of timer while unit is casting an ability.
---| '"interrupt"'   #Callback is called when unit interrupted casting.
---| '"finish"'      #Callback is called if casting was not interrupted and cast time passed.

---@class AbilityEvent
local AbilityEvent = {}

function AbilityEvent.init()
    ---@type Trigger
    UnitEvent.getTrigger("AnyUnitStartChannelAbility"):addAction(AbilityEvent.startCast, nil)
end

---@return wc3_Unit|wc3_Item|wc3_Destructable|nil
function AbilityEvent.getSpellTarget()
    local target = GetSpellTargetUnit()
    if not target then target = GetSpellTargetItem() end
    if not target then target = GetSpellTargetDestructable() end
    return target
end

---Calls this function when any unit starts casting ability.
---@return nil
function AbilityEvent.startCast()
    Debug("Cast start")
    ---@type Ability
    local ability = AbilityDB.get(GetSpellAbilityId())
    if ability == nil then return nil end

    local target = AbilityEvent.getSpellTarget()
    local caster = GetSpellAbilityUnit()
    local x = GetSpellTargetX()
    local y = GetSpellTargetY()
    local spell_data = SpellData.new(ability, caster, target, x, y)
    local cast_time = ability:getCastingTime(spell_data)
    spell_data:setCastTime(cast_time)

    local continue = ability:runCallback("start", spell_data)
    if not continue then caster:orderStop() return nil end

    if not ability:getCanMoveWhileCasting() then

    end
    CastTimer:addAction(0, AbilityEvent.timerPeriod, spell_data)
    CasterDB.add(caster, spell_data)
    Debug("Cast started")
end

---Global timer calls this function every loop for every casting ability.
---@param spell_data SpellData
function AbilityEvent.timerPeriod(spell_data)
    -- Unit started another casting.
    if spell_data ~= CasterDB.get(spell_data:getCaster()) then
        local abil = spell_data:getAbility()
        abil:runCallback("interrupt", spell_data)
        return nil
    end

    local delta = CastTimer:getPeriod()
    spell_data:addTime(delta)
    if spell_data:isFinished() then
        local abil = spell_data:getAbility()
        abil:runCallback("finish", spell_data)
        CasterDB.rm(spell_data:getCaster())
        return nil
    end

    -- Should unit continue casting or its broken by other reasons.
    local abil = spell_data:getAbility()
    local continue = abil:runCallback('casting', spell_data)
    if continue then
        CastTimer:addAction(0, AbilityEvent.timerPeriod, spell_data)
    else
        abil:runCallback("interrupt", spell_data)
        CasterDB.rm(spell_data:getCaster())
    end
end

return AbilityEvent