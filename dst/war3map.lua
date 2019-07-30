  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["unit.parameters.mathParam"] = function()
    local MathParameter = {}
    local val_for_half_cap = 300
    MathParameter.linear = function(base, mult, bonus)
        return base/mult-bonus
    end
    MathParameter.inverseLinear = function(base, mult, bonus)
        return base/mult-bonus
    end
    MathParameter.percent = function(base, mult, bonus, param_cap)
        local val = base*mult+bonus
        local k = val/val+val_for_half_cap
        return k*param_cap
    end
    MathParameter.inversePercent = function(base, mult, bonus, param_cap)
        local val = base*mult+bonus
        local k = val/val+val_for_half_cap
        return 100-k*100-param_cap
    end
    return MathParameter
end
__require_data.module["unit.parameters.applyParam"] = function()
    local UnitApplyParameter = {}
    local attack_dispertion = 0.15
    UnitApplyParameter.attack = function(owner, val)
        local k = 1-attack_dispertion
        local dmg = k*val
        local dice_sides = 2*attack_dispertion*val
        BlzSetUnitBaseDamage(owner, math.floor(dmg), 0)
        BlzSetUnitDiceNumber(owner, 1, 0)
        BlzSetUnitDiceSides(owner, math.floor(dice_sides+1), 0)
    end
    UnitApplyParameter.attackSpeed = function(owner, val)
        BlzSetUnitAttackCooldown(owner, val, 0)
    end
    UnitApplyParameter.armor = function(owner, val)
        BlzSetUnitArmor(owner, val)
    end
    UnitApplyParameter.spellPower = function(owner, val)

    end
    UnitApplyParameter.castSpeed = function(owner, val)

    end
    local resist_id = "AM#$"
    UnitApplyParameter.resistance = function(owner, val)
        if (GetUnitAbilityLevel(owner, FourCC(resist_id)) == 0) then
          UnitAddAbility(owner, FourCC(resist_id))
        end
        local abil = BlzGetUnitAbility(owner, FourCC(resist_id))
        BlzSetAbilityRealLevelField(abil, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 0, val)
    end
    UnitApplyParameter.cooldown = function(owner, val)

    end
    UnitApplyParameter.health = function(owner, val)
        BlzSetUnitMaxHP(owner, math.floor(val))
    end
    UnitApplyParameter.regeneration = function(owner, val)
        BlzSetUnitRealField(owner, UNIT_RF_HIT_POINTS_REGENERATION_RATE, val)
    end
    UnitApplyParameter.mana = function(owner, val)
        BlzSetUnitMaxMana(owner, math.floor(val))
    end
    UnitApplyParameter.recovery = function(owner, val)
        BlzSetUnitRealField(owner, UNIT_RF_MANA_REGENERATION, val)
    end
    local crit_and_dodge_id = "AM#%"
    UnitApplyParameter.critChance = function(owner, val)
        if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
          UnitAddAbility(owner, FourCC(crit_and_dodge_id))
        end
        local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
        BlzSetAbilityRealLevelField(abil, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 0, val)
    end
    UnitApplyParameter.critPower = function(owner, val)
        if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
          UnitAddAbility(owner, FourCC(crit_and_dodge_id))
        end
        local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
        BlzSetAbilityRealLevelField(abil, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 0, val)
    end
    UnitApplyParameter.dodgeChance = function(owner, val)
        val = val/100
        if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
          UnitAddAbility(owner, FourCC(crit_and_dodge_id))
        end
        local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
        BlzSetAbilityRealLevelField(abil, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 0, val)
    end
    UnitApplyParameter.strength = function(owner, val)
        SetHeroStr(owner, math.floor(val), true)
    end
    UnitApplyParameter.agility = function(owner, val)
        SetHeroAgi(owner, math.floor(val), true)
    end
    UnitApplyParameter.strength = function(owner, val)
        SetHeroInt(owner, math.floor(val), true)
    end
    return UnitApplyParameter
end
__require_data.module["unit.parameters.parameter"] = function()
    local ApplyParam = require("unit.parameters.applyParam")
    local MathParam = require("unit.parameters.mathParam")
    local UnitParameter = {}
    function UnitParameter.new(owner_struct, base, apply_param_func, math_func, max_val)
      local container = {owner_struct = owner_struct, base = base, bonus = 0, mult = 1, cap = max_val, apply_param_func = apply_param_func, math_func = math_func}
      setmetatable(container, {__index = UnitParameter})
      container:update()
      return container
    end
    function UnitParameter.addContainer(unit)
      local parameters = {attack = UnitParameter.new(unit, 1, ApplyParam.attack, MathParam.linear), attackSpeed = UnitParameter.new(unit, 2, ApplyParam.attackSpeed, MathParam.inverseLinear), armor = UnitParameter.new(unit, 0, ApplyParam.armor, MathParam.linear), spellPower = UnitParameter.new(unit, 0, ApplyParam.spellPower, MathParam.linear), castSpeed = UnitParameter.new(unit, 0, ApplyParam.castSpeed, MathParam.inversePercent, 25), resistance = UnitParameter.new(unit, 0, ApplyParam.resistance, MathParam.percent, 90), health = UnitParameter.new(unit, 100, ApplyParam.health, MathParam.linear), regeneration = UnitParameter.new(unit, 0, ApplyParam.regeneration, MathParam.linear), mana = UnitParameter.new(unit, 100, ApplyParam.mana, MathParam.linear), recovery = UnitParameter.new(unit, 0, ApplyParam.recovery, MathParam.linear), critChance = UnitParameter.new(unit, 0, ApplyParam.critChance, MathParam.percent, 100), critPower = UnitParameter.new(unit, 1, ApplyParam.critPower, MathParam.linear), dodge = UnitParameter.new(unit, 0, ApplyParam.dodgeChance, MathParam.percent, 75), cooldown = UnitParameter.new(unit, 0, ApplyParam.cooldown, MathParam.percent, 75)}
      if (unit.id:sub(1, 1) == string.upper(unit.id:sub(1, 1))) then
        parameters.strength = UnitParameter.new(unit, 0, ApplyParam.strength, MathParam.linear)
        parameters.agility = UnitParameter.new(unit, 0, ApplyParam.agility, MathParam.linear)
        parameters.intelligence = UnitParameter.new(unit, 0, ApplyParam.intelligence, MathParam.linear)
      end
      unit.parameters = parameters
    end
    function UnitParameter:set(base, mult, bonus)
      self.base = base
      self.mult = mult
      self.bonus = bonus
      self:update()
    end
    function UnitParameter:add(base, mult, bonus)
      self.base = self.base+base
      self.mult = self.mult+mult
      self.bonus = self.bonus+bonus
      self:update()
    end
    function UnitParameter:get()
      return self.base, self.mult, self.bonus, self.math_func(self.base, self.mult, self.bonus, self.cap)
    end
    function UnitParameter:update()
      local val = self.math_func(self.base, self.mult, self.bonus, self.cap)
      self.apply_param_func(self.owner_struct.unit, val)
    end
    return UnitParameter
end
__require_data.module["unit.unit"] = function()
    local Parameter = require("unit.parameters.parameter")
    local Unit = {}
    local UnitDB = {}
    function UnitDB.add(unit)
      UnitDB[unit.unit] = unit
    end
    function UnitDB.rm(unit)
      UnitDB[unit.unit] = nil
    end
    function UnitDB.get(unit_obj)
      return UnitDB[unit_obj]
    end
    function Unit.new(player_id, unit_id, x, y, face)
      unit_id = ID(unit_id)
      local instance = {id = ID2str(unit_id), unit_obj = CreateUnit(Player(player_id), unit_id, x, y, face)}
      setmetatable(instance, {__index = Unit})
      instance:prepareCustomData()
      UnitDB.add(instance)
      return instance
    end
    function Unit.newCorpse(player_id, unit_id, x, y, face)
      unit_id = ID(unit_id)
      local instance = {id = ID2str(unit_id), unit_obj = CreateCorpse(Player(player_id), unit_id, x, y, face)}
      setmetatable(instance, {__index = Unit})
      instance:prepareCustomData()
      UnitDB.add(instance)
      return instance
    end
    function Unit:prepareCustomData()
      self.parameters = Parameter.addContainer(self)
    end
    function Unit:addAttack(base, mult, bonus)
      self.parameters.attack:add(base, mult, bonus)
    end
    function Unit:getAttack()
      return self.parameters.attack:get()
    end
    function Unit:addAttackSpeed(base, mult, bonus)
      self.parameters.attackSpeed:add(base, mult, bonus)
    end
    function Unit:getAttackSpeed()
      return self.parameters.attackSpeed:get()
    end
    function Unit:addArmor(base, mult, bonus)
      self.parameters.armor:add(base, mult, bonus)
    end
    function Unit:getArmor()
      return self.parameters:get()
    end
    function Unit:addSpellPower(base, mult, bonus)
      self.parameters.spellPower:add(base, mult, bonus)
    end
    function Unit:getSpellPower()
      return self.parameters.spellPower:get()
    end
    function Unit:addCastSpeed(base, mult, bonus)
      self.parameters.castSpeed:add(base, mult, bonus)
    end
    function Unit:getCastSpeed()
      return self.parameters.castSpeed:get()
    end
    function Unit:addCastSpeed(base, mult, bonus)
      self.parameters.castSpeed:add(base, mult, bonus)
    end
    function Unit:getCastSpeed()
      return self.parameters.castSpeed:get()
    end
    function Unit:addResistance(base, mult, bonus)
      self.parameters.resistance:add(base, mult, bonus)
    end
    function Unit:getResistance()
      return self.parameters.resistance:get()
    end
    function Unit:addHealth(base, mult, bonus)
      self.parameters.health:add(base, mult, bonus)
    end
    function Unit:getHealth()
      return self.parameters.health:get()
    end
    function Unit:addRegeneration(base, mult, bonus)
      self.parameters.regeneration:add(base, mult, bonus)
    end
    function Unit:getRegeneration()
      return self.parameters.regeneration:get()
    end
    function Unit:addMana(base, mult, bonus)
      self.parameters.mana:add(base, mult, bonus)
    end
    function Unit:getMana()
      return self.parameters.mana:get()
    end
    function Unit:addRecovery(base, mult, bonus)
      self.parameters.recovery:add(base, mult, bonus)
    end
    function Unit:getRecovery()
      return self.parameters.recovery:get()
    end
    function Unit:addCritChance(base, mult, bonus)
      self.parameters.critChance:add(base, mult, bonus)
    end
    function Unit:getCritChance()
      return self.parameters.critChance:get()
    end
    function Unit:addCritPower(base, mult, bonus)
      self.parameters.critPower:add(base, mult, bonus)
    end
    function Unit:getCritPower()
      return self.parameters.critPower:get()
    end
    function Unit:addDodgeChance(base, mult, bonus)
      self.parameters.dodge:add(base, mult, bonus)
    end
    function Unit:getDodgeChance()
      return self.parameters.dodge:get()
    end
    function Unit:addCooldown(base, mult, bonus)
      self.parameters.cooldown:add(base, mult, bonus)
    end
    function Unit:getCooldown()
      return self.parameters.cooldown:get()
    end
    function Unit:addStrength(base, mult, bonus)
      if (self.parameters.strength ~= nil) then
        self.parameters.strength:add(base, mult, bonus)
      end
    end
    function Unit:getStrength()
      if (self.parameters.strength ~= nil) then
        return self.parameters.strength:get()
      else
        return 0, 0, 0, 0
      end
    end
    function Unit:addAgility(base, mult, bonus)
      if (self.parameters.agility ~= nil) then
        self.parameters.agility:add(base, mult, bonus)
      end
    end
    function Unit:getAgility()
      if (self.parameters.agility ~= nil) then
        return self.parameters.agility:get()
      else
        return 0, 0, 0, 0
      end
    end
    function Unit:addIntelligence(base, mult, bonus)
      if (self.parameters.intelligence ~= nil) then
        self.parameters.intelligence:add(base, mult, bonus)
      end
    end
    function Unit:getIntelligence()
      if (self.parameters.intelligence ~= nil) then
        return self.parameters.intelligence:get()
      else
        return 0, 0, 0, 0
      end
    end
    Unit.__replaced_functions = {GetLevelingUnit = GetLevelingUnit, GetLearningUnit = GetLearningUnit, GetRevivableUnit = GetRevivableUnit, GetRevivingUnit = GetRevivingUnit, GetAttacker = GetAttacker, GetRescuer = GetRescuer, GetDyingUnit = GetDyingUnit, GetKillingUnit = GetKillingUnit, GetDecayingUnit = GetDecayingUnit, GetConstructingStructure = GetConstructingStructure, GetCancelledStructure = GetCancelledStructure, GetConstructedStructure = GetConstructedStructure, GetResearchingUnit = GetResearchingUnit, GetTrainedUnit = GetTrainedUnit, GetDetectedUnit = GetDetectedUnit, GetSummoningUnit = GetSummoningUnit, GetSummonedUnit = GetSummonedUnit, GetTransportUnit = GetTransportUnit, GetLoadedUnit = GetLoadedUnit, GetSellingUnit = GetSellingUnit, GetSoldUnit = GetSoldUnit, GetBuyingUnit = GetBuyingUnit, GetChangingUnit = GetChangingUnit, GetManipulatingUnit = GetManipulatingUnit, GetOrderedUnit = GetOrderedUnit, GetOrderTargetUnit = GetOrderTargetUnit, GetSpellAbilityUnit = GetSpellAbilityUnit, GetSpellTargetUnit = GetSpellTargetUnit, GetTriggerUnit = GetTriggerUnit, GetEventDamage = GetEventDamage, GetEventDamageSource = GetEventDamageSource, GetEventTargetUnit = GetEventTargetUnit}
    function GetLevelingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetLevelingUnit())
    end
    function GetLearningUnit()
      return UnitDB.get(Unit.replaced_functions.__GetLearningUnit())
    end
    function GetRevivableUnit()
      return UnitDB.get(Unit.replaced_functions.__GetRevivableUnit())
    end
    function GetRevivingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetRevivingUnit())
    end
    function GetAttacker()
      return UnitDB.get(Unit.replaced_functions.__GetAttacker())
    end
    function GetRescuer()
      return UnitDB.get(Unit.replaced_functions.__GetRescuer())
    end
    function GetDyingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetDyingUnit())
    end
    function GetKillingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetKillingUnit())
    end
    function GetDecayingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetDecayingUnit())
    end
    function GetConstructingStructure()
      return UnitDB.get(Unit.replaced_functions.__GetConstructingStructure())
    end
    function GetCancelledStructure()
      return UnitDB.get(Unit.replaced_functions.__GetCancelledStructure())
    end
    function GetConstructedStructure()
      return UnitDB.get(Unit.replaced_functions.__GetConstructedStructure())
    end
    function GetResearchingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetResearchingUnit())
    end
    function GetTrainedUnit()
      return UnitDB.get(Unit.replaced_functions.__GetTrainedUnit())
    end
    function GetDetectedUnit()
      return UnitDB.get(Unit.replaced_functions.__GetDetectedUnit())
    end
    function GetSummoningUnit()
      return UnitDB.get(Unit.replaced_functions.__GetSummoningUnit())
    end
    function GetSummonedUnit()
      return UnitDB.get(Unit.replaced_functions.__GetSummonedUnit())
    end
    function GetTransportUnit()
      return UnitDB.get(Unit.replaced_functions.__GetTransportUnit())
    end
    function GetLoadedUnit()
      return UnitDB.get(Unit.replaced_functions.__GetLoadedUnit())
    end
    function GetSellingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetSellingUnit())
    end
    function GetSoldUnit()
      return UnitDB.get(Unit.replaced_functions.__GetSoldUnit())
    end
    function GetBuyingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetBuyingUnit())
    end
    function GetChangingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetChangingUnit())
    end
    function GetManipulatingUnit()
      return UnitDB.get(Unit.replaced_functions.__GetManipulatingUnit())
    end
    function GetOrderedUnit()
      return UnitDB.get(Unit.replaced_functions.__GetOrderedUnit())
    end
    function GetOrderTargetUnit()
      return UnitDB.get(Unit.replaced_functions.__GetOrderTargetUnit())
    end
    function GetSpellAbilityUnit()
      return UnitDB.get(Unit.replaced_functions.__GetSpellAbilityUnit())
    end
    function GetSpellTargetUnit()
      return UnitDB.get(Unit.replaced_functions.__GetSpellTargetUnit())
    end
    function GetTriggerUnit()
      return UnitDB.get(Unit.replaced_functions.__GetTriggerUnit())
    end
    function GetEventDamage()
      return UnitDB.get(Unit.replaced_functions.__GetEventDamage())
    end
    function GetEventDamageSource()
      return UnitDB.get(Unit.replaced_functions.__GetEventDamageSource())
    end
    function GetEventTargetUnit()
      return UnitDB.get(Unit.replaced_functions.__GetEventTargetUnit())
    end
    return Unit
end
  nil
  local Unit = require("unit.unit")
  GG_trg_Melee_Initialization = nil
  function InitGlobals()

  end
  function Trig_Melee_Initialization_Actions()
    MeleeStartingVisibility()
    MeleeStartingHeroLimit()
    MeleeGrantHeroItems()
    MeleeStartingResources()
    MeleeClearExcessUnits()
    MeleeStartingUnits()
    MeleeStartingAI()
    MeleeInitVictoryDefeat()
    local u1 = Unit.new(0, "hfoo", 0, 0, 0)
    u1:addAttack(10, 1, 0)
    local u2 = Unit.new(0, "hfoo", 0, 0, 0)
  end
  function InitTrig_Melee_Initialization()
    GG_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(GG_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
  end
  function InitCustomTriggers()
    InitTrig_Melee_Initialization()
  end
  function RunInitializationTriggers()
    ConditionalTriggerExecute(GG_trg_Melee_Initialization)
  end
  function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
  end
  function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
  end
  function main()
    SetCameraBounds(-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0-GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0-GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
  end
  function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, -1953.6, -3131.3)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
  end
  nil