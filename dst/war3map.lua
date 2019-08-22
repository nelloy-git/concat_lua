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
    local crit_and_dodge_id = 1095574308
    local resist_id = 1095574309
    local book_id = 1095574310
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
        BlzUnitHideAbility(wc3_unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(wc3_unit, resist_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 1, val)
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
        BlzUnitHideAbility(wc3_unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 1, val)
    end
    function UnitApplyParameter.critPower(wc3_unit, val)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 1, val)
    end
    function UnitApplyParameter.dodgeChance(wc3_unit, val)
      val = (val/100)
      if (GetUnitAbilityLevel(wc3_unit, book_id) <= 0) then
        UnitAddAbility(wc3_unit, book_id)
        BlzUnitHideAbility(wc3_unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(wc3_unit, crit_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 1, val)
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
      self.parameter = ParameterContainer.new(self.__wc3_unit)
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
    function Unit.GetLevelingUnit()
      return UnitDB.get(GetLevelingUnit())
    end
    function Unit.GetLearningUnit()
      return UnitDB.get(GetLearningUnit())
    end
    function Unit.GetRevivableUnit()
      return UnitDB.get(GetRevivableUnit())
    end
    function Unit.GetRevivingUnit()
      return UnitDB.get(GetRevivingUnit())
    end
    function Unit.GetAttacker()
      return UnitDB.get(GetAttacker())
    end
    function Unit.GetRescuer()
      return UnitDB.get(GetRescuer())
    end
    function Unit.GetDyingUnit()
      return UnitDB.get(GetDyingUnit())
    end
    function Unit.GetKillingUnit()
      return UnitDB.get(GetKillingUnit())
    end
    function Unit.GetDecayingUnit()
      return UnitDB.get(GetDecayingUnit())
    end
    function Unit.GetConstructingStructure()
      return UnitDB.get(GetConstructingStructure())
    end
    function Unit.GetCancelledStructure()
      return UnitDB.get(GetCancelledStructure())
    end
    function Unit.GetConstructedStructure()
      return UnitDB.get(GetConstructedStructure())
    end
    function Unit.GetResearchingUnit()
      return UnitDB.get(GetResearchingUnit())
    end
    function Unit.GetTrainedUnit()
      return UnitDB.get(GetTrainedUnit())
    end
    function Unit.GetDetectedUnit()
      return UnitDB.get(GetDetectedUnit())
    end
    function Unit.GetSummoningUnit()
      return UnitDB.get(GetSummoningUnit())
    end
    function Unit.GetSummonedUnit()
      return UnitDB.get(GetSummonedUnit())
    end
    function Unit.GetTransportUnit()
      return UnitDB.get(GetTransportUnit())
    end
    function Unit.GetLoadedUnit()
      return UnitDB.get(GetLoadedUnit())
    end
    function Unit.GetSellingUnit()
      return UnitDB.get(GetSellingUnit())
    end
    function Unit.GetSoldUnit()
      return UnitDB.get(GetSoldUnit())
    end
    function Unit.GetBuyingUnit()
      return UnitDB.get(GetBuyingUnit())
    end
    function Unit.GetChangingUnit()
      return UnitDB.get(GetChangingUnit())
    end
    function Unit.GetManipulatingUnit()
      return UnitDB.get(GetManipulatingUnit())
    end
    function Unit.GetOrderedUnit()
      return UnitDB.get(GetOrderedUnit())
    end
    function Unit.GetOrderTargetUnit()
      return UnitDB.get(GetOrderTargetUnit())
    end
    function Unit.GetSpellAbilityUnit()
      return UnitDB.get(GetSpellAbilityUnit())
    end
    function Unit.GetSpellTargetUnit()
      return UnitDB.get(GetSpellTargetUnit())
    end
    function Unit.GetTriggerUnit()
      return UnitDB.get(GetTriggerUnit())
    end
    function Unit.GetEventDamage()
      return UnitDB.get(GetEventDamage())
    end
    function Unit.GetEventDamageSource()
      return UnitDB.get(GetEventDamageSource())
    end
    function Unit.GetEventTargetUnit()
      return UnitDB.get(GetEventTargetUnit())
    end
    return Unit
end
__require_data.module["ability.casterDB"] = function()
    local CasterDB = {}
    function CasterDB.add(caster, data)
      CasterDB[caster] = data
    end
    function CasterDB.rm(caster)
      CasterDB[caster] = nil
    end
    function CasterDB.get(caster)
      return CasterDB[caster]
    end
    return CasterDB
end
__require_data.module["ability.spellInstance"] = function()
    local SpellInstance = {}
    local SpellInstance_meta = {__index = SpellInstance}
    function SpellInstance.new(ability, caster, target, x, y, full_time)
      local data = {_ability = ability, _caster = caster, _target = target, _x = x, _y = y, _time = 0, _full_time = full_time}
      setmetatable(data, SpellInstance_meta)
      return data
    end
    function SpellInstance:getAll()
      return self._ability, self._caster, self._target, self._x, self._y, self._time, self._full_time
    end
    function SpellInstance:addTime(delta)
      self._time = (self._time+delta)
    end
    function SpellInstance:getTime()
      return self._time
    end
    function SpellInstance:getFullTime()
      return self._full_time
    end
    function SpellInstance:getAbility()
      return self._ability
    end
    function SpellInstance:getCaster()
      return self._caster
    end
    function SpellInstance:getTarget()
      return self._target
    end
    function SpellInstance:getX()
      return self._x
    end
    function SpellInstance:getY()
      return self._y
    end
    return SpellInstance
end
__require_data.module["ability.AbilityDB"] = function()
    local AbilityDB = {}
    function AbilityDB.add(ability_id, ability)
      AbilityDB[ability_id] = ability
    end
    function AbilityDB.rm(ability_id)
      AbilityDB[ability_id] = nil
    end
    function AbilityDB.get(ability_id)
      return AbilityDB[ability_id]
    end
    return AbilityDB
end
__require_data.module["ability.AbilityEvent"] = function()
    local AbilityDB = require("ability.AbilityDB")
    local UnitEvent = require("trigger.events.unitEvent")
    local SpellInstance = require("ability.spellInstance")
    local CasterDB = require("ability.casterDB")
    local AbilityEvent = {}
    function AbilityEvent.init()
      UnitEvent.getTrigger("AnyUnitStartChannelAbility"):addAction(AbilityEvent.startCast, nil)
    end
    function AbilityEvent.getSpellTarget()
      local target = GetSpellTargetUnit()
      if (target == nil) then
        target = GetSpellTargetItem()
      end
      if (target == nil) then
        target = GetSpellTargetDestructable()
      end
      return target
    end
    function AbilityEvent.startCast()
      Debug("Cast start")
      local ability = AbilityDB.get(GetSpellAbilityId())
      if (ability == nil) then
        return nil
      end
      local target = AbilityEvent.getSpellTarget()
      local caster = GetSpellAbilityUnit()
      local x = GetSpellTargetX()
      local y = GetSpellTargetY()
      local continue = ability:runCallback("start", caster, target, x, y)
      if (not continue) then
        caster:orderStop()
        return nil
      end
      local data = SpellInstance.new(ability, caster, target, x, y, ability:getCastingTime(caster))
      glTimer.addAction(0, AbilityEvent.timerPeriod, data)
      CasterDB.add(caster, data)
      Debug("Cast start")
    end
    function AbilityEvent.timerPeriod(spell_data)
      local ability, caster, target, x, y, cur_time, full_time = spell_data:getAll()
      local caster_data = CasterDB.get(caster)
      Debug(spell_data, caster_data)
      if (caster_data ~= spell_data) then
        ability:runCallback("interrupt", caster, target, x, y, cur_time, full_time)
        CasterDB.rm(caster)
        return nil
      end
      local delta = glTimer.getPrecision()
      cur_time = (cur_time+delta)
      if (cur_time >= full_time) then
        ability:runCallback("finish", caster, target, x, y, full_time)
        CasterDB.rm(caster)
        return nil
      end
      local continue = ability:runCallback("casting", caster, target, x, y, cur_time, full_time)
      if (continue) then
        spell_data:addTime(delta)
        caster_data:addTime(delta)
        glTimer.addAction(0, AbilityEvent.timerPeriod, spell_data)
      else
        ability:runCallback("interrupt", caster, target, x, y, cur_time, full_time)
        CasterDB.rm(caster)
      end
    end
    function AbilityEvent.getUnitCastingData(caster)
      local data = CasterDB[caster]
      if (data == nil) then
        return nil, -1, -1
      end
      return data.ability, data.time, data.full_time
    end
    return AbilityEvent
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
__require_data.module["trigger.event"] = function()
    local Event = {Game = {}, Player = {}, PlayerUnit = {}, AnyUnit = {}, Unit = {}}
    Event.Game.Victory = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VICTORY)
    end
    Event.Game.End = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_END_LEVEL)
    end
    Event.Game.VariableLimit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VARIABLE_LIMIT)
    end
    Event.Game.StateLimit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_STATE_LIMIT)
    end
    Event.Game.TimerExpired = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TIMER_EXPIRED)
    end
    Event.Game.EnterRegion = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_ENTER_REGION)
    end
    Event.Game.LeaveRegion = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LEAVE_REGION)
    end
    Event.Game.TrackableHit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_HIT)
    end
    Event.Game.TrackableTrack = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_TRACK)
    end
    Event.Game.ShowSkill = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SHOW_SKILL)
    end
    Event.Game.BuildSubmenu = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_BUILD_SUBMENU)
    end
    Event.Game.Loaded = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LOADED)
    end
    Event.Game.TournamentFinishSoon = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_SOON)
    end
    Event.Game.TournamentFinishNow = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_NOW)
    end
    Event.Game.Save = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SAVE)
    end
    Event.Game.CustomUIFrame = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_CUSTOM_UI_FRAME)
    end
    Event.Player.StateLimit = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_STATE_LIMIT)
    end
    Event.Player.AllianceChanged = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ALLIANCE_CHANGED)
    end
    Event.Player.Defeat = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_DEFEAT)
    end
    Event.Player.Victory = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_VICTORY)
    end
    Event.Player.Leave = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_LEAVE)
    end
    Event.Player.Chat = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_CHAT)
    end
    Event.Player.EndCinematic = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_END_CINEMATIC)
    end
    Event.Player.ArrowLeft_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_DOWN)
    end
    Event.Player.ArrowLeft_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_UP)
    end
    Event.Player.ArrowRight_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_DOWN)
    end
    Event.Player.ArrowRight_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_UP)
    end
    Event.Player.ArrowDown_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_DOWN)
    end
    Event.Player.ArrowDown_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_UP)
    end
    Event.Player.ArrowUp_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_DOWN)
    end
    Event.Player.ArrowUp_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_UP)
    end
    Event.Player.MouseDown = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_DOWN)
    end
    Event.Player.MouseUp = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_UP)
    end
    Event.Player.MouseMove = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_MOVE)
    end
    Event.Player.SyncData = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_SYNC_DATA)
    end
    Event.Player.Key = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY)
    end
    Event.Player.KeyDown = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_DOWN)
    end
    Event.Player.KeyUp = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_UP)
    end
    Event.PlayerUnit.Attacked = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ATTACKED)
    end
    Event.PlayerUnit.Resqued = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESCUED)
    end
    Event.PlayerUnit.Death = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DEATH)
    end
    Event.PlayerUnit.Decay = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DECAY)
    end
    Event.PlayerUnit.Death = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DETECTED)
    end
    Event.PlayerUnit.Hidden = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_HIDDEN)
    end
    Event.PlayerUnit.Selected = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELECTED)
    end
    Event.PlayerUnit.Deselected = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DESELECTED)
    end
    Event.PlayerUnit.ConstructStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    end
    Event.PlayerUnit.ConstructCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    end
    Event.PlayerUnit.ConstructFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    end
    Event.PlayerUnit.UpgradeStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_START)
    end
    Event.PlayerUnit.Cancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    end
    Event.PlayerUnit.Finish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    end
    Event.PlayerUnit.TrainStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_START)
    end
    Event.PlayerUnit.TrainCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    end
    Event.PlayerUnit.TrainFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    end
    Event.PlayerUnit.ResearchStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_START)
    end
    Event.PlayerUnit.ResearchCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    end
    Event.PlayerUnit.ResearchFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    end
    Event.PlayerUnit.IssuedOrder = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    end
    Event.PlayerUnit.IssuedOrderPointTartet = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    end
    Event.PlayerUnit.IssuedOrderTarget = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    end
    Event.PlayerUnit.IssuedOrderUnitTarget = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    end
    Event.PlayerUnit.Level = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_LEVEL)
    end
    Event.PlayerUnit.Skill = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_SKILL)
    end
    Event.PlayerUnit.Revivable = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVABLE)
    end
    Event.PlayerUnit.ReviveStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_START)
    end
    Event.PlayerUnit.ReviveCance = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_CANCEL)
    end
    Event.PlayerUnit.ReviveFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_FINISH)
    end
    Event.PlayerUnit.Summon = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SUMMON)
    end
    Event.PlayerUnit.DropItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DROP_ITEM)
    end
    Event.PlayerUnit.PickUpItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    end
    Event.PlayerUnit.UseItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_USE_ITEM)
    end
    Event.PlayerUnit.Loaded = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_LOADED)
    end
    Event.PlayerUnit.Damaged = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGED)
    end
    Event.PlayerUnit.Damaging = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGING)
    end
    Event.PlayerUnit.Sell = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL)
    end
    Event.PlayerUnit.ChangeOwner = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    end
    Event.PlayerUnit.SellItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL_ITEM)
    end
    Event.PlayerUnit.SpellChannel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    end
    Event.PlayerUnit.SpellCast = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CAST)
    end
    Event.PlayerUnit.SpellEffect = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    end
    Event.PlayerUnit.SpellFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_FINISH)
    end
    Event.PlayerUnit.SpellEndCast = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    end
    Event.PlayerUnit.PawnItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PAWN_ITEM)
    end
    Event.AnyUnit.Attacked = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ATTACKED)
        end
    end
    Event.AnyUnit.Resqued = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESCUED)
        end
    end
    Event.AnyUnit.Death = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DEATH)
        end
    end
    Event.AnyUnit.Decay = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DECAY)
        end
    end
    Event.AnyUnit.Detect = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DETECTED)
        end
    end
    Event.AnyUnit.Hidden = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_HIDDEN)
        end
    end
    Event.AnyUnit.Selected = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELECTED)
        end
    end
    Event.AnyUnit.Deselected = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DESELECTED)
        end
    end
    Event.AnyUnit.ConstructStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START)
        end
    end
    Event.AnyUnit.ConstructCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
        end
    end
    Event.AnyUnit.ConstructFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
        end
    end
    Event.AnyUnit.UpgradeStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START)
        end
    end
    Event.AnyUnit.Cancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
        end
    end
    Event.AnyUnit.Finish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH)
        end
    end
    Event.AnyUnit.TrainStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_START)
        end
    end
    Event.AnyUnit.TrainCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL)
        end
    end
    Event.AnyUnit.TrainFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH)
        end
    end
    Event.AnyUnit.ResearchStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START)
        end
    end
    Event.AnyUnit.ResearchCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
        end
    end
    Event.AnyUnit.ResearchFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
        end
    end
    Event.AnyUnit.IssuedOrder = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER)
        end
    end
    Event.AnyUnit.IssuedOrderPointTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
        end
    end
    Event.AnyUnit.IssuedOrderTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
        end
    end
    Event.AnyUnit.IssuedOrderUnitTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
        end
    end
    Event.AnyUnit.Level = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_LEVEL)
        end
    end
    Event.AnyUnit.Skill = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_SKILL)
        end
    end
    Event.AnyUnit.Revivable = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVABLE)
        end
    end
    Event.AnyUnit.ReviveStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_START)
        end
    end
    Event.AnyUnit.ReviveCance = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL)
        end
    end
    Event.AnyUnit.ReviveFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH)
        end
    end
    Event.AnyUnit.Summon = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SUMMON)
        end
    end
    Event.AnyUnit.DropItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM)
        end
    end
    Event.AnyUnit.PickUpItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM)
        end
    end
    Event.AnyUnit.UseItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_USE_ITEM)
        end
    end
    Event.AnyUnit.Loaded = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_LOADED)
        end
    end
    Event.AnyUnit.Damaged = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED)
        end
    end
    Event.AnyUnit.Damaging = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGING)
        end
    end
    Event.AnyUnit.Sell = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL)
        end
    end
    Event.AnyUnit.ChangeOwner = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER)
        end
    end
    Event.AnyUnit.SellItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM)
        end
    end
    Event.AnyUnit.SpellChannel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL)
        end
    end
    Event.AnyUnit.SpellCast = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST)
        end
    end
    Event.AnyUnit.SpellEffect = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT)
        end
    end
    Event.AnyUnit.SpellFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH)
        end
    end
    Event.AnyUnit.SpellEndCast = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST)
        end
    end
    Event.AnyUnit.PawnItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM)
        end
    end
    Event.Unit.Damaged = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGED)
    end
    Event.Unit.Damaging = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGING)
    end
    Event.Unit.Death = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DEATH)
    end
    Event.Unit.Decay = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DECAY)
    end
    Event.Unit.Detected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DETECTED)
    end
    Event.Unit.Hiden = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HIDDEN)
    end
    Event.Unit.Selected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELECTED)
    end
    Event.Unit.Deselected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DESELECTED)
    end
    Event.Unit.StateLimit = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_STATE_LIMIT)
    end
    Event.Unit.AcquiredTarget = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ACQUIRED_TARGET)
    end
    Event.Unit.TargetInRange = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TARGET_IN_RANGE)
    end
    Event.Unit.Attacked = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ATTACKED)
    end
    Event.Unit.Resqued = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESCUED)
    end
    Event.Unit.ConstructCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_CANCEL)
    end
    Event.Unit.ConstructFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_FINISH)
    end
    Event.Unit.UpgradeStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_START)
    end
    Event.Unit.UpgradeCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_CANCEL)
    end
    Event.Unit.UpgradeFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_FINISH)
    end
    Event.Unit.TrainStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_START)
    end
    Event.Unit.TrainCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_CANCEL)
    end
    Event.Unit.TrainFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_FINISH)
    end
    Event.Unit.ResearchStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_START)
    end
    Event.Unit.ResearchCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_CANCEL)
    end
    Event.Unit.ResearchFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_FINISH)
    end
    Event.Unit.IssuedOrder = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_ORDER)
    end
    Event.Unit.IssuedOrderPoint = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_POINT_ORDER)
    end
    Event.Unit.IssuedOrderTarget = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_TARGET_ORDER)
    end
    Event.Unit.Level = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_LEVEL)
    end
    Event.Unit.Skill = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_SKILL)
    end
    Event.Unit.Revivable = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVABLE)
    end
    Event.Unit.ReviveStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_START)
    end
    Event.Unit.ReviveCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_CANCEL)
    end
    Event.Unit.ReviveFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_FINISH)
    end
    Event.Unit.Summon = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SUMMON)
    end
    Event.Unit.DropItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DROP_ITEM)
    end
    Event.Unit.PickUpItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PICKUP_ITEM)
    end
    Event.Unit.UseItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_USE_ITEM)
    end
    Event.Unit.Loaded = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_LOADED)
    end
    Event.Unit.Sell = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL)
    end
    Event.Unit.ChangeOwner = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CHANGE_OWNER)
    end
    Event.Unit.SellItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL_ITEM)
    end
    Event.Unit.SpellChannel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CHANNEL)
    end
    Event.Unit.SpellCast = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CAST)
    end
    Event.Unit.SpellEffect = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_EFFECT)
    end
    Event.Unit.SpellFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_FINISH)
    end
    Event.Unit.SpellEndCast = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_ENDCAST)
    end
    Event.Unit.PawnItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PAWN_ITEM)
    end
    return Event
end
__require_data.module["trigger.TriggerAction"] = function()
    local TriggerAction = {}
    local TriggerAction_meta = {__index = TriggerAction, __gc = TriggerAction.destroy}
    function TriggerAction.new(callback, data)
      local action = {__callback = callback, __data = data}
      setmetatable(action, TriggerAction_meta)
      return action
    end
    function TriggerAction:destroy()
      self.__callback = nil
      self.__data = nil
    end
    function TriggerAction:run()
      self.__callback(self.__data)
    end
    function TriggerAction:getCallback()
      return self.__callback
    end
    function TriggerAction:getData()
      return self.__data
    end
    return TriggerAction
end
__require_data.module["trigger.TriggerDB"] = function()
    local TriggerDB = {}
    function TriggerDB.add(wc3_trigger, trigger)
      TriggerDB[wc3_trigger] = trigger
    end
    function TriggerDB.rm(wc3_trigger)
      TriggerDB[wc3_trigger] = nil
    end
    function TriggerDB.get(wc3_trigger)
      return TriggerDB[wc3_trigger]
    end
    return TriggerDB
end
__require_data.module["trigger.trigger"] = function()
    local Settings = require("utils.Settings")
    local TriggerDB = require("trigger.TriggerDB")
    local TriggerAction = require("trigger.TriggerAction")
    local Event = require("trigger.event")
    local Trigger = {}
    local Trigger_meta = {__index = Trigger, __gc = Trigger.destroy}
    function Trigger_meta.__tostring(self)
      return string.format("Trigger with %d action(s).", #self.__actions)
    end
    local function runTriggerActions()
      local self = TriggerDB.get(GetTriggeringTrigger())
      for i = 1, #self.__actions do
        local action = self.__actions[i]
        if (Settings.debug) then
          local succes, result = pcall(action.run, action)
          if (not succes) then
            Debug("Error in trigger")
            Debug(result)
          end
        else
          action:run()
        end
      end
      return true
    end
    function Trigger.new()
      local wc3_trigger = CreateTrigger()
      local trigger = {__wc3_trigger = wc3_trigger, __wc3_action = TriggerAddAction(wc3_trigger, runTriggerActions), __actions = {}}
      setmetatable(trigger, Trigger_meta)
      TriggerDB.add(trigger.__wc3_trigger, trigger)
      return trigger
    end
    function Trigger:destroy()
      self:clearActions()
      DestroyTrigger(self.__wc3_trigger)
      self.__wc3_trigger = nil
    end
    function Trigger:getObj()
      return self.__wc3_trigger
    end
    function Trigger:getActionObj()
      return self.__wc3_action
    end
    function Trigger:addAction(callback, data)
      local action = TriggerAction.new(callback, data)
      table.insert(self.__actions, (#self.__actions+1), action)
      return action
    end
    function Trigger:removeAction(action)
      local pos = -1
      for i = 1, #self.__actions do
        if (self.__actions[i] == action) then
          pos = i
          break
        end
      end
      if (pos > 0) then
        table.remove(self.__actions, pos)
        return true
      end
      return false
    end
    function Trigger:clearActions()
      while(#self.__actions > 0) do
        table.remove(self.__actions, 1)
      end
    end
    function Trigger:execute()
      TriggerExecute(self.__wc3_trigger)
    end
    function Trigger:addEvent_Game(event)
      Event.Game[event](self.__wc3_trigger)
    end
    function Trigger:addEvent_Player(event, wc3_player)
      Event.Player[event](self.__wc3_trigger, wc3_player)
    end
    function Trigger:addEvent_Unit(event, wc3_unit)
      Event.Unit[event](self.__wc3_trigger, wc3_unit)
    end
    function Trigger:addEvent_PlayerUnit(event, wc3_player)
      Event.PlayerUnit[event](self.__wc3_trigger, wc3_player)
    end
    function Trigger:addEvent_AnyUnit(event)
      Event.AnyUnit[event](self.__wc3_trigger)
    end
    return Trigger
end
__require_data.module["trigger.events.unitEvent"] = function()
    local Trigger = require("trigger.trigger")
    local UnitEvent = {__triggers = {}}
    local initialized = false
    function UnitEvent.init()
      if (initialized) then
        return nil
      end
      UnitEvent.__triggers.AnyUnitDie = Trigger.new()
      UnitEvent.__triggers.AnyUnitDie:addEvent_AnyUnit("Death")
      UnitEvent.__triggers.AnyUnitStartChannelAbility = Trigger.new()
      UnitEvent.__triggers.AnyUnitStartChannelAbility:addEvent_AnyUnit("SpellChannel")
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder = Trigger.new()
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder:addEvent_AnyUnit("IssuedOrder")
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder:addEvent_AnyUnit("IssuedOrderTarget")
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder:addEvent_AnyUnit("IssuedOrderUnitTarget")
      UnitEvent.__triggers.AnyUnitIssuedAnyOrder:addEvent_AnyUnit("IssuedOrderPointTarget")
      UnitEvent.__triggers.AnyUnitSelected = Trigger.new()
      UnitEvent.__triggers.AnyUnitSelected:addEvent_AnyUnit("Selected")
      UnitEvent.__triggers.AnyUnitDeselected = Trigger.new()
      UnitEvent.__triggers.AnyUnitDeselected:addEvent_AnyUnit("Deselected")
      initialized = true
    end
    function UnitEvent.getTrigger(name)
      if (not initialized) then
        UnitEvent.init()
      end
      return UnitEvent.__triggers[name]
    end
    return UnitEvent
end
__require_data.module["utils.Settings"] = function()
    local Settings = {debug = true, Timer = {glTimer_period = 0.03125, run_test = true}, UnitParameters = {attack_dispersion = 0.15, value_to_get_half_cap_for_percent_value = 500}, EnabledEvents = {Unit = true}}
    return Settings
end
__require_data.module["utils.Globals"] = function()
    local Settings = require("utils.Settings")
    local Globals = {}
    local initialized = false
    local Requirements = nil
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
    require("ability.AbilityEvent")
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