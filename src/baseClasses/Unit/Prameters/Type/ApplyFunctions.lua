---@type Settings
local Settings = require('utils.Settings')

local UnitParameterApplyFunction = {}

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setAttackDamage(unit, value)
    local dmg = (1 - Settings.Unit.attack_dispersion) * value
    local dice_sides = 2 * Settings.Unit.attack_dispersion * value

    BlzSetUnitBaseDamage(unit, math.floor(dmg), 0)
    BlzSetUnitDiceNumber(unit, 1, 0)
    BlzSetUnitDiceSides(unit, math.floor(dice_sides + 1), 0)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setAttacksPerSecond(unit, value)
    BlzSetUnitAttackCooldown(unit, 1 / value, 0)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setArmor(unit, value)
    BlzSetUnitArmor(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setPhysicalDamageReduction(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setSpellDamage(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setCastingTimeReduction(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setResistance(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setMagicalDamageReduction(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setDodgeChance(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setCritChance(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setCritDamage(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setCooldownReduction(unit, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setHealth(unit, value)
    local percent_hp = GetUnitLifePercent(unit)
    BlzSetUnitMaxHP(unit, math.floor(value))
    SetUnitLifePercentBJ(unit, percent_hp)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setRegeneration(unit, value)
    BlzSetUnitRealField(unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setMana(unit, value)
    local percent_mana = GetUnitManaPercent(unit)
    BlzSetUnitMaxMana(unit, math.floor(value))
    SetUnitManaPercentBJ(unit, percent_mana)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setRecovery(unit, value)
    BlzSetUnitRealField(unit, UNIT_RF_MANA_REGENERATION, value)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setStrength(unit, value)
    SetHeroStr(unit, math.floor(value), true)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setAgility(unit, value)
    SetHeroAgi(unit, math.floor(value), true)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setIntelligence(unit, value)
    SetHeroInt(unit, math.floor(value), true)
end

---@param unit unit
---@param value number
function UnitParameterApplyFunction.setMoveSpeed(unit, value)
    if value <= 1 then
        SetUnitTurnSpeed(unit, 0)
    else
        SetUnitTurnSpeed(unit, GetUnitDefaultTurnSpeed(unit))
    end
    SetUnitMoveSpeed(unit, value)
end

return UnitParameterApplyFunction