local Unit = require('classes.Unit.UnitData')
local UnitEvent = require('utils.trigger.events.UnitEvents')
local Settings = require('utils.Settings')

local UnitParameter = {}

-- ============
--  Predefined
-- ============
---@type fun():nil
local damageEventAction
---@type fun():UnitParameterValues
local createValues
---@type fun(values:UnitParameterValues, base:number, mult:number, bonus:number):nil
local addValues
---@type fun(values:UnitParameterValues):number
local linearResult
---@type fun(values:UnitParameterValues):number
local percentOfMaximumResult

local initialized = false
function UnitParameter.init()
    if initialized then return nil end

    UnitEvent.init()
    UnitEvent.getTrigger("AnyUnitDamaging"):addAction(damageEventAction)

    initialized = true
end

-- Add container initialisation to every new Unit.
Unit.addCreationFunction(function(unit)
    if unit.__parameters then
        Debug("UnitParameters error: Unit instance already has field __parameters.")
        return false
    end

    unit.__parameters = {}
    unit.__parameters.AttackDamage = createValues()
    unit.__parameters.AttackSpeed = createValues()
    unit.__parameters.Armor = createValues()
    unit.__parameters.PhysicalDamageReduction = createValues()
    unit.__parameters.PhysicalDamageReduction.maximum = Settings.Unit.maximum_physical_damage_reduction

    unit.__parameters.SpellDamage = createValues()
    unit.__parameters.CastingTimeReduction = createValues()
    unit.__parameters.CastingTimeReduction.maximum = Settings.Unit.maximum_casting_speed
    unit.__parameters.Resistance = createValues()
    unit.__parameters.MagicalDamageReduction = createValues()
    unit.__parameters.MagicalDamageReduction.maximum = Settings.Unit.maximum_magical_damage_reduction

    unit.__parameters.DodgeChance = createValues()
    unit.__parameters.DodgeChance.maximum = Settings.Unit.maximum_dodge_chance
    unit.__parameters.CritChance = createValues()
    unit.__parameters.CritChance.maximum = Settings.Unit.maximum_crit_chance
    unit.__parameters.CritDamage = createValues()
    unit.__parameters.CooldownReduction = createValues()
    unit.__parameters.CooldownReduction.maximum = Settings.Unit.maximum_cooldown_reduction

    unit.__parameters.Health = createValues()
    unit.__parameters.Regeneration = createValues()
    unit.__parameters.Mana = createValues()
    unit.__parameters.Recovery = createValues()

    unit.__parameters.Strength = createValues()
    unit.__parameters.Agility = createValues()
    unit.__parameters.Intelligence = createValues()

    return true
end)

-- ==============
--  AttackDamage
-- ==============

---Formula: (base_damage) * (multiplicator) + (bonus).
---@param base_damage number
---@param multiplicator number
---@param bonus number
function Unit:addAttackDamage(base_damage, multiplicator, bonus)
    addValues(self.__parameters.AttackDamage, base_damage, multiplicator, bonus)
    local value = linearResult(self.__parameters.AttackDamage)

    local k = 1 - Settings.Unit.attack_dispersion
    local dmg = k * value
    local dice_sides = 2 * Settings.Unit.attack_dispersion * value

    -- Apply
    BlzSetUnitBaseDamage(self:getObj(), math.floor(dmg), 0)
    BlzSetUnitDiceNumber(self:getObj(), 1, 0)
    BlzSetUnitDiceSides(self:getObj(), math.floor(dice_sides + 1), 0)
end

---@return number
function Unit:getAttackDamage()
    return linearResult(self.__parameters.AttackDamage)
end

-- =============
--  AttackSpeed
-- =============

---Formula: (attacks per second) * (multiplicator) * (bonus)
---@param attacks_per_sec number
function Unit:setAttacksPerSecond(attacks_per_sec)
    local values = self.__parameters.AttackSpeed
    values.base = attacks_per_sec
    values.result = values.base * values.mult * values.bonus

    -- Apply
    BlzSetUnitAttackCooldown(self:getObj(), values.result, 0)
end

---Formula: (attacks per second) * (multiplicator) * (bonus)
---@param multiplicator number
---@param bonus number
function Unit:addAttackSpeed(multiplicator, bonus)
    local values = self.__parameters.AttackSpeed
    values.mult = values.mult + multiplicator
    values.bonus = values.bonus + bonus
    values.result = values.base * values.mult * values.bonus

    -- Apply
    BlzSetUnitAttackCooldown(self:getObj(), values.result, 0)
end

---@return number
function Unit:getAttacksPerSecond()
    return self.__parameters.AttackSpeed.result
end

-- =======
--  Armor
-- =======

---Formula: (base) * (multiplicator) + (bonus)
---@param base_armor number
---@param multiplicator number
---@param bonus number
function Unit:addArmor(base_armor, multiplicator, bonus)
    addValues(self.__parameters.Armor, base_armor, multiplicator, bonus)
    linearResult(self.__parameters.Armor)
end

---@return number
function Unit:getArmor()
    return linearResult(self.__parameters.Armor)
end

-- =========================
--  PhysicalDamageReduction
-- =========================

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function Unit:addPhysicalDamageReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.PhysicalDamageReduction, base_rating, multiplicator, bonus)
    percentOfMaximumResult(self.__parameters.PhysicalDamageReduction)
end

---@return number
function Unit:getPhysicalDamageReduction()
    return percentOfMaximumResult(self.__parameters.PhysicalDamageReduction)
end

-- =============
--  SpellDamage
-- =============

--- Formula: (base_damage) * (multiplicator) + bonus
---@param base_damage number
---@param multiplicator number
---@param bonus number
function Unit:addSpellDamage(base_damage, multiplicator, bonus)
    addValues(self.__parameters.SpellDamage, base_damage, multiplicator, bonus)
    linearResult(self.__parameters.SpellDamage)
end

---@return number
function Unit:getSpellDamage()
    return linearResult(self.__parameters.SpellDamage)
end

-- ======================
--  CastingTimeReduction
-- ======================

--- Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function Unit:setCastingTimeReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.CastingTimeReduction, base_rating, multiplicator, bonus)
    percentOfMaximumResult(self.__parameters.CastingTimeReduction)
end

---@return number
function Unit:getCastingTimeReduction()
    return percentOfMaximumResult(self.__parameters.CastingTimeReduction)
end

-- ============
--  Resistance
-- ============

--- Formula: (base_resistance) * (multiplicator) + bonus
---@param base_resistance number
---@param multiplicator number
---@param bonus number
function Unit:addResistance(base_resistance, multiplicator, bonus)
    addValues(self.__parameters.Resistance, base_resistance, multiplicator, bonus)
    linearResult(self.__parameters.Resistance)
end

---@return number
function Unit:getResistance()
    return linearResult(self.__parameters.Resistance)
end

-- =========================
--  MagicalDamageReduction
-- =========================

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function Unit:addMagicalDamageReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.MagicalDamageReduction, base_rating, multiplicator, bonus)
    percentOfMaximumResult(self.__parameters.MagicalDamageReduction)
end

---@return number
function Unit:getMagicalDamageReduction()
    return percentOfMaximumResult(self.__parameters.MagicalDamageReduction)
end

-- =============
--  DodgeChance
-- =============

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function Unit:addDodgeChance(base_rating, multiplicator, bonus)
    addValues(self.__parameters.DodgeChance, base_rating, multiplicator, bonus)
    percentOfMaximumResult(self.__parameters.DodgeChance)
end

function Unit:getDodgeChance()
    percentOfMaximumResult(self.__parameters.DodgeChance)
end

-- ============
--  CritChance
-- ============

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function Unit:addCritChance(base_rating, multiplicator, bonus)
    addValues(self.__parameters.CritChance, base_rating, multiplicator, bonus)
    percentOfMaximumResult(self.__parameters.CritChance)
end

function Unit:getCritChance()
    percentOfMaximumResult(self.__parameters.CritChance)
end

-- ============
--  CritDamage
-- ============

--- Formula: (base_crit_damage) * (multiplicator) + bonus
---@param base_crit_damage number
---@param multiplicator number
---@param bonus number
function Unit:addCritDamage(base_crit_damage, multiplicator, bonus)
    addValues(self.__parameters.CritDamage, base_crit_damage, multiplicator, bonus)
    linearResult(self.__parameters.CritDamage)
end

---@return number
function Unit:getCritDamage()
    return linearResult(self.__parameters.CritDamage)
end

-- ===================
--  CooldownReduction
-- ===================

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function Unit:addCooldownReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.CooldownReduction, base_rating, multiplicator, bonus)
    percentOfMaximumResult(self.__parameters.CooldownReduction)
end

function Unit:getCooldownReduction()
    percentOfMaximumResult(self.__parameters.CooldownReduction)
end

-- ========
--  Health
-- ========

--- Formula: (base_health) * (multiplicator) + bonus
---@param base_health number
---@param multiplicator number
---@param bonus number
function Unit:addHealth(base_health, multiplicator, bonus)
    addValues(self.__parameters.Health, base_health, multiplicator, bonus)
    local value = linearResult(self.__parameters.Health)

    -- Apply
    BlzSetUnitMaxHP(self:getObj(), math.floor(value))
end

---@return number
function Unit:getHealth()
    return linearResult(self.__parameters.Health)
end

-- ==============
--  Regeneration
-- ==============

--- Formula: (base_regeneration) * (multiplicator) + bonus
---@param base_regeneration number
---@param multiplicator number
---@param bonus number
function Unit:addRegeneration(base_regeneration, multiplicator, bonus)
    addValues(self.__parameters.Regeneration, base_regeneration, multiplicator, bonus)
    linearResult(self.__parameters.Regeneration)

    -- Apply
    BlzSetUnitRealField(self:getObj(), UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
end

---@return number
function Unit:getRegeneration()
    return linearResult(self.__parameters.Regeneration)
end

-- ======
--  Mana
-- ======

--- Formula: (base_mana) * (multiplicator) + bonus
---@param base_mana number
---@param multiplicator number
---@param bonus number
function Unit:addMana(base_mana, multiplicator, bonus)
    addValues(self.__parameters.Mana, base_mana, multiplicator, bonus)
    local value = linearResult(self.__parameters.Mana)

    -- Apply
    BlzSetUnitMaxMana(self:getObj(), math.floor(value))
end

---@return number
function Unit:getMana()
    return linearResult(self.__parameters.Mana)
end

-- ==========
--  Recovery
-- ==========

--- Formula: (base_recovery) * (multiplicator) + bonus
---@param base_recovery number
---@param multiplicator number
---@param bonus number
function Unit:addRecovery(base_recovery, multiplicator, bonus)
    addValues(self.__parameters.Recovery, base_recovery, multiplicator, bonus)
    linearResult(self.__parameters.Recovery)

    -- Apply
    BlzSetUnitRealField(self:getObj(), UNIT_RF_MANA_REGENERATION, value)
end

---@return number
function Unit:getRecovery()
    return linearResult(self.__parameters.Recovery)
end

-- ==========
--  Strength
-- ==========

--- Formula: (base_strength) * (multiplicator) + bonus
---@param base_strength number
---@param multiplicator number
---@param bonus number
function Unit:addStrength(base_strength, multiplicator, bonus)
    addValues(self.__parameters.Strength, base_strength, multiplicator, bonus)
    linearResult(self.__parameters.Strength)

    -- Apply
    SetHeroStr(self:getObj(), math.floor(value), true)
end

---@return number
function Unit:getStrength()
    return linearResult(self.__parameters.Strength)
end


-- =======
--  Utils
-- =======

damageEventAction = function()
    local damage = GetEventDamage()
    local source = Unit.GetEventDamageSource()
    local target = Unit.GetEventDamageTarget()

    if math.random() <= target:getDodgeChance() then
        damage = 0
        -- TODO show dodge
    end

    if damage >= 1 and math.random() <= source:getCritChance() then
        damage = damage * source:getCritDamage()
        -- TODO show crit
    end

    if damage >= 1 then
        local damage_type = BlzGetEventDamageType()
        if damage_type == Settings.DamageType.Physic then
            damage = damage * (1 - target:getPhysicalDamageReduction()) - target:getArmor()
        elseif damage_type == Settings.DamageType.Magic then
            damage = damage * (1 - target:getMagicalDamageReduction()) - target:getResistance()
        end
    end

    if damage < 1 then damage = 0 end
    BlzSetEventDamage(damage)
end

createValues = function()
    ---@class UnitParameterValues
    local values = {base = 0,
                    mult = 1,
                    bonus = 0,
                    result = 0,
                    result_ready = false,
                    maximum = 10^10}
    return values
end

---@param values UnitParameterValues
---@param base number
---@param mult number
---@param bonus number
addValues = function(values, base, mult, bonus)
    values.base = values.base + base
    values.mult = values.mult + mult
    values.bonus = values.bonus + bonus
    values.result_ready = false
end

---@param values UnitParameterValues
---@return number
linearResult = function(values)
    if not values.result_ready then
        values.result = torange(values.base * values.mult + value.bonus, values.minimum, value.maximum)
        values.result_ready = true
    end
    return values.result
end

---@param values UnitParameterValues
---@return number
percentOfMaximumResult = function(values)
    if not values.result_ready then
        values.result = values.maximum * (values.base * values.mult) / (100 + (values.base * values.mult)) + values.bonus
        values.result_ready = true
    end
    return values.result
end

return UnitParameter