---@type Settings
local Settings = require('utils.Settings')

local UnitApplyParameter = {}

local attack_dispersion = Settings.UnitParameters.attack_dispersion

---Generated ability for critical chance, critical damage and dodge.
---@type string
local critical_and_dodge_id = compiletime(function()
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilityId()
    local we_ability = WeObjEdit.Ability.BladeMasterCriticalStrike.new(id)
    we_ability:setName("CriticalStrikeAndDodge")
    we_ability:setLevels(1)
    we_ability:setDamageMultiplier(1, 1)
    we_ability:setCriticalStrikeChance(0, 1)
    we_ability:setDamageBonus(0, 1)
    we_ability:setEvadeChance(0, 1)
    we_ability:setNeverMiss(true, 1)
    we_ability:setHeroAbility(false)
    return ID(id)
end)

---Generated ability for magic resistance.
---@type string
local resist_id = compiletime(function()
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilityId()
    local we_ability = WeObjEdit.Ability.RunedBracers.new(id)
    we_ability:setName("Resistance")
    we_ability:setLevels(1)
    we_ability:setDamageReduction(0, 1)
    return ID(id)
end)

local book_id = compiletime(function()
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilityId()
    local order_id = WeObjEdit.Utils.nextOrderId()
    ---@type SpellBookWeAbility
    local we_ability = WeObjEdit.Ability.SpellBook.new(id)
    we_ability:setName("UnitParametersKeeper")
    we_ability:setLevels(1)
    we_ability:setMaximumSpells(11, 1)
    we_ability:setSharedSpellCooldown(false, 1)
    we_ability:setSpellList(ID2str(critical_and_dodge_id)..','..ID2str(resist_id))
    we_ability:setMinimumSpells(0, 1)
    we_ability:setBaseOrderID(order_id, 1)
    return ID(id)
end)

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.attack(unit, value)
    local k = 1 - attack_dispersion
    local dmg = k * value
    local dice_sides = 2 * attack_dispersion * value

    BlzSetUnitBaseDamage(unit, math.floor(dmg), 0)
    BlzSetUnitDiceNumber(unit, 1, 0)
    BlzSetUnitDiceSides(unit, math.floor(dice_sides + 1), 0)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.attackSpeed(unit, value)
    BlzSetUnitAttackCooldown(unit, value, 0)
    BlzSetUnitAttackCooldown(unit, value, 1)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.armor(unit, value)
    BlzSetUnitArmor(unit, math.floor(value))
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.spellPower(unit, value)
    -- TODO
    unit = nil
    value = nil
end


---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.castSpeed(unit, value)
    -- TODO
    unit = nil
    value = nil
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.resistance(unit, value)
    if GetUnitAbilityLevel(unit, book_id) <= 0 then
        UnitAddAbility(unit, book_id)
        BlzUnitHideAbility(unit, book_id, true)
    end
    local unit_ability = BlzGetUnitAbility(unit, resist_id)
    BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 1, value)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.cooldown(unit, value)
    -- TODO
    unit = nil
    value = nil
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.health(unit, value)
    BlzSetUnitMaxHP(unit, math.floor(value))
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.regeneration(unit, value)
    BlzSetUnitRealField(unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.mana(unit, value)
    BlzSetUnitMaxMana(unit, math.floor(value))
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.recovery(unit, value)
    BlzSetUnitRealField(unit, UNIT_RF_MANA_REGENERATION, value)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.criticalChance(unit, value)
    if GetUnitAbilityLevel(unit, book_id) <= 0 then
        UnitAddAbility(unit, book_id)
        BlzUnitHideAbility(unit, book_id, true)
    end
    local unit_ability = BlzGetUnitAbility(unit, critical_and_dodge_id)
    BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 1, value)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.criticalPower(unit, value)
    if GetUnitAbilityLevel(unit, book_id) <= 0 then
        UnitAddAbility(unit, book_id)
        BlzUnitHideAbility(unit, book_id, true)
    end
    local unit_ability = BlzGetUnitAbility(unit, critical_and_dodge_id)
    BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 1, value)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.dodgeChance(unit, value)
    value = value / 100 -- percents to [0:1]
    if GetUnitAbilityLevel(unit, book_id) <= 0 then
        UnitAddAbility(unit, book_id)
        BlzUnitHideAbility(unit, book_id, true)
    end
    local unit_ability = BlzGetUnitAbility(unit, critical_and_dodge_id)
    BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 1, value)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.strength(unit, value)
    SetHeroStr(unit, math.floor(value), true)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.agility(unit, value)
    SetHeroAgi(unit, math.floor(value), true)
end

---@param unit unit
---@param value number
---@return nil
function UnitApplyParameter.intelligence(unit, value)
    SetHeroInt(unit, math.floor(value), true)
end

return UnitApplyParameter