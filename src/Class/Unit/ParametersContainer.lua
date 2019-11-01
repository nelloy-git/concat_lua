--=========
-- Include
--=========

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Unit
local Unit = require('Class.Unit.Main')
---@type ParameterValues
local ParameterValues = require('Include.ParameterValues')
---@type ParameterType
local ParameterType = require('Include.ParameterType')
---@type Settings
local Settings = require('utils.Settings')
---@type UnitEvent
local UnitEvent = require('Class.Unit.Event')

--============
-- Predefined
--============

local addParameterValue

--=======
-- Class
--=======

---@class UnitParameterContainer
---@type UnitParameterContainer
local UnitParametersContainer  = newClass("UnitParameterContainer")
UnitParametersContainer_meta = newMeta(UnitParametersContainer)
UnitParametersContainer.__db = DataBase.new('Unit', 'UnitParameterContainer')

---@param owner Unit
---@return UnitParameterContainer
function UnitParametersContainer.new(owner)
    -- Initialize start parameters.
    local base = Settings.Unit.StartingParameter
    local container = {}
    container[ParameterType.P_DMG]           = ParameterValues.new(ParameterType.P_DMG,           base.P_DMG,           1, 0)
    container[ParameterType.ATKS_PER_SEC]    = ParameterValues.new(ParameterType.ATKS_PER_SEC,    base.ATKS_PER_SEC,    1, 0)
    container[ParameterType.ARMOR]           = ParameterValues.new(ParameterType.ARMOR,           base.ARMOR,           1, 0)
    container[ParameterType.P_DMG_REDUC]     = ParameterValues.new(ParameterType.P_DMG_REDUC,     base.P_DMG_REDUC,     1, 0)
    container[ParameterType.M_DMG]           = ParameterValues.new(ParameterType.M_DMG,           base.M_DMG,           1, 0)
    container[ParameterType.CAST_TIME_REDUC] = ParameterValues.new(ParameterType.CAST_TIME_REDUC, base.CAST_TIME_REDUC, 1, 0)
    container[ParameterType.RESIST]          = ParameterValues.new(ParameterType.RESIST,          base.RESIST,          1, 0)
    container[ParameterType.M_DMG_REDUC]     = ParameterValues.new(ParameterType.M_DMG_REDUC,     base.M_DMG_REDUC,     1, 0)
    container[ParameterType.DODGE]           = ParameterValues.new(ParameterType.DODGE,           base.DODGE_CH,        1, 0)
    container[ParameterType.CRIT_CH]         = ParameterValues.new(ParameterType.CRIT_CH,         base.CRIT_CH,         1, 0)
    container[ParameterType.CRIT_DMG]        = ParameterValues.new(ParameterType.CRIT_DMG,        base.CRIT_DMG,        1, 0)
    container[ParameterType.CD_REDUC]        = ParameterValues.new(ParameterType.CD_REDUC,        base.CD_REDUC,        1, 0)
    container[ParameterType.HP]              = ParameterValues.new(ParameterType.HP,              base.HP,              1, 0)
    container[ParameterType.REGEN]           = ParameterValues.new(ParameterType.REGEN,           base.REGEN,           1, 0)
    container[ParameterType.MP]              = ParameterValues.new(ParameterType.MP,              base.MP,              1, 0)
    container[ParameterType.RECOV]           = ParameterValues.new(ParameterType.RECOV,           base.RECOV,           1, 0)
    container[ParameterType.STR]             = ParameterValues.new(ParameterType.STR,             base.STR,             1, 0)
    container[ParameterType.AGI]             = ParameterValues.new(ParameterType.AGI,             base.AGI,             1, 0)
    container[ParameterType.INT]             = ParameterValues.new(ParameterType.INT,             base.INT,             1, 0)
    container[ParameterType.MS]              = ParameterValues.new(ParameterType.MS,              base.MS,              1, 0)
    
    setmetatable(container, UnitParametersContainer_meta)
    UnitParametersContainer.__db:add(owner, container)

    owner:addPhysicalDamageBase(0)
    owner:addAttackSpeed(0)
    owner:addArmorBase(0)
    owner:addPhysicalDamageReductionRatingBase(0)
    owner:addMagicalDamageBase(0)
    owner:addCastingTimeReductionRatingBase(0)
    owner:addResistanceBase(0)
    owner:addMagicalDamageReductionRatingBase(0)
    owner:addDodgeChanceRatingBase(0)
    owner:addCriticalChanceRatingBase(0)
    owner:addCooldownReductionRatingBase(0)
    owner:addHealthBase(0)
    owner:addRegenerationBase(0)
    owner:addManaBase(0)
    owner:addRecoveryBase(0)
    owner:addStrengthBase(20)
    owner:addAgilityBase(0)
    owner:addIntelligenceBase(0)
    owner:addMoveSpeedBase(0)

    return container
end

function UnitParametersContainer:destroy()
    UnitParametersContainer.__db:remove(self.__owner)
end

Unit.addCreationFunction(function(owner) UnitParametersContainer.new(owner) end)
Unit.addRemovalFunction(function(owner) UnitParametersContainer.__db:remove(owner) end)

---@param owner Unit
---@return UnitParameterContainer
function UnitParametersContainer.get(owner)
    return UnitParametersContainer.__db:get(owner)
end

--================
-- Register event
--================

UnitEvent.UNIT_CHANGED_PARAMETER = UnitEvent.new('UNIT_CHANGED_PARAMETER')
---@return Unit
function UnitEvent.GetUnitWithChangedParameters() return nil end
---@return ParameterType
function UnitEvent.GetChangedParameterType() return nil end
---@return number
function UnitEvent.GetChangedParameterOldValue() return nil end
---@return number
function UnitEvent.GetChangedParameterNewValue() return nil end

---@param unit Unit
---@param param_type ParameterType
---@param old_value number
---@param new_value number
local function runUnitChangedParameterEvent(unit, param_type, old_value, new_value)
    -- Save previous variables.
    local prev_get_unit = UnitEvent.GetUnitWithChangedParameters
    local prev_get_name = UnitEvent.GetChangedParameterType
    local prev_get_old_val = UnitEvent.GetChangedParameterOldVaue
    local prev_get_new_val = UnitEvent.GetChangedParameterewValue
    -- Set new variables.
    UnitEvent.GetUnitWithChangedParameters = function() return unit end
    UnitEvent.GetChangedParameterType = function() return param_type end
    UnitEvent.GetChangedParameterOldValue = function() return old_value end
    UnitEvent.GetChangedParameterNewValue = function() return new_value end

    runFuncInDebug(UnitEvent.run, UnitEvent.UNIT_CHANGED_PARAMETER)

    -- Restore variables.
    UnitEvent.GetUnitWithChangedParameters = prev_get_unit
    UnitEvent.GetChangedParameterType = prev_get_name
    UnitEvent.GetChangedParameterOldValue = prev_get_old_val
    UnitEvent.GetChangedParameterNewValue = prev_get_new_val
end

---@param param ParameterType
---@param unit Unit
---@param base number
---@param mult number
---@param bonus number
addParameterValue = function (param, unit, base, mult, bonus)
    ---@type ParameterValues
    local values = UnitParametersContainer.get(unit)[param]
    local old = values:getResult()
    values:addAll(base, mult, bonus)
    local new = values:getResult()
    runUnitChangedParameterEvent(unit, param, old, new)

    return new
end

---@param param ParameterType
---@param unit Unit
---@return number
local function getResult(param, unit)
    ---@type ParameterValues
    local values = UnitParametersContainer.get(unit)[param]
    return values:getResult()
end

--==================
-- Physical damage.
--==================

local function applyAttackDmg(unit, value)
    local dmg = (1 - Settings.Unit.attack_dispersion) * value
    local dice_sides = 2 * Settings.Unit.attack_dispersion * value

    BlzSetUnitBaseDamage(unit:getObj(), math.floor(dmg), 0)
    BlzSetUnitDiceNumber(unit:getObj(), 1, 0)
    BlzSetUnitDiceSides(unit:getObj(), math.floor(dice_sides + 1), 0)
end

---@param value number
function Unit:addPhysicalDamageBase(value)
    local res = addParameterValue(ParameterType.P_DMG, self, value, 0, 0)
    applyAttackDmg(self, res)
end

---@param percent number
function Unit:addPhysicalDamagePercent(percent)
    local res = addParameterValue(ParameterType.P_DMG, self, 0, percent/100, 0)
    applyAttackDmg(self, res)
end

---@param value number
function Unit:addPhysicalDamageBonus(value)
    local res = addParameterValue(ParameterType.P_DMG, self, 0, 0, value)
    applyAttackDmg(self, res)
end

---@return number
function Unit:getPhysicalDamage()
    return getResult(ParameterType.P_DMG, self)
end

--===============
-- Attack speed.
--===============

---@param unit Unit
---@param value number
local function applyAttacksPerSecond(unit, value)
    BlzSetUnitAttackCooldown(unit:getObj(), 1 / value, 0)
end

---@param value number
function Unit:setAttacksPerSecBase(value)
    local param = ParameterType.ATKS_PER_SEC
    ---@type ParameterValues
    local values = UnitParametersContainer.get(self)[param]
    local cur_base = values:getBase()
    local diff = value - cur_base

    local old = values:getResult()
    values:addBase(diff)
    local new = values:getResult()

    runUnitChangedParameterEvent(self, param, old, new)
    applyAttacksPerSecond(self, new)
end

---@param percent number
function Unit:addAttackSpeed(percent)
    local res = addParameterValue(ParameterType.ATKS_PER_SEC, self, 0, percent/100, 0)
    applyAttacksPerSecond(self, res)
end

---@return number
function Unit:getAttacksPerSec()
    return getResult(ParameterType.ATKS_PER_SEC, self)
end

---@return number
function Unit:getAttackSpeedPercent()
    local param = ParameterType.ATKS_PER_SEC
    ---@type ParameterValues
    local values = UnitParametersContainer.get(self)[param]
    return 100 * values:getMult()
end

--========
-- Armor.
--========

---@param value number
function Unit:addArmorBase(value)
    addParameterValue(ParameterType.ARMOR, self, value, 0, 0)
end

---@param percent number
function Unit:addArmorPercent(percent)
    addParameterValue(ParameterType.ARMOR, self, 0, percent/100, 0)
end

---@param value number
function Unit:addArmorBonus(value)
    addParameterValue(ParameterType.ARMOR, self, 0, 0, value)
end

---@return number
function Unit:getArmor()
    return getResult(ParameterType.ARMOR, self)
end

--============================
-- Physical damage reduction.
--============================

---@param value number
function Unit:addPhysicalDamageReductionRatingBase(value)
    addParameterValue(ParameterType.P_DMG_REDUC, self, value, 0, 0)
end

---@param percent number
function Unit:addPhysicalDamageReductionRatingPercent(percent)
    addParameterValue(ParameterType.P_DMG_REDUC, self, 0, percent/100, 0)
end

---@param percent number
function Unit:addPhysicalDamageReductionOvercapPercent(percent)
    addParameterValue(ParameterType.P_DMG_REDUC, self, 0, 0, percent/100)
end

---@return number
function Unit:getPhysicalDamageReductionPercent()
    return 100 * getResult(ParameterType.P_DMG_REDUC, self)
end

--=================
-- Magical damage.
--=================

---@param value number
function Unit:addMagicalDamageBase(value)
    addParameterValue(ParameterType.M_DMG, self, value, 0, 0)
end

---@param percent number
function Unit:addMagicalDamagePercent(percent)
    addParameterValue(ParameterType.M_DMG, self, 0, percent/100, 0)
end

---@param value number
function Unit:addMagicalDamageBonus(value)
    addParameterValue(ParameterType.M_DMG, self, 0, 0, value)
end

---@return number
function Unit:getMagicalDamage()
    return getResult(ParameterType.M_DMG, self)
end

--=========================
-- Casting time reduction.
--=========================

---@param value number
function Unit:addCastingTimeReductionRatingBase(value)
    addParameterValue(ParameterType.CAST_TIME_REDUC, self, value, 0, 0)
end

---@param percent number
function Unit:addCastingTimeReductionRatingPercent(percent)
    addParameterValue(ParameterType.CAST_TIME_REDUC, self, 0, percent/100, 0)
end

---@param percent number
function Unit:addCastingTimeReductionOvercapPercent(percent)
    addParameterValue(ParameterType.CAST_TIME_REDUC, self, 0, 0, percent/100)
end

---@return number
function Unit:getCastingTimeReductionPercent()
    return 100 * getResult(ParameterType.CAST_TIME_REDUC, self)
end

--=============
-- Resistance.
--=============

---@param value number
function Unit:addResistanceBase(value)
    addParameterValue(ParameterType.RESIST, self, value, 0, 0)
end

---@param percent number
function Unit:addResistancePercent(percent)
    addParameterValue(ParameterType.RESIST, self, 0, percent/100, 0)
end

---@param value number
function Unit:addResistanceBonus(value)
    addParameterValue(ParameterType.RESIST, self, 0, 0, value)
end

---@return number
function Unit:getResistance()
    return getResult(ParameterType.RESIST, self)
end

--===========================
-- Magical damage reduction.
--===========================

---@param value number
function Unit:addMagicalDamageReductionRatingBase(value)
    addParameterValue(ParameterType.M_DMG_REDUC, self, value, 0, 0)
end

---@param percent number
function Unit:addMagicalDamageReductionRatingPercent(percent)
    addParameterValue(ParameterType.M_DMG_REDUC, self, 0, percent/100, 0)
end

---@param percent number
function Unit:addMagicalDamageReductionOvercapPercent(percent)
    addParameterValue(ParameterType.M_DMG_REDUC, self, 0, 0, percent/100)
end

---@return number
function Unit:getMagicalDamageReductionPercent()
    return 100 * getResult(ParameterType.M_DMG_REDUC, self)
end

--===============
-- Dodge chance.
--===============

---@param value number
function Unit:addDodgeChanceRatingBase(value)
    addParameterValue(ParameterType.DODGE, self, value, 0, 0)
end

---@param percent number
function Unit:addDodgeChanceRatingPercent(percent)
    addParameterValue(ParameterType.DODGE, self, 0, percent/100, 0)
end

---@param percent number
function Unit:addDodgeChanceOvercapPercent(percent)
    addParameterValue(ParameterType.DODGE, self, 0, 0, percent/100)
end

---@return number
function Unit:getDodgeChance()
    return 100 * getResult(ParameterType.DODGE, self)
end

--=========================
-- Critical strike chance.
--=========================

---@param value number
function Unit:addCriticalChanceRatingBase(value)
    addParameterValue(ParameterType.CRIT_CH, self, value, 0, 0)
end

---@param percent number
function Unit:addCriticalChanceRatingPercent(percent)
    addParameterValue(ParameterType.CRIT_CH, self, 0, percent/100, 0)
end

---@param percent number
function Unit:addCriticalChanceOvercapPercent(percent)
    addParameterValue(ParameterType.CRIT_CH, self, 0, 0, percent/100)
end

---@return number
function Unit:getCriticalChancePercent()
    return 100 * getResult(ParameterType.CRIT_CH, self)
end

--=========================
-- Critical strike damage.
--=========================

---@param percent number
function Unit:addCriticalDamagePercent(percent)
    addParameterValue(ParameterType.CRIT_DMG, self, percent/100, 0, 0)
end

---@return number
function Unit:getCriticalDamagePercent()
    return 100 * getResult(ParameterType.CRIT_DMG, self)
end

--====================
-- Coldown reduction.
--====================

---@param value number
function Unit:addCooldownReductionRatingBase(value)
    addParameterValue(ParameterType.CD_REDUC, self, value, 0, 0)
end

---@param percent number
function Unit:addCooldownReductionRatingPercent(percent)
    addParameterValue(ParameterType.CD_REDUC, self, 0, percent/100, 0)
end

---@param value number
function Unit:addCooldownReductionOvercapBonus(value)
    addParameterValue(ParameterType.CD_REDUC, self, 0, 0, value)
end

---@return number
function Unit:getCooldownReduction()
    return 100 * getResult(ParameterType.CRIT_DMG, self)
end

--=========
-- Health.
--=========

---@param unit Unit
---@param value number
local function applyHealth(unit, value)
    local percent_hp = GetUnitLifePercent(unit:getObj())
    BlzSetUnitMaxHP(unit:getObj(), math.floor(value))
    SetUnitLifePercentBJ(unit:getObj(), percent_hp)
end

---@param value number
function Unit:addHealthBase(value)
    local res = addParameterValue(ParameterType.HP, self, value, 0, 0)
    applyHealth(self, res)
end

---@param percent number
function Unit:addHealthPercent(percent)
    local res = addParameterValue(ParameterType.HP, self, 0, percent/100, 0)
    applyHealth(self, res)
end

---@param value number
function Unit:addHealthBonus(value)
    local res = addParameterValue(ParameterType.HP, self, 0, 0, value)
    applyHealth(self, res)
end

---@return number
function Unit:getHealth()
    return getResult(ParameterType.HP, self)
end

--===============
-- Regeneration.
--===============

---@param unit Unit
---@param value number
local function applyRegeneration(unit, value)
    BlzSetUnitRealField(unit:getObj(), UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@param value number
function Unit:addRegenerationBase(value)
    local res = addParameterValue(ParameterType.REGEN, self, value, 0, 0)
    applyRegeneration(self, res)
end

---@param percent number
function Unit:addRegenerationPercent(percent)
    local res = addParameterValue(ParameterType.REGEN, self, 0, percent/100, 0)
    applyRegeneration(self, res)
end

---@param value number
function Unit:addRegenerationBonus(value)
    local res = addParameterValue(ParameterType.REGEN, self, 0, 0, value)
    applyRegeneration(self, res)
end

---@return number
function Unit:getRegeneration()
    return getResult(ParameterType.REGEN, self)
end

--=========
-- Mana.
--=========

---@param unit Unit
---@param value number
local function applyMana(unit, value)
    local percent_mana = GetUnitManaPercent(unit:getObj())
    BlzSetUnitMaxMana(unit:getObj(), math.floor(value))
    SetUnitManaPercentBJ(unit:getObj(), percent_mana)
end

---@param value number
function Unit:addManaBase(value)
    local res = addParameterValue(ParameterType.MP, self, value, 0, 0)
    applyMana(self, res)
end

---@param percent number
function Unit:addManaPercent(percent)
    local res = addParameterValue(ParameterType.MP, self, 0, percent/100, 0)
    applyMana(self, res)
end

---@param value number
function Unit:addManaBonus(value)
    local res = addParameterValue(ParameterType.MP, self, 0, 0, value)
    applyMana(self, res)
end

---@return number
function Unit:getMana()
    return getResult(ParameterType.MP, self)
end

--===========
-- Recovery.
--===========

---@param unit Unit
---@param value number
local function applyRecovery(unit, value)
    BlzSetUnitRealField(unit:getObj(), UNIT_RF_MANA_REGENERATION, value)
end

---@param value number
function Unit:addRecoveryBase(value)
    local res = addParameterValue(ParameterType.RECOV, self, value, 0, 0)
    applyRecovery(self, res)
end

---@param percent number
function Unit:addRecoveryPercent(percent)
    local res = addParameterValue(ParameterType.RECOV, self, 0, percent/100, 0)
    applyRecovery(self, res)
end

---@param value number
function Unit:addRecoveryBonus(value)
    local res = addParameterValue(ParameterType.RECOV, self, 0, 0, value)
    applyRecovery(self, res)
end

---@return number
function Unit:getRecovery()
    return getResult(ParameterType.RECOV, self)
end

--===========
-- Strength.
--===========
---@param unit Unit
---@param old number
---@param new number
local function applyStrength(unit, old, new)
    local diff = new - old
    local p_dmg = diff * Settings.Unit.p_dmg_per_str
    local armor = diff * Settings.Unit.armor_per_str
    local health = diff * Settings.Unit.health_per_str

    SetHeroStr(unit:getObj(), math.floor(new), true)
    unit:addPhysicalDamageBase(p_dmg)
    unit:addArmorBase(armor)
    unit:addHealthBase(health)
end

---@param value number
function Unit:addStrengthBase(value)
    local old = getResult(ParameterType.STR, self)
    local new = addParameterValue(ParameterType.STR, self, value, 0, 0)
    applyStrength(self, old, new)
end

---@param percent number
function Unit:addStrengthPercent(percent)
    local old = getResult(ParameterType.STR, self)
    local new = addParameterValue(ParameterType.STR, self, 0, percent/100, 0)
    applyStrength(self, old, new)
end

---@param value number
function Unit:addStrengthBonus(value)
    local old = getResult(ParameterType.STR, self)
    local new = addParameterValue(ParameterType.STR, self, 0, 0, value)
    applyStrength(self, old, new)
end

---@return number
function Unit:getStrength()
    getResult(ParameterType.STR, self)
end

--==========
-- Agility.
--==========

---@param unit Unit
---@param old number
---@param new number
local function applyAgility(unit, old, new)
    -- Remove previous bonuses
    local diff = new - old
    local aspd = diff * Settings.Unit.attack_speed_per_agi
    local ct_reduc = diff * Settings.Unit.casting_time_reduction_per_agi
    local dodge = diff * Settings.Unit.dodge_chance_per_agi

    SetHeroAgi(unit:getObj(), math.floor(new), true)
    unit:addAttackSpeed(aspd)
    unit:addCastingTimeReductionRatingBase(ct_reduc)
    unit:addDodgeChanceRatingBase(dodge)
end

---@param value number
function Unit:addAgilityBase(value)
    local old = getResult(ParameterType.AGI, self)
    local new = addParameterValue(ParameterType.AGI, self, value, 0, 0)
    applyAgility(self, old, new)
end

---@param percent number
function Unit:addAgilityPercent(percent)
    local old = getResult(ParameterType.AGI, self)
    local new = addParameterValue(ParameterType.AGI, self, 0, percent/100, 0)
    applyAgility(self, old, new)
end

---@param value number
function Unit:addAgilityBonus(value)
    local old = getResult(ParameterType.AGI, self)
    local new = addParameterValue(ParameterType.AGI, self, 0, 0, value)
    applyAgility(self, old, new)
end

---@return number
function Unit:getAgility()
    return getResult(ParameterType.AGI)
end

--===============
-- Intelligence.
--===============

---@param unit Unit
---@param old number
---@param new number
local function applyIntelligence(unit, old, new)
    local diff = new - old
    local m_dmg = diff * Settings.Unit.m_dmg_per_int
    local cd_reduc = diff * Settings.Unit.cooldown_reduction_per_int
    local mana = diff * Settings.Unit.mana_per_int

    SetHeroInt(unit:getObj(), math.floor(new), true)
    unit:addMagicalDamageBase(m_dmg)
    unit:addCooldownReductionRatingBase(cd_reduc)
    unit:addManaBase(mana)
end

---@param value number
function Unit:addIntelligenceBase(value)
    local old = getResult(ParameterType.INT, self)
    local new = addParameterValue(ParameterType.INT, self, value, 0, 0)
    applyIntelligence(self, old, new)
end

---@param percent number
function Unit:addIntelligencePercent(percent)
    local old = getResult(ParameterType.INT, self)
    local new = addParameterValue(ParameterType.INT, self, 0, percent/100, 0)
    applyIntelligence(self, old, new)
end

---@param value number
function Unit:addIntelligenceBonus(value)
    local old = getResult(ParameterType.INT, self)
    local new = addParameterValue(ParameterType.INT, self, 0, 0, value)
    applyIntelligence(self, old, new)
end

---@return number
function Unit:getIntelligence()
    return getResult(ParameterType.INT)
end

--=============
-- Move speed.
--=============

---@param unit Unit
---@param value number
local function applyMoveSpeed(unit, value)
    if value <= 1 then
        SetUnitTurnSpeed(unit:getObj(), 0)
    else
        SetUnitTurnSpeed(unit:getObj(), GetUnitDefaultTurnSpeed(unit:getObj()))
    end
    SetUnitMoveSpeed(unit:getObj(), value)
end

---@param value number
function Unit:addMoveSpeedBase(value)
    local res = addParameterValue(ParameterType.MS, self, value, 0, 0)
    applyMoveSpeed(self, res)
end

---@param percent number
function Unit:addMoveSpeedPercent(percent)
    local res = addParameterValue(ParameterType.MS, self, 0, percent/100, 0)
    applyMoveSpeed(self, res)
end

---@param value number
function Unit:addMoveSpeedBonus(value)
    local res = addParameterValue(ParameterType.MS, self, 0, 0, value)
    applyMoveSpeed(self, res)
end

---@return number
function Unit:getMoveSpeed()
    getResult(ParameterType.MS)
end


return UnitParametersContainer