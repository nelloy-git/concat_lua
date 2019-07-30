---@class UnitApplyParameter
local UnitApplyParameter = {}

local attack_dispertion = 0.15

---@alias UnitApplyParameterFunc fun(owner:UnitObject, val:number):nil

---@type UnitApplyParameterFunc
UnitApplyParameter.attack = function(owner, val)
    local k = 1 - attack_dispertion
    local dmg = k * val
    local dice_sides = 2 * attack_dispertion * val

    BlzSetUnitBaseDamage(owner, math.floor(dmg), 0)
    BlzSetUnitDiceNumber(owner, 1, 0)
    BlzSetUnitDiceSides(owner, math.floor(dice_sides + 1), 0)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.attackSpeed = function(owner, val)
    BlzSetUnitAttackCooldown(owner, val, 0)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.armor = function(owner, val)
    BlzSetUnitArmor(owner, val)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.spellPower = function(owner, val)
    -- TODO
end

---@type UnitApplyParameterFunc
UnitApplyParameter.castSpeed = function(owner, val)
    -- TODO
end

local resist_id = compiletime(function()
    ---@type ObjEdit
    local objEdit = require('compiletime.objEdit.objEdit')
    local id = objEdit.Utils.nextAbilId()
    local we_abil = objEdit.Ability.RunedBracers.new(id)
    we_abil:setLevels(1)
    we_abil:setDamageReduction(0, 1)
    return id
end)

---@type UnitApplyParameterFunc
UnitApplyParameter.resistance = function(owner, val)
    if GetUnitAbilityLevel(owner, FourCC(resist_id)) == 0 then
        UnitAddAbility(owner, FourCC(resist_id))
    end
    local abil = BlzGetUnitAbility(owner, FourCC(resist_id))
    BlzSetAbilityRealLevelField(abil, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 0, val)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.cooldown = function(owner, val)
    -- TODO
end

---@type UnitApplyParameterFunc
UnitApplyParameter.health = function(owner, val)
    BlzSetUnitMaxHP(owner, math.floor(val))
end

---@type UnitApplyParameterFunc
UnitApplyParameter.regeneration = function(owner, val)
    BlzSetUnitRealField(owner, UNIT_RF_HIT_POINTS_REGENERATION_RATE, val)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.mana = function(owner, val)
    BlzSetUnitMaxMana(owner, math.floor(val))
end

---@type UnitApplyParameterFunc
UnitApplyParameter.recovery = function(owner, val)
    BlzSetUnitRealField(owner, UNIT_RF_MANA_REGENERATION, val)
end

local crit_and_dodge_id = compiletime(function()
    local objEdit = require('compiletime.objEdit.objEdit')
    local id = objEdit.Utils.nextAbilId()
    local we_abil = objEdit.Ability.BladeMasterCriticalStrike.new(id)
    we_abil:setLevels(1)
    we_abil:setDamageMultiplier(1, 1)
    we_abil:setChancetoCriticalStrike(0, 1)
    we_abil:setDamageBonus(0, 1)
    we_abil:setChancetoEvade(0, 1)
    we_abil:setNeverMiss(true, 1)
    return id
end)

---@type UnitApplyParameterFunc
UnitApplyParameter.critChance = function(owner, val)
    if GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0 then
        UnitAddAbility(owner, FourCC(crit_and_dodge_id))
    end
    local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
    BlzSetAbilityRealLevelField(abil, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 0, val)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.critPower = function(owner, val)
    if GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0 then
        UnitAddAbility(owner, FourCC(crit_and_dodge_id))
    end
    local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
    BlzSetAbilityRealLevelField(abil, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 0, val)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.dodgeChance = function(owner, val)
    val = val / 100 -- percents to [0:1]
    if GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0 then
        UnitAddAbility(owner, FourCC(crit_and_dodge_id))
    end
    local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
    BlzSetAbilityRealLevelField(abil, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 0, val)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.strength = function(owner, val)
    SetHeroStr(owner, math.floor(val), true)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.agility = function(owner, val)
    SetHeroAgi(owner, math.floor(val), true)
end

---@type UnitApplyParameterFunc
UnitApplyParameter.strength = function(owner, val)
    SetHeroInt(owner, math.floor(val), true)
end

return UnitApplyParameter