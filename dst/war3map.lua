  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["player.playerEvent"] = function()
    local Trigger = require("trigger.trigger")
    local Players = require("player.player")
    local PlayerEvent = {}
    function PlayerEvent.init()
      PlayerEvent.local_mouse_move = Trigger.new()
      PlayerEvent.local_mouse_move:addEvent_PlayerMouseMove(Players.getLocalPlayerIndex())
      print("PlayerEvent initialized")
    end
    return PlayerEvent
end
__require_data.module["player.player"] = function()
    local Players = {}
    local local_player = nil
    local local_player_index = -1
    local players_array = {}
    function Players.init()
      local_player = GetLocalPlayer()
      local_player_index = player2index(local_player)
      for i = 1, bj_MAX_PLAYER_SLOTS do
        players_array[i] = Player((i-1))
      end
    end
    function Players.getLocalPlayerIndex()
      return local_player_index
    end
    function Players.forceUIKey(index, key)
      if (players_array[index] == local_player) then
        ForceUIKey(key)
      end
    end
    return Players
end
__require_data.module["ability.spiritMage.spiritRush"] = function()
    local Ability = require("ability.ability")
    local SummonSwordman = require("ability.spiritMage.summonSwordman")
    local Unit = require("unit.unit")
    local AbilityEvent = require("ability.abilityEvent")
    local timer = AbilityEvent.CastingTimer
    local Players = require("player.player")
    local PlayerEvent = require("player.playerEvent")
    local function generateDummyAbility(name, tooltip, hot_key)
      local id = WeObjEdit.Utils.nextAbilId()
      local order = WeObjEdit.Utils.nextOrderId()
      local abil = WeObjEdit.Preset.Channel.new(id, order, 1, "none", true, false, false, false, false)
      abil:setTooltipNormal(name, 1)
      abil:setTooltipNormalExtended(tooltip, 1)
      abil:setHotkeyNormal(hot_key)
      abil:setCastingTime(0, 1)
      abil:setFollowThroughTime(0, 1)
      abil:setArtDuration(0, 1)
      return id
    end
    local function generateAbility(range, cast_time, hot_key)
      local id = WeObjEdit.Utils.nextAbilId()
      local order = WeObjEdit.Utils.nextOrderId()
      local abil = WeObjEdit.Preset.Channel.new(id, order, 1, "point", true, false, false, false, false)
      abil:setCastRange(range, 1)
      abil:setHotkeyNormal(hot_key)
      abil:setCastingTime(0, 1)
      abil:setFollowThroughTime(cast_time, 1)
      abil:setArtDuration(cast_time, 1)
      return id
    end
    local ability_name = "Spirit rush"
    local ability_tooltip = "Sends all summons to target.\n"
    local range = 500
    local area = 150
    local cast_time = 0
    local base_cooldown = 0
    local hot_key = "Z"
    local dummy_id = "AM#'"
    local abil_id = "AM#("
    local moveSpeed = 30
    local movePeriod = 0.03125
    local skillAnimationBaseTime = 1
    local positios_range = 100
    local pos_offsets = {[1] = {x = 0, y = 0}, [2] = {x = positios_range, y = 0}, [3] = {x = -positios_range, y = 0}, [4] = {x = 0, y = positios_range}, [5] = {x = positios_range, y = positios_range}, [6] = {x = -positios_range, y = positios_range}, [7] = {x = 0, y = (2*positios_range)}, [8] = {x = positios_range, y = (2*positios_range)}, [9] = {x = -positios_range, y = (2*positios_range)}}
    local dummySpiritRush = Ability.new(dummy_id)
    local SpiritRush = Ability.new(abil_id)
    local circle_model = "Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl"
    function createCircules(count, x, y, caster_x, caster_y)
      local dx = (x-caster_x)
      local dy = (y-caster_y)
      local r = (((dx*dx)+(dy*dy))^0.5)
      local cos = (x/r)
      local sin = (y/r)
      local effects = {}
      for i = 1, count do
        local pos_x = ((x+(pos_offsets[i].x*sin))+(pos_offsets[i].y*cos))
        local pos_y = ((y+(pos_offsets[i].x*cos))+(pos_offsets[i].y*sin))
        effects[i] = AddSpecialEffect(circle_model, pos_x, pos_y)
      end
      return effects
    end
    local function trackingTarget(caster, effects)
      print("Tracking")
      local mouse_x = BlzGetTriggerPlayerMouseX()
      local mouse_y = BlzGetTriggerPlayerMouseY()
      local slaves = SummonSwordman.getSlaves(caster)
      local count = #slaves
      local x, y = caster:getPos()
      local new_circles = createCircules(count, mouse_x, mouse_y, x, y)
      for i = 1, #effects do
        BlzSetSpecialEffectPosition(effects[i], 0, 0, -5000)
        DestroyEffect(effects[i])
      end
      for i = 1, #new_circles do
        effects[i] = new_circles[i]
      end
      for i = (#new_circles+1), #effects do
        effects[i] = nil
      end
    end
    local function startTargeting(caster, target, x, y)
      local owner_index = caster:getOwningPlayerIndex()
      caster:removeAbility(dummySpiritRush)
      caster:addAbility(SpiritRush)
      Players.forceUIKey(owner_index, hot_key)
      local slaves = SummonSwordman.getSlaves(caster)
      local caster_x, caster_y = caster:getPos()
      local circles = createCircules(#slaves, 0, 0, caster_x, caster_y)
      PlayerEvent.local_mouse_move:addAction(function()
          trackingTarget(caster, circles)
      end)
    end
    local function moveUnit(data)
      local speed = moveSpeed
      local x, y = data.unit:getPos()
      if (speed >= data.r) then
        speed = data.r
        local u = data.unit
        u:setPos((x-(data.cos*speed)), (y-(data.sin*speed)))
        u:unpause()
        u:playAnimation("stand")
        u:setAnimationSpeed(1)
      else
        data.unit:setPos((x-(data.cos*speed)), (y-(data.sin*speed)))
        data.r = (data.r-speed)
        timer:addAction(movePeriod, moveUnit, data)
      end
    end
    local function finish(caster, target, x, y, full_time)
      local summons = SummonSwordman.getSlaves(caster)
      for i = 1, #summons do
        local u = summons[i]
        u:pause()
        u:setFacingTo(x, y)
        u:playAnimation("Attack Spell Slam")
        local u_x, u_y = u:getPos()
        local dx = (u_x-x)
        local dy = (u_y-y)
        local r = (((dx*dx)+(dy*dy))^0.5)
        local anim_time = ((r/moveSpeed)*movePeriod)
        u:setAnimationSpeed((skillAnimationBaseTime/anim_time))
        local data = {unit = u, sin = (dy/r), cos = (dx/r), r = r}
        timer:addAction(movePeriod, moveUnit, data)
      end
    end
    SpiritRush:setCallback(finish, "finish")
    SpiritRush:setName(ability_name)
    SpiritRush:setCastTime(cast_time)
    dummySpiritRush:setCallback(startTargeting, "finish")
    return dummySpiritRush
end
__require_data.module["unit.unitEvent"] = function()
    local Trigger = require("trigger.trigger")
    local UnitEvent = {}
    function UnitEvent.init()
      UnitEvent.death_trigger = Trigger.new()
      UnitEvent.death_trigger:addEvent_AnyUnitDeath()
      print("UnitEvent initialized")
    end
    return UnitEvent
end
__require_data.module["ability.spiritMage.summonSwordman"] = function()
    local Unit = require("unit.unit")
    local UnitEvent = require("unit.unitEvent")
    local Ability = require("ability.ability")
    local AbilityEvent = require("ability.abilityEvent")
    local function generateAbility(name, tooltip, range, area, cast_time, cooldown)
      local id = WeObjEdit.Utils.nextAbilId()
      local order = WeObjEdit.Utils.nextOrderId()
      local abil = WeObjEdit.Preset.Channel.new(id, order, 1, "point", true, true, false, false, false)
      abil:setTooltipNormal(name, 1)
      abil:setTooltipNormalExtended(tooltip, 1)
      abil:setCastRange(range, 1)
      abil:setAreaofEffect(area, 1)
      abil:setCastingTime(0, 1)
      abil:setFollowThroughTime(cast_time, 1)
      abil:setArtDuration(cast_time, 1)
      abil:setCooldown(cooldown, 1)
      abil:setHotkeyNormal("X")
      return id
    end
    local function generateUnit(base_id, model, abilities)
      local id = WeObjEdit.Utils.nextUnitId()
      local summon = WeObjEdit.Unit.Unit.new(id, base_id)
      summon:setModelFile(model)
      summon:setNormalAbilities(abilities)
      summon:setSpeedBase(1)
      return id
    end
    local ability_name = "Summon Swordman"
    local ability_tooltip = "Mage summons invulnerale spirit warrior.\n"
    local range = 500
    local area = 150
    local cast_time = 0
    local base_cooldown = 0
    local abil_id = "AM#&"
    local unit_model = "war3mapImported\\units\\SwordNya.mdx"
    local unit_abilities = "Avul,Aloc"
    local unit_id = "x##$"
    local SummonCrystalSwordmanAbility = Ability.new(abil_id)
    SummonCrystalSwordmanAbility:setName(ability_name)
    SummonCrystalSwordmanAbility:setCastTime(cast_time)
    SummonCrystalSwordmanAbility.SlaveToMaster = {}
    SummonCrystalSwordmanAbility.MasterToSlaves = {}
    function SummonCrystalSwordmanAbility.getSlaves(master)
      return SummonCrystalSwordmanAbility.MasterToSlaves[master]
    end
    function SummonCrystalSwordmanAbility.setSlaves(master, slaves)
      SummonCrystalSwordmanAbility.MasterToSlaves[master] = slaves
    end
    function SummonCrystalSwordmanAbility.getMaster(slave)
      return SummonCrystalSwordmanAbility.SlaveToMaster[slave]
    end
    function SummonCrystalSwordmanAbility.setMaster(slave, master)
      SummonCrystalSwordmanAbility.SlaveToMaster[slave] = master
    end
    local finish = function(caster, target, x, y, full_time)
        local owner = caster:getOwningPlayerIndex()
        local unit = Unit.new(owner, unit_id, x, y, caster:getFacing())
        unit:setVertexColor(1, 1, 1, 0.35)
        unit:applyTimedLife(10)
        SummonCrystalSwordmanAbility.setMaster(unit, caster)
        local slaves = SummonCrystalSwordmanAbility.getSlaves(caster)
        if (slaves == nil) then
          slaves = {}
        end
        table.insert(slaves, 1, unit)
        SummonCrystalSwordmanAbility.setSlaves(caster, slaves)
        unit.parameter:setAttacksPerSec(1)
    end
    SummonCrystalSwordmanAbility:setCallback(finish, "finish")
    function SummonCrystalSwordmanAbility.init()
      UnitEvent.death_trigger:addAction(function()
          local unit = GetDyingUnit()
          local dying_id = unit:getId()
          if (dying_id == ID(unit_id)) then
            local master = SummonCrystalSwordmanAbility.getMaster(unit)
            local slaves = SummonCrystalSwordmanAbility.getSlaves(master)
            SummonCrystalSwordmanAbility.setMaster(unit, nil)
            local changed_slaves = {}
            for i = 1, #slaves do
              if (slaves[i] ~= unit) then
                table.insert(changed_slaves, 1, slaves[i])
              end
            end
            if (#changed_slaves > 0) then
              SummonCrystalSwordmanAbility.setSlaves(master, changed_slaves)
            else
              SummonCrystalSwordmanAbility.setSlaves(master, nil)
            end
          end
      end)
    end
    return SummonCrystalSwordmanAbility
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
      local string_id = ID2str(unit:getId())
      local first = string_id:sub(1, 1)
      if (first == string.upper(first)) then
        parameter_container.strength = UnitParameter.new(unit, 1, ApplyParam.strength, MathParam.linear)
        parameter_container.agility = UnitParameter.new(unit, 1, ApplyParam.agility, MathParam.linear)
        parameter_container.intelligence = UnitParameter.new(unit, 1, ApplyParam.intelligence, MathParam.linear)
      end
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
    local ParameterContainer = require("unit.parameters.unitParameterContainer")
    local Ability = require("ability.ability")
    local Unit = {}
    local UnitDB = {}
    function UnitDB.add(unit)
      UnitDB[unit.unit_obj] = unit
    end
    function UnitDB.rm(unit)
      UnitDB[unit.unit_obj] = nil
    end
    function UnitDB.get(unit_obj)
      return UnitDB[unit_obj]
    end
    function Unit.new(player_id, unit_id, x, y, face)
      unit_id = ID(unit_id)
      local instance = {id = unit_id, unit_obj = CreateUnit(Player(player_id), unit_id, x, y, face)}
      setmetatable(instance, {__index = Unit})
      instance:prepareCustomData()
      UnitDB.add(instance)
      return instance
    end
    function Unit.newCorpse(player_id, unit_id, x, y, face)
      unit_id = ID(unit_id)
      local instance = {id = unit_id, unit_obj = CreateCorpse(Player(player_id), unit_id, x, y, face)}
      setmetatable(instance, {__index = Unit})
      instance:prepareCustomData()
      UnitDB.add(instance)
      return instance
    end
    function Unit:prepareCustomData()
      self.parameter = ParameterContainer.new(self)
    end
    function Unit:getId()
      return self.id
    end
    local function to_range(val, min, max)
      if (val < min) then
        return min
      end
      if (val > max) then
        return max
      end
      return val
    end
    function Unit:setVertexColor(red, green, blue, alpha)
      red = math.floor((255*to_range(red, 0, 1)))
      green = math.floor((255*to_range(green, 0, 1)))
      blue = math.floor((255*to_range(blue, 0, 1)))
      alpha = math.floor((255*to_range(alpha, 0, 1)))
      SetUnitVertexColor(self.unit_obj, red, green, blue, alpha)
    end
    function Unit:getOwningPlayerIndex()
      return player2index(GetOwningPlayer(self.unit_obj))
    end
    function Unit:setPos(x, y)
      SetUnitX(self.unit_obj, x)
      SetUnitY(self.unit_obj, y)
    end
    function Unit:getPos()
      return GetUnitX(self.unit_obj), GetUnitY(self.unit_obj)
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
    return Unit
end
__require_data.module["utils.timer"] = function()
    local Timer = {}
    local TimersDB = {}
    local function period()
      local wc_timer = GetExpiredTimer()
      local timer_data = TimersDB[wc_timer]
      timer_data.cur_time = (timer_data.cur_time+timer_data.precision)
      local cur_time = timer_data.cur_time
      local cur_list = timer_data.actions
      local remove_list = timer_data.to_remove
      timer_data.actions = {}
      timer_data.to_remove = {}
      for i = 1, #cur_list do
        local action = cur_list[i]
        local removed = false
        for j = 1, #remove_list do
          if (action == remove_list[j]) then
            removed = true
            break
          end
        end
        if (cur_time >= action.time and not removed) then
          action.callback(action.user_data)
        end
      end
    end
    function Timer.new(precision)
      local wc_timer = CreateTimer()
      local timer_data = {cur_time = 0, precision = precision or 0.25, actions = {}, to_remove = {}}
      setmetatable(timer_data, {__index = Timer})
      TimersDB[wc_timer] = timer_data
      TimerStart(wc_timer, precision, true, period)
      return timer_data
    end
    function Timer:addAction(delay, callback, user_data)
      local action = {time = (self.cur_time+delay), callback = callback, user_data = user_data, period = period}
      table.insert(self.actions, 1, action)
    end
    function Timer:removeAction(action)
      table.insert(self.to_remove, 1, action)
    end
    return Timer
end
__require_data.module["ability.ability"] = function()
    local Timer = require("utils.timer")
    local Trigger = require("trigger.trigger")
    local Ability = {}
    local Ability_meta = {__index = Ability}
    local AbilityDB = {}
    function Ability.new(id)
      id = ID(id)
      local ability = {id = id, _start = function()
  return true
end, _casting = function()
  return true
end, _interrupt = function()

end, _finish = function()

end}
      setmetatable(ability, Ability_meta)
      AbilityDB[id] = ability
      return ability
    end
    function Ability.getAbility(id)
      id = ID(id)
      if (id) then
        return AbilityDB[id]
      end
      return nil
    end
    function Ability:getId()
      return self.id
    end
    function Ability:setCallback(callback, type)
      if (type == "start") then
        self._start = callback
      end
      if (type == "casting") then
        self._casting = callback
      end
      if (type == "interrupt") then
        self._interrupt = callback
      end
      if (type == "finish") then
        self._finish = callback
      end
    end
    function Ability:runCallback(type, ...)
      if (type == "start") then
        return self._start(...)
      end
      if (type == "casting") then
        return self._casting(...)
      end
      if (type == "interrupt") then
        return self._interrupt(...)
      end
      if (type == "finish") then
        return self._finish(...)
      end
    end
    function Ability:setCastTime(cast_time)
      self.cast_time = cast_time
    end
    function Ability:getCastTime(caster)
      if (type(self.cast_time) == "number") then
        return self.cast_time
      elseif (type(self.cast_time) == "function") then
        return self.cast_time(caster)
      end

      return 0
    end
    function Ability:setName(name)
      self.name = name
    end
    function Ability:getName()
      if (type(self.name) == "string") then
        return self.name
      elseif (type(self.name) == "function") then
        return self.name()
      end

      return ""
    end
    function Ability:setTooltip(tooltip, lvl, player_index)
      if (player_index == nil) then
        BlzSetAbilityTooltip(self.id, tooltip, lvl)
        return nil
      end
      local local_player_index = player2index(GetLocalPlayer())
      if (player_index == local_player_index) then
        BlzSetAbilityTooltip(self.id, tooltip, lvl)
      end
    end
    function Ability:setExtendedTooltip(ext_tooltip, lvl, player_index)
      if (player_index == nil) then
        BlzSetAbilityExtendedTooltip(self.id, ext_tooltip, lvl)
        return nil
      end
      local local_player_index = player2index(GetLocalPlayer())
      if (player_index == local_player_index) then
        BlzSetAbilityExtendedTooltip(self.id, ext_tooltip, lvl)
      end
    end
    function Ability:setIcon(icon_path, player_index)
      if (player_index == nil) then
        BlzSetAbilityIcon(self.id, icon_path)
        return nil
      end
      local local_player_index = player2index(GetLocalPlayer())
      if (player_index == local_player_index) then
        BlzSetAbilityIcon(self.id, icon_path)
      end
    end
    function Ability:setPosition(x, y, player_index)
      if (player_index == nil) then
        BlzSetAbilityPosX(self.id, x)
        BlzSetAbilityPosY(self.id, y)
        return nil
      end
      local local_player_index = player2index(GetLocalPlayer())
      if (player_index == local_player_index) then
        BlzSetAbilityPosX(self.id, x)
        BlzSetAbilityPosY(self.id, y)
      end
    end
    return Ability
end
__require_data.module["ability.abilityEvent"] = function()
    local Ability = require("ability.ability")
    local Timer = require("utils.timer")
    local Trigger = require("trigger.trigger")
    local AbilityEvent = {}
    local CasterDB = {}
    local timer_precision = 0.05
    AbilityEvent.CastingTimer = nil
    function AbilityEvent.init()
      AbilityEvent.CastingTimer = Timer.new(timer_precision)
      local casting_trigger = Trigger.new()
      casting_trigger:addEvent_AnyUnitSpellChannel()
      casting_trigger:addAction(AbilityEvent.startCast)
      local trigger = Trigger.new()
      trigger:addEvent_AnyUnitIssuedOrder()
      trigger:addEvent_AnyUnitIssuedOrderTarget()
      trigger:addEvent_AnyUnitIssuedOrderPointTarget()
      trigger:addEvent_AnyUnitIssuedOrderUnitTarget()
      trigger:addAction(function()
          CasterDB[GetOrderedUnit()] = nil
      end)
      print("Abilities events initialized")
    end
    local function generateDataForCast(ability, caster, target, x, y)
      local casting_data = {ability = ability, caster = caster, target = target, x = x, y = y, time = 0, full_time = ability:getCastTime(caster)}
      local unit_data = {ability = ability, time = 0, full_time = casting_data.full_time}
      return casting_data, unit_data
    end
    function AbilityEvent.startCast()
      local ability = Ability.getAbility(GetSpellAbilityId())
      if (ability == nil) then
        return nil
      end
      local target = GetSpellTargetUnit()
      if (target == nil) then
        target = GetSpellTargetItem()
      end
      if (target == nil) then
        target = GetSpellTargetDestructable()
      end
      local caster = GetSpellAbilityUnit()
      local x = GetSpellTargetX()
      local y = GetSpellTargetY()
      local continue = ability:runCallback("start", caster, target, x, y)
      if (not continue) then
        return nil
      end
      local casting_data, unit_data = generateDataForCast(ability, caster, target, x, y)
      AbilityEvent.CastingTimer:addAction(timer_precision, AbilityEvent.timerPeriod, casting_data)
      CasterDB[caster] = unit_data
    end
    function AbilityEvent.timerPeriod(data)
      local ability = data.ability
      local caster_data = CasterDB[data.caster]
      if (caster_data == nil) then
        ability:runCallback("interrupt", data.caster, data.target, data.x, data.y, data.time, data.full_time)
        CasterDB[data.caster] = nil
        return nil
      end
      local cur_ability = caster_data.ability
      local cur_time = caster_data.time
      if (cur_ability ~= data.ability or cur_time ~= data.time) then
        ability:runCallback("interrupt", data.caster, data.target, data.x, data.y, data.time, data.full_time)
        CasterDB[data.caster] = nil
        return nil
      end
      data.time = (data.time+timer_precision)
      if (data.time >= data.full_time) then
        ability:runCallback("finish", data.caster, data.target, data.x, data.y, data.full_time)
        CasterDB[data.caster] = nil
        return nil
      end
      CasterDB[data.caster].time = data.time
      local continue = ability:runCallback("casting", data.caster, data.target, data.x, data.y, data.time, data.full_time)
      if (continue) then
        AbilityEvent.CastingTimer:addAction(timer_precision, AbilityEvent.timerPeriod, data)
      else
        ability:runCallback("interrupt", data.caster, data.target, data.x, data.y, data.time, data.full_time)
        CasterDB[data.caster] = nil
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
__require_data.module["trigger.trigger"] = function()
    local Trigger = {}
    local Trigger_meta = {__index = Trigger}
    function Trigger.new()
      local trigger = {trigger_obj = CreateTrigger(), actions = {}}
      setmetatable(trigger, Trigger_meta)
      return trigger
    end
    function Trigger:addAction(callback)
      local action = TriggerAddAction(self.trigger_obj, callback)
      self.actions[callback] = action
    end
    function Trigger:removeAction(callback)
      local action = self.actions[callback]
      self.actions[callback] = nil
      TriggerRemoveAction(self.trigger_obj, action)
    end
    function Trigger:clearActions()
      for callback, action in pairs(self.actions) do
        TriggerRemoveAction(self.trigger_obj, action)
        self.actions[callback] = nil
      end
    end
    function Trigger:execute()
      TriggerExecute(self.trigger_obj)
    end
    function Trigger:addEvent_GameVictory()
      TriggerRegisterGameEvent(self, EVENT_GAME_VICTORY)
    end
    function Trigger:addEvent_GameEnd()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_END_LEVEL)
    end
    function Trigger:addEvent_GameVariableLimit()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_VARIABLE_LIMIT)
    end
    function Trigger:addEvent_GameStateLimit()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_STATE_LIMIT)
    end
    function Trigger:addEvent_GameTimerExpired()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TIMER_EXPIRED)
    end
    function Trigger:addEvent_GameEnterRegion()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_ENTER_REGION)
    end
    function Trigger:addEvent_GameLeaveRegion()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_LEAVE_REGION)
    end
    function Trigger:addEvent_GameTrackableHit()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TRACKABLE_HIT)
    end
    function Trigger:addEvent_GameTrackableTrack()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TRACKABLE_TRACK)
    end
    function Trigger:addEvent_GameShowSkill()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_SHOW_SKILL)
    end
    function Trigger:addEvent_GameBuildSubmenu()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_BUILD_SUBMENU)
    end
    function Trigger:addEvent_GameLoaded()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_LOADED)
    end
    function Trigger:addEvent_GameTournamentFinishSoon()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TOURNAMENT_FINISH_SOON)
    end
    function Trigger:addEvent_GameTournamentFinishNow()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_TOURNAMENT_FINISH_NOW)
    end
    function Trigger:addEvent_GameSave()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_SAVE)
    end
    function Trigger:addEvent_GameCustomUIFrame()
      TriggerRegisterGameEvent(self.trigger_obj, EVENT_GAME_CUSTOM_UI_FRAME)
    end
    function Trigger:addEvent_PlayerStateLimit(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_STATE_LIMIT)
    end
    function Trigger:addEvent_PlayerAllianceChanged(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ALLIANCE_CHANGED)
    end
    function Trigger:addEvent_PlayerDefeat(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_DEFEAT)
    end
    function Trigger:addEvent_PlayerVictory(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_VICTORY)
    end
    function Trigger:addEvent_PlayerLeave(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_LEAVE)
    end
    function Trigger:addEvent_PlayerChat(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_CHAT)
    end
    function Trigger:addEvent_PlayerEndCinematic(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_END_CINEMATIC)
    end
    function Trigger:addEvent_PlayerArrowLeft_Down(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_LEFT_DOWN)
    end
    function Trigger:addEvent_PlayerArrowLeft_Up(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_LEFT_UP)
    end
    function Trigger:addEvent_PlayerArrowRight_Down(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_RIGHT_DOWN)
    end
    function Trigger:addEvent_PlayerArrowRight_Up(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_RIGHT_UP)
    end
    function Trigger:addEvent_PlayerArrowDown_Down(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_DOWN_DOWN)
    end
    function Trigger:addEvent_PlayerArrowDown_Up(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_DOWN_UP)
    end
    function Trigger:addEvent_PlayerArrowUp_Down(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_UP_DOWN)
    end
    function Trigger:addEvent_PlayerArrowUp_Up(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_ARROW_UP_UP)
    end
    function Trigger:addEvent_PlayerMouseDown(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_MOUSE_DOWN)
    end
    function Trigger:addEvent_PlayerMouseUp(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_MOUSE_UP)
    end
    function Trigger:addEvent_PlayerMouseMove(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_MOUSE_MOVE)
    end
    function Trigger:addEvent_PlayerSyncData(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_SYNC_DATA)
    end
    function Trigger:addEvent_PlayerKey(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_KEY)
    end
    function Trigger:addEvent_PlayerKeyDown(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_KEY_DOWN)
    end
    function Trigger:addEvent_PlayerKeyUp(player_index)
      TriggerRegisterPlayerEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_KEY_UP)
    end
    function Trigger:addEvent_AnyUnitAttacked()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ATTACKED)
      end
    end
    function Trigger:addEvent_AnyUnitResqued()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESCUED)
      end
    end
    function Trigger:addEvent_AnyUnitDeath()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DEATH)
      end
    end
    function Trigger:addEvent_AnyUnitDecay()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DECAY)
      end
    end
    function Trigger:addEvent_AnyUnitDetect()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DETECTED)
      end
    end
    function Trigger:addEvent_AnyUnitHidden()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_HIDDEN)
      end
    end
    function Trigger:addEvent_AnyUnitSelected()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELECTED)
      end
    end
    function Trigger:addEvent_AnyUnitDeselected()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DESELECTED)
      end
    end
    function Trigger:addEvent_AnyUnitConstructStart()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_START)
      end
    end
    function Trigger:addEvent_AnyUnitConstructCancel()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
      end
    end
    function Trigger:addEvent_AnyUnitConstructFinish()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
      end
    end
    function Trigger:addEvent_AnyUnitUpgradeStart()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_START)
      end
    end
    function Trigger:addEvent_AnyUnitCancel()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
      end
    end
    function Trigger:addEvent_AnyUnitFinish()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_UPGRADE_FINISH)
      end
    end
    function Trigger:addEvent_AnyUnitTrainStart()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_START)
      end
    end
    function Trigger:addEvent_AnyUnitTrainCancel()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_CANCEL)
      end
    end
    function Trigger:addEvent_AnyUnitTrainFinish()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_TRAIN_FINISH)
      end
    end
    function Trigger:addEvent_AnyUnitResearchStart()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_START)
      end
    end
    function Trigger:addEvent_AnyUnitResearchCancel()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
      end
    end
    function Trigger:addEvent_AnyUnitResearchFinish()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
      end
    end
    function Trigger:addEvent_AnyUnitIssuedOrder()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER)
      end
    end
    function Trigger:addEvent_AnyUnitIssuedOrderPointTarget()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
      end
    end
    function Trigger:addEvent_AnyUnitIssuedOrderTarget()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
      end
    end
    function Trigger:addEvent_AnyUnitIssuedOrderUnitTarget()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
      end
    end
    function Trigger:addEvent_AnyHeroLevel()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_LEVEL)
      end
    end
    function Trigger:addEvent_AnyHeroSkill()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_SKILL)
      end
    end
    function Trigger:addEvent_AnyHeroRevivable()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVABLE)
      end
    end
    function Trigger:addEvent_AnyHeroReviveStart()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_START)
      end
    end
    function Trigger:addEvent_AnyHeroReviveCance()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_CANCEL)
      end
    end
    function Trigger:addEvent_AnyHeroReviveFinish()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_HERO_REVIVE_FINISH)
      end
    end
    function Trigger:addEvent_AnyUnitSummon()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SUMMON)
      end
    end
    function Trigger:addEvent_AnyUnitDropItem()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM)
      end
    end
    function Trigger:addEvent_AnyUnitPickUpItem()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM)
      end
    end
    function Trigger:addEvent_AnyUnitUseItem()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_USE_ITEM)
      end
    end
    function Trigger:addEvent_AnyUnitLoaded()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_LOADED)
      end
    end
    function Trigger:addEvent_AnyUnitDamaged()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DAMAGED)
      end
    end
    function Trigger:addEvent_AnyUnitDamaging()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_DAMAGING)
      end
    end
    function Trigger:addEvent_AnyUnitSell()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELL)
      end
    end
    function Trigger:addEvent_AnyUnitChangeOwner()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_CHANGE_OWNER)
      end
    end
    function Trigger:addEvent_AnyUnitSellItem()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SELL_ITEM)
      end
    end
    function Trigger:addEvent_AnyUnitSpellChannel()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL)
      end
    end
    function Trigger:addEvent_AnyUnitSpellCast()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST)
      end
    end
    function Trigger:addEvent_AnyUnitSpellEffect()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT)
      end
    end
    function Trigger:addEvent_AnyUnitSpellFinish()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH)
      end
    end
    function Trigger:addEvent_AnyUnitSpellEndCast()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST)
      end
    end
    function Trigger:addEvent_AnyUnitPawnItem()
      for i = 0, (bj_MAX_PLAYER_SLOTS-1) do
        TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(i), EVENT_PLAYER_UNIT_PAWN_ITEM)
      end
    end
    function Trigger:addEvent_PlayerUnitAttacked(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ATTACKED)
    end
    function Trigger:addEvent_PlayerUnitResqued(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_RESCUED)
    end
    function Trigger:addEvent_PlayerUnitDeath(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DEATH)
    end
    function Trigger:addEvent_PlayerUnitDecay(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DECAY)
    end
    function Trigger:addEvent_PlayerUnitDeath(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DETECTED)
    end
    function Trigger:addEvent_PlayerUnitHidden(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_HIDDEN)
    end
    function Trigger:addEvent_PlayerUnitSelected(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SELECTED)
    end
    function Trigger:addEvent_PlayerUnitDeselected(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DESELECTED)
    end
    function Trigger:addEvent_PlayerUnitConstructStart(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_CONSTRUCT_START)
    end
    function Trigger:addEvent_PlayerUnitConstructCancel(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    end
    function Trigger:addEvent_PlayerUnitConstructFinish(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    end
    function Trigger:addEvent_PlayerUnitUpgradeStart(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_UPGRADE_START)
    end
    function Trigger:addEvent_PlayerUnitCancel(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    end
    function Trigger:addEvent_PlayerUnitFinish(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    end
    function Trigger:addEvent_PlayerUnitTrainStart(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_TRAIN_START)
    end
    function Trigger:addEvent_PlayerUnitTrainCancel(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    end
    function Trigger:addEvent_PlayerUnitTrainFinish(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_TRAIN_FINISH)
    end
    function Trigger:addEvent_PlayerUnitResearchStart(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_RESEARCH_START)
    end
    function Trigger:addEvent_PlayerUnitResearchCancel(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    end
    function Trigger:addEvent_PlayerUnitResearchFinish(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    end
    function Trigger:addEvent_PlayerUnitIssuedOrder(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ISSUED_ORDER)
    end
    function Trigger:addEvent_PlayerUnitIssuedOrderPointTartet(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    end
    function Trigger:addEvent_PlayerUnitIssuedOrderTarget(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    end
    function Trigger:addEvent_PlayerUnitIssuedOrderUnitTarget(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    end
    function Trigger:addEvent_PlayerHeroLevel(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_LEVEL)
    end
    function Trigger:addEvent_PlayerHeroSkill(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_SKILL)
    end
    function Trigger:addEvent_PlayerHeroRevivable(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_REVIVABLE)
    end
    function Trigger:addEvent_PlayerHeroReviveStart(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_REVIVE_START)
    end
    function Trigger:addEvent_PlayerHeroReviveCance(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_REVIVE_CANCEL)
    end
    function Trigger:addEvent_PlayerHeroReviveFinish(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_HERO_REVIVE_FINISH)
    end
    function Trigger:addEvent_PlayerUnitSummon(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SUMMON)
    end
    function Trigger:addEvent_PlayerUnitDropItem(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DROP_ITEM)
    end
    function Trigger:addEvent_PlayerUnitPickUpItem(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_PICKUP_ITEM)
    end
    function Trigger:addEvent_PlayerUnitUseItem(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_USE_ITEM)
    end
    function Trigger:addEvent_PlayerUnitLoaded(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_LOADED)
    end
    function Trigger:addEvent_PlayerUnitDamaged(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DAMAGED)
    end
    function Trigger:addEvent_PlayerUnitDamaging(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_DAMAGING)
    end
    function Trigger:addEvent_PlayerUnitSell(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SELL)
    end
    function Trigger:addEvent_PlayerUnitChangeOwner(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_CHANGE_OWNER)
    end
    function Trigger:addEvent_PlayerUnitSellItem(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SELL_ITEM)
    end
    function Trigger:addEvent_PlayerUnitSpellChannel(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    end
    function Trigger:addEvent_PlayerUnitSpellCast(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_CAST)
    end
    function Trigger:addEvent_PlayerUnitSpellEffect(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_EFFECT)
    end
    function Trigger:addEvent_PlayerUnitSpellFinish(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_FINISH)
    end
    function Trigger:addEvent_PlayerUnitSpellEndCast(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    end
    function Trigger:addEvent_PlayerUnitPawnItem(player_index)
      TriggerRegisterPlayerUnitEvent(self.trigger_obj, Player(player_index), EVENT_PLAYER_UNIT_PAWN_ITEM)
    end
    function Trigger:addEvent_UnitDamaged(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DAMAGED)
    end
    function Trigger:addEvent_UnitDamaging(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DAMAGING)
    end
    function Trigger:addEvent_UnitDeath(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DEATH)
    end
    function Trigger:addEvent_UnitDecay(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DECAY)
    end
    function Trigger:addEvent_UnitDetected(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DETECTED)
    end
    function Trigger:addEvent_UnitHiden(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HIDDEN)
    end
    function Trigger:addEvent_UnitSelected(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SELECTED)
    end
    function Trigger:addEvent_UnitDeselected(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DESELECTED)
    end
    function Trigger:addEvent_UnitStateLimit(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_STATE_LIMIT)
    end
    function Trigger:addEvent_UnitAcquiredTarget(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ACQUIRED_TARGET)
    end
    function Trigger:addEvent_UnitTargetInRange(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_TARGET_IN_RANGE)
    end
    function Trigger:addEvent_UnitAttacked(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ATTACKED)
    end
    function Trigger:addEvent_UnitResqued(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_RESCUED)
    end
    function Trigger:addEvent_UnitConstructCancel(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_CONSTRUCT_CANCEL)
    end
    function Trigger:addEvent_UnitConstructFinish(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_CONSTRUCT_FINISH)
    end
    function Trigger:addEvent_UnitUpgradeStart(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_START)
    end
    function Trigger:addEvent_UnitUpgradeCancel(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_CANCEL)
    end
    function Trigger:addEvent_UnitUpgradeFinish(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_UPGRADE_FINISH)
    end
    function Trigger:addEvent_UnitTrainStart(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_START)
    end
    function Trigger:addEvent_UnitTrainCancel(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_CANCEL)
    end
    function Trigger:addEvent_UnitTrainFinish(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_TRAIN_FINISH)
    end
    function Trigger:addEvent_UnitResearchStart(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_START)
    end
    function Trigger:addEvent_UnitResearchCancel(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_CANCEL)
    end
    function Trigger:addEvent_UnitResearchFinish(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_RESEARCH_FINISH)
    end
    function Trigger:addEvent_UnitIssuedOrder(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_ORDER)
    end
    function Trigger:addEvent_UnitIssuedOrderPoint(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_POINT_ORDER)
    end
    function Trigger:addEvent_UnitIssuedOrderTarget(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_ISSUED_TARGET_ORDER)
    end
    function Trigger:addEvent_HeroLevel(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_LEVEL)
    end
    function Trigger:addEvent_HeroSkill(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_SKILL)
    end
    function Trigger:addEvent_HeroRevivable(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVABLE)
    end
    function Trigger:addEvent_HeroReviveStart(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_START)
    end
    function Trigger:addEvent_HeroReviveCancel(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_CANCEL)
    end
    function Trigger:addEvent_HeroReviveFinish(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_HERO_REVIVE_FINISH)
    end
    function Trigger:addEvent_UnitSummon(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SUMMON)
    end
    function Trigger:addEvent_UnitDropItem(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_DROP_ITEM)
    end
    function Trigger:addEvent_UnitPickUpItem(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_PICKUP_ITEM)
    end
    function Trigger:addEvent_UnitUseItem(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_USE_ITEM)
    end
    function Trigger:addEvent_UnitLoaded(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_LOADED)
    end
    function Trigger:addEvent_UnitSell(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SELL)
    end
    function Trigger:addEvent_UnitChangeOwner(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_CHANGE_OWNER)
    end
    function Trigger:addEvent_UnitSellItem(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SELL_ITEM)
    end
    function Trigger:addEvent_UnitSpellChannel(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_CHANNEL)
    end
    function Trigger:addEvent_UnitSpellCast(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_CAST)
    end
    function Trigger:addEvent_UnitSpellEffect(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_EFFECT)
    end
    function Trigger:addEvent_UnitSpellFinish(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_FINISH)
    end
    function Trigger:addEvent_UnitSpellEndCast(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_SPELL_ENDCAST)
    end
    function Trigger:addEvent_UnitPawnItem(unit)
      TriggerRegisterUnitEvent(self.trigger_obj, unit.unit_obj, EVENT_UNIT_PAWN_ITEM)
    end
    function Trigger:addEvent_Dialog(dialog)
      TriggerRegisterDialogEvent(self.trigger_obj, dialog)
    end
    function Trigger:addEvent_DialogButtonClicked(button)
      TriggerRegisterDialogButtonEvent(self.trigger_obj, button)
    end
    return Trigger
end
__require_data.module["player.unitsSelected"] = function()
    local Trigger = require("trigger.trigger")
    local SelectedUnits = {}
    function SelectedUnits.init()
      for i = 0, bj_MAX_PLAYER_SLOTS do
        SelectedUnits[i] = {}
      end
      local select_trigger = Trigger.new()
      select_trigger:addEvent_AnyUnitSelected()
      select_trigger:addAction(function()
          local unit = GetTriggerUnit()
          local player_index = player2index(GetTriggerPlayer())
          found = false
          for _, cur in pairs(SelectedUnits[player_index]) do
            if (unit == cur) then
              found = true
              break
            end
          end
          if (not found) then
            table.insert(SelectedUnits[player_index], 1, unit)
          end
      end)
      local deselect_trigger = Trigger.new()
      deselect_trigger:addEvent_AnyUnitDeselected()
      deselect_trigger:addAction(function()
          local unit = GetTriggerUnit()
          local owner_index = unit:getOwningPlayerIndex()
          local new_list = {}
          for i = 1, #SelectedUnits[owner_index] do
            if (not SelectedUnits[owner_index][i] == unit) then
              table.insert(new_list, 1, SelectedUnits[owner_index][i])
            end
          end
          SelectedUnits[owner_index] = new_list
      end)
      print("Unit selection initialized")
    end
    function SelectedUnits.get(player_index)
      return SelectedUnits[player_index]
    end
    function SelectedUnits.count(player_index)
      return #SelectedUnits[player_index]
    end
    return SelectedUnits
end
__require_data.module["interface.frames.castBar"] = function()
    local SelectedUnits = require("player.unitsSelected")
    local AbilityEvent = require("ability.abilityEvent")
    local castBar = {}
    function castBar.init()
      local toc_file = "war3mapImported\\frame_files\\MyBar.toc"
      if (not BlzLoadTOCFile(toc_file)) then
        print("Error in "..toc_file)
        print(getErrorPos())
      end
      print("CastBar")
      local castProgressBar = BlzCreateSimpleFrame("MyBarEx", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 1)
      local castProgressBarText = BlzGetFrameByName("MyBarExText", 1)
      BlzFrameSetAbsPoint(castProgressBar, FRAMEPOINT_CENTER, 0.3, 0.15)
      BlzFrameSetSize(castProgressBar, 0.17, 0.02)
      BlzFrameSetValue(castProgressBar, 50)
      BlzFrameSetTexture(castProgressBar, "Replaceabletextures\\Teamcolor\\Teamcolor01.blp", 0, true)
      BlzFrameSetText(castProgressBarText, "Cast")
      BlzFrameSetVisible(castProgressBar, false)
      print("Cast bar init done")
      local function update()
        local player_index = player2index(GetLocalPlayer())
        local selected_units = SelectedUnits.get(player_index)
        if (#selected_units ~= 1) then
          BlzFrameSetVisible(castProgressBar, false)
          return nil
        end
        local unit = selected_units[1]
        local ability, time, full_time = AbilityEvent.getUnitCastingData(unit)
        if (time >= 0) then
          BlzFrameSetValue(castProgressBar, ((100*time)/full_time))
          BlzFrameSetText(castProgressBarText, ability:getName())
          BlzFrameSetVisible(castProgressBar, true)
        else
          BlzFrameSetVisible(castProgressBar, false)
        end
      end
      local trigger2 = CreateTrigger()
      TriggerRegisterTimerEvent(trigger2, 0.05, true)
      TriggerAddAction(trigger2, update)
      print("CastingBar initialized.")
    end
    return castBar
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
          print(name)
          __require_data.result[name].init()
        end
      end
      print("Initialisation finished")
    end
    return Init
end
__require_data.module["utils.utils"] = function()
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
          if (t == "integer" or t == "number" or t == "table") then
            v = tostring(v)
          elseif (t == "nil") then
            v = "Nil"
          elseif (t == "userdata") then
            v = "userdata"
          elseif (type(v) ~= "string") then
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
    Init.start()
    require("interface.frames.castBar")
    local Unit = require("unit.unit")
    local u = Unit.new(0, "hfoo", 0, 0, 0)
    local summon_abil = require("ability.spiritMage.summonSwordman")
    local rush_abil = require("ability.spiritMage.spiritRush")
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