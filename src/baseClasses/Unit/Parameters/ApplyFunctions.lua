---@type Settings
local Settings = require('utils.Settings')

local UnitParameterApplyFunction = {}

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setAttackDamage(unit, value)
    local dmg = (1 - Settings.Unit.attack_dispersion) * value
    local dice_sides = 2 * Settings.Unit.attack_dispersion * value

    BlzSetUnitBaseDamage(unit:getObj(), math.floor(dmg), 0)
    BlzSetUnitDiceNumber(unit:getObj(), 1, 0)
    BlzSetUnitDiceSides(unit:getObj(), math.floor(dice_sides + 1), 0)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setAttacksPerSecond(unit, value)
    BlzSetUnitAttackCooldown(unit:getObj(), 1 / value, 0)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setHealth(unit, value)
    local percent_hp = GetUnitLifePercent(unit:getObj())
    BlzSetUnitMaxHP(unit:getObj(), math.floor(value))
    SetUnitLifePercentBJ(unit:getObj(), percent_hp)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setRegeneration(unit, value)
    BlzSetUnitRealField(unit:getObj(), UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setMana(unit, value)
    local percent_mana = GetUnitManaPercent(unit:getObj())
    BlzSetUnitMaxMana(unit:getObj(), math.floor(value))
    SetUnitManaPercentBJ(unit:getObj(), percent_mana)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setRecovery(unit, value)
    BlzSetUnitRealField(unit:getObj(), UNIT_RF_MANA_REGENERATION, value)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setStrength(unit, value)
    -- Remove previous bonuses
    local prev_value = GetHeroStr(unit:getObj(), true)
    local p_dmg = prev_value * Settings.Unit.p_dmg_per_str
    local armor = prev_value * Settings.Unit.armor_per_str
    local health = prev_value * Settings.Unit.health_per_str

    unit:addPhysicalDamageBase(-p_dmg)
    unit:addArmorBase(-armor)
    unit:addMoveSpeedBase(-health)

    SetHeroStr(unit:getObj(), math.floor(value), true)

    -- Add new bonuses
    local new_value = GetHeroStr(unit:getObj(), true)
    p_dmg = new_value * Settings.Unit.p_dmg_per_str
    armor = new_value * Settings.Unit.armor_per_str
    health = new_value * Settings.Unit.health_per_str

    unit:addPhysicalDamageBase(p_dmg)
    unit:addArmorBase(armor)
    unit:addMoveSpeedBase(health)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setAgility(unit, value)
    -- Remove previous bonuses
    local prev_value = GetHeroAgi(unit:getObj(), true)
    local aspd = prev_value * Settings.Unit.attack_speed_per_agi
    local ct_reduc = prev_value * Settings.Unit.casting_time_reduction_per_agi
    local dodge = prev_value * Settings.Unit.dodge_chance_per_agi

    unit:addAttackSpeed(-aspd)
    unit:addCastingTimeReductionBase(-ct_reduc)
    unit:addDodgeChanceBase(-dodge)

    SetHeroAgi(unit:getObj(), math.floor(value), true)

    -- Add new bonuses
    local new_value = GetHeroAgi(unit:getObj(), true)
    aspd = new_value * Settings.Unit.attack_speed_per_agi
    ct_reduc = new_value * Settings.Unit.casting_time_reduction_per_agi
    dodge = new_value * Settings.Unit.dodge_chance_per_agi

    unit:addAttackSpeed(aspd)
    unit:addCastingTimeReductionBase(ct_reduc)
    unit:addDodgeChanceBase(dodge)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setIntelligence(unit, value)
    -- Remove previous bonuses
    local prev_value = GetHeroInt(unit:getObj(), true)
    local m_dmg = prev_value * Settings.Unit.m_dmg_per_int
    local cd_reduc = prev_value * Settings.Unit.cooldown_reduction_per_int
    local mana = prev_value * Settings.Unit.mana_per_int

    unit:addMagicalDamageBase(-m_dmg)
    unit:addCooldownReductionBase(-cd_reduc)
    unit:addManaBase(-mana)

    SetHeroInt(unit:getObj(), math.floor(value), true)

    -- Add new bonuses
    local new_value = GetHeroInt(unit:getObj(), true)
    m_dmg = new_value * Settings.Unit.m_dmg_per_int
    cd_reduc = new_value * Settings.Unit.cooldown_reduction_per_int
    mana = new_value * Settings.Unit.mana_per_int

    unit:addMagicalDamageBase(m_dmg)
    unit:addCooldownReductionBase(cd_reduc)
    unit:addManaBase(mana)
end

---@param unit Unit
---@param value number
function UnitParameterApplyFunction.setMoveSpeed(unit, value)
    if value <= 1 then
        SetUnitTurnSpeed(unit:getObj(), 0)
    else
        SetUnitTurnSpeed(unit:getObj(), GetUnitDefaultTurnSpeed(unit:getObj()))
    end
    SetUnitMoveSpeed(unit:getObj(), value)
end

return UnitParameterApplyFunction