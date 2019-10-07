---@type DataBase
local DataBase = require('utils.DataBase')
---@type Unit
local Unit = require('baseClasses.Unit.UnitData')
---@type UnitEvent
local UnitEvent = require('baseClasses.Unit.UnitEvent')
---@type UnitParameterType
local UnitParameterType = require('baseClasses.Unit.Parameters.Type')
---@type UnitParameterValue
local UnitParameterValue = require('baseClasses.Unit.Parameters.Value')
---@type Settings
local Settings = require('utils.Settings')

---@class UnitParameterContainer
local UnitParameterContainer  = newClass("UnitParameterContainer")
UnitParameterContainer_meta = newMeta(UnitParameterContainer)
UnitParameterContainer.__db = DataBase.new('Unit', 'UnitParameterContainer')

local initialized = false
function UnitParameterContainer.init()
    if initialized then return nil end
    --================
    -- Register event
    --================
    UnitEvent.UNIT_CHANGED_PARAMETERS = UnitEvent.new('UNIT_CHANGED_PARAMETERS')
    ---@return Unit
    function UnitEvent.GetUnitWithChangedParameters() return nil end
    ---@return UnitParameterType
    function UnitEvent.GetChangedParameterType() return nil end
    ---@return number
    function UnitEvent.GetChangedParameterOldValue() return nil end
    ---@return number
    function UnitEvent.GetChangedParameterNewValue() return nil end
    initialized = true
end

---@param owner Unit
---@return UnitParameterContainer
function UnitParameterContainer.new(owner)
    local container = {
        P_DMG = UnitParameterValue.new(owner, UnitParameterType.P_DMG, 1),
        ATKS_PER_SEC = UnitParameterValue.new(owner, UnitParameterType.ATKS_PER_SEC),
        ARMOR = UnitParameterValue.new(owner, UnitParameterType.ARMOR),
        P_DMG_REDUC = UnitParameterValue.new(owner, UnitParameterType.P_DMG_REDUC, -Settings.Unit.maximum_physical_damage_reduction, Settings.Unit.maximum_physical_damage_reduction),
        M_DMG = UnitParameterValue.new(owner, UnitParameterType.M_DMG),
        CAST_TIME_REDUC = UnitParameterValue.new(owner, UnitParameterType.CAST_TIME_REDUC, -Settings.Unit.maximum_casting_time_reduction, Settings.Unit.maximum_casting_time_reduction),
        RESIST = UnitParameterValue.new(owner, UnitParameterType.RESIST),
        M_DMG_REDUC = UnitParameterValue.new(owner, UnitParameterType.M_DMG_REDUC, -Settings.Unit.maximum_magical_damage_reduction, Settings.Unit.maximum_magical_damage_reduction),
        DODGE_CH = UnitParameterValue.new(owner, UnitParameterType.DODGE_CH, 0, Settings.Unit.maximum_dodge_chance),
        CRIT_CH = UnitParameterValue.new(owner, UnitParameterType.CRIT_CH, 0, Settings.Unit.maximum_crit_chance),
        CRIT_DMG = UnitParameterValue.new(owner, UnitParameterType.CRIT_DMG, 1, nil),
        CD_REDUC = UnitParameterValue.new(owner, UnitParameterType.CD_REDUC, -Settings.Unit.maximum_cooldown_reduction, Settings.Unit.maximum_cooldown_reduction),
        HP = UnitParameterValue.new(owner, UnitParameterType.HP),
        REGEN = UnitParameterValue.new(owner, UnitParameterType.REGEN),
        MP = UnitParameterValue.new(owner, UnitParameterType.MP),
        RECOV = UnitParameterValue.new(owner, UnitParameterType.RECOV),
        STR = UnitParameterValue.new(owner, UnitParameterType.STR),
        AGI = UnitParameterValue.new(owner, UnitParameterType.AGI),
        INT = UnitParameterValue.new(owner, UnitParameterType.INT),
        MS = UnitParameterValue.new(owner, UnitParameterType.MS, 1, 512)
    }
    setmetatable(container, UnitParameterContainer_meta)
    UnitParameterContainer.__db:add(owner, container)

    -- Initialize start parameters.
    local base = Settings.Unit.StartingParameter
    container.P_DMG:add(base.P_DMG, 0, 0)
    container.ATKS_PER_SEC:add(base.ATKS_PER_SEC, 0, 0)
    container.ARMOR:add(base.ARMOR, 0, 0)
    container.P_DMG_REDUC:add(base.P_DMG_REDUC, 0, 0)
    container.M_DMG:add(base.M_DMG, 0, 0)
    container.CAST_TIME_REDUC:add(base.CAST_TIME_REDUC, 0, 0)
    container.RESIST:add(base.RESIST, 0, 0)
    container.M_DMG_REDUC:add(base.M_DMG_REDUC, 0, 0)
    container.DODGE_CH:add(base.DODGE_CH, 0, 0)
    container.CRIT_CH:add(base.CRIT_CH, 0, 0)
    container.CRIT_DMG:add(base.CRIT_DMG, 0, 0)
    container.CD_REDUC:add(base.CD_REDUC, 0, 0)
    container.HP:add(base.HP, 0, 0)
    container.REGEN:add(base.REGEN, 0, 0)
    container.MP:add(base.MP, 0, 0)
    container.RECOV:add(base.RECOV, 0, 0)
    container.STR:add(base.STR, 0, 0)
    container.AGI:add(base.AGI, 0, 0)
    container.INT:add(base.INT, 0, 0)
    container.MS:add(base.MS, 0, 0)

    return container
end

function UnitParameterContainer:destroy()
    UnitParameterContainer.__db:remove(self.__owner)
end

Unit.addCreationFunction(function(owner) UnitParameterContainer.new(owner) end)
Unit.addRemovalFunction(function(owner) UnitParameterContainer.__db:remove(owner) end)

---@param owner Unit
---@param param string
---@return UnitParameterValue
local function getParam(owner, param)
    return UnitParameterContainer.__db:get(owner)[param]
end

---@param unit Unit
---@param param_type UnitParameterType
---@param old_value number
---@param new_value number
local function runEvent(unit, param_type, old_value, new_value)
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

    UnitEvent.UNIT_CHANGED_PARAMETERS:run()

    -- Restore variables.
    UnitEvent.GetUnitWithChangedParameters = prev_get_unit
    UnitEvent.GetChangedParameterType = prev_get_name
    UnitEvent.GetChangedParameterOldValue = prev_get_old_val
    UnitEvent.GetChangedParameterNewValue = prev_get_new_val
end

--==================
-- Physical damage.
--==================

---@param value number
function Unit:addPhysicalDamageBase(value)
    local param = getParam(self, 'P_DMG')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addPhysicalDamagePercent(percent)
    local param = getParam(self, 'P_DMG')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addPhysicalDamageBonus(value)
    local param = getParam(self, 'P_DMG')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getPhysicalDamage()
    local param = getParam(self, 'P_DMG')
    return param:get()
end

---@return number
function Unit:getPhysicalDamagePercent()
    local param = getParam(self, 'P_DMG')
    return 100 * param:getMult()
end

--===============
-- Attack speed.
--===============

---@param value number
function Unit:setAttacksPerSecBase(value)
    local param = getParam(self, 'ATKS_PER_SEC')
    local old = param:get()
    param:set(value, nil, nil)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addAttackSpeed(percent)
    local param = getParam(self, 'ATKS_PER_SEC')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getAttacksPerSec()
    local param = getParam(self, 'ATKS_PER_SEC')
    param:get()
end

---@return number
function Unit:getAttackSpeedPercent()
    local param = getParam(self, 'ATKS_PER_SEC')
    return 100 * param:getMult()
end

--========
-- Armor.
--========

---@param value number
function Unit:addArmorBase(value)
    local param = getParam(self, 'ARMOR')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addArmorPercent(percent)
    local param = getParam(self, 'ARMOR')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addArmorBonus(value)
    local param = getParam(self, 'ARMOR')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getArmor()
    local param = getParam(self, 'ARMOR')
    return param:get()
end

---@return number
function Unit:getArmorPercent()
    local param = getParam(self, 'ARMOR')
    return 100 * param:getMult()
end

--============================
-- Physical damage reduction.
--============================

---@param value number
function Unit:addPhysicalDamageReductionBase(value)
    local param = getParam(self, 'P_DMG_REDUC')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addPhysicalDamageReductionPercent(percent)
    local param = getParam(self, 'P_DMG_REDUC')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addPhysicalDamageReductionBonus(value)
    local param = getParam(self, 'P_DMG_REDUC')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getPhysicalDamageReduction()
    local param = getParam(self, 'P_DMG_REDUC')
    return param:get()
end

---@return number
function Unit:getPhysicalDamageReductionPercent()
    local param = getParam(self, 'P_DMG_REDUC')
    return 100 * param:getMult()
end

--=================
-- Magical damage.
--=================

---@param value number
function Unit:addMagicalDamageBase(value)
    local param = getParam(self, 'M_DMG')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addMagicalDamagePercent(percent)
    local param = getParam(self, 'M_DMG')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addMagicalDamageBonus(value)
    local param = getParam(self, 'M_DMG')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getMagicalDamage()
    local param = getParam(self, 'M_DMG')
    return param:get()
end

---@return number
function Unit:getMagicalDamagePercent()
    local param = getParam(self, 'M_DMG')
    return 100 * param:getMult()
end

--=========================
-- Casting time reduction.
--=========================

---@param value number
function Unit:addCastingTimeReductionBase(value)
    local param = getParam(self, 'CAST_TIME_REDUC')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addCastingTimeReductionPercent(percent)
    local param = getParam(self, 'CAST_TIME_REDUC')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addCastingTimeReductionBonus(value)
    local param = getParam(self, 'CAST_TIME_REDUC')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getCastingTimeReduction()
    local param = getParam(self, 'CAST_TIME_REDUC')
    return param:get()
end

---@return number
function Unit:getCastingTimeReductionPercent()
    local param = getParam(self, 'CAST_TIME_REDUC')
    return 100 * param:getMult()
end

--=============
-- Resistance.
--=============

---@param value number
function Unit:addResistanceBase(value)
    local param = getParam(self, 'RESIST')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addResistancePercent(percent)
    local param = getParam(self, 'RESIST')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addResistanceBonus(value)
    local param = getParam(self, 'RESIST')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getResistance()
    local param = getParam(self, 'RESIST')
    return param:get()
end

---@return number
function Unit:getResistancePercent()
    local param = getParam(self, 'RESIST')
    return 100 * param:getMult()
end


--===========================
-- Magical damage reduction.
--===========================

---@param value number
function Unit:addMagicalRamageReductionBase(value)
    local param = getParam(self, 'M_DMG_REDUC')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addMagicalRamageReductionPercent(percent)
    local param = getParam(self, 'M_DMG_REDUC')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addMagicalRamageReductionBonus(value)
    local param = getParam(self, 'M_DMG_REDUC')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getMagicalRamageReduction()
    local param = getParam(self, 'M_DMG_REDUC')
    return param:get()
end

---@return number
function Unit:getMagicalRamageReductionPercent()
    local param = getParam(self, 'M_DMG_REDUC')
    return 100 * param:getMult()
end

--===============
-- Dodge chance.
--===============

---@param value number
function Unit:addDodgeChanceBase(value)
    local param = getParam(self, 'DODGE_CH')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addDodgeChancePercent(percent)
    local param = getParam(self, 'DODGE_CH')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addDodgeChanceBonus(value)
    local param = getParam(self, 'DODGE_CH')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getDodgeChance()
    local param = getParam(self, 'DODGE_CH')
    return param:get()
end

---@return number
function Unit:getDodgeChancePercent()
    local param = getParam(self, 'DODGE_CH')
    return 100 * param:getMult()
end

--=========================
-- Critical strike chance.
--=========================

---@param value number
function Unit:addCriticalStrikeChanceBase(value)
    local param = getParam(self, 'CRIT_CH')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addCriticalStrikeChancePercent(percent)
    local param = getParam(self, 'CRIT_CH')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addCriticalStrikeChanceBonus(value)
    local param = getParam(self, 'CRIT_CH')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getCriticalStrikeChance()
    local param = getParam(self, 'CRIT_CH')
    return param:get()
end

---@return number
function Unit:getCriticalStrikeChancePercent()
    local param = getParam(self, 'CRIT_CH')
    return 100 * param:getMult()
end

--=========================
-- Critical strike damage.
--=========================

---@param value number
function Unit:addCriticalStrikeDamageBase(value)
    local param = getParam(self, 'CRIT_DMG')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addCriticalStrikeDamagePercent(percent)
    local param = getParam(self, 'CRIT_DMG')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addCriticalStrikeDamageBonus(value)
    local param = getParam(self, 'CRIT_DMG')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getCriticalStrikeDamage()
    local param = getParam(self, 'CRIT_DMG')
    return param:get()
end

---@return number
function Unit:getCriticalStrikeDamagePercent()
    local param = getParam(self, 'CRIT_DMG')
    return 100 * param:getMult()
end

--====================
-- Coldown reduction.
--====================

---@param value number
function Unit:addCooldownReductionBase(value)
    local param = getParam(self, 'CD_REDUC')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addCooldownReductionPercent(percent)
    local param = getParam(self, 'CD_REDUC')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addCooldownReductionBonus(value)
    local param = getParam(self, 'CD_REDUC')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getCooldownReduction()
    local param = getParam(self, 'CD_REDUC')
    return param:get()
end

---@return number
function Unit:getCooldownReductionPercent()
    local param = getParam(self, 'CD_REDUC')
    return 100 * param:getMult()
end

--=========
-- Health.
--=========

---@param value number
function Unit:addHealthBase(value)
    local param = getParam(self, 'HP')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addHealthPercent(percent)
    local param = getParam(self, 'HP')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addHealthBonus(value)
    local param = getParam(self, 'HP')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getHealth()
    local param = getParam(self, 'HP')
    return param:get()
end

---@return number
function Unit:getHealthPercent()
    local param = getParam(self, 'HP')
    return 100 * param:getMult()
end

--===============
-- Regeneration.
--===============

---@param value number
function Unit:addRegenerationBase(value)
    local param = getParam(self, 'REGEN')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addRegenerationPercent(percent)
    local param = getParam(self, 'REGEN')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addRegenerationBonus(value)
    local param = getParam(self, 'REGEN')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getRegeneration()
    local param = getParam(self, 'REGEN')
    return param:get()
end

---@return number
function Unit:getRegenerationPercent()
    local param = getParam(self, 'REGEN')
    return 100 * param:getMult()
end

--=========
-- Mana.
--=========

---@param value number
function Unit:addManaBase(value)
    local param = getParam(self, 'MP')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addManaPercent(percent)
    local param = getParam(self, 'MP')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addManaBonus(value)
    local param = getParam(self, 'MP')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getMana()
    local param = getParam(self, 'MP')
    return param:get()
end

---@return number
function Unit:getManaPercent()
    local param = getParam(self, 'MP')
    return 100 * param:getMult()
end

--===========
-- Recovery.
--===========

---@param value number
function Unit:addRecoveryBase(value)
    local param = getParam(self, 'RECOV')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addRecoveryPercent(percent)
    local param = getParam(self, 'RECOV')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addRecoveryBonus(value)
    local param = getParam(self, 'RECOV')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getRecovery()
    local param = getParam(self, 'RECOV')
    return param:get()
end

---@return number
function Unit:getRecoveryPercent()
    local param = getParam(self, 'RECOV')
    return 100 * param:getMult()
end

--===========
-- Strength.
--===========

---@param value number
function Unit:addStrengthBase(value)
    local param = getParam(self, 'STR')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addStrengthPercent(percent)
    local param = getParam(self, 'STR')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addStrengthBonus(value)
    local param = getParam(self, 'STR')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getStrength()
    local param = getParam(self, 'STR')
    return param:get()
end

---@return number
function Unit:getStrengthPercent()
    local param = getParam(self, 'STR')
    return 100 * param:getMult()
end

--==========
-- Agility.
--==========

---@param value number
function Unit:addAgilityBase(value)
    local param = getParam(self, 'AGI')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addAgilityPercent(percent)
    local param = getParam(self, 'AGI')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addAgilityBonus(value)
    local param = getParam(self, 'AGI')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getAgility()
    local param = getParam(self, 'AGI')
    return param:get()
end

---@return number
function Unit:getAgilityPercent()
    local param = getParam(self, 'AGI')
    return 100 * param:getMult()
end

--===============
-- Intelligence.
--===============

---@param value number
function Unit:addIntelligenceBase(value)
    local param = getParam(self, 'INT')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addIntelligencePercent(percent)
    local param = getParam(self, 'INT')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addIntelligenceBonus(value)
    local param = getParam(self, 'INT')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getIntelligence()
    local param = getParam(self, 'INT')
    return param:get()
end

---@return number
function Unit:getIntelligencePercent()
    local param = getParam(self, 'INT')
    return 100 * param:getMult()
end

--=============
-- Move speed.
--=============

---@param value number
function Unit:addMoveSpeedBase(value)
    local param = getParam(self, 'MS')
    local old = param:get()
    param:add(value, 0, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param percent number
function Unit:addMoveSpeedPercent(percent)
    local param = getParam(self, 'MS')
    local old = param:get()
    param:add(0, percent/100, 0)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@param value number
function Unit:addMoveSpeedBonus(value)
    local param = getParam(self, 'MS')
    local old = param:get()
    param:add(0, 0, value)
    local new = param:get()
    runEvent(self, param:getType(), old, new)
end

---@return number
function Unit:getMoveSpeed()
    local param = getParam(self, 'MS')
    return param:get()
end

---@return number
function Unit:getMoveSpeedPercent()
    local param = getParam(self, 'MS')
    return 100 * param:getMult()
end

return UnitParameterContainer