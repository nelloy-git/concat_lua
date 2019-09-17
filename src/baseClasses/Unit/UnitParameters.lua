---@type Unit
local Unit = require('baseClasses.Unit.UnitData')
---@type Settings
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
---@type fun(unit:Unit, parameter:unitparameter, value:number):nil
local runChangedParametersTrigger


---@type playerunitevent
EVENT_PLAYER_UNIT_CHANGED_PARAMETERS = 'UNIT_CHANGED_PARAMETERS'

---@class unitparameter : string
---@type unitparameter
UNIT_PARAMETER_ATTACK_DAMAGE = 'AttackDamage'
---@type unitparameter
UNIT_PARAMETER_ATTACK_SPEED = 'AttackSpeed'
---@type unitparameter
UNIT_PARAMETER_ARMOR = 'Armor'
---@type unitparameter
UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION = 'PhysicalDamageReduction'
---@type unitparameter
UNIT_PARAMETER_SPELL_DAMAGE = 'SpellDamage'
---@type unitparameter
UNIT_PARAMETER_CASTING_TIME_REDUCTION = 'CastingTimeReduction'
---@type unitparameter
UNIT_PARAMETER_RESISTANCE = 'Resistance'
---@type unitparameter
UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION = 'MagicalDamageReduction'
---@type unitparameter
UNIT_PARAMETER_DODGE_CHANCE = 'DodgeChance'
---@type unitparameter
UNIT_PARAMETER_CRIT_CHANCE = 'CritChance'
---@type unitparameter
UNIT_PARAMETER_CRIT_DAMAGE = 'CritDamage'
---@type unitparameter
UNIT_PARAMETER_COOLDOWN_REDUCTION = 'CooldownReduction'
---@type unitparameter
UNIT_PARAMETER_HEALTH = 'Health'
---@type unitparameter
UNIT_PARAMETER_REGENERATION = 'Regeneration'
---@type unitparameter
UNIT_PARAMETER_MANA = 'Mana'
---@type unitparameter
UNIT_PARAMETER_RECOVERY = 'Recovery'
---@type unitparameter
UNIT_PARAMETER_STRENGTH = 'Strength'
---@type unitparameter
UNIT_PARAMETER_AGILITY = 'Agility'
---@type unitparameter
UNIT_PARAMETER_INTELLIGENCE = 'Intelligence'
---@type unitparameter
UNIT_PARAMETER_MOVE_SPEED = 'MoveSpeed'

---@type Trigger
local parameters_changed_trigger
---@type Unit
local unit_with_changed_parameters
---@type unitparameter
local changed_parameter
---@type number
local changed_parameter_value

---@return Unit
function GetUnitWithChangedParameters()
    return unit_with_changed_parameters
end

---@return unitparameter
function GetUnitChangedParameter()
    return changed_parameter
end

--- Returns new value of parameter.
---@return unitparameter
function GetUnitChangedParameterValue()
    return changed_parameter_value
end

local initialized = false
function UnitParameter.init()
    if initialized then return nil end

    local damage_trigger = Unit.getTrigger(EVENT_PLAYER_UNIT_DAMAGING)
    damage_trigger:addAction(damageEventAction)

    parameters_changed_trigger = Unit.getTrigger(EVENT_PLAYER_UNIT_CHANGED_PARAMETERS)

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
    unit.__parameters.AttackSpeed.attacks_per_sec = Settings.Unit.base_attacks_per_sec
    unit.__parameters.AttackSpeed.maximum = Settings.Unit.maximum_attack_speed
    unit.__parameters.Armor = createValues()
    unit.__parameters.PhysicalDamageReduction = createValues()
    unit.__parameters.PhysicalDamageReduction.maximum = Settings.Unit.maximum_physical_damage_reduction
    unit.__parameters.SpellDamage = createValues()
    unit.__parameters.CastingTimeReduction = createValues()
    unit.__parameters.CastingTimeReduction.maximum = Settings.Unit.maximum_casting_time_reduction
    unit.__parameters.Resistance = createValues()
    unit.__parameters.MagicalDamageReduction = createValues()
    unit.__parameters.MagicalDamageReduction.maximum = Settings.Unit.maximum_magical_damage_reduction
    unit.__parameters.DodgeChance = createValues()
    unit.__parameters.DodgeChance.maximum = Settings.Unit.maximum_dodge_chance
    unit.__parameters.CritChance = createValues()
    unit.__parameters.CritChance.maximum = Settings.Unit.maximum_crit_chance
    unit.__parameters.CritDamage = createValues()
    unit.__parameters.CritDamage.base = Settings.Unit.base_crit_damage
    unit.__parameters.CooldownReduction = createValues()
    unit.__parameters.CooldownReduction.maximum = Settings.Unit.maximum_cooldown_reduction
    unit.__parameters.Health = createValues()
    unit.__parameters.Health.base = 100
    unit.__parameters.Regeneration = createValues()
    unit.__parameters.Mana = createValues()
    unit.__parameters.Recovery = createValues()
    unit.__parameters.MoveSpeed = createValues()

    -- Non hero protection
    local char1 = string.sub(unit:getId(), 1, 1)
    if char1 == string.upper(char1) then
        unit.__parameters.Strength = createValues()
        unit.__parameters.Agility = createValues()
        unit.__parameters.Intelligence = createValues()
    end

    unit:updateParameters()

    return true
end)

function Unit:updateParameters()
    self:addAttackDamage(5, 0, 0)
    self:addAttackSpeed(0, 0, 0)
    self:addArmor(0, 0, 0)
    self:addPhysicalDamageReduction(0, 0, 0)
    self:addSpellDamage(0, 0, 0)
    self:addCastingTimeReduction(0, 0, 0)
    self:addResistance(0, 0, 0)
    self:addMagicalDamageReduction(0, 0, 0)
    self:addDodgeChance(0, 0, 0)
    self:addCritChance(0, 0, 0)
    self:addCritDamage(0, 0, 0)
    self:addCooldownReduction(0, 0, 0)
    self:addHealth(0, 0, 0)
    self:addRegeneration(0, 0, 0)
    self:addMana(0, 0, 0)
    self:addRecovery(0, 0, 0)
    self:addStrength(0, 0, 0)
    self:addAgility(0, 0, 0)
    self:addIntelligence(0, 0, 0)
    self:addMoveSpeed(GetUnitMoveSpeed(self:getObj()), 0, 0)
end

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

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_ATTACK_DAMAGE, value)
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
    self.__parameters.AttackSpeed.attacks_per_sec = attacks_per_sec
    self:addAttackSpeed(0, 0, 0)
end

---Formula: 10 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function Unit:addAttackSpeed(base_rating, multiplicator, bonus)
    addValues(self.__parameters.AttackSpeed, base_rating, multiplicator, bonus)
    local value = self.__parameters.AttackSpeed.attacks_per_sec / (percentOfMaximumResult(self.__parameters.AttackSpeed) + 1)
    self.__parameters.AttackSpeed.result = value
    if value <= 0 then value = 10^6 end

    -- Apply
    --Debug("Attack cooldown:", value)
    BlzSetUnitAttackCooldown(self:getObj(), value, 0)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_ATTACK_SPEED, value)
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
    local value = linearResult(self.__parameters.Armor)

    -- Apply
    BlzSetUnitArmor(self:getObj(), value)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_ARMOR, value)
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
    local value = percentOfMaximumResult(self.__parameters.PhysicalDamageReduction)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION, value)
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
    local value = linearResult(self.__parameters.SpellDamage)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_SPELL_DAMAGE, value)
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
function Unit:addCastingTimeReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.CastingTimeReduction, base_rating, multiplicator, bonus)
    local value = percentOfMaximumResult(self.__parameters.CastingTimeReduction)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_CASTING_TIME_REDUCTION, value)
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
    local value = linearResult(self.__parameters.Resistance)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_RESISTANCE, value)
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
    local value = percentOfMaximumResult(self.__parameters.MagicalDamageReduction)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION, value)
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
    local value = percentOfMaximumResult(self.__parameters.DodgeChance)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_DODGE_CHANCE, value)
end

function Unit:getDodgeChance()
    return percentOfMaximumResult(self.__parameters.DodgeChance)
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
    local value = percentOfMaximumResult(self.__parameters.CritChance)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_CRIT_CHANCE, value)
end

function Unit:getCritChance()
    return percentOfMaximumResult(self.__parameters.CritChance)
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
    local value = linearResult(self.__parameters.CritDamage)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_CRIT_DAMAGE, value)
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
    local value = percentOfMaximumResult(self.__parameters.CooldownReduction)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_COOLDOWN_REDUCTION, value)
end

function Unit:getCooldownReduction()
    return percentOfMaximumResult(self.__parameters.CooldownReduction)
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
    local percent_hp = GetUnitLifePercent(self:getObj())
    BlzSetUnitMaxHP(self:getObj(), math.floor(value))
    SetUnitLifePercentBJ(self:getObj(), percent_hp)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_HEALTH, value)
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
    local value = linearResult(self.__parameters.Regeneration)

    -- Apply
    BlzSetUnitRealField(self:getObj(), UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_REGENERATION, value)
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
    local percent_mana = GetUnitManaPercent(self:getObj())
    BlzSetUnitMaxMana(self:getObj(), math.floor(value))
    SetUnitManaPercentBJ(self:getObj(), percent_mana)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_MANA, value)
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
    local value = linearResult(self.__parameters.Recovery)

    -- Apply
    BlzSetUnitRealField(self:getObj(), UNIT_RF_MANA_REGENERATION, value)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_RECOVERY, value)
end

---@return number
function Unit:getRecovery()
    return linearResult(self.__parameters.Recovery)
end

-- ==========
--  Strength
-- ==========

--- Formula: (base_strength) * (multiplicator) + bonus
---|Strength adds base attack damage, base health and base armor
---@param base_strength number
---@param multiplicator number
---@param bonus number
function Unit:addStrength(base_strength, multiplicator, bonus)
    local char1 = string.sub(self:getId(), 1, 1)
    if char1 ~= string.upper(char1) then return nil end
    -- Remove old parameters
    local prev_val = linearResult(self.__parameters.Strength)
    local damage = prev_val * Settings.Unit.attack_damage_per_str
    local health = prev_val * Settings.Unit.health_per_str
    local armor = prev_val * Settings.Unit.armor_per_str

    self:addAttackDamage(-damage, 0, 0)
    self:addHealth(-health, 0, 0)
    self:addArmor(-armor, 0, 0)

    addValues(self.__parameters.Strength, base_strength, multiplicator, bonus)
    local value = linearResult(self.__parameters.Strength)

    -- Apply
    SetHeroStr(self:getObj(), math.floor(value), true)
    damage = value * Settings.Unit.attack_damage_per_str
    health = value * Settings.Unit.health_per_str
    armor = value * Settings.Unit.armor_per_str

    self:addAttackDamage(damage, 0, 0)
    self:addHealth(health, 0, 0)
    self:addArmor(armor, 0, 0)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_STRENGTH, value)
end

---@return number
function Unit:getStrength()
    local char1 = string.sub(self:getId(), 1, 1)
    if char1 ~= string.upper(char1) then return 0 end
    return linearResult(self.__parameters.Strength)
end

-- =========
--  Agility
-- =========

--- Formula: (base_agility) * (multiplicator) + bonus
---|Agility adds attack speed, casting speed and dodge chance
---@param base_agility number
---@param multiplicator number
---@param bonus number
function Unit:addAgility(base_agility, multiplicator, bonus)
    local char1 = string.sub(self:getId(), 1, 1)
    if char1 ~= string.upper(char1) then return nil end
    -- Remove old parameters
    local prev_val = linearResult(self.__parameters.Agility)
    local attack_speed = prev_val * Settings.Unit.attack_speed_per_agi
    local casting_time_reduction = prev_val * Settings.Unit.casting_time_reduction_per_agi
    local dodge_chance = prev_val * Settings.Unit.dodge_chance_per_agi

    self:addAttackSpeed(-attack_speed, 0, 0)
    self:addCastingTimeReduction(-casting_time_reduction, 0, 0)
    self:addDodgeChance(-dodge_chance, 0, 0)

    addValues(self.__parameters.Agility, base_agility, multiplicator, bonus)
    local value = linearResult(self.__parameters.Agility)

    -- Apply
    SetHeroAgi(self:getObj(), math.floor(value), true)
    attack_speed = value * Settings.Unit.attack_speed_per_agi
    casting_time_reduction = value * Settings.Unit.casting_time_reduction_per_agi
    dodge_chance = value * Settings.Unit.dodge_chance_per_agi

    self:addAttackSpeed(attack_speed, 0, 0)
    self:addCastingTimeReduction(casting_time_reduction, 0, 0)
    self:addDodgeChance(dodge_chance, 0, 0)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_AGILITY, value)
end

---@return number
function Unit:getAgility()
    local char1 = string.sub(self:getId(), 1, 1)
    if char1 ~= string.upper(char1) then return 0 end
    return linearResult(self.__parameters.Agility)
end

-- ==============
--  Intelligence
-- ==============

--- Formula: (base_intelligence) * (multiplicator) + bonus
---|Intelligence adds base spell damage, base mana and base cooldown reduction
---@param base_intelligence number
---@param multiplicator number
---@param bonus number
function Unit:addIntelligence(base_intelligence, multiplicator, bonus)
    local char1 = string.sub(self:getId(), 1, 1)
    if char1 ~= string.upper(char1) then return nil end
    -- Remove old parameters
    local prev_val = linearResult(self.__parameters.Intelligence)
    local spell_damage = prev_val * Settings.Unit.spell_damage_per_int
    local mana = prev_val * Settings.Unit.mana_per_int
    local cooldown_reduction = prev_val * Settings.Unit.cooldown_reduction_per_int

    self:addSpellDamage(-spell_damage, 0, 0)
    self:addMana(-mana, 0, 0)
    self:addCooldownReduction(-cooldown_reduction, 0, 0)

    addValues(self.__parameters.Intelligence, base_intelligence, multiplicator, bonus)
    local value = linearResult(self.__parameters.Intelligence)

    -- Apply
    SetHeroInt(self:getObj(), math.floor(value), true)
    spell_damage = value * Settings.Unit.spell_damage_per_int
    mana = value * Settings.Unit.mana_per_int
    cooldown_reduction = value * Settings.Unit.cooldown_reduction_per_int

    self:addSpellDamage(spell_damage, 0, 0)
    self:addMana(mana, 0, 0)
    self:addCooldownReduction(cooldown_reduction, 0, 0)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_INTELLIGENCE, value)
end

---@return number
function Unit:getIntelligence()
    local char1 = string.sub(self:getId(), 1, 1)
    if char1 ~= string.upper(char1) then return 0 end
    return linearResult(self.__parameters.Intelligence)
end

-- ===========
--  MoveSpeed
-- ===========

--- Formula: (base_move_speed) * (multiplicator) + bonus
---@param base_move_speed number
---@param multiplicator number
---@param bonus number
function Unit:addMoveSpeed(base_move_speed, multiplicator, bonus)
    addValues(self.__parameters.MoveSpeed, base_move_speed, multiplicator, bonus)
    local value = linearResult(self.__parameters.MoveSpeed)
    value = torange(value, 0, 512)

    -- Apply

    --Debug("Move speed:", value)
    if value <= 1 then
        SetUnitTurnSpeed(self:getObj(), 0)
    else
        SetUnitTurnSpeed(self:getObj(), GetUnitDefaultTurnSpeed(self:getObj()))
    end
    SetUnitMoveSpeed(self:getObj(), value)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_MOVE_SPEED, value)
end

---@return number
function Unit:getMoveSpeed()
    return linearResult(self.__parameters.MoveSpeed)
end


-- =======
--  Utils
-- =======

damageEventAction = function()
    local damage = GetEventDamage()
    local source = Unit.GetEventDamageSource()
    local target = Unit.GetEventDamageTarget()

    if not source or not target then return nil end

    if math.random() <= target:getDodgeChance() then
        BlzSetEventDamage(0)

        local text_tag = CreateTextTag()
        SetTextTagText(text_tag, "Dodge", 0.027)
        SetTextTagPos(text_tag, GetUnitX(target:getObj()), GetUnitY(target:getObj()), 50)
        SetTextTagColor(text_tag, 200, 200, 200, 255)
        SetTextTagPermanent(text_tag, false)
        SetTextTagFadepoint(text_tag, 1)
        SetTextTagLifespan(text_tag, 2)
        SetTextTagVelocity(text_tag, 0., 0.027)

        return nil
    end

    local is_crit = false
    if damage >= 1 and math.random() <= source:getCritChance() then
        is_crit = true
    end

    local color = {r = 250, g = 50, b = 50}
    local damage_type = BlzGetEventDamageType()
    if damage >= 1 then
        if damage_type == Settings.DamageType.Physic then
            damage = damage * (1 - target:getPhysicalDamageReduction()) - target:getArmor()
        elseif damage_type == Settings.DamageType.Magic then
            color = {r = 50, g = 50, b = 250}
            damage = damage * (1 - target:getMagicalDamageReduction()) - target:getResistance()
        end
    end
    if damage < 1 then damage = 0 end

    if is_crit then
        damage = damage * source:getCritDamage()

        local text_tag = CreateTextTag()
        SetTextTagText(text_tag, string.format("%.0f!", damage), 0.027)
        SetTextTagPos(text_tag, GetUnitX(source:getObj()), GetUnitY(source:getObj()), 50)
        SetTextTagColor(text_tag, color.r, color.g, color.b, 255)
        SetTextTagPermanent(text_tag, false)
        SetTextTagFadepoint(text_tag, 1)
        SetTextTagLifespan(text_tag, 2)
        SetTextTagVelocity(text_tag, 0., 0.027)
    end

    BlzSetEventDamage(damage)
end

createValues = function()
    ---@class UnitParameterValues
    local values = {base = 0,
                    mult = 1,
                    bonus = 0,
                    result = 0,
                    result_ready = false,
                    maximum = 10^8}
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
        values.result = values.base * values.mult + values.bonus
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

runChangedParametersTrigger = function(unit, parameter, value)
    unit_with_changed_parameters = unit
    changed_parameter = parameter
    changed_parameter_value = value
    parameters_changed_trigger:execute()
    unit_with_changed_parameters = nil
    changed_parameter = nil
    changed_parameter_value = nil
end

return UnitParameter