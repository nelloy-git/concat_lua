---@type Settings
local Settings = require('utils.Settings')

---@class UnitParameterApplier
local UnitParameterApplier, UnitParameterApplier_meta = newClass('UnitParameterApplier')

---@param apply_func fun(unit:unit, value:number):nil
---@return UnitParameterApplier
function UnitParameterApplier.new(apply_func)
    local applier = {
        __func = apply_func
    }
    setmetatable(applier, UnitParameterApplier_meta)

    return applier
end

---@param unit unit
---@param value number
function UnitParameterApplier:apply(unit, value)
    self.__func(unit, value)
end

-- ==============
--  AttackDamage
-- ==============

---@param value number
local function setAttackDamage(unit, value)
    local dmg = (1 - Settings.Unit.attack_dispersion) * value
    local dice_sides = 2 * Settings.Unit.attack_dispersion * value

    BlzSetUnitBaseDamage(unit, math.floor(dmg), 0)
    BlzSetUnitDiceNumber(unit, 1, 0)
    BlzSetUnitDiceSides(unit, math.floor(dice_sides + 1), 0)
end

---@param value number
local function setAttacksPerSecond(unit, value)
    BlzSetUnitAttackCooldown(unit, 1 / value, 0)
end

---@param value number
local function setArmor(unit, value)
    BlzSetUnitArmor(unit, value)
end

---@param value number
local function setPhysicalDamageReduction(unit, value)
end

---@param value number
local function setSpellDamage(unit, value)
end

---@param value number
local function setCastingTimeReduction(unit, value)
end

---@param value number
local function setResistance(unit, value)
end

---@param value number
local function setMagicalDamageReduction(unit, value)
end

---@param value number
local function setDodgeChance(unit, value)
end

---@param value number
local function setCritChance(unit, value)
end

---@param value number
local function setCritDamage(unit, value)
end

---@param value number
local function setCooldownReduction(unit, value)
end

---@param value number
local function setHealth(unit, value)
    local percent_hp = GetUnitLifePercent(unit)
    BlzSetUnitMaxHP(unit, math.floor(value))
    SetUnitLifePercentBJ(unit, percent_hp)
end

---@param value number
local function setRegeneration(unit, value)
    BlzSetUnitRealField(unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@param value number
local function setMana(unit, value)
    local percent_mana = GetUnitManaPercent(unit)
    BlzSetUnitMaxMana(unit, math.floor(value))
    SetUnitManaPercentBJ(unit, percent_mana)
end

---@param value number
local function setRecovery(unit, value)
    BlzSetUnitRealField(unit, UNIT_RF_MANA_REGENERATION, value)
end

---@param value number
local function setStrength(unit, value)
    SetHeroStr(unit, math.floor(value), true)
end

---@param value number
local function setAgility(unit, value)
    SetHeroAgi(unit, math.floor(value), true)
end

---@param value number
local function setIntelligence(unit, value)
    SetHeroInt(unit, math.floor(value), true)
end

---@param value number
local function setMoveSpeed(unit, value)
    if value <= 1 then
        SetUnitTurnSpeed(unit, 0)
    else
        SetUnitTurnSpeed(unit, GetUnitDefaultTurnSpeed(unit))
    end
    SetUnitMoveSpeed(unit, value)
end

function UnitParameterApplier.init()
    UnitParameterApplier.ATTACK_DAMAGE = UnitParameterApplier.new(setAttackDamage)
    UnitParameterApplier.ATTACKS_PER_SEC = UnitParameterApplier.new(setAttacksPerSecond)
    UnitParameterApplier.ARMOR = UnitParameterApplier.new(setArmor)
    UnitParameterApplier.PHYSICAL_DAMAGE_REDUCTION = UnitParameterApplier.new(setPhysicalDamageReduction)
    UnitParameterApplier.SPELL_DAMAGE = UnitParameterApplier.new(setSpellDamage)
    UnitParameterApplier.CASTING_TIME_REDUCTION = UnitParameterApplier.new(setCastingTimeReduction)
    UnitParameterApplier.RESISTANCE = UnitParameterApplier.new(setResistance)
    UnitParameterApplier.MAGICAL_DAMAGE_REDUCTION = UnitParameterApplier.new(setMagicalDamageReduction)
    UnitParameterApplier.DODGE_CHANCE = UnitParameterApplier.new(setDodgeChance)
    UnitParameterApplier.CRIT_CHANCE = UnitParameterApplier.new(setCritChance)
    UnitParameterApplier.CRIT_DAMAGE = UnitParameterApplier.new(setCritDamage)
    UnitParameterApplier.COOLDOWN_REDUCTION = UnitParameterApplier.new(setCooldownReduction)
    UnitParameterApplier.HEALTH = UnitParameterApplier.new(setHealth)
    UnitParameterApplier.REGENERATION = UnitParameterApplier.new(setRegeneration)
    UnitParameterApplier.MANA = UnitParameterApplier.new(setMana)
    UnitParameterApplier.RECOVERY = UnitParameterApplier.new(setRecovery)
    UnitParameterApplier.STRENGTH = UnitParameterApplier.new(setStrength)
    UnitParameterApplier.AGILITY = UnitParameterApplier.new(setAgility)
    UnitParameterApplier.INTELLIGENCE = UnitParameterApplier.new(setIntelligence)
    UnitParameterApplier.MOVE_SPEED = UnitParameterApplier.new(setMoveSpeed)
end

return UnitParameterApplier