---@type AbilityDB
local AbilityDB = require('ability.AbilityDB')
---@type UnitEvent
local UnitEvent = require('trigger.events.unitEvent')
---@type SpellInstance
local SpellInstance = require('ability.spellInstance')
---@type CasterDB
local CasterDB = require('ability.casterDB')

local AbilityEvent = {}

function AbilityEvent.init()
    ---@type Trigger
    UnitEvent.getTrigger("AnyUnitStartChannelAbility"):addAction(AbilityEvent.startCast, nil)
end

---@alias SpellTarget Unit|Item|Destructable|nil
---@return SpellTarget
function AbilityEvent.getSpellTarget()
    local target = GetSpellTargetUnit()
    if target == nil then target = GetSpellTargetItem() end
    if target == nil then target = GetSpellTargetDestructable() end
    return target
end

---Calls this function when eny unit starts casting ability.
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

    local continue = ability:runCallback('start', caster, target, x, y)
    if not continue then caster:orderStop() return nil end

    local data = SpellInstance.new(ability, caster, target, x, y, ability:getCastingTime(caster))
    glTimer.addAction(0, AbilityEvent.timerPeriod, data)
    CasterDB.add(caster, data)
    Debug("Cast start")
end

---CastTimer calls this function every loop for every casting ability.
---@param spell_data SpellInstance
---@return nil
function AbilityEvent.timerPeriod(spell_data)
    local ability, caster, target, x, y, cur_time, full_time = spell_data:getAll()
    local caster_data = CasterDB.get(caster)
    Debug(spell_data, caster_data)
    if caster_data ~= spell_data then
        ability:runCallback('interrupt', caster, target, x, y, cur_time, full_time)
        CasterDB.rm(caster)
        return nil
    end

    local delta = glTimer.getPrecision()
    cur_time = cur_time + delta
    if cur_time >= full_time then
        ability:runCallback('finish', caster, target, x, y, full_time)
        CasterDB.rm(caster)
        return nil
    end

    -- Should unit continue casting or its broken by casting reasons.
    local continue = ability:runCallback('casting', caster, target, x, y, cur_time, full_time)
    if continue then
        spell_data:addTime(delta)
        caster_data:addTime(delta)
        glTimer.addAction(0, AbilityEvent.timerPeriod, spell_data)
    else
        ability:runCallback('interrupt', caster, target, x, y, cur_time, full_time)
        CasterDB.rm(caster)
    end
end

---@param caster Unit
---@return Ability, number, number
function AbilityEvent.getUnitCastingData(caster)
    local data = CasterDB[caster]
    if data == nil then return nil, -1, -1 end
    return data.ability, data.time, data.full_time
end

return AbilityEvent