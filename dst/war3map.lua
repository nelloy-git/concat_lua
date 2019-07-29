  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["utils.utils"] = function()
    local Utils = {}
    function Utils.getErrorPos()
      local str = ""
      local i = 2
      while(debug.getinfo(i, "ln") ~= nil) do
        local func = debug.getinfo(i, "lnS")
        local source_type = func.source:sub((#func.source-3), #func.source)
        if (func.source:sub((#func.source-3), #func.source) == ".lua") then
          str = "  "..func.source..":"..tostring(func.currentline).."\n"..str
        end
        i = (i+1)
      end
      return str
    end
    local __real_print = print
    function print(...)
      if (is_compiletime == true) then
        __real_print(...)
      else
        local s = ""
        for i = 1, select("#", ...) do
          local v = select(i, ...)
          local t = type(v)
          if (t == "number" or t == "table" or t == "nil") then
            v = tostring(v)
          end
          if (type(v) ~= "string") then
            v = ""
          end
          s = s.." "..v
        end
        for i = 0, 23 do
          DisplayTimedTextToPlayer(Player(i), 0, 0, 30, "[Debug]: "..s)
        end
      end
    end
    function ID(id)
      if (type(id) == "string") then
        return string.unpack(">I4", id)
      elseif (type(id) == "number" and math.fmod(id, 1) == 0) then
        return id
      end

      print("Wrong id fromat")
      print(Utils.getErrorPos())
      return nil
    end
    function id2str(id)
      return string.pack(">I4", id)
    end
    return Utils
end
__require_data.module["unit.parameters.mathParam"] = function()
    local MathParam = {}
    local val_for_half_cap = 300
    function MathParam.linear(base, mult, bonus, _)
      return ((base*mult)+bonus)
    end
    function MathParam.inverseLinear(base, mult, bonus, _)
      return ((base/mult)-bonus)
    end
    function MathParam.percent(base, mult, bonus, param_cap)
      local val = ((base*mult)+bonus)
      local k = (val/(val+val_for_half_cap))
      return (k*param_cap)
    end
    function MathParam.inversePercent(base, mult, bonus, param_cap)
      local val = ((base*mult)+bonus)
      local k = (val/(val+val_for_half_cap))
      return (100-(k*param_cap))
    end
    return MathParam
end
__require_data.module["unit.parameters.applyParam"] = function()
    local ApplyParameter = {}
    local attack_dispertion = 0.15
    function ApplyParameter.attack(owner, val)
      local k = (1-attack_dispertion)
      local dmg = (k*val)
      local dice_sides = ((2*attack_dispertion)*val)
      BlzSetUnitBaseDamage(owner, math.floor(dmg), 0)
      BlzSetUnitDiceNumber(owner, 1, 0)
      BlzSetUnitDiceSides(owner, math.floor((dice_sides+1)), 0)
    end
    function ApplyParameter.attackSpeed(owner, val)
      BlzSetUnitAttackCooldown(owner, val, 0)
    end
    function ApplyParameter.armor(owner, val)
      BlzSetUnitArmor(owner, val)
    end
    function ApplyParameter.spellPower(owner, val)

    end
    function ApplyParameter.castSpeed(owner, val)

    end
    local resist_id = "AM#$"
    function ApplyParameter.resistance(owner, val)
      if (GetUnitAbilityLevel(owner, FourCC(resist_id)) == 0) then
        UnitAddAbility(owner, FourCC(resist_id))
      end
      local abil = BlzGetUnitAbility(owner, FourCC(resist_id))
      BlzSetAbilityRealLevelField(abil, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 0, val)
    end
    function ApplyParameter.cooldown(owner, val)

    end
    function ApplyParameter.health(owner, val)
      BlzSetUnitMaxHP(owner, math.floor(val))
    end
    function ApplyParameter.regeneration(owner, val)
      BlzSetUnitRealField(owner, UNIT_RF_HIT_POINTS_REGENERATION_RATE, val)
    end
    function ApplyParameter.mana(owner, val)
      BlzSetUnitMaxMana(owner, math.floor(val))
    end
    function ApplyParameter.recovery(owner, val)
      BlzSetUnitRealField(owner, UNIT_RF_MANA_REGENERATION, val)
    end
    local crit_and_dodge_id = "AM#%"
    function ApplyParameter.critChance(owner, val)
      if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
        UnitAddAbility(owner, FourCC(crit_and_dodge_id))
      end
      local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
      BlzSetAbilityRealLevelField(abil, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 0, val)
    end
    function ApplyParameter.critPower(owner, val)
      if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
        UnitAddAbility(owner, FourCC(crit_and_dodge_id))
      end
      local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
      BlzSetAbilityRealLevelField(abil, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 0, val)
    end
    function ApplyParameter.dodgeChance(owner, val)
      val = (val/100)
      if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
        UnitAddAbility(owner, FourCC(crit_and_dodge_id))
      end
      local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
      BlzSetAbilityRealLevelField(abil, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 0, val)
    end
    function ApplyParameter.strength(owner, val)
      SetHeroStr(owner, math.floor(val), true)
    end
    function ApplyParameter.agility(owner, val)
      SetHeroAgi(owner, math.floor(val), true)
    end
    function ApplyParameter.strength(owner, val)
      SetHeroInt(owner, math.floor(val), true)
    end
    return ApplyParameter
end
__require_data.module["unit.parameters.parameter"] = function()
    local Parameter = {}
    function Parameter.new(owner_struct, base, apply_param_func, math_func, max_val)
      local container = {owner_struct = owner_struct, base = base, bonus = 0, mult = 1, cap = max_val, apply_param_func = apply_param_func, math_func = math_func}
      setmetatable(container, {__index = Parameter})
      container:update()
      return container
    end
    function Parameter:set(base, mult, bonus)
      self.base = base
      self.mult = mult
      self.bonus = bonus
      self:update()
    end
    function Parameter:add(base, mult, bonus)
      self.base = (self.base+base)
      self.mult = (self.mult+mult)
      self.bonus = (self.bonus+bonus)
      self:update()
    end
    function Parameter:get()
      return self.base, self.mult, self.bonus, self.math_func(self.base, self.mult, self.bonus, self.cap)
    end
    function Parameter:update()
      local val = self.math_func(self.base, self.mult, self.bonus, self.cap)
      self.apply_param_func(self.owner_struct.unit, val)
    end
    return Parameter
end
__require_data.module["unit.unit"] = function()
    local Param = require("unit.parameters.parameter")
    local ApplyParam = require("unit.parameters.applyParam")
    local MathParam = require("unit.parameters.mathParam")
    local Unit = {unit = nil}
    function Unit.new(player_id, unit_id, x, y, face)
      unit_id = ID(unit_id)
      local instance = {id = id2str(unit_id), unit = CreateUnit(Player(player_id), unit_id, x, y, face)}
      setmetatable(instance, {__index = Unit})
      instance:prepareCustomData()
      return instance
    end
    function Unit.newCorpse(player_id, unit_id, x, y, face)
      unit_id = ID(unit_id)
      local instance = {id = id2str(unit_id), unit = CreateCorpse(Player(player_id), unit_id, x, y, face)}
      setmetatable(instance, {__index = Unit})
      instance:prepareCustomData()
      return instance
    end
    function Unit:prepareCustomData()
      self:prepareParameters()
    end
    function Unit:prepareParameters()
      local parameters = {attack = Param.new(self, 1, ApplyParam.attack, MathParam.linear), attackSpeed = Param.new(self, 2, ApplyParam.attackSpeed, MathParam.inverseLinear), armor = Param.new(self, 0, ApplyParam.armor, MathParam.linear), spellPower = Param.new(self, 0, ApplyParam.spellPower, MathParam.linear), castSpeed = Param.new(self, 0, ApplyParam.castSpeed, MathParam.inversePercent, 75), resistance = Param.new(self, 0, ApplyParam.resistance, MathParam.percent, 90), health = Param.new(self, 100, ApplyParam.health, MathParam.linear), regeneration = Param.new(self, 0, ApplyParam.regeneration, MathParam.linear), mana = Param.new(self, 100, ApplyParam.mana, MathParam.linear), recovery = Param.new(self, 0, ApplyParam.recovery, MathParam.linear), critChance = Param.new(self, 0, ApplyParam.critChance, MathParam.percent, 100), critPower = Param.new(self, 1, ApplyParam.critPower, MathParam.linear), dodge = Param.new(self, 0, ApplyParam.dodgeChance, MathParam.percent, 75), cooldown = Param.new(self, 0, ApplyParam.cooldown, MathParam.percent, 75)}
      if (self.id:sub(1, 1) == string.upper(self.id:sub(1, 1))) then
        parameters.strength = Param.new(self, 0, ApplyParam.strength, MathParam.linear)
        parameters.agility = Param.new(self, 0, ApplyParam.agility, MathParam.linear)
        parameters.intelligence = Param.new(self, 0, ApplyParam.intelligence, MathParam.linear)
      end
      self.parameters = parameters
    end
    function Unit:setAttack(base, mult, bonus)
      self.parameters.attack:set(base, mult, bonus)
    end
    function Unit:addAttack(base, mult, bonus)
      self.parameters.attack:add(base, mult, bonus)
    end
    function Unit:getAttack()
      return self.parameters.attack:get()
    end
    function Unit:setAttackSpeed(base, mult, bonus)
      self.parameters.attackSpeed:set(base, mult, bonus)
    end
    function Unit:addAttackSpeed(base, mult, bonus)
      self.parameters.attackSpeed:add(base, mult, bonus)
    end
    function Unit:getAttackSpeed()
      return self.parameters.attackSpeed:get()
    end
    function Unit:setArmor(base, mult, bonus)
      self.parameters.armor:set(base, mult, bonus)
    end
    function Unit:addArmor(base, mult, bonus)
      self.parameters.armor:add(base, mult, bonus)
    end
    function Unit:getArmor()
      return self.parameters:get()
    end
    function Unit:setSpellPower(base, mult, bonus)
      self.parameters.spellPower:set(base, mult, bonus)
    end
    function Unit:addSpellPower(base, mult, bonus)
      self.parameters.spellPower:add(base, mult, bonus)
    end
    function Unit:getSpellPower()
      return self.parameters.spellPower:get()
    end
    function Unit:setCastSpeed(base, mult, bonus)
      self.parameters.castSpeed:set(base, mult, bonus)
    end
    function Unit:addCastSpeed(base, mult, bonus)
      self.parameters.castSpeed:add(base, mult, bonus)
    end
    function Unit:getCastSpeed()
      return self.parameters.castSpeed:get()
    end
    function Unit:setCastSpeed(base, mult, bonus)
      self.parameters.castSpeed:set(base, mult, bonus)
    end
    function Unit:addCastSpeed(base, mult, bonus)
      self.parameters.castSpeed:add(base, mult, bonus)
    end
    function Unit:getCastSpeed()
      return self.parameters.castSpeed:get()
    end
    function Unit:setResistance(base, mult, bonus)
      self.parameters.resistance:set(base, mult, bonus)
    end
    function Unit:addResistance(base, mult, bonus)
      self.parameters.resistance:add(base, mult, bonus)
    end
    function Unit:getResistance()
      return self.parameters.resistance:get()
    end
    function Unit:setHealth(base, mult, bonus)
      self.parameters.health:set(base, mult, bonus)
    end
    function Unit:addHealth(base, mult, bonus)
      self.parameters.health:add(base, mult, bonus)
    end
    function Unit:getHealth()
      return self.parameters.health:get()
    end
    function Unit:setRegeneration(base, mult, bonus)
      self.parameters.regeneration:set(base, mult, bonus)
    end
    function Unit:addRegeneration(base, mult, bonus)
      self.parameters.regeneration:add(base, mult, bonus)
    end
    function Unit:getRegeneration()
      return self.parameters.regeneration:get()
    end
    function Unit:setMana(base, mult, bonus)
      self.parameters.mana:set(base, mult, bonus)
    end
    function Unit:addMana(base, mult, bonus)
      self.parameters.mana:add(base, mult, bonus)
    end
    function Unit:getMana()
      return self.parameters.mana:get()
    end
    function Unit:setRecovery(base, mult, bonus)
      self.parameters.recovery:set(base, mult, bonus)
    end
    function Unit:addRecovery(base, mult, bonus)
      self.parameters.recovery:add(base, mult, bonus)
    end
    function Unit:getRecovery()
      return self.parameters.recovery:get()
    end
    function Unit:setCritChance(base, mult, bonus)
      self.parameters.critChance:set(base, mult, bonus)
    end
    function Unit:addCritChance(base, mult, bonus)
      self.parameters.critChance:add(base, mult, bonus)
    end
    function Unit:getCritChance()
      return self.parameters.critChance:get()
    end
    function Unit:setCritPower(base, mult, bonus)
      self.parameters.critPower:set(base, mult, bonus)
    end
    function Unit:addCritPower(base, mult, bonus)
      self.parameters.critPower:add(base, mult, bonus)
    end
    function Unit:getCritPower()
      return self.parameters.critPower:get()
    end
    function Unit:setDodgeChance(base, mult, bonus)
      self.parameters.dodge:set(base, mult, bonus)
    end
    function Unit:addDodgeChance(base, mult, bonus)
      self.parameters.dodge:add(base, mult, bonus)
    end
    function Unit:getDodgeChance()
      return self.parameters.dodge:get()
    end
    function Unit:setCooldown(base, mult, bonus)
      self.parameters.cooldown:set(base, mult, bonus)
    end
    function Unit:addCooldown(base, mult, bonus)
      self.parameters.cooldown:add(base, mult, bonus)
    end
    function Unit:getCooldown()
      return self.parameters.cooldown:get()
    end
    function Unit:setStrength(base, mult, bonus)
      if (self.parameters.strength ~= nil) then
        self.parameters.strength:set(base, mult, bonus)
      end
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
    function Unit:setAgility(base, mult, bonus)
      if (self.parameters.agility ~= nil) then
        self.parameters.agility:set(base, mult, bonus)
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
    function Unit:setIntelligence(base, mult, bonus)
      if (self.parameters.intelligence ~= nil) then
        self.parameters.intelligence:set(base, mult, bonus)
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
    return Unit
end
  
  local Unit = require("unit.unit")
  local Utils = require("utils.utils")
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
    local u2 = Unit.new(0, "hfoo", 0, 0, 0)
    u2:setDodgeChance(5000, 3, 0)
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
    SetCameraBounds((-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT)), (-3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM)), (3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT)), (3072.0-GetCameraMargin(CAMERA_MARGIN_TOP)), (-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT)), (3072.0-GetCameraMargin(CAMERA_MARGIN_TOP)), (3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT)), (-3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM)))
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
  