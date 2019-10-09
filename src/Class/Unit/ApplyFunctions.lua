---@type Settings
local Settings = require('utils.Settings')

local ParameterType = require('Class.ParameterType.Id')

local ParameterTypeApplyFunction = {}

---@param unit Unit
---@param value number
local function setAttackDamage(unit, value)
    local dmg = (1 - Settings.Unit.attack_dispersion) * value
    local dice_sides = 2 * Settings.Unit.attack_dispersion * value

    BlzSetUnitBaseDamage(unit:getObj(), math.floor(dmg), 0)
    BlzSetUnitDiceNumber(unit:getObj(), 1, 0)
    BlzSetUnitDiceSides(unit:getObj(), math.floor(dice_sides + 1), 0)
end

---@param unit Unit
---@param value number
local function setAttacksPerSecond(unit, value)
    BlzSetUnitAttackCooldown(unit:getObj(), 1 / value, 0)
end

---@param unit Unit
---@param value number
local function setHealth(unit, value)
    local percent_hp = GetUnitLifePercent(unit:getObj())
    BlzSetUnitMaxHP(unit:getObj(), math.floor(value))
    SetUnitLifePercentBJ(unit:getObj(), percent_hp)
end

---@param unit Unit
---@param value number
local function setRegeneration(unit, value)
    BlzSetUnitRealField(unit:getObj(), UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@param unit Unit
---@param value number
local function setMana(unit, value)
    local percent_mana = GetUnitManaPercent(unit:getObj())
    BlzSetUnitMaxMana(unit:getObj(), math.floor(value))
    SetUnitManaPercentBJ(unit:getObj(), percent_mana)
end

---@param unit Unit
---@param value number
local function setRecovery(unit, value)
    BlzSetUnitRealField(unit:getObj(), UNIT_RF_MANA_REGENERATION, value)
end

---@param unit Unit
---@param value number
local function setStrength(unit, value)
    -- Remove previous bonuses
    local prev_value = GetHeroStr(unit:getObj(), true)
    local p_dmg = prev_value * Settings.Unit.p_dmg_per_str
    local armor = prev_value * Settings.Unit.armor_per_str
    local health = prev_value * Settings.Unit.health_per_str

    unit:addPhysicalDamage(-p_dmg, 0, 0)
    unit:addArmor(-armor, 0, 0)
    unit:addHealth(-health, 0, 0)

    SetHeroStr(unit:getObj(), math.floor(value), true)

    -- Add new bonuses
    local value = GetHeroStr(unit:getObj(), true)
    local p_dmg = value * Settings.Unit.p_dmg_per_str
    local armor = value * Settings.Unit.armor_per_str
    local health = value * Settings.Unit.health_per_str

    unit:addPhysicalDamage(p_dmg, 0, 0)
    unit:addArmor(armor, 0, 0)
    unit:addHealth(health, 0, 0)
end

---@param unit Unit
---@param value number
local function setAgility(unit, value)
    -- Remove previous bonuses
    local prev_value = GetHeroAgi(unit:getObj(), true)
    local aspd = prev_value * Settings.Unit.attack_speed_per_agi
    local ct_reduc = prev_value * Settings.Unit.casting_time_reduction_per_agi
    local dodge = prev_value * Settings.Unit.dodge_chance_per_agi

    unit:addMagicalDamage(-aspd, 0, 0)
    unit:addCooldownReduction(-ct_reduc, 0, 0)
    unit:addMana(-dodge, 0, 0)

    SetHeroAgi(unit:getObj(), math.floor(value), true)

    -- Add new bonuses
    local value = GetHeroAgi(unit:getObj(), true)
    local aspd = value * Settings.Unit.attack_speed_per_agi
    local ct_reduc = value * Settings.Unit.casting_time_reduction_per_agi
    local dodge = value * Settings.Unit.dodge_chance_per_agi

    unit:addMagicalDamage(aspd, 0, 0)
    unit:addCooldownReduction(ct_reduc, 0, 0)
    unit:addMana(dodge, 0, 0)
end

---@param unit Unit
---@param value number
local function setIntelligence(unit, value)
    -- Remove previous bonuses
    local prev_value = GetHeroInt(unit:getObj(), true)
    local m_dmg = prev_value * Settings.Unit.m_dmg_per_int
    local cd_reduc = prev_value * Settings.Unit.cooldown_reduction_per_int
    local mana = prev_value * Settings.Unit.mana_per_int

    unit:addMagicalDamage(-m_dmg, 0, 0)
    unit:addCooldownReduction(-cd_reduc, 0, 0)
    unit:addMana(-mana, 0, 0)

    SetHeroInt(unit:getObj(), math.floor(value), true)

    -- Add new bonuses
    local value = GetHeroInt(unit:getObj(), true)
    local m_dmg = value * Settings.Unit.m_dmg_per_int
    local cd_reduc = value * Settings.Unit.cooldown_reduction_per_int
    local mana = value * Settings.Unit.mana_per_int

    unit:addMagicalDamage(m_dmg, 0, 0)
    unit:addCooldownReduction(cd_reduc, 0, 0)
    unit:addMana(mana, 0, 0)
end

---@param unit Unit
---@param value number
local function setMoveSpeed(unit, value)
    if value <= 1 then
        SetUnitTurnSpeed(unit:getObj(), 0)
    else
        SetUnitTurnSpeed(unit:getObj(), GetUnitDefaultTurnSpeed(unit))
    end
    SetUnitMoveSpeed(unit:getObj(), value)
end

ParameterTypeApplyFunction[ParameterType.P_DMG] = setAttackDamage
ParameterTypeApplyFunction[ParameterType.ATKS_PER_SEC] = setAttacksPerSecond
ParameterTypeApplyFunction[ParameterType.ARMOR] = nil
ParameterTypeApplyFunction[ParameterType.P_DMG_REDUC] = nil
ParameterTypeApplyFunction[ParameterType.M_DMG] = nil
ParameterTypeApplyFunction[ParameterType.CAST_TIME_REDUC] = nil
ParameterTypeApplyFunction[ParameterType.RESIST] = nil
ParameterTypeApplyFunction[ParameterType.M_DMG_REDUC] = nil
ParameterTypeApplyFunction[ParameterType.DODGE_CH] = nil
ParameterTypeApplyFunction[ParameterType.CRIT_CH] = nil
ParameterTypeApplyFunction[ParameterType.CRIT_DMG] = nil
ParameterTypeApplyFunction[ParameterType.CD_REDUC] = nil
ParameterTypeApplyFunction[ParameterType.HP] = setHealth
ParameterTypeApplyFunction[ParameterType.REGEN] = setRegeneration
ParameterTypeApplyFunction[ParameterType.MP] = setMana
ParameterTypeApplyFunction[ParameterType.RECOV] = setRecovery
ParameterTypeApplyFunction[ParameterType.STR] = setStrength
ParameterTypeApplyFunction[ParameterType.AGI] = setAgility
ParameterTypeApplyFunction[ParameterType.INT] = setIntelligence
ParameterTypeApplyFunction[ParameterType.MS] = setMoveSpeed

return ParameterTypeApplyFunction