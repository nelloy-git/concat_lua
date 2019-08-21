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
__require_data.module["unitParameter.mathFunc"] = function()
    local Settings = require("utils.Settings")
    local UnitMathParameter = {}
    local half_cap = Settings.UnitParameters.value_to_get_half_cap_for_percent_value
    function UnitMathParameter.linear(base, mult, bonus)
      return ((base*mult)+bonus)
    end
    function UnitMathParameter.inverseLinear(base, mult, bonus)
      return ((base/mult)-bonus)
    end
    function UnitMathParameter.percent(base, mult, bonus, param_cap)
      local val = ((base*mult)+bonus)
      local k = (val/(val+half_cap))
      return (k*param_cap)
    end
    function UnitMathParameter.inversePercent(base, mult, bonus, param_cap)
      local val = ((base*mult)+bonus)
      local k = (val/(val+half_cap))
      return (100-(k*(100-param_cap)))
    end
    return UnitMathParameter
end
__require_data.module["unitParameter.applyFunc"] = function()
    local Settings = require("utils.Settings")
    local UnitApplyParameter = {}
    local attack_dispertion = Settings.UnitParameters.attack_dispersion
    local crit_and_dodge_id = "AM#$"
    local resist_id = "AM#%"
    local book_id = nil
    function UnitApplyParameter.attack(wc3_unit, val)
      local k = (1-attack_dispertion)
      local dmg = (k*val)
      local dice_sides = ((2*attack_dispertion)*val)
      BlzSetUnitBaseDamage(wc3_unit, math.floor(dmg), 0)
      BlzSetUnitDiceNumber(wc3_unit, 1, 0)
      BlzSetUnitDiceSides(wc3_unit, math.floor((dice_sides+1)), 0)
    end
    function UnitApplyParameter.attackSpeed(wc3_unit, val)
      BlzSetUnitAttackCooldown(wc3_unit, val, 0)
      BlzSetUnitAttackCooldown(wc3_unit, val, 1)
    end
    function UnitApplyParameter.armor(wc3_unit, val)
      BlzSetUnitArmor(wc3_unit, math.floor(val))
    end
    function UnitApplyParameter.spellPower(wc3_unit, val)

    end
    function UnitApplyParameter.castSpeed(wc3_unit, val)

    end
    function UnitApplyParameter.resistance(wc3_unit, val)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
      end
      local units_ability = BlzGetUnitAbility(wc3_unit, resist_id)
      BlzSetAbilityRealLevelField(units_ability, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 1, val)
    end
    function UnitApplyParameter.cooldown(wc3_unit, val)

    end
    function UnitApplyParameter.health(wc3_unit, val)
      BlzSetUnitMaxHP(wc3_unit, math.floor(val))
    end
    function UnitApplyParameter.regeneration(wc3_unit, val)
      BlzSetUnitRealField(wc3_unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, val)
    end
    function UnitApplyParameter.mana(wc3_unit, val)
      BlzSetUnitMaxMana(wc3_unit, math.floor(val))
    end
    function UnitApplyParameter.recovery(wc3_unit, val)
      BlzSetUnitRealField(wc3_unit, UNIT_RF_MANA_REGENERATION, val)
    end
    function UnitApplyParameter.critChance(wc3_unit, val)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
      end
      local units_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(units_ability, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 1, val)
    end
    function UnitApplyParameter.critPower(wc3_unit, val)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
      end
      local units_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(units_ability, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 1, val)
    end
    function UnitApplyParameter.dodgeChance(wc3_unit, val)
      val = (val/100)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
      end
      local units_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(units_ability, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 1, val)
    end
    function UnitApplyParameter.strength(wc3_unit, val)
      SetHeroStr(wc3_unit, math.floor(val), true)
    end
    function UnitApplyParameter.agility(wc3_unit, val)
      SetHeroAgi(wc3_unit, math.floor(val), true)
    end
    function UnitApplyParameter.strength(wc3_unit, val)
      SetHeroInt(wc3_unit, math.floor(val), true)
    end
    return UnitApplyParameter
end
__require_data.module["unitParameter.UnitParameterContainerDB"] = function()
    local UnitParameterContainerDB = {}
    function UnitParameterContainerDB.add(wc3_unit, container)
      UnitParameterContainerDB[wc3_unit] = container
    end
    function UnitParameterContainerDB.rm(wc3_unit)
      UnitParameterContainerDB[wc3_unit] = nil
    end
    function UnitParameterContainerDB.get(wc3_unit)
      return UnitParameterContainerDB[wc3_unit]
    end
    return UnitParameterContainerDB
end
__require_data.module["unitParameter.UnitParameter"] = function()
    local UnitParameter = {}
    local UnitParameter_meta = {__index = UnitParameter}
    function UnitParameter.new(wc3_unit, base, apply_param_func, math_func, max_val)
      local parameter = {__wc3_unit = wc3_unit, __base = base, __bonus = 0, __mult = 1, __cap = max_val, __apply_param_func = apply_param_func, __math_func = math_func}
      setmetatable(parameter, UnitParameter_meta)
      parameter:update()
      return parameter
    end
    function UnitParameter:set(base, mult, bonus)
      self.__base = base
      self.__mult = mult
      self.__bonus = bonus
      self:update()
    end
    function UnitParameter:addAll(base, mult, bonus)
      self.__base = (self.__base+base)
      self.__mult = (self.__mult+mult)
      self.__bonus = (self.__bonus+bonus)
      self:update()
    end
    function UnitParameter:addBase(val)
      self.__base = (self.__base+val)
      self:update()
    end
    function UnitParameter:addBonus(val)
      self.__bonus = (self.__bonus+val)
      self:update()
    end
    function UnitParameter:addMult(val)
      self.__mult = (self.__mult+val)
      self:update()
    end
    function UnitParameter:getAll()
      return self.__base, self.__mult, self.__bonus, self.__math_func(self.__base, self.__mult, self.__bonus, self.__cap)
    end
    function UnitParameter:getBase()
      return self.__base
    end
    function UnitParameter:getBonus()
      return self.__bonus
    end
    function UnitParameter:getMult()
      return self.__mult
    end
    function UnitParameter:getResult()
      return self.__res
    end
    function UnitParameter:update()
      self.__res = self.__math_func(self.__base, self.__mult, self.__bonus, self.__cap)
      self.__apply_param_func(self.__wc3_unit, self.__res)
    end
    return UnitParameter
end
__require_data.module["unitParameter.UnitParameterContainer"] = function()
    local UnitParameter = require("unitParameter.UnitParameter")
    local UnitParameterContainerDB = require("unitParameter.UnitParameterContainerDB")
    local ApplyParam = require("unitParameter.applyFunc")
    local MathParam = require("unitParameter.mathFunc")
    local ParameterContainer = {}
    local ParameterContainer_meta = {__index = ParameterContainer}
    function ParameterContainer.new(wc3_unit)
      local container = {}
      setmetatable(container, ParameterContainer_meta)
      UnitParameterContainerDB.add(wc3_unit)
      container.__attack = UnitParameter.new(wc3_unit, 1, ApplyParam.attack, MathParam.linear)
      container.__attackSpeed = UnitParameter.new(wc3_unit, 2, ApplyParam.attackSpeed, MathParam.inverseLinear)
      container.__armor = UnitParameter.new(wc3_unit, 0, ApplyParam.armor, MathParam.linear)
      container.__spellPower = UnitParameter.new(wc3_unit, 0, ApplyParam.spellPower, MathParam.linear)
      container.__castSpeed = UnitParameter.new(wc3_unit, 0, ApplyParam.castSpeed, MathParam.inversePercent, 25)
      container.__resistance = UnitParameter.new(wc3_unit, 0, ApplyParam.resistance, MathParam.percent, 90)
      container.__health = UnitParameter.new(wc3_unit, 100, ApplyParam.health, MathParam.linear)
      container.__regeneration = UnitParameter.new(wc3_unit, 0, ApplyParam.regeneration, MathParam.linear)
      container.__mana = UnitParameter.new(wc3_unit, 100, ApplyParam.mana, MathParam.linear)
      container.__recovery = UnitParameter.new(wc3_unit, 0, ApplyParam.recovery, MathParam.linear)
      container.__critChance = UnitParameter.new(wc3_unit, 0, ApplyParam.critChance, MathParam.percent, 100)
      container.__critPower = UnitParameter.new(wc3_unit, 1, ApplyParam.critPower, MathParam.linear)
      container.__dodge = UnitParameter.new(wc3_unit, 0, ApplyParam.dodgeChance, MathParam.percent, 75)
      container.__cooldown = UnitParameter.new(wc3_unit, 0, ApplyParam.cooldown, MathParam.percent, 75)
      local string_id = ID2str(wc3_unit)
      local first = string_id:sub(1, 1)
      if (first == string.upper(first)) then
        container.strength = UnitParameter.new(wc3_unit, 1, ApplyParam.strength, MathParam.linear)
        container.agility = UnitParameter.new(wc3_unit, 1, ApplyParam.agility, MathParam.linear)
        container.intelligence = UnitParameter.new(wc3_unit, 1, ApplyParam.intelligence, MathParam.linear)
      end
      return container
    end
    function ParameterContainer.get(wc3_unit)
      return UnitParameterContainerDB.get(wc3_unit)
    end
    function ParameterContainer:addAttack(base, mult, bonus)
      self.__attack:add(base, mult, bonus)
    end
    function ParameterContainer:getAttack()
      return self.__attack:get()
    end
    function ParameterContainer:setAttacksPerSec(base)
      _, mult, bonus, _ = self.__attackSpeed:get()
      self.__attackSpeed:set(base, mult, bonus)
    end
    function ParameterContainer:addAttackSpeed(mult)
      self.__attackSpeed:add(0, mult, 0)
    end
    function ParameterContainer:getAttackSpeed()
      base, mult, _, res = self.__attackSpeed:get()
      return base, mult, res
    end
    function ParameterContainer:addArmor(base, mult, bonus)
      self.__armor:add(base, mult, bonus)
    end
    function ParameterContainer:getArmor()
      return self.__armor:get()
    end
    function ParameterContainer:addSpellPower(base, mult, bonus)
      self.__spellPower:add(base, mult, bonus)
    end
    function ParameterContainer:getSpellPower()
      return self.__spellPower:get()
    end
    function ParameterContainer:addCastSpeed(base, mult, bonus)
      self.__castSpeed:add(base, mult, bonus)
    end
    function ParameterContainer:getCastSpeed()
      return self.__castSpeed:get()
    end
    function ParameterContainer:addResistance(base, mult, bonus)
      self.__resistance:add(base, mult, bonus)
    end
    function ParameterContainer:getResistance()
      return self.__resistance:get()
    end
    function ParameterContainer:addHealth(base, mult, bonus)
      self.__health:add(base, mult, bonus)
    end
    function ParameterContainer:getHealth()
      return self.__health:get()
    end
    function ParameterContainer:addRegeneration(base, mult, bonus)
      self.__regeneration:add(base, mult, bonus)
    end
    function ParameterContainer:getRegeneration()
      return self.__regeneration:get()
    end
    function ParameterContainer:addMana(base, mult, bonus)
      self.__mana:add(base, mult, bonus)
    end
    function ParameterContainer:getMana()
      return self.__mana:get()
    end
    function ParameterContainer:addRecovery(base, mult, bonus)
      self.__recovery:add(base, mult, bonus)
    end
    function ParameterContainer:getRecovery()
      return self.__recovery:get()
    end
    function ParameterContainer:addCritChance(base, mult, bonus)
      self.__critChance:add(base, mult, bonus)
    end
    function ParameterContainer:getCritChance()
      return self.__critChance:get()
    end
    function ParameterContainer:addCritPower(base, mult, bonus)
      self.__critPower:add(base, mult, bonus)
    end
    function ParameterContainer:getCritPower()
      return self.__critPower:get()
    end
    function ParameterContainer:addDodgeChance(base, mult, bonus)
      self.__dodge:add(base, mult, bonus)
    end
    function ParameterContainer:getDodgeChance()
      return self.__dodge:get()
    end
    function ParameterContainer:addCooldown(base, mult, bonus)
      self.__cooldown:add(base, mult, bonus)
    end
    function ParameterContainer:getCooldown()
      return self.__cooldown:get()
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
    local ParameterContainer = require("unitParameter.UnitParameterContainer")
    local UnitDB = require("unit.unitDB")
    local Unit = {}
    local Unit_meta = {__index = Unit, __gc = Unit.destroy}
    function Unit_meta.__tostring(self)
      return string.format("Unit %s (%s) at [%.2f, %.2f, %.2f]", self:getName(), ID2str(self:getId()), self:getX(), self:getY(), self:getZ())
    end
    function Unit.new(wc3_player, id, x, y, face, is_dead)
      id = ID(id)
      local wc3_unit = nil
      if (is_dead) then
        wc3_unit = CreateCorpse(wc3_player, id, x, y, face)
      else
        wc3_unit = CreateUnit(wc3_player, id, x, y, face)
      end
      local unit = {__id = id, __wc3_unit = wc3_unit}
      setmetatable(unit, Unit_meta)
      UnitDB.add(unit.__wc3_unit, unit)
      unit:initCustomData()
      return unit
    end
    function Unit:destroy()
      self:destroyCustomData()
      UnitDB.rm(self.__wc3_unit)
      RemoveUnit(self.__wc3_unit)
      self.__wc3_unit = nil
    end
    function Unit:getObj()
      return self.__wc3_unit
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
      return GetUnitName(self.__wc3_unit)
    end
    function Unit:setVertexColor(red, green, blue, alpha)
      red = math.floor((255*torange(red, 0, 1)))
      green = math.floor((255*torange(green, 0, 1)))
      blue = math.floor((255*torange(blue, 0, 1)))
      alpha = math.floor((255*torange(alpha, 0, 1)))
      SetUnitVertexColor(self.__wc3_unit, red, green, blue, alpha)
    end
    function Unit:getOwningPlayer()
      return GetOwningPlayer(self.__wc3_unit)
    end
    function Unit:setPos2(pos)
      self:setX(pos.x)
      self:setY(pos.y)
    end
    function Unit:setPos3(pos)
      self:setX(pos.x)
      self:setY(pos.y)
      self:setZ(pos.z)
    end
    function Unit:setX(x)
      SetUnitX(self.__wc3_unit, x)
    end
    function Unit:setY(y)
      SetUnitY(self.__wc3_unit, y)
    end
    function Unit:setZ(z)
      self:setFlyHeight((z-GetTerrainZ(self:getX(), self:getY())))
    end
    function Unit:getPos2()
      return Vec2.new(self:getX(), self:getY())
    end
    function Unit:getPos3()
      return Vec3.new(self:getX(), self:getY(), self:getZ())
    end
    function Unit:getX()
      return GetUnitX(self.__wc3_unit)
    end
    function Unit:getY()
      return GetUnitY(self.__wc3_unit)
    end
    function Unit:getZ()
      return (GetTerrainZ(self:getX(), self:getY())+self:getFlyHeight())
    end
    function Unit:getFlyHeight()
      return GetUnitFlyHeight(self.__wc3_unit)
    end
    function Unit:setFlyHeigth(height)
      return SetUnitFlyHeight(self.__wc3_unit, height)
    end
    function Unit:getDefaultsFlyHeight()
      return GetUnitDefaultFlyHeight(self.__wc3_unit)
    end
    function Unit:setFacing(angle, time)
      if (time == nil or time <= 0) then
        SetUnitFacing(self.__wc3_unit, angle)
      else
        SetUnitFacingTimed(self.__wc3_unit, angle, time)
      end
    end
    function Unit:setFacingTo(target, time)
      local x, y = self:getPos()
      local angle = (180+((180/math.pi)*math.atan((y-target.y), (x-target.x))))
      self:setFacing(angle, time)
    end
    function Unit:getFacing()
      return GetUnitFacing(self.__wc3_unit)
    end
    function Unit:getMoveSpeed()
      return GetUnitMoveSpeed(self.__wc3_unit)
    end
    function Unit:setMoveSpeed(speed)
      SetUnitMoveSpeed(self.__wc3_unit, speed)
    end
    function Unit:getTurnSpeed()
      return GetUnitTurnSpeed(self.__wc3_unit)
    end
    function Unit:setTurnSpeed(speed)
      SetUnitTurnSpeed(self.__wc3_unit, speed)
    end
    function Unit:getDefaultTurnSpeed()
      return GetUnitDefaultTurnSpeed(self.__wc3_unit)
    end
    function Unit:addAbility(ability_id)
      UnitAddAbility(self.__wc3_unit, ability_id)
    end
    function Unit:removeAbility(ability_id)
      UnitRemoveAbility(self.__wc3_unit, ability_id)
    end
    function Unit:getAbilityLevel(ability_id)
      return GetUnitAbilityLevel(self.__wc3_unit, ability_id)
    end
    function Unit:setAbilityLevel(ability_id)
      SetUnitAbilityLevel(self.__wc3_unit, ability_id)
    end
    function Unit:setInvulnerable(flag)
      SetUnitInvulnerable(self.__wc3_unit, flag)
    end
    function Unit:applyTimedLife(time)
      UnitApplyTimedLife(self.__wc3_unit, 0, time)
    end
    function Unit:issueImmediateOrderById(order_id)
      IssueImmediateOrderById(self.__wc3_unit, order_id)
    end
    function Unit:orderStop()
      self:issueImmediateOrderById(851972)
    end
    function Unit:issuePointOrderById(order_id, x, y)
      IssuePointOrderById(self.__wc3_unit, order_id, x, y)
    end
    function Unit:setMoveSpeed(speed)
      SetUnitMoveSpeed(self.__wc3_unit, speed)
    end
    function Unit:setTurnSpeed(speed)
      SetUnitTurnSpeed(self.__wc3_unit, speed)
    end
    function Unit:playAnimation(animation)
      SetUnitAnimation(self.__wc3_unit, animation)
    end
    function Unit:setAnimationSpeed(scale)
      SetUnitTimeScale(self.__wc3_unit, scale)
    end
    function Unit:pause()
      PauseUnit(self.__wc3_unit, true)
    end
    function Unit:unpause()
      PauseUnit(self.__wc3_unit, false)
    end
    local __replaced_functions = {GetLevelingUnit = GetLevelingUnit, GetLearningUnit = GetLearningUnit, GetRevivableUnit = GetRevivableUnit, GetRevivingUnit = GetRevivingUnit, GetAttacker = GetAttacker, GetRescuer = GetRescuer, GetDyingUnit = GetDyingUnit, GetKillingUnit = GetKillingUnit, GetDecayingUnit = GetDecayingUnit, GetConstructingStructure = GetConstructingStructure, GetCancelledStructure = GetCancelledStructure, GetConstructedStructure = GetConstructedStructure, GetResearchingUnit = GetResearchingUnit, GetTrainedUnit = GetTrainedUnit, GetDetectedUnit = GetDetectedUnit, GetSummoningUnit = GetSummoningUnit, GetSummonedUnit = GetSummonedUnit, GetTransportUnit = GetTransportUnit, GetLoadedUnit = GetLoadedUnit, GetSellingUnit = GetSellingUnit, GetSoldUnit = GetSoldUnit, GetBuyingUnit = GetBuyingUnit, GetChangingUnit = GetChangingUnit, GetManipulatingUnit = GetManipulatingUnit, GetOrderedUnit = GetOrderedUnit, GetOrderTargetUnit = GetOrderTargetUnit, GetSpellAbilityUnit = GetSpellAbilityUnit, GetSpellTargetUnit = GetSpellTargetUnit, GetTriggerUnit = GetTriggerUnit, GetEventDamage = GetEventDamage, GetEventDamageSource = GetEventDamageSource, GetEventTargetUnit = GetEventTargetUnit, CreateUnit = CreateUnit, CreateCorpse = CreateCorpse}
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
    return Unit
end
__require_data.module["utils.timer.TimerDB"] = function()
    local TimerDB = {}
    function TimerDB.add(timer_obj, timer)
      TimerDB[timer_obj] = timer
    end
    function TimerDB.rm(timer_obj)
      TimerDB[timer_obj] = nil
    end
    function TimerDB.get(timer_obj)
      return TimerDB[timer_obj]
    end
    return TimerDB
end
__require_data.module["utils.timer.TimerAction"] = function()
    local TimerAction = {}
    local TimerAction_meta = {__index = TimerAction}
    function TimerAction.new(time, callback, data)
      local action = {__time = time, __callback = callback, __data = data}
      setmetatable(action, TimerAction_meta)
      return action
    end
    function TimerAction:destroy()

    end
    function TimerAction:getTime()
      return self.__time
    end
    function TimerAction:run()
      self.__callback(self.__data)
    end
    return TimerAction
end
__require_data.module["utils.timer.Timer"] = function()
    local TimerAction = require("utils.timer.TimerAction")
    local TimerDB = require("utils.timer.TimerDB")
    local Timer = {}
    local Timer_meta = {__index = Timer, __gc = Timer.destroy}
    function Timer.new(period)
      local timer = {__timer_obj = CreateTimer(), __cur_time = 0.0, __period = period, __actions = {}}
      setmetatable(timer, Timer_meta)
      TimerDB.add(timer.__timer_obj, timer)
      TimerStart(timer.__timer_obj, timer.__period, true, Timer.timeout)
      return timer
    end
    function Timer:destroy()
      while(#self.__actions > 0) do
        local action = table.remove(self.__actions, 1)
        action:destroy()
      end
      TimerDB.rm(self.__timer_obj)
      DestroyTimer(self.__timer_obj)
    end
    function Timer:getPeriod()
      return self.__period
    end
    function Timer.timeout()
      local self = TimerDB.get(GetExpiredTimer())
      local cur_time = (self.__cur_time+self.__period)
      while(#self.__actions > 0) do
        local action = table.remove(self.__actions, 1)
        if (action:getTime() <= cur_time) then
          action:run()
        else
          table.insert(self.__actions, 1, action)
          break
        end
      end
      self.__cur_time = cur_time
    end
    function Timer:findPos(time, first, len)
      if (len == 0) then
        return first
      end
      local half_len, d = math.modf((len/2))
      local pos = (first+half_len)
      if (self.__actions[pos]:getTime() > time) then
        return self:findPos(time, first, half_len)
      else
        return self:findPos(time, ((first+half_len)+(2*d)), half_len)
      end
    end
    function Timer:findPosSimple(time)
      local count = #self.__actions
      if (count == 0) then
        return 1
      end
      for i = 1, count do
        if (self.__actions[i]:getTime() > time) then
          return i
        end
      end
      return (count+1)
    end
    function Timer:addAction(delay, callback, data)
      if (delay <= 0) then
        delay = 0.01
      end
      local time = (self.__cur_time+delay)
      local action = TimerAction.new(time, callback, data)
      local pos = 1
      pos = self:findPos(time, 1, #self.__actions)
      table.insert(self.__actions, pos, action)
      return action
    end
    function Timer:removeAction(action)
      local count = #self.__actions
      for i = 1, count do
        if (self.__actions[i] == action) then
          table.remove(self.__actions, i)
          return true
        end
      end
      return false
    end
    local count = 10
    local test_result = {}
    local test_timer = nil
    local function test(num)
      table.insert(test_result, (#test_result+1), num)
    end
    local function check_test()
      DestroyTimer(GetExpiredTimer())
      for i = 1, count do
        if (test_result[i] ~= (i//2)) then
          Debug("Timer test failed")
          return nil
        end
      end
      test_timer:destroy()
      Debug("Timer test passed.")
    end
    function Timer.test()
      test_timer = Timer.new(0.03125)
      local t = 0.05
      for i = 1, count do
        test_timer:addAction((i*t), test, i)
        test_timer:addAction(((count-i)*t), test, (count-i))
      end
      local timer = CreateTimer()
      TimerStart(timer, ((1.1*t)*count), false, check_test)
    end
    return Timer
end
__require_data.module["utils.math.Vec3"] = function()
    local Vec3 = {}
    local Vec3_meta = {__index = Vec3}
    function Vec3_meta.__tostring(self)
      return string.format("[%.2f, %.2f, %.2f]", self.x, self.y, self.z)
    end
    local loc = nil
    function Vec3.init()
      loc = Location(0, 0)
    end
    function GetTerrainZ(x, y)
      MoveLocation(loc, x, y)
      return GetLocationZ(loc)
    end
    function Vec3.new(x, y, z)
      local v = {x = x, y = y, z = z}
      setmetatable(v, Vec3_meta)
      return v
    end
    return Vec3
end
__require_data.module["utils.math.Vec2"] = function()
    local Vec2 = {}
    local Vec2_meta = {__index = Vec2}
    function Vec2_meta.__tostring(self)
      return string.format("[%.2f, %.2f]", self.x, self.y)
    end
    function Vec2.new(x, y)
      local v = {x = x, y = y}
      setmetatable(v, Vec2_meta)
      return v
    end
    return Vec2
end
__require_data.module["utils.Settings"] = function()
    local Settings = {debug = true, Timer = {glTimer_period = 0.03125, run_test = true}, UnitParameters = {attack_dispersion = 0.15, value_to_get_half_cap_for_percent_value = 500}}
    return Settings
end
__require_data.module["utils.Globals"] = function()
    local Settings = require("utils.Settings")
    local Globals = {}
    local initialized = false
    function Globals.init()
      if (initialized) then
        return nil
      end
      Vec2 = require("utils.math.Vec2")
      Vec3 = require("utils.math.Vec3")
      local Timer = require("utils.timer.Timer")
      glTimer = Timer.new(Settings.Timer.glTimer_period)
      initialized = true
    end
    local compiletime_print = print
    function Debug(...)
      if (is_compiletime) then
        compiletime_print(...)
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
          elseif (t == "table" or t == "function") then
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
      return nil
    end
    function ID2str(id)
      if (type(id) == "number" or type(id) == "integer") then
        return string.pack(">I4", id)
      end
      return id
    end
    function torange(val, min, max)
      if (val < min) then
        return min
      end
      if (val > max) then
        return max
      end
      return val
    end
    return Globals
end
__require_data.module["utils.Init"] = function()
    local Init = {}
    local Globals = require("utils.Globals")
    if (not is_compiletime) then
      Globals.init()
    end
    function Init.start()
      for name, _ in pairs(__require_data.module) do
        if (not __require_data.loaded[name]) then
          local success, result = pcall(__require_data.module[name])
          if (success) then
            __require_data.result[name] = result
            __require_data.loaded[name] = true
          else
            Debug(string.format("Error in loading %s\n%s", name, result))
          end
        end
        if (__require_data.result[name] ~= nil) then
          if (__require_data.result[name].init ~= nil) then
            local success, result = pcall(__require_data.result[name].init)
            if (not success) then
              Debug(string.format("Error in %s initialization\n%s", name, result))
            end
          end
        end
      end
      Debug("Initialisation finished")
      local Settings = require("utils.Settings")
      if (Settings.Timer.run_test) then
        local Timer = require("utils.timer.Timer")
        Debug("Timer test.")
        Timer.test()
      end
    end
    return Init
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
    local Init = require("utils.Init")
    Init.start()
    local Unit = require("unit.unit")
    local u = Unit.new(Player(0), "hfoo", 0, 0, 0)
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