---@type Settings
local Settings = require('utils.Settings')

local UnitApplyParameter = {}

local attack_dispertion = Settings.UnitParameters.attack_dispersion

---Generated ability for crit chance, crit damage and dodge.
---@type string
local crit_and_dodge_id = compiletime(function()
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilId()
    local we_abil = WeObjEdit.Ability.BladeMasterCriticalStrike.new(id)
    we_abil:setName("CriticalStrikeAndDodge")
    we_abil:setLevels(1)
    we_abil:setDamageMultiplier(1, 1)
    we_abil:setChancetoCriticalStrike(0, 1)
    we_abil:setDamageBonus(0, 1)
    we_abil:setChancetoEvade(0, 1)
    we_abil:setNeverMiss(true, 1)
    we_abil:setHeroAbility(false)
    return ID(id)
end)

---Generated ability for magic resistance.
---@type string
local resist_id = compiletime(function()
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilId()
    local we_abil = WeObjEdit.Ability.RunedBracers.new(id)
    we_abil:setName("Resistance")
    we_abil:setLevels(1)
    we_abil:setDamageReduction(0, 1)
    return ID(id)
end)

local book_id = compiletime(function()
    if not WeObjEdit then print('WeObjEdit module is not loaded.') return nil end
    local id = WeObjEdit.Utils.nextAbilId()
    local order_id = WeObjEdit.Utils.nextOrderId()
    ---@type SpellBookWeAbility
    local we_abil = WeObjEdit.Ability.SpellBook.new(id)
    we_abil:setName("UnitParametersKeeper")
    we_abil:setLevels(1)
    we_abil:setMaximumSpells(11, 1)
    we_abil:setSharedSpellCooldown(false, 1)
    we_abil:setSpellList(ID2str(crit_and_dodge_id)..','..ID2str(resist_id))
    we_abil:setMinimumSpells(0, 1)
    we_abil:setBaseOrderID(order_id, 1)
    return ID(id)
end)

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.attack(wc3_unit, val)
    local k = 1 - attack_dispertion
    local dmg = k * val
    local dice_sides = 2 * attack_dispertion * val

    BlzSetUnitBaseDamage(wc3_unit, math.floor(dmg), 0)
    BlzSetUnitDiceNumber(wc3_unit, 1, 0)
    BlzSetUnitDiceSides(wc3_unit, math.floor(dice_sides + 1), 0)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.attackSpeed(wc3_unit, val)
    BlzSetUnitAttackCooldown(wc3_unit, val, 0)
    BlzSetUnitAttackCooldown(wc3_unit, val, 1)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.armor(wc3_unit, val)
    BlzSetUnitArmor(wc3_unit, math.floor(val))
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.spellPower(wc3_unit, val)
    -- TODO
end


---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.castSpeed(wc3_unit, val)
    -- TODO
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.resistance(wc3_unit, val)
    if GetUnitAbilityLevel(wc3_unit, book_id) <= 0 then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
    end
    local unit_ability = BlzGetUnitAbility(wc3_unit, resist_id)
    BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 1, val)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.cooldown(wc3_unit, val)
    -- TODO
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.health(wc3_unit, val)
    BlzSetUnitMaxHP(wc3_unit, math.floor(val))
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.regeneration(wc3_unit, val)
    BlzSetUnitRealField(wc3_unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, val)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.mana(wc3_unit, val)
    BlzSetUnitMaxMana(wc3_unit, math.floor(val))
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.recovery(wc3_unit, val)
    BlzSetUnitRealField(wc3_unit, UNIT_RF_MANA_REGENERATION, val)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.critChance(wc3_unit, val)
    if GetUnitAbilityLevel(wc3_unit, book_id) <= 0 then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
    end
    local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
    BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 1, val)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.critPower(wc3_unit, val)
    if GetUnitAbilityLevel(wc3_unit, book_id) <= 0 then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
    end
    local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
    BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 1, val)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.dodgeChance(wc3_unit, val)
    val = val / 100 -- percents to [0:1]
    if GetUnitAbilityLevel(wc3_unit, book_id) <= 0 then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
    end
    local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
    BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 1, val)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.strength(wc3_unit, val)
    SetHeroStr(wc3_unit, math.floor(val), true)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.agility(wc3_unit, val)
    SetHeroAgi(wc3_unit, math.floor(val), true)
end

---@param wc3_unit wc3_Unit
---@param val number
---@return nil
function UnitApplyParameter.strength(wc3_unit, val)
    SetHeroInt(wc3_unit, math.floor(val), true)
end

return UnitApplyParameter