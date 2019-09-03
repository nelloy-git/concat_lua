  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["ability.warlord.settings"] = function()
    local WarlordSettings = {SummonSpearman = {ArtEffect = "", Name = "SummonSpearman", CustomCastingTime = 3, TargetType = "point", ArtSpecial = "", Id = "AM#'", AreaofEffect = 150, CastRange = 500, Cooldown = 0, TooltipNormalExtended = "Summons invulnerale spirit warrior.", DisableOtherAbilities = false, OrderId = "acidbomb", ArtTarget = "", Levels = 1, FollowThroughTime = 0, Options = 3, HotkeyNormal = "X", ArtCaster = "", CastingTime = 0, TooltipNormal = "Summon spearman"}, SpearmanUnit = {HideHeroDeathMsg = true, Name = "Spearman", HideHeroMinimapDisplay = true, NormalAbilities = "Avul,Aloc", Id = "HM#$", CollisionSize = 0, ModelFile = "war3mapImported\\units\\SwordNya.mdx", SpeedBase = 1, HideHeroInterfaceIcon = true}}
    return WarlordSettings
end
__require_data.module["ability.SummonsDB"] = function()
    local DataBase = require("utils.DataBase")
    local SummonsDB = {__masters = DataBase.new("userdata", "userdata"), __slaves = DataBase.new("userdata", "table")}
    local MastersDB = {}
    local SlavesDB = {}
    function SummonsDB.addSlave(slave, master)
      SummonsDB.__masters:add(slave, master)
      local slaves = SummonsDB.__slaves:get(master)
      if (not slaves) then
        slaves = {}
        SummonsDB.__slaves:add(master, slaves)
      end
      table.insert(slaves, 1, slave)
    end
    function SummonsDB.rmSlave(slave)
      local master = SummonsDB.__masters:get(slave)
      if (not master) then
        Debug("SummonDB error: summoned unit does not have master.")
        return false
      end
      SummonsDB.__masters:remove(slave)
      local slaves = SummonsDB.__slaves:get(master)
      if (not slaves) then
        Debug("SummonDB error: found master does not have any summons.")
        return false
      end
      local pos = -1
      for i = 0, #slaves do
        if (slaves[i] == slave) then
          pos = i
          break
        end
      end
      if (pos > 0) then
        table.remove(slaves, pos)
        return true
      else
        Debug("SummonsDB error: found master does not have unit in summons list.")
      end
      return false
    end
    function SummonsDB.getMaster(slave)
      return SummonsDB.__masters:get(slave)
    end
    function SummonsDB.getSlaves(master)
      return SummonsDB.__slaves:get(master)
    end
    return SummonsDB
end
__require_data.module["ability.Ability"] = function()
    local DataBase = require("utils.DataBase")
    local Ability = {__type = "AbilityClass", __ui_db = DataBase.new("number", "Ability"), __db = DataBase.new("number", "Ability")}
    local Ability_meta = {__type = "Ability", __index = Ability}
    function Ability_meta.__tostring(self)
      local str = string.format("%s %s (%s) with callbacks: ", self.__type, self.__name, ID2str(self.__id))
      local callbacks = ""
      if (self:getCallback("startTargeting")) then
        callbacks = callbacks..",startTargeting"
      end
      if (self:getCallback("finishTargeting")) then
        callbacks = callbacks..",finishTargeting"
      end
      if (self:getCallback("start")) then
        callbacks = callbacks..",start"
      end
      if (self:getCallback("casting")) then
        callbacks = callbacks..",casting"
      end
      if (self:getCallback("cancel")) then
        callbacks = callbacks..",cancel"
      end
      if (self:getCallback("interrupt")) then
        callbacks = callbacks..",interrupt"
      end
      if (self:getCallback("finish")) then
        callbacks = callbacks..",finish"
      end
      callbacks = callbacks:sub(2)
      return str..callbacks
    end
    function Ability.new(id, ui_id, hotkey)
      local ability = {__id = ID(id), __ui_id = ID(ui_id), __hotkey = hotkey, __callbacks = {}, __casting_time_func = nil}
      setmetatable(ability, Ability_meta)
      Ability.__db:add(ID(id), ability)
      Ability.__ui_db:add(ID(ui_id), ability)
      return ability
    end
    
    function Ability:getId()
      return self.__id
    end
    function Ability:getUI_Id()
      return self.__ui_id
    end
    function Ability:getHotkey()
      return self.__hotkey
    end
    function Ability.get(id)
      return Ability.__db:get(id)
    end
    function Ability.getUIAbility(id)
      return Ability.__ui_db:get(id)
    end
    function Ability:setCallback(callback, callback_type)
      self.__callbacks[callback_type] = callback
    end
    function Ability:getCallback(callback_type)
      return self.__callbacks[callback_type]
    end
    function Ability:runCallback(callback_type, cast_data)
      if (type(self.__callbacks[callback_type]) == "function") then
        return self.__callbacks[callback_type](cast_data)
      else
        return true
      end
    end
    function Ability:setFlag(flag, flag_name)
      self.__flag[flag_name] = flag
    end
    function Ability:getFlag(flag_name)
      return self.__flag[flag_name]
    end
    function Ability:setCastingTimeFunction(func)
      self.__casting_time_func = func
    end
    function Ability:getCastingTime(data)
      if (type(self.__casting_time_func) == "function") then
        return self.__casting_time_func(data)
      end
      return 0
    end
    function Ability:setName(name)
      self.__name = name
    end
    function Ability:getName()
      return self.__name
    end
    function Ability:setTooltip(tooltip, lvl, player)
      if (player == nil) then
        BlzSetAbilityTooltip(self.__ui_id, tooltip, lvl)
      elseif (player == GetLocalPlayer()) then
        BlzSetAbilityTooltip(self.__ui_id, tooltip, lvl)
      end

    end
    function Ability:setExtendedTooltip(ext_tooltip, lvl, player)
      if (player == nil) then
        BlzSetAbilityExtendedTooltip(self.__ui_id, ext_tooltip, lvl)
      elseif (player == GetLocalPlayer()) then
        BlzSetAbilityExtendedTooltip(self.__ui_id, ext_tooltip, lvl)
      end

    end
    function Ability:setIcon(icon_path, player)
      if (player == nil) then
        BlzSetAbilityIcon(self.__ui_id, icon_path)
      elseif (player == GetLocalPlayer()) then
        BlzSetAbilityIcon(self.__ui_id, icon_path)
      end

    end
    function Ability:setPosition(x, y, player)
      if (player == nil) then
        BlzSetAbilityPosX(self.__ui_id, x)
        BlzSetAbilityPosY(self.__ui_id, y)
      elseif (player == GetLocalPlayer()) then
        BlzSetAbilityPosX(self.__ui_id, x)
        BlzSetAbilityPosY(self.__ui_id, y)
      end

    end
    return Ability
end
__require_data.module["unitParameter.mathFunc"] = function()
    local Settings = require("utils.Settings")
    local UnitMathParameter = {}
    local half_cap = Settings.UnitParameters.value_to_get_half_cap_for_percent_value
    function UnitMathParameter.linear(base, multiplicator, bonus)
      return ((base*multiplicator)+bonus)
    end
    function UnitMathParameter.inverseLinear(base, multiplicator, bonus)
      return ((base/multiplicator)-bonus)
    end
    function UnitMathParameter.percent(base, multiplicator, bonus, param_cap)
      local val = ((base*multiplicator)+bonus)
      local k = (val/(val+half_cap))
      return (k*param_cap)
    end
    function UnitMathParameter.inversePercent(base, multiplicator, bonus, param_cap)
      local val = ((base*multiplicator)+bonus)
      local k = (val/(val+half_cap))
      return (100-(k*(100-param_cap)))
    end
    return UnitMathParameter
end
__require_data.module["unitParameter.applyFunc"] = function()
    local Settings = require("utils.Settings")
    local UnitApplyParameter = {}
    local attack_dispersion = Settings.UnitParameters.attack_dispersion
    local critical_and_dodge_id = 1095574308
    local resist_id = 1095574309
    local book_id = 1095574310
    function UnitApplyParameter.attack(unit, value)
      local k = (1-attack_dispersion)
      local dmg = (k*value)
      local dice_sides = ((2*attack_dispersion)*value)
      BlzSetUnitBaseDamage(unit, math.floor(dmg), 0)
      BlzSetUnitDiceNumber(unit, 1, 0)
      BlzSetUnitDiceSides(unit, math.floor((dice_sides+1)), 0)
    end
    function UnitApplyParameter.attackSpeed(unit, value)
      BlzSetUnitAttackCooldown(unit, value, 0)
      BlzSetUnitAttackCooldown(unit, value, 1)
    end
    function UnitApplyParameter.armor(unit, value)
      BlzSetUnitArmor(unit, math.floor(value))
    end
    function UnitApplyParameter.spellPower(unit, value)
      unit = nil
      value = nil
    end
    function UnitApplyParameter.castSpeed(unit, value)
      unit = nil
      value = nil
    end
    function UnitApplyParameter.resistance(unit, value)
      if (GetUnitAbilityLevel(unit, book_id) <= 0) then
        UnitAddAbility(unit, book_id)
        BlzUnitHideAbility(unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(unit, resist_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_REDUCTION_ISR2, 1, value)
    end
    function UnitApplyParameter.cooldown(unit, value)
      unit = nil
      value = nil
    end
    function UnitApplyParameter.health(unit, value)
      BlzSetUnitMaxHP(unit, math.floor(value))
    end
    function UnitApplyParameter.regeneration(unit, value)
      BlzSetUnitRealField(unit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, value)
    end
    function UnitApplyParameter.mana(unit, value)
      BlzSetUnitMaxMana(unit, math.floor(value))
    end
    function UnitApplyParameter.recovery(unit, value)
      BlzSetUnitRealField(unit, UNIT_RF_MANA_REGENERATION, value)
    end
    function UnitApplyParameter.criticalChance(unit, value)
      if (GetUnitAbilityLevel(unit, book_id) <= 0) then
        UnitAddAbility(unit, book_id)
        BlzUnitHideAbility(unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(unit, critical_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE, 1, value)
    end
    function UnitApplyParameter.criticalPower(unit, value)
      if (GetUnitAbilityLevel(unit, book_id) <= 0) then
        UnitAddAbility(unit, book_id)
        BlzUnitHideAbility(unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(unit, critical_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2, 1, value)
    end
    function UnitApplyParameter.dodgeChance(unit, value)
      value = (value/100)
      if (GetUnitAbilityLevel(unit, book_id) <= 0) then
        UnitAddAbility(unit, book_id)
        BlzUnitHideAbility(unit, book_id, true)
      end
      local unit_ability = BlzGetUnitAbility(unit, critical_and_dodge_id)
      BlzSetAbilityRealLevelField(unit_ability, ABILITY_RLF_CHANCE_TO_EVADE_OCR4, 1, value)
    end
    function UnitApplyParameter.strength(unit, value)
      SetHeroStr(unit, math.floor(value), true)
    end
    function UnitApplyParameter.agility(unit, value)
      SetHeroAgi(unit, math.floor(value), true)
    end
    function UnitApplyParameter.intelligence(unit, value)
      SetHeroInt(unit, math.floor(value), true)
    end
    return UnitApplyParameter
end
__require_data.module["unitParameter.UnitParameter"] = function()
    local UnitParameter = {}
    local UnitParameter_meta = {__index = UnitParameter}
    function UnitParameter.new(unit, base, apply_param_func, math_func, max_val)
      local parameter = {__wc3_unit = unit, __base = base, __bonus = 0, __multiplicator = 1, __cap = max_val, __apply_param_func = apply_param_func, __math_func = math_func}
      setmetatable(parameter, UnitParameter_meta)
      parameter:update()
      return parameter
    end
    function UnitParameter:set(base, multiplicator, bonus)
      self.__base = base
      self.__multiplicator = multiplicator
      self.__bonus = bonus
      self:update()
    end
    function UnitParameter:addAll(base, multiplicator, bonus)
      self.__base = (self.__base+base)
      self.__multiplicator = (self.__multiplicator+multiplicator)
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
    function UnitParameter:addMultiplicator(val)
      self.__multiplicator = (self.__multiplicator+val)
      self:update()
    end
    function UnitParameter:getAll()
      return self.__base, self.__multiplicator, self.__bonus, self.__math_func(self.__base, self.__multiplicator, self.__bonus, self.__cap)
    end
    function UnitParameter:getBase()
      return self.__base
    end
    function UnitParameter:getBonus()
      return self.__bonus
    end
    function UnitParameter:getMultiplicator()
      return self.__multiplicator
    end
    function UnitParameter:getResult()
      return self.__res
    end
    function UnitParameter:update()
      self.__res = self.__math_func(self.__base, self.__multiplicator, self.__bonus, self.__cap)
      self.__apply_param_func(self.__wc3_unit, self.__res)
    end
    return UnitParameter
end
__require_data.module["unitParameter.UnitParameterContainer"] = function()
    local UnitParameter = require("unitParameter.UnitParameter")
    local DataBase = require("utils.DataBase")
    local ApplyParam = require("unitParameter.applyFunc")
    local MathParam = require("unitParameter.mathFunc")
    local ParameterContainer = {__type = "ParameterContainerClass"}
    local ParameterContainer_meta = {__type = "ParameterContainer", __index = ParameterContainer}
    local ParameterContainerDB = DataBase.new("userdata", "ParameterContainer")
    function ParameterContainer.new(unit)
      local container = {}
      setmetatable(container, ParameterContainer_meta)
      ParameterContainerDB:add(unit, container)
      local string_id = ID2str(GetUnitTypeId(unit))
      local first = string_id:sub(1, 1)
      if (first == string.upper(first)) then
        container.__strength = UnitParameter.new(unit, 1, ApplyParam.strength, MathParam.linear)
        container.__agility = UnitParameter.new(unit, 1, ApplyParam.agility, MathParam.linear)
        container.__intelligence = UnitParameter.new(unit, 1, ApplyParam.intelligence, MathParam.linear)
      end
      container.__attack = UnitParameter.new(unit, 1, ApplyParam.attack, MathParam.linear)
      container.__attackSpeed = UnitParameter.new(unit, 2, ApplyParam.attackSpeed, MathParam.inverseLinear)
      container.__armor = UnitParameter.new(unit, 0, ApplyParam.armor, MathParam.linear)
      container.__spellPower = UnitParameter.new(unit, 0, ApplyParam.spellPower, MathParam.linear)
      container.__castSpeed = UnitParameter.new(unit, 0, ApplyParam.castSpeed, MathParam.inversePercent, 25)
      container.__resistance = UnitParameter.new(unit, 0, ApplyParam.resistance, MathParam.percent, 90)
      container.__health = UnitParameter.new(unit, 100, ApplyParam.health, MathParam.linear)
      container.__regeneration = UnitParameter.new(unit, 0, ApplyParam.regeneration, MathParam.linear)
      container.__mana = UnitParameter.new(unit, 100, ApplyParam.mana, MathParam.linear)
      container.__recovery = UnitParameter.new(unit, 0, ApplyParam.recovery, MathParam.linear)
      container.__criticalChance = UnitParameter.new(unit, 0, ApplyParam.criticalChance, MathParam.percent, 100)
      container.__criticalPower = UnitParameter.new(unit, 1, ApplyParam.criticalPower, MathParam.linear)
      container.__dodge = UnitParameter.new(unit, 0, ApplyParam.dodgeChance, MathParam.percent, 75)
      container.__cooldown = UnitParameter.new(unit, 0, ApplyParam.cooldown, MathParam.percent, 75)
      return container
    end
    function ParameterContainer.get(unit)
      return ParameterContainerDB:get(unit)
    end
    function ParameterContainer:addAttack(base, multiplicator, bonus)
      self.__attack:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getAttack()
      return self.__attack:get()
    end
    function ParameterContainer:setAttacksPerSec(base)
      _, multiplicator, bonus, _ = self.__attackSpeed:get()
      self.__attackSpeed:set(base, multiplicator, bonus)
    end
    function ParameterContainer:addAttackSpeed(multiplicator)
      self.__attackSpeed:add(0, multiplicator, 0)
    end
    function ParameterContainer:getAttackSpeed()
      base, multiplicator, _, res = self.__attackSpeed:get()
      return base, multiplicator, res
    end
    function ParameterContainer:addArmor(base, multiplicator, bonus)
      self.__armor:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getArmor()
      return self.__armor:get()
    end
    function ParameterContainer:addSpellPower(base, multiplicator, bonus)
      self.__spellPower:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getSpellPower()
      return self.__spellPower:get()
    end
    function ParameterContainer:addCastSpeed(base, multiplicator, bonus)
      self.__castSpeed:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getCastSpeed()
      return self.__castSpeed:get()
    end
    function ParameterContainer:addResistance(base, multiplicator, bonus)
      self.__resistance:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getResistance()
      return self.__resistance:get()
    end
    function ParameterContainer:addHealth(base, multiplicator, bonus)
      self.__health:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getHealth()
      return self.__health:get()
    end
    function ParameterContainer:addRegeneration(base, multiplicator, bonus)
      self.__regeneration:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getRegeneration()
      return self.__regeneration:get()
    end
    function ParameterContainer:addMana(base, multiplicator, bonus)
      self.__mana:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getMana()
      return self.__mana:get()
    end
    function ParameterContainer:addRecovery(base, multiplicator, bonus)
      self.__recovery:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getRecovery()
      return self.__recovery:get()
    end
    function ParameterContainer:addCriticalChance(base, multiplicator, bonus)
      self.__criticalChance:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getCriticalChance()
      return self.__criticalChance:get()
    end
    function ParameterContainer:addCriticalPower(base, multiplicator, bonus)
      self.__criticalPower:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getCriticalPower()
      return self.__criticalPower:get()
    end
    function ParameterContainer:addDodgeChance(base, multiplicator, bonus)
      self.__dodge:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getDodgeChance()
      return self.__dodge:get()
    end
    function ParameterContainer:addCooldown(base, multiplicator, bonus)
      self.__cooldown:add(base, multiplicator, bonus)
    end
    function ParameterContainer:getCooldown()
      return self.__cooldown:get()
    end
    function ParameterContainer:addStrength(base, multiplicator, bonus)
      if (self.strength ~= nil) then
        self.strength:add(base, multiplicator, bonus)
      end
    end
    function ParameterContainer:getStrength()
      if (self.strength ~= nil) then
        return self.strength:get()
      else
        return 0, 0, 0, 0
      end
    end
    function ParameterContainer:addAgility(base, multiplicator, bonus)
      if (self.agility ~= nil) then
        self.agility:add(base, multiplicator, bonus)
      end
    end
    function ParameterContainer:getAgility()
      if (self.agility ~= nil) then
        return self.agility:get()
      else
        return 0, 0, 0, 0
      end
    end
    function ParameterContainer:addIntelligence(base, multiplicator, bonus)
      if (self.intelligence ~= nil) then
        self.intelligence:add(base, multiplicator, bonus)
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
__require_data.module["unit.Unit"] = function()
    local ParameterContainer = require("unitParameter.UnitParameterContainer")
    local DataBase = require("utils.DataBase")
    local Unit = {__type = "ClassUnit", __db = DataBase.new("userdata", "Unit")}
    local Unit_meta = {__type = "Unit", __index = Unit, __tostring = function(self)
  return string.format("Unit %s (%s) at [%.2f, %.2f, %.2f]", self:getName(), ID2str(self:getId()), self:getX(), self:getY(), self:getZ())
end, __gc = Unit.destroy}
    function Unit.new(player, id, x, y, face, is_dead)
      id = ID(id)
      local unit_obj
      if (is_dead) then
        unit_obj = CreateCorpse(player, id, x, y, face)
      else
        unit_obj = CreateUnit(player, id, x, y, face)
      end
      local unit = {__id = id, __unit_obj = unit_obj}
      setmetatable(unit, Unit_meta)
      Unit.__db:add(unit.__unit_obj, unit)
      unit:initCustomData()
      return unit
    end
    function Unit.get(unit)
      Unit.__db:get(unit)
    end
    function Unit:destroy()
      self:destroyCustomData()
      Unit.__db:rm(self.__unit_obj)
      RemoveUnit(self.__unit_obj)
      self.__unit_obj = nil
    end
    function Unit:getObj()
      return self.__unit_obj
    end
    function Unit:initCustomData()
      self.parameter = runFuncInDebug(ParameterContainer.new, self.__unit_obj)
    end
    function Unit:destroyCustomData()

    end
    function Unit:getId()
      return self.__id
    end
    function Unit:getName()
      return GetUnitName(self.__unit_obj)
    end
    function Unit:setVertexColor(red, green, blue, alpha)
      red = math.floor((255*torange(red, 0, 1)))
      green = math.floor((255*torange(green, 0, 1)))
      blue = math.floor((255*torange(blue, 0, 1)))
      alpha = math.floor((255*torange(alpha, 0, 1)))
      SetUnitVertexColor(self.__unit_obj, red, green, blue, alpha)
    end
    function Unit:getOwningPlayer()
      return GetOwningPlayer(self.__unit_obj)
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
      SetUnitX(self.__unit_obj, x)
    end
    function Unit:setY(y)
      SetUnitY(self.__unit_obj, y)
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
      return GetUnitX(self.__unit_obj)
    end
    function Unit:getY()
      return GetUnitY(self.__unit_obj)
    end
    function Unit:getZ()
      return (GetTerrainZ(self:getX(), self:getY())+self:getFlyHeight())
    end
    function Unit:getFlyHeight()
      return GetUnitFlyHeight(self.__unit_obj)
    end
    function Unit:setFlyHeight(height)
      return SetUnitFlyHeight(self.__unit_obj, height)
    end
    function Unit:getDefaultsFlyHeight()
      return GetUnitDefaultFlyHeight(self.__unit_obj)
    end
    function Unit:setFacing(angle, time)
      if (time == nil or time <= 0) then
        SetUnitFacing(self.__unit_obj, angle)
      else
        SetUnitFacingTimed(self.__unit_obj, angle, time)
      end
    end
    function Unit:setFacingTo(target, time)
      local x, y = self:getPos()
      local angle = (180+((180/math.pi)*math.atan((y-target.y), (x-target.x))))
      self:setFacing(angle, time)
    end
    function Unit:getFacing()
      return GetUnitFacing(self.__unit_obj)
    end
    function Unit:getMoveSpeed()
      return GetUnitMoveSpeed(self.__unit_obj)
    end
    function Unit:setMoveSpeed(speed)
      SetUnitMoveSpeed(self.__unit_obj, speed)
    end
    function Unit:getTurnSpeed()
      return GetUnitTurnSpeed(self.__unit_obj)
    end
    function Unit:setTurnSpeed(speed)
      SetUnitTurnSpeed(self.__unit_obj, speed)
    end
    function Unit:getDefaultTurnSpeed()
      return GetUnitDefaultTurnSpeed(self.__unit_obj)
    end
    function Unit:addAbility(ability_id)
      UnitAddAbility(self.__unit_obj, ability_id)
    end
    function Unit:removeAbility(ability_id)
      UnitRemoveAbility(self.__unit_obj, ability_id)
    end
    function Unit:getAbilityLevel(ability_id)
      return GetUnitAbilityLevel(self.__unit_obj, ability_id)
    end
    function Unit:setAbilityLevel(ability_id)
      SetUnitAbilityLevel(self.__unit_obj, ability_id)
    end
    function Unit:setInvulnerable(flag)
      SetUnitInvulnerable(self.__unit_obj, flag)
    end
    function Unit:applyTimedLife(time)
      UnitApplyTimedLife(self.__unit_obj, 0, time)
    end
    function Unit:issueImmediateOrderById(order_id)
      IssueImmediateOrderById(self.__unit_obj, order_id)
    end
    function Unit:orderStop()
      self:issueImmediateOrderById(851972)
    end
    function Unit:issuePointOrderById(order_id, x, y)
      IssuePointOrderById(self.__unit_obj, order_id, x, y)
    end
    function Unit:setMoveSpeed(speed)
      SetUnitMoveSpeed(self.__unit_obj, speed)
    end
    function Unit:setTurnSpeed(speed)
      SetUnitTurnSpeed(self.__unit_obj, speed)
    end
    function Unit:playAnimation(animation)
      SetUnitAnimation(self.__unit_obj, animation)
    end
    function Unit:setAnimationSpeed(scale)
      SetUnitTimeScale(self.__unit_obj, scale)
    end
    function Unit:pause()
      PauseUnit(self.__unit_obj, true)
    end
    function Unit:unpause()
      PauseUnit(self.__unit_obj, false)
    end
    function Unit.get(wc3_unit)
      return Unit.__db:get(wc3_unit)
    end
    function Unit.GetLevelingUnit()
      return Unit.__db:get(GetLevelingUnit())
    end
    function Unit.GetLearningUnit()
      return Unit.__db:get(GetLearningUnit())
    end
    function Unit.GetRevivableUnit()
      return Unit.__db:get(GetRevivableUnit())
    end
    function Unit.GetRevivingUnit()
      return Unit.__db:get(GetRevivingUnit())
    end
    function Unit.GetAttacker()
      return Unit.__db:get(GetAttacker())
    end
    function Unit.GetRescuer()
      return Unit.__db:get(GetRescuer())
    end
    function Unit.GetDyingUnit()
      return Unit.__db:get(GetDyingUnit())
    end
    function Unit.GetKillingUnit()
      return Unit.__db:get(GetKillingUnit())
    end
    function Unit.GetDecayingUnit()
      return Unit.__db:get(GetDecayingUnit())
    end
    function Unit.GetConstructingStructure()
      return Unit.__db:get(GetConstructingStructure())
    end
    function Unit.GetCancelledStructure()
      return Unit.__db:get(GetCancelledStructure())
    end
    function Unit.GetConstructedStructure()
      return Unit.__db:get(GetConstructedStructure())
    end
    function Unit.GetResearchingUnit()
      return Unit.__db:get(GetResearchingUnit())
    end
    function Unit.GetTrainedUnit()
      return Unit.__db:get(GetTrainedUnit())
    end
    function Unit.GetDetectedUnit()
      return Unit.__db:get(GetDetectedUnit())
    end
    function Unit.GetSummoningUnit()
      return Unit.__db:get(GetSummoningUnit())
    end
    function Unit.GetSummonedUnit()
      return Unit.__db:get(GetSummonedUnit())
    end
    function Unit.GetTransportUnit()
      return Unit.__db:get(GetTransportUnit())
    end
    function Unit.GetLoadedUnit()
      return Unit.__db:get(GetLoadedUnit())
    end
    function Unit.GetSellingUnit()
      return Unit.__db:get(GetSellingUnit())
    end
    function Unit.GetSoldUnit()
      return Unit.__db:get(GetSoldUnit())
    end
    function Unit.GetBuyingUnit()
      return Unit.__db:get(GetBuyingUnit())
    end
    function Unit.GetChangingUnit()
      return Unit.__db:get(GetChangingUnit())
    end
    function Unit.GetManipulatingUnit()
      return Unit.__db:get(GetManipulatingUnit())
    end
    function Unit.GetOrderedUnit()
      return Unit.__db:get(GetOrderedUnit())
    end
    function Unit.GetOrderTargetUnit()
      return Unit.__db:get(GetOrderTargetUnit())
    end
    function Unit.GetSpellAbilityUnit()
      return Unit.__db:get(GetSpellAbilityUnit())
    end
    function Unit.GetSpellTargetUnit()
      return Unit.__db:get(GetSpellTargetUnit())
    end
    function Unit.GetTriggerUnit()
      return Unit.__db:get(GetTriggerUnit())
    end
    function Unit.GetEventDamage()
      return Unit.__db:get(GetEventDamage())
    end
    function Unit.GetEventDamageSource()
      return Unit.__db:get(GetEventDamageSource())
    end
    function Unit.GetEventTargetUnit()
      return Unit.__db:get(GetEventTargetUnit())
    end
    return Unit
end
__require_data.module["ability.warlord.summon"] = function()
    local Unit = require("unit.Unit")
    local UnitEvent = require("utils.trigger.events.UnitEvents")
    local Ability = require("ability.Ability")
    local SummonsDB = require("ability.SummonsDB")
    local FullData = require("ability.warlord.settings")
    local AbilityData = FullData.SummonSpearman
    local SummonData = FullData.SpearmanUnit
    local targeting_ability_id = "AM#("
    local SummonCrystalSpearmanAbility = Ability.new(AbilityData.Id, targeting_ability_id, AbilityData.HotkeyNormal)
    function SummonCrystalSpearmanAbility.init()
      UnitEvent.getTrigger("AnyUnitDie"):addAction(function()
          local unit = Unit.GetDyingUnit()
          local dying_id = unit:getId()
          if (dying_id == ID(SummonData.Id)) then
            SummonsDB.rmSlave(unit:getObj())
          end
      end)
    end
    local function finishCastingCallback(spell_data)
      local caster = spell_data:getCaster()
      local owner = GetOwningPlayer(caster)
      local unit = Unit.new(owner, SummonData.Id, spell_data:getX(), spell_data:getY(), GetUnitFacing(caster))
      unit:setVertexColor(1, 1, 1, 0.35)
      unit:applyTimedLife(10)
      SummonsDB.addSlave(unit:getObj(), caster)
      unit.parameter:setAttacksPerSec(1)
    end
    SummonCrystalSpearmanAbility:setName(AbilityData.TooltipNormal)
    SummonCrystalSpearmanAbility:setCastingTimeFunction(function()
        return AbilityData.CustomCastingTime
    end)
    SummonCrystalSpearmanAbility:setCallback(finishCastingCallback, "finish")
    return SummonCrystalSpearmanAbility
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
    local DataBase = require("utils.DataBase")
    local Timer = {__type = "TimerClass"}
    local Timer_meta = {__type = "Timer", __index = Timer, __gc = Timer.destroy}
    local TimerDB = DataBase.new("userdata", type(Timer_meta))
    function Timer.new(period)
      local timer = {__timer_obj = CreateTimer(), __cur_time = 0.0, __period = period, __actions = {}}
      setmetatable(timer, Timer_meta)
      TimerDB:add(timer.__timer_obj, timer)
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
    local test_timer
    local function test(num)
      table.insert(test_result, (#test_result+1), num)
    end
    local function check_test()
      DestroyTimer(GetExpiredTimer())
      for i = 1, count do
        a, b = modf((i/2))
        if (test_result[i] ~= a) then
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
    local Vec3 = {__type = "Vec3Class"}
    local Vec3_meta = {__type = "Vec3", __index = Vec3, __tostring = function(self)
  return string.format("%s[%.2f, %.2f, %.2f]", self.__type, self.x, self.y, self.z)
end}
    local loc
    if (not is_compiletime) then
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
    local Vec2 = {__type = "Vec2Class"}
    local Vec2_meta = {__type = "Vec2", __index = Vec2}
    function Vec2_meta.__tostring(self)
      return string.format("[%.2f, %.2f]", self.x, self.y)
    end
    function Vec2.new(x, y)
      local v = {x = x, y = y}
      setmetatable(v, Vec2_meta)
      return v
    end
    function GetSpellTargetPos()
      return Vec2.new(GetSpellTargetX(), GetSpellTargetY())
    end
    return Vec2
end
__require_data.module["utils.trigger.events.PlayerEvents"] = function()
    local Trigger = require("utils.trigger.Trigger")
    local PlayerEvent = {__triggers = {}}
    local initialized = false
    function PlayerEvent.init()
      if (initialized) then
        return nil
      end
      PlayerEvent.__triggers.LocalPlayerMouseMove = Trigger.new()
      PlayerEvent.__triggers.LocalPlayerMouseMove:addEvent_Player("MouseMove", GetLocalPlayer())
      PlayerEvent.__triggers.LocalPlayerKeyPressed = Trigger.new()
      PlayerEvent.__triggers.LocalPlayerKeyPressed:addEvent_Player("Key", GetLocalPlayer())
      PlayerEvent.__triggers.LocalPlayerKeyDown = Trigger.new()
      PlayerEvent.__triggers.LocalPlayerKeyDown:addEvent_Player("KeyDown", GetLocalPlayer())
      PlayerEvent.__triggers.LocalPlayerKeyUp = Trigger.new()
      PlayerEvent.__triggers.LocalPlayerKeyUp:addEvent_Player("KeyUp", GetLocalPlayer())
      initialized = true
    end
    function PlayerEvent.getTrigger(event)
      if (not initialized) then
        PlayerEvent.init()
      end
      return PlayerEvent.__triggers[event]
    end
    return PlayerEvent
end
__require_data.module["utils.trigger.TriggerEvent"] = function()
    local TriggerEvent = {Game = {}, AnyPlayer = {}, Player = {}, PlayerUnit = {}, AnyUnit = {}, Unit = {}}
    TriggerEvent.Game.Victory = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VICTORY)
    end
    TriggerEvent.Game.End = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_END_LEVEL)
    end
    TriggerEvent.Game.VariableLimit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_VARIABLE_LIMIT)
    end
    TriggerEvent.Game.StateLimit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_STATE_LIMIT)
    end
    TriggerEvent.Game.TimerExpired = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TIMER_EXPIRED)
    end
    TriggerEvent.Game.EnterRegion = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_ENTER_REGION)
    end
    TriggerEvent.Game.LeaveRegion = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LEAVE_REGION)
    end
    TriggerEvent.Game.TrackableHit = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_HIT)
    end
    TriggerEvent.Game.TrackableTrack = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TRACKABLE_TRACK)
    end
    TriggerEvent.Game.ShowSkill = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SHOW_SKILL)
    end
    TriggerEvent.Game.BuildSubmenu = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_BUILD_SUBMENU)
    end
    TriggerEvent.Game.Loaded = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_LOADED)
    end
    TriggerEvent.Game.TournamentFinishSoon = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_SOON)
    end
    TriggerEvent.Game.TournamentFinishNow = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_TOURNAMENT_FINISH_NOW)
    end
    TriggerEvent.Game.Save = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_SAVE)
    end
    TriggerEvent.Game.CustomUIFrame = function(wc3_trigger)
        TriggerRegisterGameEvent(wc3_trigger, EVENT_GAME_CUSTOM_UI_FRAME)
    end
    TriggerEvent.Player.StateLimit = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_STATE_LIMIT)
    end
    TriggerEvent.Player.AllianceChanged = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ALLIANCE_CHANGED)
    end
    TriggerEvent.Player.Defeat = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_DEFEAT)
    end
    TriggerEvent.Player.Victory = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_VICTORY)
    end
    TriggerEvent.Player.Leave = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_LEAVE)
    end
    TriggerEvent.Player.Chat = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_CHAT)
    end
    TriggerEvent.Player.EndCinematic = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_END_CINEMATIC)
    end
    TriggerEvent.Player.ArrowLeft_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_DOWN)
    end
    TriggerEvent.Player.ArrowLeft_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_LEFT_UP)
    end
    TriggerEvent.Player.ArrowRight_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_DOWN)
    end
    TriggerEvent.Player.ArrowRight_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_RIGHT_UP)
    end
    TriggerEvent.Player.ArrowDown_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_DOWN)
    end
    TriggerEvent.Player.ArrowDown_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_DOWN_UP)
    end
    TriggerEvent.Player.ArrowUp_Down = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_DOWN)
    end
    TriggerEvent.Player.ArrowUp_Up = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_ARROW_UP_UP)
    end
    TriggerEvent.Player.MouseDown = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_DOWN)
    end
    TriggerEvent.Player.MouseUp = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_UP)
    end
    TriggerEvent.Player.MouseMove = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_MOUSE_MOVE)
    end
    TriggerEvent.Player.SyncData = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_SYNC_DATA)
    end
    TriggerEvent.Player.Key = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY)
    end
    TriggerEvent.Player.KeyDown = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_DOWN)
    end
    TriggerEvent.Player.KeyUp = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerEvent(wc3_trigger, wc3_player, EVENT_PLAYER_KEY_UP)
    end
    TriggerEvent.AnyPlayer.StateLimit = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_STATE_LIMIT)
        end
    end
    TriggerEvent.AnyPlayer.AllianceChanged = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ALLIANCE_CHANGED)
        end
    end
    TriggerEvent.AnyPlayer.Defeat = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_DEFEAT)
        end
    end
    TriggerEvent.AnyPlayer.Victory = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_VICTORY)
        end
    end
    TriggerEvent.AnyPlayer.Leave = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_LEAVE)
        end
    end
    TriggerEvent.AnyPlayer.Chat = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_CHAT)
        end
    end
    TriggerEvent.AnyPlayer.EndCinematic = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_END_CINEMATIC)
        end
    end
    TriggerEvent.AnyPlayer.ArrowLeft_Down = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ARROW_LEFT_DOWN)
        end
    end
    TriggerEvent.AnyPlayer.ArrowLeft_Up = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ARROW_LEFT_UP)
        end
    end
    TriggerEvent.AnyPlayer.ArrowRight_Down = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ARROW_RIGHT_DOWN)
        end
    end
    TriggerEvent.AnyPlayer.ArrowRight_Up = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ARROW_RIGHT_UP)
        end
    end
    TriggerEvent.AnyPlayer.ArrowDown_Down = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ARROW_DOWN_DOWN)
        end
    end
    TriggerEvent.AnyPlayer.ArrowDown_Up = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ARROW_DOWN_UP)
        end
    end
    TriggerEvent.AnyPlayer.ArrowUp_Down = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ARROW_UP_DOWN)
        end
    end
    TriggerEvent.AnyPlayer.ArrowUp_Up = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_ARROW_UP_UP)
        end
    end
    TriggerEvent.AnyPlayer.MouseDown = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_MOUSE_DOWN)
        end
    end
    TriggerEvent.AnyPlayer.MouseUp = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_MOUSE_UP)
        end
    end
    TriggerEvent.AnyPlayer.MouseMove = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_MOUSE_MOVE)
        end
    end
    TriggerEvent.AnyPlayer.SyncData = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_SYNC_DATA)
        end
    end
    TriggerEvent.AnyPlayer.Key = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_KEY)
        end
    end
    TriggerEvent.AnyPlayer.KeyDown = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_KEY_DOWN)
        end
    end
    TriggerEvent.AnyPlayer.KeyUp = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerEvent(wc3_trigger, Player(i), EVENT_PLAYER_KEY_UP)
        end
    end
    TriggerEvent.PlayerUnit.Attacked = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ATTACKED)
    end
    TriggerEvent.PlayerUnit.Rescued = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESCUED)
    end
    TriggerEvent.PlayerUnit.Death = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DEATH)
    end
    TriggerEvent.PlayerUnit.Decay = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DECAY)
    end
    TriggerEvent.PlayerUnit.Death = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DETECTED)
    end
    TriggerEvent.PlayerUnit.Hidden = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_HIDDEN)
    end
    TriggerEvent.PlayerUnit.Selected = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELECTED)
    end
    TriggerEvent.PlayerUnit.Deselected = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DESELECTED)
    end
    TriggerEvent.PlayerUnit.ConstructStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    end
    TriggerEvent.PlayerUnit.ConstructCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    end
    TriggerEvent.PlayerUnit.ConstructFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    end
    TriggerEvent.PlayerUnit.UpgradeStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_START)
    end
    TriggerEvent.PlayerUnit.Cancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    end
    TriggerEvent.PlayerUnit.Finish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    end
    TriggerEvent.PlayerUnit.TrainStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_START)
    end
    TriggerEvent.PlayerUnit.TrainCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    end
    TriggerEvent.PlayerUnit.TrainFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    end
    TriggerEvent.PlayerUnit.ResearchStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_START)
    end
    TriggerEvent.PlayerUnit.ResearchCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    end
    TriggerEvent.PlayerUnit.ResearchFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    end
    TriggerEvent.PlayerUnit.IssuedOrder = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    end
    TriggerEvent.PlayerUnit.IssuedOrderPointTarget = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    end
    TriggerEvent.PlayerUnit.IssuedOrderTarget = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    end
    TriggerEvent.PlayerUnit.IssuedOrderUnitTarget = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    end
    TriggerEvent.PlayerUnit.Level = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_LEVEL)
    end
    TriggerEvent.PlayerUnit.Skill = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_SKILL)
    end
    TriggerEvent.PlayerUnit.Revivable = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVABLE)
    end
    TriggerEvent.PlayerUnit.ReviveStart = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_START)
    end
    TriggerEvent.PlayerUnit.ReviveCancel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_CANCEL)
    end
    TriggerEvent.PlayerUnit.ReviveFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_HERO_REVIVE_FINISH)
    end
    TriggerEvent.PlayerUnit.Summon = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SUMMON)
    end
    TriggerEvent.PlayerUnit.DropItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DROP_ITEM)
    end
    TriggerEvent.PlayerUnit.PickUpItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    end
    TriggerEvent.PlayerUnit.UseItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_USE_ITEM)
    end
    TriggerEvent.PlayerUnit.Loaded = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_LOADED)
    end
    TriggerEvent.PlayerUnit.Damaged = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGED)
    end
    TriggerEvent.PlayerUnit.Damaging = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_DAMAGING)
    end
    TriggerEvent.PlayerUnit.Sell = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL)
    end
    TriggerEvent.PlayerUnit.ChangeOwner = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    end
    TriggerEvent.PlayerUnit.SellItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SELL_ITEM)
    end
    TriggerEvent.PlayerUnit.SpellChannel = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    end
    TriggerEvent.PlayerUnit.SpellCast = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_CAST)
    end
    TriggerEvent.PlayerUnit.SpellEffect = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    end
    TriggerEvent.PlayerUnit.SpellFinish = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_FINISH)
    end
    TriggerEvent.PlayerUnit.SpellEndCast = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    end
    TriggerEvent.PlayerUnit.PawnItem = function(wc3_trigger, wc3_player)
        TriggerRegisterPlayerUnitEvent(wc3_trigger, wc3_player, EVENT_PLAYER_UNIT_PAWN_ITEM)
    end
    TriggerEvent.AnyUnit.Attacked = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ATTACKED)
        end
    end
    TriggerEvent.AnyUnit.Rescued = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESCUED)
        end
    end
    TriggerEvent.AnyUnit.Death = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DEATH)
        end
    end
    TriggerEvent.AnyUnit.Decay = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DECAY)
        end
    end
    TriggerEvent.AnyUnit.Detect = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DETECTED)
        end
    end
    TriggerEvent.AnyUnit.Hidden = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_HIDDEN)
        end
    end
    TriggerEvent.AnyUnit.Selected = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELECTED)
        end
    end
    TriggerEvent.AnyUnit.Deselected = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DESELECTED)
        end
    end
    TriggerEvent.AnyUnit.ConstructStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START)
        end
    end
    TriggerEvent.AnyUnit.ConstructCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
        end
    end
    TriggerEvent.AnyUnit.ConstructFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
        end
    end
    TriggerEvent.AnyUnit.UpgradeStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START)
        end
    end
    TriggerEvent.AnyUnit.Cancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
        end
    end
    TriggerEvent.AnyUnit.Finish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH)
        end
    end
    TriggerEvent.AnyUnit.TrainStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_START)
        end
    end
    TriggerEvent.AnyUnit.TrainCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL)
        end
    end
    TriggerEvent.AnyUnit.TrainFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH)
        end
    end
    TriggerEvent.AnyUnit.ResearchStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START)
        end
    end
    TriggerEvent.AnyUnit.ResearchCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
        end
    end
    TriggerEvent.AnyUnit.ResearchFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
        end
    end
    TriggerEvent.AnyUnit.IssuedOrder = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER)
        end
    end
    TriggerEvent.AnyUnit.IssuedOrderPointTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
        end
    end
    TriggerEvent.AnyUnit.IssuedOrderTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
        end
    end
    TriggerEvent.AnyUnit.IssuedOrderUnitTarget = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
        end
    end
    TriggerEvent.AnyUnit.Level = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_LEVEL)
        end
    end
    TriggerEvent.AnyUnit.Skill = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_SKILL)
        end
    end
    TriggerEvent.AnyUnit.Revivable = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVABLE)
        end
    end
    TriggerEvent.AnyUnit.ReviveStart = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_START)
        end
    end
    TriggerEvent.AnyUnit.ReviveCancel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL)
        end
    end
    TriggerEvent.AnyUnit.ReviveFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH)
        end
    end
    TriggerEvent.AnyUnit.Summon = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SUMMON)
        end
    end
    TriggerEvent.AnyUnit.DropItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM)
        end
    end
    TriggerEvent.AnyUnit.PickUpItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM)
        end
    end
    TriggerEvent.AnyUnit.UseItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_USE_ITEM)
        end
    end
    TriggerEvent.AnyUnit.Loaded = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_LOADED)
        end
    end
    TriggerEvent.AnyUnit.Damaged = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED)
        end
    end
    TriggerEvent.AnyUnit.Damaging = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_DAMAGING)
        end
    end
    TriggerEvent.AnyUnit.Sell = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL)
        end
    end
    TriggerEvent.AnyUnit.ChangeOwner = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER)
        end
    end
    TriggerEvent.AnyUnit.SellItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM)
        end
    end
    TriggerEvent.AnyUnit.SpellChannel = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL)
        end
    end
    TriggerEvent.AnyUnit.SpellCast = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST)
        end
    end
    TriggerEvent.AnyUnit.SpellEffect = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT)
        end
    end
    TriggerEvent.AnyUnit.SpellFinish = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH)
        end
    end
    TriggerEvent.AnyUnit.SpellEndCast = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST)
        end
    end
    TriggerEvent.AnyUnit.PawnItem = function(wc3_trigger)
        for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
          TriggerRegisterPlayerUnitEvent(wc3_trigger, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM)
        end
    end
    TriggerEvent.Unit.Damaged = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGED)
    end
    TriggerEvent.Unit.Damaging = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DAMAGING)
    end
    TriggerEvent.Unit.Death = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DEATH)
    end
    TriggerEvent.Unit.Decay = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DECAY)
    end
    TriggerEvent.Unit.Detected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DETECTED)
    end
    TriggerEvent.Unit.Hiden = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HIDDEN)
    end
    TriggerEvent.Unit.Selected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELECTED)
    end
    TriggerEvent.Unit.Deselected = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DESELECTED)
    end
    TriggerEvent.Unit.StateLimit = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_STATE_LIMIT)
    end
    TriggerEvent.Unit.AcquiredTarget = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ACQUIRED_TARGET)
    end
    TriggerEvent.Unit.TargetInRange = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TARGET_IN_RANGE)
    end
    TriggerEvent.Unit.Attacked = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ATTACKED)
    end
    TriggerEvent.Unit.Rescued = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESCUED)
    end
    TriggerEvent.Unit.ConstructCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_CANCEL)
    end
    TriggerEvent.Unit.ConstructFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CONSTRUCT_FINISH)
    end
    TriggerEvent.Unit.UpgradeStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_START)
    end
    TriggerEvent.Unit.UpgradeCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_CANCEL)
    end
    TriggerEvent.Unit.UpgradeFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_UPGRADE_FINISH)
    end
    TriggerEvent.Unit.TrainStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_START)
    end
    TriggerEvent.Unit.TrainCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_CANCEL)
    end
    TriggerEvent.Unit.TrainFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_TRAIN_FINISH)
    end
    TriggerEvent.Unit.ResearchStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_START)
    end
    TriggerEvent.Unit.ResearchCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_CANCEL)
    end
    TriggerEvent.Unit.ResearchFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_RESEARCH_FINISH)
    end
    TriggerEvent.Unit.IssuedOrder = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_ORDER)
    end
    TriggerEvent.Unit.IssuedOrderPoint = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_POINT_ORDER)
    end
    TriggerEvent.Unit.IssuedOrderTarget = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_ISSUED_TARGET_ORDER)
    end
    TriggerEvent.Unit.Level = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_LEVEL)
    end
    TriggerEvent.Unit.Skill = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_SKILL)
    end
    TriggerEvent.Unit.Revivable = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVABLE)
    end
    TriggerEvent.Unit.ReviveStart = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_START)
    end
    TriggerEvent.Unit.ReviveCancel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_CANCEL)
    end
    TriggerEvent.Unit.ReviveFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_HERO_REVIVE_FINISH)
    end
    TriggerEvent.Unit.Summon = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SUMMON)
    end
    TriggerEvent.Unit.DropItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_DROP_ITEM)
    end
    TriggerEvent.Unit.PickUpItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PICKUP_ITEM)
    end
    TriggerEvent.Unit.UseItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_USE_ITEM)
    end
    TriggerEvent.Unit.Loaded = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_LOADED)
    end
    TriggerEvent.Unit.Sell = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL)
    end
    TriggerEvent.Unit.ChangeOwner = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_CHANGE_OWNER)
    end
    TriggerEvent.Unit.SellItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SELL_ITEM)
    end
    TriggerEvent.Unit.SpellChannel = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CHANNEL)
    end
    TriggerEvent.Unit.SpellCast = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_CAST)
    end
    TriggerEvent.Unit.SpellEffect = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_EFFECT)
    end
    TriggerEvent.Unit.SpellFinish = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_FINISH)
    end
    TriggerEvent.Unit.SpellEndCast = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_SPELL_ENDCAST)
    end
    TriggerEvent.Unit.PawnItem = function(wc3_trigger, wc3_unit)
        TriggerRegisterUnitEvent(wc3_trigger, wc3_unit, EVENT_UNIT_PAWN_ITEM)
    end
    return TriggerEvent
end
__require_data.module["utils.trigger.TriggerAction"] = function()
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
__require_data.module["utils.DataBase"] = function()
    local DataBase = {}
    local DataBase_meta = {__index = DataBase}
    function DataBase.new(key_type, value_type)
      local db = {__key_type = key_type, __value_type = value_type}
      setmetatable(db, DataBase_meta)
      return db
    end
    function DataBase:add(key, value)
      if (type(key) ~= self.__key_type) then
        error("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
      end
      if (type(value) ~= self.__value_type) then
        error("DataBase: wrong value type. Need "..self.__value_type.." got "..type(value))
      end
      self[key] = value
    end
    function DataBase:remove(key)
      if (type(key) ~= self.__key_type) then
        error("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
      end
      self[key] = nil
    end
    function DataBase:get(key)
      if (type(key) ~= self.__key_type) then
        error("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
      end
      return self[key]
    end
    return DataBase
end
__require_data.module["utils.trigger.Trigger"] = function()
    local Settings = require("utils.Settings")
    local DataBase = require("utils.DataBase")
    local TriggerAction = require("utils.trigger.TriggerAction")
    local TriggerEvent = require("utils.trigger.TriggerEvent")
    local Trigger = {__type = "TriggerClass"}
    local Trigger_meta = {__type = "Trigger", __index = Trigger, __gc = Trigger.destroy}
    local TriggerDB = DataBase.new("userdata", type(Trigger_meta))
    function Trigger_meta.__tostring(self)
      local events = " "
      for i = 1, #self.__events do
        events = events..self.__events[i].." "
      end
      return string.format("Trigger with events: %s. Has %d action(s).", events, #self.__actions)
    end
    local function runTriggerActions()
      local self = TriggerDB:get(GetTriggeringTrigger())
      for i = 1, #self.__actions do
        local action = self.__actions[i]
        if (Settings.debug) then
          local success, result = pcall(action.run, action)
          if (not success) then
            Debug("Error in "..tostring(self))
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
      local trigger = {__trigger = wc3_trigger, __action_runner = TriggerAddAction(wc3_trigger, runTriggerActions), __actions = {}, __events = {}}
      setmetatable(trigger, Trigger_meta)
      TriggerDB:add(trigger.__trigger, trigger)
      return trigger
    end
    function Trigger:destroy()
      self:clearActions()
      DestroyTrigger(self.__trigger)
      self.__trigger = nil
    end
    function Trigger:getObj()
      return self.__trigger
    end
    function Trigger:getActions()
      return self.__actions
    end
    function Trigger:getEvents()
      return self.__events
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
      TriggerExecute(self.__trigger)
    end
    function Trigger:addEvent(event_type, event_name, player_or_unit)
      TriggerEvent[event_type][event_name](self.__trigger, player_or_unit)
      table.insert(self.__events, 1, event_type..event_name)
    end
    function Trigger:addEvent_Game(event)
      TriggerEvent.Game[event](self.__trigger)
      table.insert(self.__events, 1, "Game_"..event)
    end
    function Trigger:addEvent_Player(event, player)
      TriggerEvent.Player[event](self.__trigger, player)
      table.insert(self.__events, 1, "Player_"..event)
    end
    function Trigger:addEvent_AnyPlayer(event)
      TriggerEvent.AnyPlayer[event](self.__trigger)
      table.insert(self.__events, 1, "AnyPlayer_"..event)
    end
    function Trigger:addEvent_Unit(event, wc3_unit)
      TriggerEvent.Unit[event](self.__trigger, wc3_unit)
      table.insert(self.__events, 1, "Unit_"..event)
    end
    function Trigger:addEvent_PlayerUnit(event, player)
      TriggerEvent.PlayerUnit[event](self.__trigger, player)
      table.insert(self.__events, 1, "PlayerUnit_"..event)
    end
    function Trigger:addEvent_AnyUnit(event)
      TriggerEvent.AnyUnit[event](self.__trigger)
      table.insert(self.__events, 1, "AnyUnit_"..event)
    end
    return Trigger
end
__require_data.module["utils.trigger.events.UnitEvents"] = function()
    local Trigger = require("utils.trigger.Trigger")
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
      UnitEvent.__triggers.AnyUnitAttacked = Trigger.new()
      UnitEvent.__triggers.AnyUnitAttacked:addEvent_AnyUnit("Attacked")
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
    local Settings = {debug = true, Timer = {glTimer_period = 0.03125, run_test = false}, UnitParameters = {attack_dispersion = 0.15, value_to_get_half_cap_for_percent_value = 500}, EnabledEvents = {Unit = true, Player = true}}
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
    function runFuncInDebug(func, ...)
      if (Settings.debug) then
        local success, result = pcall(func, ...)
        if (success) then
          return result
        else
          Debug(result)
          return nil
        end
      else
        return func(...)
      end
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

      print("Wrong id format")
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
    local original_type = _G.type
    function type(val)
      local lua_type = original_type(val)
      if (lua_type ~= "table") then
        return lua_type
      end
      local meta = getmetatable(val)
      if (meta and meta.__type) then
        return meta.__type
      elseif (not meta and val.__type) then
        return val.__type
      end

      return lua_type
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
            Debug(string.format("Error in loading %s\\n%s", name, result))
          end
        end
        if (__require_data.result[name] ~= nil) then
          if (__require_data.result[name].init ~= nil) then
            local success, result = pcall(__require_data.result[name].init)
            if (not success) then
              Debug(string.format("Error in %s initialization\\n%s", name, result))
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
    require("ability.warlord.summon")
    local Unit = require("unit.Unit")
    local u = Unit.new(Player(0), "hfoo", 0, 0, 0)
    local u2 = Unit.new(Player(1), "hfoo", 0, 0, 0)
    local summon_ability = require("ability.warlord.summon")
    u:addAbility(summon_ability:getId())
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
    SetDayNightModels("Environment\\\\DNC\\\\DNCLordaeron\\\\DNCLordaeronTerrain\\\\DNCLordaeronTerrain.mdl", "Environment\\\\DNC\\\\DNCLordaeron\\\\DNCLordaeronUnit\\\\DNCLordaeronUnit.mdl")
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