---@type Settings
local Settings = require('utils.settings')
---@type Ability
local Ability = require('ability.ability')

---@class UnitApplyParameter
local UnitApplyParameter = {}

local attack_dispertion = Settings.UnitParameters.attack_dispersion

---Generated ability for crit chance, crit damage and dodge.
---@type string
local crit_and_dodge_id = compiletime(function()
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilId()
    local we_abil = WeObjEdit.Ability.BladeMasterCriticalStrike.new(id)
    we_abil:setLevels(1)
    we_abil:setDamageMultiplier(1, 1)
    we_abil:setChancetoCriticalStrike(0, 1)
    we_abil:setDamageBonus(0, 1)
    we_abil:setChancetoEvade(0, 1)
    we_abil:setNeverMiss(true, 1)
    return id
end)
local crit_and_dodge_abil = Ability.new(crit_and_dodge_id)

---Generated ability for magic resistance.
---@type string
local resist_id = compiletime(function()
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilId()
    local we_abil = WeObjEdit.Ability.RunedBracers.new(id)
    we_abil:setLevels(1)
    we_abil:setDamageReduction(0, 1)
    return id
end)
local resist_abil = Ability.new(resist_id)

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.attack(unit, val)
    local k = 1 - attack_dispertion
    local dmg = k * val
    local dice_sides = 2 * attack_dispertion * val

    local unit_obj = unit:getObj()
    BlzSetUnitBaseDamage(unit_obj, math.floor(dmg), 0)
    BlzSetUnitDiceNumber(unit_obj, 1, 0)
    BlzSetUnitDiceSides(unit_obj, math.floor(dice_sides + 1), 0)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.attackSpeed(unit, val)
    BlzSetUnitAttackCooldown(unit:getObj(), val, 0)
    BlzSetUnitAttackCooldown(unit:getObj(), val, 1)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.armor(unit, val)
    BlzSetUnitArmor(unit:getObj(), math.floor(val))
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.spellPower(unit, val)
    -- TODO
end


---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.castSpeed(unit, val)
    -- TODO
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.resistance(unit, val)
    if unit:getAbilityLevel(resist_abil) <= 0 then
        unit:addAbility(resist_abil)
    end
    --Debug('Resist')
    unit:changeAbilityField(resist_abil, val, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 1)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.cooldown(unit, val)
    -- TODO
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.health(unit, val)
    BlzSetUnitMaxHP(unit:getObj(), math.floor(val))
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.regeneration(unit, val)
    BlzSetUnitRealField(unit:getObj(), UNIT_RF_HIT_POINTS_REGENERATION_RATE, val)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.mana(unit, val)
    BlzSetUnitMaxMana(unit:getObj(), math.floor(val))
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.recovery(unit, val)
    BlzSetUnitRealField(unit:getObj(), UNIT_RF_MANA_REGENERATION, val)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.critChance(unit, val)
    if unit:getAbilityLevel(crit_and_dodge_abil) <= 0 then
        unit:addAbility(crit_and_dodge_abil)
    end
    --Debug('Crit chance')
    unit:changeAbilityField(crit_and_dodge_abil, val, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 1)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.critPower(unit, val)
    if unit:getAbilityLevel(crit_and_dodge_abil) <= 0 then
        unit:addAbility(crit_and_dodge_abil)
    end
    --Debug('Crit damage')
    unit:changeAbilityField(crit_and_dodge_abil, val, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 1)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.dodgeChance(unit, val)
    val = val / 100 -- percents to [0:1]
    if unit:getAbilityLevel(crit_and_dodge_abil) <= 0 then
        unit:addAbility(crit_and_dodge_abil)
    end
    --Debug('Evade')
    unit:changeAbilityField(crit_and_dodge_abil, val, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 1)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.strength(unit, val)
    SetHeroStr(unit:getObj(), math.floor(val), true)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.agility(unit, val)
    SetHeroAgi(unit:getObj(), math.floor(val), true)
end

---@param unit Unit
---@param val number
---@return nil
function UnitApplyParameter.strength(unit, val)
    SetHeroInt(unit:getObj(), math.floor(val), true)
end

return UnitApplyParameter