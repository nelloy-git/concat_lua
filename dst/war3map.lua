  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["unit.unitDB"] = function()
    local UnitDB = {}
    function UnitDB.add(unit_obj, unit)
      UnitDB[unit_obj] = unit
    end
    function UnitDB.rm(unit_obj)
      UnitDB[unit_obj] = nil
    end
    function UnitDB.get(unit_obj)
      return UnitDB[unit_obj]
    end
    return UnitDB
end
__require_data.module["unit.parameters.unitMathParameter"] = function()
    local UnitMathParameter = {}
    local val_for_half_cap = 300
    UnitMathParameter.linear = function(base, mult, bonus)
        return ((base*mult)+bonus)
    end
    UnitMathParameter.inverseLinear = function(base, mult, bonus)
        return ((base/mult)-bonus)
    end
    UnitMathParameter.percent = function(base, mult, bonus, param_cap)
        local val = ((base*mult)+bonus)
        local k = (val/(val+val_for_half_cap))
        return (k*param_cap)
    end
    UnitMathParameter.inversePercent = function(base, mult, bonus, param_cap)
        local val = ((base*mult)+bonus)
        local k = (val/(val+val_for_half_cap))
        return (100-(k*(100-param_cap)))
    end
    return UnitMathParameter
end
__require_data.module["unit.parameters.unitApplyParameter"] = function()
    local UnitApplyParameter = {}
    local attack_dispertion = 0.15
    UnitApplyParameter.attack = function(owner, val)
        local k = (1-attack_dispertion)
        local dmg = (k*val)
        local dice_sides = ((2*attack_dispertion)*val)
        BlzSetUnitBaseDamage(owner, math.floor(dmg), 0)
        BlzSetUnitDiceNumber(owner, 1, 0)
        BlzSetUnitDiceSides(owner, math.floor((dice_sides+1)), 0)
    end
    UnitApplyParameter.attackSpeed = function(owner, val)
        BlzSetUnitAttackCooldown(owner, val, 0)
    end
    UnitApplyParameter.armor = function(owner, val)
        BlzSetUnitArmor(owner, math.floor(val))
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
    local tooltip_critChance = "Crit chance: "
    local tooltip_critPower = "Crit power: "
    local tooltip_dodgechance = "Dodge chance: "
    UnitApplyParameter.critChance = function(owner, val)
        if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
          UnitAddAbility(owner, FourCC(crit_and_dodge_id))
        end
        local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
        BlzSetAbilityRealLevelField(abil, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 0, val)
        if (GetOwningPlayer(owner) == GetLocalPlayer()) then
          local tooltip = BlzGetAbilityExtendedTooltip(ID(crit_and_dodge_id), 0)
          local pos = tooltip:find(tooltip_critChance)
          if (pos == nil) then
            tooltip = tooltip_critChance.."\n"..tooltip_critPower.."\n"..tooltip_dodgechance
            pos = tooltip:find(tooltip_critChance)
          end
          pos = (pos+tooltip_critChance:len())
          tooltip = tooltip:sub(1, (pos-1))..tostring(val).."%"..tooltip:sub(tooltip:find("\n"), #tooltip)
          BlzSetAbilityExtendedTooltip(ID(crit_and_dodge_id), tooltip, 0)
        end
    end
    UnitApplyParameter.critPower = function(owner, val)
        if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
          UnitAddAbility(owner, FourCC(crit_and_dodge_id))
        end
        local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
        BlzSetAbilityRealLevelField(abil, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 0, val)
        if (GetOwningPlayer(owner) == GetLocalPlayer()) then
          local tooltip = BlzGetAbilityExtendedTooltip(ID(crit_and_dodge_id), 0)
          local start = tooltip:find(tooltip_critPower)
          if (start == nil) then
            tooltip = tooltip_critChance.."\n"..tooltip_critPower.."\n"..tooltip_dodgechance
            start = tooltip:find(tooltip_critPower)
          end
          finish = (start+tooltip_critPower:len())
          tooltip = tooltip:sub(1, (finish-1))..tostring(val).."%"..tooltip:sub(tooltip:find("\n", start), #tooltip)
          BlzSetAbilityExtendedTooltip(ID(crit_and_dodge_id), tooltip, 0)
        end
    end
    UnitApplyParameter.dodgeChance = function(owner, val)
        val = (val/100)
        if (GetUnitAbilityLevel(owner, FourCC(crit_and_dodge_id)) == 0) then
          UnitAddAbility(owner, FourCC(crit_and_dodge_id))
        end
        local abil = BlzGetUnitAbility(owner, FourCC(crit_and_dodge_id))
        BlzSetAbilityRealLevelField(abil, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 0, val)
        if (GetOwningPlayer(owner) == GetLocalPlayer()) then
          local tooltip = BlzGetAbilityExtendedTooltip(ID(crit_and_dodge_id), 0)
          local start = tooltip:find(tooltip_dodgechance)
          if (start == nil) then
            tooltip = tooltip_critChance.."\n"..tooltip_dodgechance.."\n"..tooltip_dodgechance
            start = tooltip:find(tooltip_dodgechance)
          end
          finish = (start+tooltip_dodgechance:len())
          tooltip = tooltip:sub(1, (finish-1))..tostring(val).."%"
          BlzSetAbilityExtendedTooltip(ID(crit_and_dodge_id), tooltip, 0)
        end
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
__require_data.module["unit.parameters.unitParameter"] = function()
    local UnitParameter = {}
    function UnitParameter.new(owner_struct, base, apply_param_func, math_func, max_val)
      local container = {owner_struct = owner_struct, base = base, bonus = 0, mult = 1, cap = max_val, apply_param_func = apply_param_func, math_func = math_func}
      setmetatable(container, {__index = UnitParameter})
      container:update()
      return container
    end
    function UnitParameter:set(base, mult, bonus)
      self.base = base
      self.mult = mult
      self.bonus = bonus
      self:update()
    end
    function UnitParameter:add(base, mult, bonus)
      self.base = (self.base+base)
      self.mult = (self.mult+mult)
      self.bonus = (self.bonus+bonus)
      self:update()
    end
    function UnitParameter:get()
      return self.base, self.mult, self.bonus, self.math_func(self.base, self.mult, self.bonus, self.cap)
    end
    function UnitParameter:update()
      local val = self.math_func(self.base, self.mult, self.bonus, self.cap)
      self.apply_param_func(self.owner_struct.unit_obj, val)
    end
    return UnitParameter
end
__require_data.module["unit.parameters.unitParameterContainer"] = function()
    local UnitParameter = require("unit.parameters.unitParameter")
    local ApplyParam = require("unit.parameters.unitApplyParameter")
    local MathParam = require("unit.parameters.unitMathParameter")
    local ParameterContainer = {}
    local ParameterContainer_meta = {__index = ParameterContainer}
    function ParameterContainer.new(unit)
      local parameter_container = {owner = unit, attack = UnitParameter.new(unit, 1, ApplyParam.attack, MathParam.linear), attackSpeed = UnitParameter.new(unit, 2, ApplyParam.attackSpeed, MathParam.inverseLinear), armor = UnitParameter.new(unit, 0, ApplyParam.armor, MathParam.linear), spellPower = UnitParameter.new(unit, 0, ApplyParam.spellPower, MathParam.linear), castSpeed = UnitParameter.new(unit, 0, ApplyParam.castSpeed, MathParam.inversePercent, 25), resistance = UnitParameter.new(unit, 0, ApplyParam.resistance, MathParam.percent, 90), health = UnitParameter.new(unit, 100, ApplyParam.health, MathParam.linear), regeneration = UnitParameter.new(unit, 0, ApplyParam.regeneration, MathParam.linear), mana = UnitParameter.new(unit, 100, ApplyParam.mana, MathParam.linear), recovery = UnitParameter.new(unit, 0, ApplyParam.recovery, MathParam.linear), critChance = UnitParameter.new(unit, 0, ApplyParam.critChance, MathParam.percent, 100), critPower = UnitParameter.new(unit, 1, ApplyParam.critPower, MathParam.linear), dodge = UnitParameter.new(unit, 0, ApplyParam.dodgeChance, MathParam.percent, 75), cooldown = UnitParameter.new(unit, 0, ApplyParam.cooldown, MathParam.percent, 75)}
      setmetatable(parameter_container, ParameterContainer_meta)
      Debug("Done")
      local string_id = ID2str(unit:getId())
      local first = string_id:sub(1, 1)
      if (first == string.upper(first)) then
        parameter_container.strength = UnitParameter.new(unit, 1, ApplyParam.strength, MathParam.linear)
        parameter_container.agility = UnitParameter.new(unit, 1, ApplyParam.agility, MathParam.linear)
        parameter_container.intelligence = UnitParameter.new(unit, 1, ApplyParam.intelligence, MathParam.linear)
      end
      Debug("Done")
      return parameter_container
    end
    function ParameterContainer:addAttack(base, mult, bonus)
      self.attack:add(base, mult, bonus)
    end
    function ParameterContainer:getAttack()
      return self.attack:get()
    end
    function ParameterContainer:setAttacksPerSec(base)
      _, mult, bonus, _ = self.attackSpeed:get()
      self.attackSpeed:set(base, mult, bonus)
    end
    function ParameterContainer:addAttackSpeed(mult)
      self.attackSpeed:add(0, mult, 0)
    end
    function ParameterContainer:getAttackSpeed()
      base, mult, _, res = self.attackSpeed:get()
      return base, mult, res
    end
    function ParameterContainer:addArmor(base, mult, bonus)
      self.armor:add(base, mult, bonus)
    end
    function ParameterContainer:getArmor()
      return self.armor:get()
    end
    function ParameterContainer:addSpellPower(base, mult, bonus)
      self.spellPower:add(base, mult, bonus)
    end
    function ParameterContainer:getSpellPower()
      return self.spellPower:get()
    end
    function ParameterContainer:addCastSpeed(base, mult, bonus)
      self.castSpeed:add(base, mult, bonus)
    end
    function ParameterContainer:getCastSpeed()
      return self.castSpeed:get()
    end
    function ParameterContainer:addResistance(base, mult, bonus)
      self.resistance:add(base, mult, bonus)
    end
    function ParameterContainer:getResistance()
      return self.resistance:get()
    end
    function ParameterContainer:addHealth(base, mult, bonus)
      self.health:add(base, mult, bonus)
    end
    function ParameterContainer:getHealth()
      return self.health:get()
    end
    function ParameterContainer:addRegeneration(base, mult, bonus)
      self.regeneration:add(base, mult, bonus)
    end
    function ParameterContainer:getRegeneration()
      return self.regeneration:get()
    end
    function ParameterContainer:addMana(base, mult, bonus)
      self.mana:add(base, mult, bonus)
    end
    function ParameterContainer:getMana()
      return self.mana:get()
    end
    function ParameterContainer:addRecovery(base, mult, bonus)
      self.recovery:add(base, mult, bonus)
    end
    function ParameterContainer:getRecovery()
      return self.recovery:get()
    end
    function ParameterContainer:addCritChance(base, mult, bonus)
      self.critChance:add(base, mult, bonus)
    end
    function ParameterContainer:getCritChance()
      return self.critChance:get()
    end
    function ParameterContainer:addCritPower(base, mult, bonus)
      self.critPower:add(base, mult, bonus)
    end
    function ParameterContainer:getCritPower()
      return self.critPower:get()
    end
    function ParameterContainer:addDodgeChance(base, mult, bonus)
      self.dodge:add(base, mult, bonus)
    end
    function ParameterContainer:getDodgeChance()
      return self.dodge:get()
    end
    function ParameterContainer:addCooldown(base, mult, bonus)
      self.cooldown:add(base, mult, bonus)
    end
    function ParameterContainer:getCooldown()
      return self.cooldown:get()
    end
    function ParameterContainer:addStrength(base, mult, bonus)
      if (self.strength ~= nil) then
        self.strength:add(base, mult, bonus)
      end
    end
    function ParameterContainer:getStrength()
      if (self.strength ~= nil) then
        return self.strength:get()
      else
        return 0, 0, 0, 0
      end
    end
    function ParameterContainer:addAgility(base, mult, bonus)
      if (self.agility ~= nil) then
        self.agility:add(base, mult, bonus)
      end
    end
    function ParameterContainer:getAgility()
      if (self.agility ~= nil) then
        return self.agility:get()
      else
        return 0, 0, 0, 0
      end
    end
    function ParameterContainer:addIntelligence(base, mult, bonus)
      if (self.intelligence ~= nil) then
        self.intelligence:add(base, mult, bonus)
      end
    end
    function ParameterContainer:getIntelligence()
      if (self.intelligence ~= nil) then
        return self.intelligence:get()
      else
        return 0, 0, 0, 0
      end
    end
    return ParameterContainer
end
__require_data.module["unit.unit"] = function()
    Debug("Unit class initialization...")
    local ParameterContainer = require("unit.parameters.unitParameterContainer")
    local UnitDB = require("unit.unitDB")
    local Unit = {}
    local Unit_meta = {__index = Unit, __gc = Unit.destroy}
    function Unit_meta.__tostring(self)
      Debug("here")
      return string.format("Unit %s (%s) at [%.2f, %.2f, %.2f]", self:getName(), self:getId(), self:getX(), self:getY(), self:getZ())
    end
    function Unit.new(player, id, x, y, face, is_dead)
      id = ID(id)
      local unit_obj = nil
      if (is_dead) then
        unit_obj = CreateCorpse(player:get(), id, x, y, face)
      else
        unit_obj = CreateUnit(player:get(), id, x, y, face)
      end
      local unit = {__id = id, unit_obj = unit_obj}
      setmetatable(unit, Unit_meta)
      UnitDB.add(unit.unit_obj, unit)
      unit:initCustomData()
      return unit
    end
    function Unit:destroy()
      self:destroyCustomData()
      UnitDB.rm(self.unit_obj)
      RemoveUnit(self.unit_obj)
      self.unit_obj = nil
    end
    function Unit:initCustomData()
      self.parameter = ParameterContainer.new(self)
    end
    function Unit:destroyCustomData()

    end
    function Unit:getId()
      return self.__id
    end
    function Unit:getName()
      return GetUnitName(self.unit_obj)
    end
    function Unit:setVertexColor(red, green, blue, alpha)
      red = math.floor((255*to_range(red, 0, 1)))
      green = math.floor((255*to_range(green, 0, 1)))
      blue = math.floor((255*to_range(blue, 0, 1)))
      alpha = math.floor((255*to_range(alpha, 0, 1)))
      SetUnitVertexColor(self.unit_obj, red, green, blue, alpha)
    end
    function Unit:getOwningPlayer()
      return GetOwningPlayer(self)
    end
    function Unit:setPos(x, y)
      SetUnitX(self.unit_obj, x)
      SetUnitY(self.unit_obj, y)
    end
    function Unit:getPos()
      return GetUnitX(self.unit_obj), GetUnitY(self.unit_obj)
    end
    function Unit:getX()
      return GetUnitX(self.unit_obj)
    end
    function Unit:getY()
      return GetUnitY(self.unit_obj)
    end
    function Unit:getZ()
      return GetUnitFlyHeight(self.unit_obj)
    end
    function Unit:setFacing(angle)
      SetUnitFacing(self.unit_obj, angle)
    end
    function Unit:setFacingTo(target_x, target_y)
      local x, y = self:getPos()
      local angle = (180+((180/math.pi)*math.atan((y-target_y), (x-target_x))))
      SetUnitFacing(self.unit_obj, angle)
    end
    function Unit:getFacing()
      return GetUnitFacing(self.unit_obj)
    end
    function Unit:addAbility(ability)
      UnitAddAbility(self.unit_obj, ability:getId())
    end
    function Unit:removeAbility(ability)
      UnitRemoveAbility(self.unit_obj, ability:getId())
    end
    function Unit:setInvulnerable(flag)
      SetUnitInvulnerable(self.unit_obj, flag)
    end
    function Unit:applyTimedLife(time)
      UnitApplyTimedLife(self.unit_obj, 0, time)
    end
    function Unit:issueImmediateOrderById(order_id)
      IssueImmediateOrderById(self.unit_obj, order_id)
    end
    function Unit:orderStop()
      self:issueImmediateOrderById(851972)
    end
    function Unit:issuePointOrderById(order_id, x, y)
      IssuePointOrderById(self.unit_obj, order_id, x, y)
    end
    function Unit:setMoveSpeed(speed)
      SetUnitMoveSpeed(self.unit_obj, speed)
    end
    function Unit:setTurnSpeed(speed)
      SetUnitTurnSpeed(self.unit_obj, speed)
    end
    function Unit:playAnimation(animation)
      SetUnitAnimation(self.unit_obj, animation)
    end
    function Unit:setAnimationSpeed(scale)
      SetUnitTimeScale(self.unit_obj, scale)
    end
    function Unit:pause()
      PauseUnit(self.unit_obj, true)
    end
    function Unit:unpause()
      PauseUnit(self.unit_obj, false)
    end
    local __replaced_functions = {GetLevelingUnit = GetLevelingUnit, GetLearningUnit = GetLearningUnit, GetRevivableUnit = GetRevivableUnit, GetRevivingUnit = GetRevivingUnit, GetAttacker = GetAttacker, GetRescuer = GetRescuer, GetDyingUnit = GetDyingUnit, GetKillingUnit = GetKillingUnit, GetDecayingUnit = GetDecayingUnit, GetConstructingStructure = GetConstructingStructure, GetCancelledStructure = GetCancelledStructure, GetConstructedStructure = GetConstructedStructure, GetResearchingUnit = GetResearchingUnit, GetTrainedUnit = GetTrainedUnit, GetDetectedUnit = GetDetectedUnit, GetSummoningUnit = GetSummoningUnit, GetSummonedUnit = GetSummonedUnit, GetTransportUnit = GetTransportUnit, GetLoadedUnit = GetLoadedUnit, GetSellingUnit = GetSellingUnit, GetSoldUnit = GetSoldUnit, GetBuyingUnit = GetBuyingUnit, GetChangingUnit = GetChangingUnit, GetManipulatingUnit = GetManipulatingUnit, GetOrderedUnit = GetOrderedUnit, GetOrderTargetUnit = GetOrderTargetUnit, GetSpellAbilityUnit = GetSpellAbilityUnit, GetSpellTargetUnit = GetSpellTargetUnit, GetTriggerUnit = GetTriggerUnit, GetEventDamage = GetEventDamage, GetEventDamageSource = GetEventDamageSource, GetEventTargetUnit = GetEventTargetUnit}
    function GetLevelingUnit()
      return UnitDB.get(__replaced_functions.GetLevelingUnit())
    end
    function GetLearningUnit()
      return UnitDB.get(__replaced_functions.GetLearningUnit())
    end
    function GetRevivableUnit()
      return UnitDB.get(__replaced_functions.GetRevivableUnit())
    end
    function GetRevivingUnit()
      return UnitDB.get(__replaced_functions.GetRevivingUnit())
    end
    function GetAttacker()
      return UnitDB.get(__replaced_functions.GetAttacker())
    end
    function GetRescuer()
      return UnitDB.get(__replaced_functions.GetRescuer())
    end
    function GetDyingUnit()
      return UnitDB.get(__replaced_functions.GetDyingUnit())
    end
    function GetKillingUnit()
      return UnitDB.get(__replaced_functions.GetKillingUnit())
    end
    function GetDecayingUnit()
      return UnitDB.get(__replaced_functions.GetDecayingUnit())
    end
    function GetConstructingStructure()
      return UnitDB.get(__replaced_functions.GetConstructingStructure())
    end
    function GetCancelledStructure()
      return UnitDB.get(__replaced_functions.GetCancelledStructure())
    end
    function GetConstructedStructure()
      return UnitDB.get(__replaced_functions.GetConstructedStructure())
    end
    function GetResearchingUnit()
      return UnitDB.get(__replaced_functions.GetResearchingUnit())
    end
    function GetTrainedUnit()
      return UnitDB.get(__replaced_functions.GetTrainedUnit())
    end
    function GetDetectedUnit()
      return UnitDB.get(__replaced_functions.GetDetectedUnit())
    end
    function GetSummoningUnit()
      return UnitDB.get(__replaced_functions.GetSummoningUnit())
    end
    function GetSummonedUnit()
      return UnitDB.get(__replaced_functions.GetSummonedUnit())
    end
    function GetTransportUnit()
      return UnitDB.get(__replaced_functions.GetTransportUnit())
    end
    function GetLoadedUnit()
      return UnitDB.get(__replaced_functions.GetLoadedUnit())
    end
    function GetSellingUnit()
      return UnitDB.get(__replaced_functions.GetSellingUnit())
    end
    function GetSoldUnit()
      return UnitDB.get(__replaced_functions.GetSoldUnit())
    end
    function GetBuyingUnit()
      return UnitDB.get(__replaced_functions.GetBuyingUnit())
    end
    function GetChangingUnit()
      return UnitDB.get(__replaced_functions.GetChangingUnit())
    end
    function GetManipulatingUnit()
      return UnitDB.get(__replaced_functions.GetManipulatingUnit())
    end
    function GetOrderedUnit()
      return UnitDB.get(__replaced_functions.GetOrderedUnit())
    end
    function GetOrderTargetUnit()
      return UnitDB.get(__replaced_functions.GetOrderTargetUnit())
    end
    function GetSpellAbilityUnit()
      return UnitDB.get(__replaced_functions.GetSpellAbilityUnit())
    end
    function GetSpellTargetUnit()
      return UnitDB.get(__replaced_functions.GetSpellTargetUnit())
    end
    function GetTriggerUnit()
      return UnitDB.get(__replaced_functions.GetTriggerUnit())
    end
    function GetEventDamage()
      return UnitDB.get(__replaced_functions.GetEventDamage())
    end
    function GetEventDamageSource()
      return UnitDB.get(__replaced_functions.GetEventDamageSource())
    end
    function GetEventTargetUnit()
      return UnitDB.get(__replaced_functions.GetEventTargetUnit())
    end
    Debug("Unit class initialized")
    return Unit
end
__require_data.module["player.playerDB"] = function()
    local PlayerDB = {}
    function PlayerDB.add(player_obj, player)
      PlayerDB[player_obj] = player
    end
    function PlayerDB.rm(player_obj)
      PlayerDB[player_obj] = nil
    end
    function PlayerDB.get(player_obj)
      return PlayerDB[player_obj]
    end
    return PlayerDB
end
__require_data.module["player.player"] = function()
    local PlayerDB = require("player.playerDB")
    local PlayerIndexDB = {}
    __replaced_class = {Player = Player}
    Player = {}
    local Player_meta = {__index = Player}
    setmetatable(Player, Player_meta)
    function Player_meta.__call(_, index)
      if (type(index) ~= "number") then
        return nil
      end
      return PlayerIndexDB[math.floor(index)]
    end
    function Player_meta.__tostring(self)
      return string.format("Player_%d", self:getIndex())
    end
    local function newPlayer(index)
      local player = {index = index, player_obj = __replaced_class.Player(index)}
      setmetatable(player, Player_meta)
      PlayerDB.add(player.player_obj, player)
      PlayerIndexDB[index] = player
      return player
    end
    local local_player = nil
    function Player.init()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        newPlayer(i)
      end
      local_player = PlayerDB.get(GetLocalPlayer())
    end
    function Player.getLocal()
      return local_player
    end
    function Player:get()
      return self.player_obj
    end
    function Player:getIndex()
      return self.index
    end
    function Player:forceUIKey(key)
      if (self == local_player) then
        key = string.upper(key)
        ForceUIKey(key)
      end
    end
    local __replaced_functions = {GetOwningPlayer = GetOwningPlayer}
    function GetOwningPlayer(unit)
      local player_obj = __replaced_functions.GetOwningPlayer(unit.unit_obj)
      return PlayerDB.get(player_obj)
    end
    return Player
end
__require_data.module["utils.init"] = function()
    local Init = {}
    function Init.start()
      for name, _ in pairs(__require_data.module) do
        if (not __require_data.loaded[name]) then
          __require_data.result[name] = __require_data.module[name]()
          __require_data.loaded[name] = true
        end
        if (__require_data.result[name].init ~= nil) then
          Debug(name, "init...")
          __require_data.result[name].init()
        end
      end
      Debug("Initialisation finished")
    end
    return Init
end
__require_data.module["utils.settings"] = function()
    local Settings = {debug = true}
    return Settings
end
__require_data.module["utils.utils"] = function()
    local Settings = require("utils.settings")
    local Utils = {}
    function getErrorPos()
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
          if (t == "nil") then
            v = "nil"
          elseif (t == "userdata") then
            v = "userdata"
          elseif (t == "string") then
            v = v
          elseif (t == "integer" or t == "number" or t == "table" or t == "function") then
            v = tostring(v)
          else
            v = ""
          end



          s = s.." "..v
        end
        for i = 0, 23 do
          DisplayTimedTextToPlayer(Player(i), 0, 0, 30, s)
        end
      end
    end
    function Debug(...)
      if (is_compiletime) then
        __real_print(...)
      elseif (Settings.debug) then
        local s = ""
        for i = 1, select("#", ...) do
          local v = select(i, ...)
          local t = type(v)
          if (t == "nil") then
            v = "nil"
          elseif (t == "userdata") then
            v = "userdata"
          elseif (t == "string") then
            v = v
          elseif (t == "integer" or t == "number") then
            v = tostring(v)
          elseif (t == "table") then
            v = tostring(v)
          else
            v = ""
          end




          s = s.." "..v
        end
        DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, "[Debug]: "..s)
      end

    end
    function ID(id)
      if (type(id) == "string") then
        return string.unpack(">I4", id)
      elseif (type(id) == "number" and math.fmod(id, 1) == 0) then
        return id
      end

      print("Wrong id fromat")
      print(getErrorPos())
      return nil
    end
    function ID2str(id)
      return string.pack(">I4", id)
    end
    function player2index(player)
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        if (Player(i) == player) then
          return i
        end
      end
      return -1
    end
    function to_range(val, min, max)
      if (val < min) then
        return min
      end
      if (val > max) then
        return max
      end
      return val
    end
    return Utils
end
  
  GG_trg_Melee_Initialization = nil
  function InitGlobals()

  end
  function Trig_Melee_Initialization_Actions()

  end
  function InitTrig_Melee_Initialization()
    GG_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(GG_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
  end
  function InitCustomTriggers()
    InitTrig_Melee_Initialization()
  end
  function RunInitialization()
    DestroyTimer(GetExpiredTimer())
    local Init = require("utils.init")
    local Utils = require("utils.utils")
    Init.start()
    local Player = require("player.player")
    local Unit = require("unit.unit")
    Debug(Player(0))
    local u = Unit.new(Player(0), "hfoo", 0, 0, 0)
    Debug(u)
    u:addAbility(summon_abil)
    u:addAbility(rush_abil)
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
    TimerStart(CreateTimer(), 0.1, false, RunInitialization)
  end
  function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, 0, 0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
  end