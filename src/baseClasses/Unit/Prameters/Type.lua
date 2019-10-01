---@class UnitParameterType
---@type UnitParameterType
local UnitParameterType, UnitParameterType_meta = newClass("UnitParameterType")

function UnitParameterType.init()
    UnitParameterType.ATTACK_DAMAGE = UnitParameterType.new()
    UnitParameterType.ATTACK_COOLDOWN = UnitParameterType.new()
    UnitParameterType.ARMOR = UnitParameterType.new()
    UnitParameterType.PHYSICAL_DAMAGE_REDUCTION = UnitParameterType.new()
    UnitParameterType.SPELL_DAMAGE = UnitParameterType.new()
    UnitParameterType.CASTING_TIME_REDUCTION = UnitParameterType.new()
    UnitParameterType.RESISTANCE = UnitParameterType.new()
    UnitParameterType.MAGICAL_DAMAGE_REDUCTION = UnitParameterType.new()
    UnitParameterType.DODGE_CHANCE = UnitParameterType.new()
    UnitParameterType.CRIT_CHANCE = UnitParameterType.new()
    UnitParameterType.CRIT_DAMAGE = UnitParameterType.new()
    UnitParameterType.COOLDOWN_REDUCTION = UnitParameterType.new()
    UnitParameterType.HEALTH = UnitParameterType.new()
    UnitParameterType.REGENERATION = UnitParameterType.new()
    UnitParameterType.MANA = UnitParameterType.new()
    UnitParameterType.RECOVERY = UnitParameterType.new()
    UnitParameterType.STRENGTH = UnitParameterType.new()
    UnitParameterType.AGILITY = UnitParameterType.new()
    UnitParameterType.INTELLIGENCE = UnitParameterType.new()
    UnitParameterType.MOVE_SPEED = UnitParameterType.new()
end

---@param apply_function fun(unit:unit):nil
---@return UnitParameterType
function UnitParameterType.new(apply_function)
    local param_type = {
        __apply_function = apply_function
    }
    setmetatable(param_type, UnitParameterType_meta)

    return param_type
end

-- ==============
--  AttackDamage
-- ==============

---Formula: (base_damage) * (multiplicator) + (bonus).
---@param unit unit
function UnitParameterType:applyAttackDamage(unit, value)
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
function UnitParameterType:getAttackDamage()
    return linearResult(self.__parameters.AttackDamage)
end

-- =============
--  AttackSpeed
-- =============

---Formula: (attacks per second) * (multiplicator) * (bonus)
---@param attacks_per_sec number
function UnitParameterType:setAttacksPerSecond(attacks_per_sec)
    self.__parameters.AttackSpeed.attacks_per_sec = attacks_per_sec
    self:addAttackSpeed(0, 0, 0)
end

---Formula: 10 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addAttackSpeed(base_rating, multiplicator, bonus)
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
function UnitParameterType:getAttacksPerSecond()
    return self.__parameters.AttackSpeed.result
end

-- =======
--  Armor
-- =======

---Formula: (base) * (multiplicator) + (bonus)
---@param base_armor number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addArmor(base_armor, multiplicator, bonus)
    addValues(self.__parameters.Armor, base_armor, multiplicator, bonus)
    local value = linearResult(self.__parameters.Armor)

    -- Apply
    BlzSetUnitArmor(self:getObj(), value)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_ARMOR, value)
end

---@return number
function UnitParameterType:getArmor()
    return linearResult(self.__parameters.Armor)
end

-- =========================
--  PhysicalDamageReduction
-- =========================

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addPhysicalDamageReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.PhysicalDamageReduction, base_rating, multiplicator, bonus)
    local value = percentOfMaximumResult(self.__parameters.PhysicalDamageReduction)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION, value)
end

---@return number
function UnitParameterType:getPhysicalDamageReduction()
    return percentOfMaximumResult(self.__parameters.PhysicalDamageReduction)
end

-- =============
--  SpellDamage
-- =============

--- Formula: (base_damage) * (multiplicator) + bonus
---@param base_damage number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addSpellDamage(base_damage, multiplicator, bonus)
    addValues(self.__parameters.SpellDamage, base_damage, multiplicator, bonus)
    local value = linearResult(self.__parameters.SpellDamage)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_SPELL_DAMAGE, value)
end

---@return number
function UnitParameterType:getSpellDamage()
    return linearResult(self.__parameters.SpellDamage)
end

-- ======================
--  CastingTimeReduction
-- ======================

--- Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addCastingTimeReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.CastingTimeReduction, base_rating, multiplicator, bonus)
    local value = percentOfMaximumResult(self.__parameters.CastingTimeReduction)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_CASTING_TIME_REDUCTION, value)
end

---@return number
function UnitParameterType:getCastingTimeReduction()
    return percentOfMaximumResult(self.__parameters.CastingTimeReduction)
end

-- ============
--  Resistance
-- ============

--- Formula: (base_resistance) * (multiplicator) + bonus
---@param base_resistance number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addResistance(base_resistance, multiplicator, bonus)
    addValues(self.__parameters.Resistance, base_resistance, multiplicator, bonus)
    local value = linearResult(self.__parameters.Resistance)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_RESISTANCE, value)
end

---@return number
function UnitParameterType:getResistance()
    return linearResult(self.__parameters.Resistance)
end

-- =========================
--  MagicalDamageReduction
-- =========================

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addMagicalDamageReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.MagicalDamageReduction, base_rating, multiplicator, bonus)
    local value = percentOfMaximumResult(self.__parameters.MagicalDamageReduction)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION, value)
end

---@return number
function UnitParameterType:getMagicalDamageReduction()
    return percentOfMaximumResult(self.__parameters.MagicalDamageReduction)
end

-- =============
--  DodgeChance
-- =============

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addDodgeChance(base_rating, multiplicator, bonus)
    addValues(self.__parameters.DodgeChance, base_rating, multiplicator, bonus)
    local value = percentOfMaximumResult(self.__parameters.DodgeChance)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_DODGE_CHANCE, value)
end

function UnitParameterType:getDodgeChance()
    return percentOfMaximumResult(self.__parameters.DodgeChance)
end

-- ============
--  CritChance
-- ============

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addCritChance(base_rating, multiplicator, bonus)
    addValues(self.__parameters.CritChance, base_rating, multiplicator, bonus)
    local value = percentOfMaximumResult(self.__parameters.CritChance)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_CRIT_CHANCE, value)
end

function UnitParameterType:getCritChance()
    return percentOfMaximumResult(self.__parameters.CritChance)
end

-- ============
--  CritDamage
-- ============

--- Formula: (base_crit_damage) * (multiplicator) + bonus
---@param base_crit_damage number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addCritDamage(base_crit_damage, multiplicator, bonus)
    addValues(self.__parameters.CritDamage, base_crit_damage, multiplicator, bonus)
    local value = linearResult(self.__parameters.CritDamage)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_CRIT_DAMAGE, value)
end

---@return number
function UnitParameterType:getCritDamage()
    return linearResult(self.__parameters.CritDamage)
end

-- ===================
--  CooldownReduction
-- ===================

---Formula: 0.75 * (base_rating * mutliplicator) / (100 + (base_rating * mutliplicator) + bonus
---@param base_rating number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addCooldownReduction(base_rating, multiplicator, bonus)
    addValues(self.__parameters.CooldownReduction, base_rating, multiplicator, bonus)
    local value = percentOfMaximumResult(self.__parameters.CooldownReduction)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_COOLDOWN_REDUCTION, value)
end

function UnitParameterType:getCooldownReduction()
    return percentOfMaximumResult(self.__parameters.CooldownReduction)
end

-- ========
--  Health
-- ========

--- Formula: (base_health) * (multiplicator) + bonus
---@param base_health number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addHealth(base_health, multiplicator, bonus)
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
function UnitParameterType:getHealth()
    return linearResult(self.__parameters.Health)
end

-- ==============
--  Regeneration
-- ==============

--- Formula: (base_regeneration) * (multiplicator) + bonus
---@param base_regeneration number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addRegeneration(base_regeneration, multiplicator, bonus)
    addValues(self.__parameters.Regeneration, base_regeneration, multiplicator, bonus)
    local value = linearResult(self.__parameters.Regeneration)

    -- Apply
    BlzSetUnitRealField(self:getObj(), UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_REGENERATION, value)
end

---@return number
function UnitParameterType:getRegeneration()
    return linearResult(self.__parameters.Regeneration)
end

-- ======
--  Mana
-- ======

--- Formula: (base_mana) * (multiplicator) + bonus
---@param base_mana number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addMana(base_mana, multiplicator, bonus)
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
function UnitParameterType:getMana()
    return linearResult(self.__parameters.Mana)
end

-- ==========
--  Recovery
-- ==========

--- Formula: (base_recovery) * (multiplicator) + bonus
---@param base_recovery number
---@param multiplicator number
---@param bonus number
function UnitParameterType:addRecovery(base_recovery, multiplicator, bonus)
    addValues(self.__parameters.Recovery, base_recovery, multiplicator, bonus)
    local value = linearResult(self.__parameters.Recovery)

    -- Apply
    BlzSetUnitRealField(self:getObj(), UNIT_RF_MANA_REGENERATION, value)

    -- Run trigger
    runChangedParametersTrigger(self, UNIT_PARAMETER_RECOVERY, value)
end

---@return number
function UnitParameterType:getRecovery()
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
function UnitParameterType:addStrength(base_strength, multiplicator, bonus)
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
function UnitParameterType:getStrength()
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
function UnitParameterType:addAgility(base_agility, multiplicator, bonus)
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
function UnitParameterType:getAgility()
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
function UnitParameterType:addIntelligence(base_intelligence, multiplicator, bonus)
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
function UnitParameterType:getIntelligence()
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
function UnitParameterType:addMoveSpeed(base_move_speed, multiplicator, bonus)
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
function UnitParameterType:getMoveSpeed()
    return linearResult(self.__parameters.MoveSpeed)
end

return UnitParameterType