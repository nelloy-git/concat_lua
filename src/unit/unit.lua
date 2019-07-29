local Param = require('unit.parameters.parameter')
local ApplyParam = require('unit.parameters.applyParam')
local MathParam = require('unit.parameters.mathParam')

local Unit = {
    unit = nil
}

local UnitDB = {}
function UnitDB.add(unit_struct) UnitDB[unit_struct.unit] = unit_struct end
function UnitDB.rm(unit_struct) UnitDB[unit_struct.unit] = nil end
function UnitDB.get(unit) return UnitDB[unit] end

function Unit.new(player_id, unit_id, x, y, face)
    unit_id = ID(unit_id)

    local instance = {
        id = id2str(unit_id),
        unit = CreateUnit(Player(player_id), unit_id, x, y, face)
    }
    setmetatable(instance, {__index = Unit})

    instance:prepareCustomData()
    UnitDB.add(instance)

    return instance
end

function Unit.newCorpse(player_id, unit_id, x, y, face)
    unit_id = ID(unit_id)

    local instance = {
        id = id2str(unit_id),
        unit = CreateCorpse(Player(player_id), unit_id, x, y, face)
    }
    setmetatable(instance, {__index = Unit})

    instance:prepareCustomData()
    UnitDB.add(instance)

    return instance
end

function Unit:prepareCustomData()
    self:prepareParameters()
end

function Unit:prepareParameters()
    local parameters = {
        attack = Param.new(self, 1, ApplyParam.attack, MathParam.linear),
        attackSpeed = Param.new(self, 2, ApplyParam.attackSpeed, MathParam.inverseLinear),
        armor = Param.new(self, 0, ApplyParam.armor, MathParam.linear),

        spellPower = Param.new(self, 0, ApplyParam.spellPower, MathParam.linear),
        castSpeed = Param.new(self, 0, ApplyParam.castSpeed, MathParam.inversePercent, 75), -- For inversed percent real cap = 100 - cap
        resistance = Param.new(self, 0, ApplyParam.resistance, MathParam.percent, 90),

        health = Param.new(self, 100, ApplyParam.health, MathParam.linear),
        regeneration = Param.new(self, 0, ApplyParam.regeneration, MathParam.linear),
        mana = Param.new(self, 100, ApplyParam.mana, MathParam.linear),
        recovery = Param.new(self, 0, ApplyParam.recovery, MathParam.linear),

        critChance = Param.new(self, 0, ApplyParam.critChance, MathParam.percent, 100),
        critPower = Param.new(self, 1, ApplyParam.critPower, MathParam.linear),
        dodge = Param.new(self, 0, ApplyParam.dodgeChance, MathParam.percent, 75),
        cooldown = Param.new(self, 0, ApplyParam.cooldown, MathParam.percent, 75),
    }

    -- Add hero stats
    if self.id:sub(1,1) == string.upper(self.id:sub(1,1)) then
        parameters.strength = Param.new(self, 0, ApplyParam.strength, MathParam.linear)
        parameters.agility = Param.new(self, 0, ApplyParam.agility, MathParam.linear)
        parameters.intelligence = Param.new(self, 0, ApplyParam.intelligence, MathParam.linear)
    end

    self.parameters = parameters
end

-- Attack
function Unit:setAttack(base, mult, bonus) self.parameters.attack:set(base, mult, bonus) end
function Unit:addAttack(base, mult, bonus) self.parameters.attack:add(base, mult, bonus) end
function Unit:getAttack() return self.parameters.attack:get() end

-- Attack speed
function Unit:setAttackSpeed(base, mult, bonus) self.parameters.attackSpeed:set(base, mult, bonus) end
function Unit:addAttackSpeed(base, mult, bonus) self.parameters.attackSpeed:add(base, mult, bonus) end
function Unit:getAttackSpeed() return self.parameters.attackSpeed:get() end

-- Armor
function Unit:setArmor(base, mult, bonus) self.parameters.armor:set(base, mult, bonus) end
function Unit:addArmor(base, mult, bonus) self.parameters.armor:add(base, mult, bonus) end
function Unit:getArmor() return self.parameters:get() end

-- Spell power
function Unit:setSpellPower(base, mult, bonus) self.parameters.spellPower:set(base, mult, bonus) end
function Unit:addSpellPower(base, mult, bonus) self.parameters.spellPower:add(base, mult, bonus) end
function Unit:getSpellPower() return self.parameters.spellPower:get() end

-- Cast speed
function Unit:setCastSpeed(base, mult, bonus) self.parameters.castSpeed:set(base, mult, bonus) end
function Unit:addCastSpeed(base, mult, bonus) self.parameters.castSpeed:add(base, mult, bonus) end
function Unit:getCastSpeed() return self.parameters.castSpeed:get() end

-- Cast speed
function Unit:setCastSpeed(base, mult, bonus) self.parameters.castSpeed:set(base, mult, bonus) end
function Unit:addCastSpeed(base, mult, bonus) self.parameters.castSpeed:add(base, mult, bonus) end
function Unit:getCastSpeed() return self.parameters.castSpeed:get() end

-- Resistance
function Unit:setResistance(base, mult, bonus) self.parameters.resistance:set(base, mult, bonus) end
function Unit:addResistance(base, mult, bonus) self.parameters.resistance:add(base, mult, bonus) end
function Unit:getResistance() return self.parameters.resistance:get() end

-- Health
function Unit:setHealth(base, mult, bonus) self.parameters.health:set(base, mult, bonus) end
function Unit:addHealth(base, mult, bonus) self.parameters.health:add(base, mult, bonus) end
function Unit:getHealth() return self.parameters.health:get() end

-- Regeneration
function Unit:setRegeneration(base, mult, bonus) self.parameters.regeneration:set(base, mult, bonus) end
function Unit:addRegeneration(base, mult, bonus) self.parameters.regeneration:add(base, mult, bonus) end
function Unit:getRegeneration() return self.parameters.regeneration:get() end

-- Mana
function Unit:setMana(base, mult, bonus) self.parameters.mana:set(base, mult, bonus) end
function Unit:addMana(base, mult, bonus) self.parameters.mana:add(base, mult, bonus) end
function Unit:getMana() return self.parameters.mana:get() end

-- Recovery
function Unit:setRecovery(base, mult, bonus) self.parameters.recovery:set(base, mult, bonus) end
function Unit:addRecovery(base, mult, bonus) self.parameters.recovery:add(base, mult, bonus) end
function Unit:getRecovery() return self.parameters.recovery:get() end

-- Crit chance
function Unit:setCritChance(base, mult, bonus) self.parameters.critChance:set(base, mult, bonus) end
function Unit:addCritChance(base, mult, bonus) self.parameters.critChance:add(base, mult, bonus) end
function Unit:getCritChance() return self.parameters.critChance:get() end

-- Crit power
function Unit:setCritPower(base, mult, bonus) self.parameters.critPower:set(base, mult, bonus) end
function Unit:addCritPower(base, mult, bonus) self.parameters.critPower:add(base, mult, bonus) end
function Unit:getCritPower() return self.parameters.critPower:get() end

-- Dodge
function Unit:setDodgeChance(base, mult, bonus) self.parameters.dodge:set(base, mult, bonus) end
function Unit:addDodgeChance(base, mult, bonus) self.parameters.dodge:add(base, mult, bonus) end
function Unit:getDodgeChance() return self.parameters.dodge:get() end

-- Cooldown
function Unit:setCooldown(base, mult, bonus) self.parameters.cooldown:set(base, mult, bonus) end
function Unit:addCooldown(base, mult, bonus) self.parameters.cooldown:add(base, mult, bonus) end
function Unit:getCooldown() return self.parameters.cooldown:get() end

-- Strength
function Unit:setStrength(base, mult, bonus) if self.parameters.strength ~= nil then self.parameters.strength:set(base, mult, bonus) end end
function Unit:addStrength(base, mult, bonus) if self.parameters.strength ~= nil then self.parameters.strength:add(base, mult, bonus) end end
function Unit:getStrength() if self.parameters.strength ~= nil then return self.parameters.strength:get() else return 0, 0, 0, 0 end end

-- Agility
function Unit:setAgility(base, mult, bonus) if self.parameters.agility ~= nil then self.parameters.agility:set(base, mult, bonus) end end
function Unit:addAgility(base, mult, bonus) if self.parameters.agility ~= nil then self.parameters.agility:add(base, mult, bonus) end end
function Unit:getAgility() if self.parameters.agility ~= nil then return self.parameters.agility:get() else return 0, 0, 0, 0 end end

-- Intelligence
function Unit:setIntelligence(base, mult, bonus) if self.parameters.intelligence ~= nil then self.parameters.intelligence:set(base, mult, bonus) end end
function Unit:addIntelligence(base, mult, bonus) if self.parameters.intelligence ~= nil then self.parameters.intelligence:add(base, mult, bonus) end end
function Unit:getIntelligence() if self.parameters.intelligence ~= nil then return self.parameters.intelligence:get() else return 0, 0, 0, 0 end end

Unit.__GetLevelingUnit = GetLevelingUnit
Unit.__GetLearningUnit = GetLearningUnit
Unit.__GetRevivableUnit = GetRevivableUnit
Unit.__GetRevivingUnit = GetRevivingUnit
Unit.__GetAttacker = GetAttacker
Unit.__GetRescuer = GetRescuer
Unit.__GetDyingUnit = GetDyingUnit
Unit.__GetKillingUnit = GetKillingUnit
Unit.__GetDecayingUnit = GetDecayingUnit
Unit.__GetConstructingStructure = GetConstructingStructure
Unit.__GetCancelledStructure = GetCancelledStructure
Unit.__GetConstructedStructure = GetConstructedStructure
Unit.__GetResearchingUnit = GetResearchingUnit
Unit.__GetTrainedUnit = GetTrainedUnit
Unit.__GetDetectedUnit = GetDetectedUnit
Unit.__GetSummoningUnit = GetSummoningUnit
Unit.__GetSummonedUnit = GetSummonedUnit
Unit.__GetTransportUnit = GetTransportUnit
Unit.__GetLoadedUnit = GetLoadedUnit
Unit.__GetSellingUnit = GetSellingUnit
Unit.__GetSoldUnit = GetSoldUnit
Unit.__GetBuyingUnit = GetBuyingUnit
Unit.__GetChangingUnit = GetChangingUnit
Unit.__GetManipulatingUnit = GetManipulatingUnit
Unit.__GetOrderedUnit = GetOrderedUnit
Unit.__GetOrderTargetUnit = GetOrderTargetUnit
Unit.__GetSpellAbilityUnit = GetSpellAbilityUnit
Unit.__GetSpellTargetUnit = GetSpellTargetUnit
Unit.__GetTriggerUnit = GetTriggerUnit
Unit.__GetEventDamage = GetEventDamage
Unit.__GetEventDamageSource = GetEventDamageSource
Unit.__GetEventTargetUnit = GetEventTargetUnit
function GetLevelingUnit() return UnitDB.get(Unit.__GetLevelingUnit()) end
function GetLearningUnit() return UnitDB.get(Unit.__GetLearningUnit()) end
function GetRevivableUnit() return UnitDB.get(Unit.__GetRevivableUnit()) end
function GetRevivingUnit() return UnitDB.get(Unit.__GetRevivingUnit()) end
function GetAttacker() return UnitDB.get(Unit.__GetAttacker()) end
function GetRescuer() return UnitDB.get(Unit.__GetRescuer()) end
function GetDyingUnit() return UnitDB.get(Unit.__GetDyingUnit()) end
function GetKillingUnit() return UnitDB.get(Unit.__GetKillingUnit()) end
function GetDecayingUnit() return UnitDB.get(Unit.__GetDecayingUnit()) end
function GetConstructingStructure() return UnitDB.get(Unit.__GetConstructingStructure()) end
function GetCancelledStructure() return UnitDB.get(Unit.__GetCancelledStructure()) end
function GetConstructedStructure() return UnitDB.get(Unit.__GetConstructedStructure()) end
function GetResearchingUnit() return UnitDB.get(Unit.__GetResearchingUnit()) end
function GetTrainedUnit() return UnitDB.get(Unit.__GetTrainedUnit()) end
function GetDetectedUnit() return UnitDB.get(Unit.__GetDetectedUnit()) end
function GetSummoningUnit() return UnitDB.get(Unit.__GetSummoningUnit()) end
function GetSummonedUnit() return UnitDB.get(Unit.__GetSummonedUnit()) end
function GetTransportUnit() return UnitDB.get(Unit.__GetTransportUnit()) end
function GetLoadedUnit() return UnitDB.get(Unit.__GetLoadedUnit()) end
function GetSellingUnit() return UnitDB.get(Unit.__GetSellingUnit()) end
function GetSoldUnit() return UnitDB.get(Unit.__GetSoldUnit()) end
function GetBuyingUnit() return UnitDB.get(Unit.__GetBuyingUnit()) end
function GetChangingUnit() return UnitDB.get(Unit.__GetChangingUnit()) end
function GetManipulatingUnit() return UnitDB.get(Unit.__GetManipulatingUnit()) end
function GetOrderedUnit() return UnitDB.get(Unit.__GetOrderedUnit()) end
function GetOrderTargetUnit() return UnitDB.get(Unit.__GetOrderTargetUnit()) end
function GetSpellAbilityUnit() return UnitDB.get(Unit.__GetSpellAbilityUnit()) end
function GetSpellTargetUnit() return UnitDB.get(Unit.__GetSpellTargetUnit()) end
function GetTriggerUnit() return UnitDB.get(Unit.__GetTriggerUnit()) end
function GetEventDamage() return UnitDB.get(Unit.__GetEventDamage()) end
function GetEventDamageSource() return UnitDB.get(Unit.__GetEventDamageSource()) end
function GetEventTargetUnit() return UnitDB.get(Unit.__GetEventTargetUnit()) end

--============================================================================
-- Unit API
--============================================================================
-- Movement
--[[
function Unit:getX() return GetUnitX(self.unit) end
function Unit:setX(r_newX) SetUnitX(self.unit, r_newX) end

function Unit:getY() return GetUnitY(self.unit) end
function Unit:setY(r_newY) SetUnitY(self.unit, r_newY) end

function Unit:setPosition(r_newX, r_newY) SetUnitPosition(self.unit, r_newX, r_newY) end

function Unit:getLoc() return GetUnitLoc(self.unit) end
function Unit:setPositionLoc(loc_whichLocation) SetUnitPositionLoc(self.unit, loc_whichLocation) end

function Unit:getFacing() return GetUnitFacing(self.unit) end
function Unit:setFacing(r_facingAngle) SetUnitFacing(self.unit, r_facingAngle) end
function Unit:setFacingTimed(r_facingAngle, r_duration) SetUnitFacingTimed(self.unit, r_facingAngle, r_duration) end

function Unit:getMoveSpeed() return GetUnitMoveSpeed(self.unit) end
function Unit:setMoveSpeed(r_newSpeed) SetUnitMoveSpeed(self.unit, r_newSpeed) end

function Unit:getTurnSpeed() return GetUnitTurnSpeed(self.unit) end
function Unit:setTurnSpeed(r_newTurnSpeed) SetUnitTurnSpeed(self.unit, r_newTurnSpeed) end
function Unit:getDefaultTurnSpeed() return GetUnitDefaultTurnSpeed(self.unit) end

function Unit:getFlyHeight() return GetUnitFlyHeight(self.unit) end
function Unit:setFlyHeight(r_newHeight, r_rate) SetUnitFlyHeight(self.unit, r_newHeight, r_rate) end
function Unit:getDefaultFlyHeight() return GetUnitDefaultFlyHeight(self.unit) end

-- Abilities
function Unit:getAbilityLevel(id_abil) return GetUnitAbilityLevel(self.unit, Unit.Utils.S2ID(id_abil)) end
function Unit:decAbilityLevel(id_abil) return DecUnitAbilityLevel(self.unit, Unit.Utils.S2ID(id_abil)) end
function Unit:incAbilityLevel(id_abil) return IncUnitAbilityLevel(self.unit, Unit.Utils.S2ID(id_abil)) end
function Unit:setAbilityLevel(id_abil, i_level) return SetUnitAbilityLevel(self.unit, Unit.Utils.S2ID(id_abil), i_level) end

function Unit:setRescueRange(r_range) SetUnitRescueRange(self.unit, r_range) end
function Unit:setState(unitstate_whichUnitState, r_newVal) SetUnitState(self.unit, unitstate_whichUnitState, r_newVal) end
function Unit:kill() KillUnit(self.unit) end
function Unit:remove() RemoveUnit(self.unit) end
function Unit:show(b_show) ShowUnit(self.unit, b_show) end
function Unit:setPropWindow(r_newPropWindowAngle) SetUnitPropWindow(self.unit, r_newPropWindowAngle) end
function Unit:setAcquireRange(r_newAcquireRange) SetUnitAcquireRange(self.unit, r_newAcquireRange) end
function Unit:setCreepGuard(b_creepGuard) SetUnitCreepGuard(self.unit, b_creepGuard) end
function Unit:getAcquireRange() return GetUnitAcquireRange(self.unit) end
function Unit:getPropWindow() return GetUnitPropWindow(self.unit) end
function Unit:getDefaultAcquireRange() return GetUnitDefaultAcquireRange(self.unit) end
function Unit:getDefaultPropWindow() return GetUnitDefaultPropWindow(self.unit) end
function Unit:setOwner(player_whichPlayer, b_changeColor) SetUnitOwner(self.unit, player_whichPlayer, b_changeColor) end
function Unit:setColor(playercolor_whichColor) SetUnitColor(self.unit, playercolor_whichColor) end
function Unit:setScale(r_scaleX, r_scaleY, r_scaleZ) SetUnitScale(self.unit, r_scaleX, r_scaleY, r_scaleZ) end
function Unit:setTimeScale(r_timeScale) SetUnitTimeScale(self.unit, r_timeScale) end
function Unit:setBlendTime(r_blendTime) SetUnitBlendTime(self.unit, r_blendTime) end
function Unit:setVertexColor(i_red, i_green, i_blue, i_alpha) SetUnitVertexColor(self.unit, i_red, i_green, i_blue, i_alpha) end
function Unit:queueAnimation(s_whichAnimation) QueueUnitAnimation(self.unit, s_whichAnimation) end
function Unit:setAnimation(s_whichAnimation) SetUnitAnimation(self.unit, s_whichAnimation) end
function Unit:setAnimationByIndex(i_whichAnimation) SetUnitAnimationByIndex(self.unit, i_whichAnimation) end
function Unit:setAnimationWithRarity(s_whichAnimation, raritycontrol_rarity) SetUnitAnimationWithRarity(self.unit, s_whichAnimation, raritycontrol_rarity) end
function Unit:addAnimationProperties(s_animProperties, b_add) AddUnitAnimationProperties(self.unit, s_animProperties, b_add) end
function Unit:setLookAt(s_whichBone, unit_lookAtTarget, r_offsetX, r_offsetY, r_offsetZ) SetUnitLookAt(self.unit, s_whichBone, unit_lookAtTarget, r_offsetX, r_offsetY, r_offsetZ) end
function Unit:resetLookAt() ResetUnitLookAt(self.unit) end
function Unit:setRescuable(player_byWhichPlayer, b_flag) SetUnitRescuable(self.unit, player_byWhichPlayer, b_flag) end
function Unit:setExploded(b_exploded) SetUnitExploded(self.unit, b_exploded) end
function Unit:setInvulnerable(b_flag) SetUnitInvulnerable(self.unit, b_flag) end
function Unit:pause(b_flag) PauseUnit(self.unit, b_flag) end
function Unit:isPaused() return IsUnitPaused(self.unit) end
function Unit:setPathing(b_flag) SetUnitPathing(self.unit, b_flag) end
function Unit:select(b_flag) SelectUnit(self.unit, b_flag) end
function Unit:getPointValue() return GetUnitPointValue(self.unit) end
--native SetUnitPointValueByType takes integer unitType, integer newPointValue returns
function Unit:addItem(item_whichItem) return UnitAddItem(self.unit, item_whichItem) end
function Unit:addItemById(i_itemId) return UnitAddItemById(self.unit, i_itemId) end
function Unit:addItemToSlotById(i_itemId, i_itemSlot) return UnitAddItemToSlotById(self.unit, i_itemId, i_itemSlot) end
function Unit:removeItem(item_whichItem) UnitRemoveItem(self.unit, item_whichItem) end
function Unit:removeItemFromSlot(i_itemSlot) return UnitRemoveItemFromSlot(self.unit, i_itemSlot) end
function Unit:hasItem(item_whichItem) return UnitHasItem(self.unit, item_whichItem) end
function Unit:itemInSlot(i_itemSlot) return UnitItemInSlot(self.unit, i_itemSlot) end
function Unit:inventorySize() return UnitInventorySize(self.unit) end
function Unit:dropItemPoint(item_whichItem, r_x, r_y) return UnitDropItemPoint(self.unit, item_whichItem, r_x, r_y) end
function Unit:dropItemSlot(item_whichItem, i_slot) return UnitDropItemSlot(self.unit, item_whichItem, i_slot) end
function Unit:dropItemTarget(item_whichItem, widget_target) return UnitDropItemTarget(self.unit, item_whichItem, widget_target) end
function Unit:useItem(item_whichItem) return UnitUseItem(self.unit, item_whichItem) end
function Unit:useItemPoint(item_whichItem, r_x, r_y) return UnitUseItemPoint(self.unit, item_whichItem, r_x, r_y) end
function Unit:useItemTarget(item_whichItem, widget_target) return UnitUseItemTarget(self.unit, item_whichItem, widget_target) end
function Unit:getDefaultMoveSpeed() return GetUnitDefaultMoveSpeed(self.unit) end
function Unit:getState(unitstate_whichUnitState) return GetUnitState(self.unit, unitstate_whichUnitState) end
function Unit:getOwningPlayer() return GetOwningPlayer(self.unit) end
function Unit:getTypeId() return GetUnitTypeId(self.unit) end
function Unit:getRace() return GetUnitRace(self.unit) end
function Unit:getName() return GetUnitName(self.unit) end
function Unit:getFoodUsed() return GetUnitFoodUsed(self.unit) end
function Unit:getFoodMade() return GetUnitFoodMade(self.unit) end
function Unit:setUseFood(b_useFood) SetUnitUseFood(self.unit, b_useFood) end
function Unit:getRallyPoint() return GetUnitRallyPoint(self.unit) end
function Unit:getRally() return GetUnitRallyUnit(self.unit) end
function Unit:getRallyDestructable() return GetUnitRallyDestructable(self.unit) end
function Unit:isInGroup(group_whichGroup) return IsUnitInGroup(self.unit, group_whichGroup) end
function Unit:isInForce(force_whichForce) return IsUnitInForce(self.unit, force_whichForce) end
function Unit:isOwnedByPlayer(player_whichPlayer) return IsUnitOwnedByPlayer(self.unit, player_whichPlayer) end
function Unit:isAlly(player_whichPlayer) return IsUnitAlly(self.unit, player_whichPlayer) end
function Unit:isEnemy(player_whichPlayer) return IsUnitEnemy(self.unit, player_whichPlayer) end
function Unit:isVisible(player_whichPlayer) return IsUnitVisible(self.unit, player_whichPlayer) end
function Unit:isDetected(player_whichPlayer) return IsUnitDetected(self.unit, player_whichPlayer) end
function Unit:isInvisible(player_whichPlayer) return IsUnitInvisible(self.unit, player_whichPlayer) end
function Unit:isFogged(player_whichPlayer) return IsUnitFogged(self.unit, player_whichPlayer) end
function Unit:isMasked(player_whichPlayer) return IsUnitMasked(self.unit, player_whichPlayer) end
function Unit:isSelected(player_whichPlayer) return IsUnitSelected(self.unit, player_whichPlayer) end
function Unit:isRace(race_whichRace) return IsUnitRace(self.unit, race_whichRace) end
function Unit:isType(unittype_whichUnitType) return IsUnitType(self.unit, unittype_whichUnitType) end
function Unit:is(unit_whichSpecifiedUnit) return IsUnit(self.unit, unit_whichSpecifiedUnit) end
function Unit:isInRange(unit_otherUnit, r_distance) return IsUnitInRange(self.unit, unit_otherUnit, r_distance) end
function Unit:isInRangeXY(r_x, r_y, r_distance) return IsUnitInRangeXY(self.unit, r_x, r_y, r_distance) end
function Unit:isInRangeLoc(loc_whichLocation, r_distance) return IsUnitInRangeLoc(self.unit, loc_whichLocation, r_distance) end
function Unit:isHidden() return IsUnitHidden(self.unit) end
function Unit:isIllusion() return IsUnitIllusion(self.unit) end
function Unit:isInTransport(unit_whichTransport) return IsUnitInTransport(self.unit, unit_whichTransport) end
function Unit:isLoaded() return IsUnitLoaded(self.unit) end
function Unit:shareVision(player_whichPlayer, b_share) UnitShareVision(self.unit, player_whichPlayer, b_share) end
function Unit:suspendDecay(b_suspend) UnitSuspendDecay(self.unit, b_suspend) end
function Unit:addType(unittype_whichUnitType) return UnitAddType(self.unit, unittype_whichUnitType) end
function Unit:removeType(unittype_whichUnitType) return UnitRemoveType(self.unit, unittype_whichUnitType) end
function Unit:addAbility(i_abilityId) return UnitAddAbility(self.unit, i_abilityId) end
function Unit:removeAbility(i_abilityId) return UnitRemoveAbility(self.unit, i_abilityId) end
function Unit:makeAbilityPermanent(b_permanent, i_abilityId) return UnitMakeAbilityPermanent(self.unit, b_permanent, i_abilityId) end
function Unit:removeBuffs(b_removePositive, b_removeNegative) UnitRemoveBuffs(self.unit, b_removePositive, b_removeNegative) end
function Unit:removeBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) UnitRemoveBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:hasBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return UnitHasBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:countBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return UnitCountBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:addSleep(b_add) UnitAddSleep(self.unit, b_add) end
function Unit:canSleep() return UnitCanSleep(self.unit) end
function Unit:addSleepPerm(b_add) UnitAddSleepPerm(self.unit, b_add) end
function Unit:canSleepPerm() return UnitCanSleepPerm(self.unit) end
function Unit:isSleeping() return UnitIsSleeping(self.unit) end
function Unit:wakeUp() UnitWakeUp(self.unit) end
function Unit:applyTimedLife(i_buffId, r_duration) UnitApplyTimedLife(self.unit, i_buffId, r_duration) end
function Unit:ignoreAlarm(b_flag) return UnitIgnoreAlarm(self.unit, b_flag) end
function Unit:ignoreAlarmToggled() return UnitIgnoreAlarmToggled(self.unit) end
function Unit:resetCooldown() UnitResetCooldown(self.unit) end
function Unit:setConstructionProgress(i_constructionPercentage) UnitSetConstructionProgress(self.unit, i_constructionPercentage) end
function Unit:setUpgradeProgress(i_upgradePercentage) UnitSetUpgradeProgress(self.unit, i_upgradePercentage) end
function Unit:pauseTimedLife(b_flag) UnitPauseTimedLife(self.unit, b_flag) end
function Unit:setUsesAltIcon(b_flag) UnitSetUsesAltIcon(self.unit, b_flag) end
function Unit:damagePoint(r_delay, r_radius, r_x, r_y, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return UnitDamagePoint(self.unit, r_delay, r_radius, r_x, r_y, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) end
function Unit:damageTarget(widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return UnitDamageTarget(self.unit, widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) end
function Unit:setResourceAmount(i_amount) SetResourceAmount(self.unit, i_amount) end
function Unit:addResourceAmount(i_amount) AddResourceAmount(self.unit, i_amount) end
function Unit:getResourceAmount() return GetResourceAmount(self.unit) end
function Unit:addItemToStock(i_itemId, i_currentStock, i_stockMax) AddItemToStock(self.unit, i_itemId, i_currentStock, i_stockMax) end
function Unit:removeItemFromStock(i_itemId) RemoveItemFromStock(self.unit, i_itemId) end
function Unit:removeFromStock(id_unitType) RemoveUnitFromStock(self.unit, id_unitType) end
function Unit:setItemTypeSlots(i_slots) SetItemTypeSlots(self.unit, i_slots) end
function Unit:setTypeSlots(i_slots) SetUnitTypeSlots(self.unit, i_slots) end
function Unit:getUserData() return GetUnitUserData(self.unit) end
function Unit:setUserData(i_data) SetUnitUserData(self.unit, i_data) end
function Unit:getLevel() return GetUnitLevel(self.unit) end
function Unit:isInRegion(region_which) return IsUnitInRegion(region_which, self.unit) end

--============================================================================
-- Hero API
--============================================================================
function Unit:getHeroProperName() return GetHeroProperName(self.unit) end

function Unit:setHeroStr(i_str, b_permanent) SetHeroStr(self.unit, i_str, b_permanent) end
function Unit:setHeroAgi(i_agi, b_permanent) SetHeroAgi(self.unit, i_agi, b_permanent) end
function Unit:setHeroInt(i_int, b_permanent) SetHeroInt(self.unit, i_int, b_permanent) end
function Unit:getHeroStr(b_includeBonuses) return GetHeroStr(self.unit, b_includeBonuses) end
function Unit:getHeroAgi(b_includeBonuses) return GetHeroAgi(self.unit, b_includeBonuses) end
function Unit:getHeroInt(b_includeBonuses) return GetHeroInt(self.unit, b_includeBonuses) end

function Unit:getHeroXP() return GetHeroXP(self.unit) end
function Unit:setHeroXP(i_xpVal, b_showEyeCandy) SetHeroXP(self.unit, i_xpVal, b_showEyeCandy) end
function Unit:addHeroXP(i_xpToAdd, b_showEyeCandy) AddHeroXP(self.unit, i_xpToAdd, b_showEyeCandy) end
function Unit:suspendHeroXP(b_flag) SuspendHeroXP(self.unit, b_flag) end
function Unit:isSuspendedXP() return IsSuspendedXP(self.unit) end
function Unit:setHeroLevel(i_level, b_showEyeCandy) SetHeroLevel(self.unit, i_level, b_showEyeCandy) end
function Unit:getHeroLevel() return GetHeroLevel(self.unit) end
function Unit:stripHeroLevel(i_howManyLevels) return UnitStripHeroLevel(self.unit, i_howManyLevels) end
function Unit:getHeroSkillPoints() return GetHeroSkillPoints(self.unit) end
function Unit:modifySkillPoints(i_skillPointDelta) return UnitModifySkillPoints(self.unit, i_skillPointDelta) end
function Unit:selectHeroSkill(id_abil) SelectHeroSkill(self.unit, id_abil) end

function Unit:reviveHero(r_x, r_y, b_doEyecandy) return ReviveHero(self.unit, r_x, r_y, b_doEyecandy) end
function Unit:reviveHeroLoc(loc_loc, b_doEyecandy) return ReviveHeroLoc(self.unit, loc_loc, b_doEyecandy) end

--============================================================================
-- Waygate API
--============================================================================
function Unit.waygateGetDestinationX() return WaygateGetDestinationX(self.unit) end
function Unit.waygateGetDestinationY() return WaygateGetDestinationY(self.unit) end
function Unit.waygateSetDestination(r_x, r_y) WaygateSetDestination(self.unit, r_x, r_y) end
function Unit.waygateActivate(b_activate) WaygateActivate(self.unit, b_activate) end
function Unit.waygateIsActive() return WaygateIsActive(self.unit) end

--============================================================================
-- Order API
--============================================================================
function Unit:getCurrentOrder() return GetUnitCurrentOrder(self.unit) end

function Unit:issueImmediateOrder(s_order) return IssueImmediateOrder(self.unit, s_order) end
function Unit:issueImmediateOrderById(i_order) return IssueImmediateOrderById(self.unit, i_order) end
function Unit:issuePointOrder(s_order, r_x, r_y) return IssuePointOrder(self.unit, s_order, r_x, r_y) end
function Unit:issuePointOrderLoc(s_order, loc_whichLocation) return IssuePointOrderLoc(self.unit, s_order, loc_whichLocation) end
function Unit:issuePointOrderById(i_order, r_x, r_y) return IssuePointOrderById(self.unit, i_order, r_x, r_y) end
function Unit:issuePointOrderByIdLoc(i_order, loc_whichLocation) return IssuePointOrderByIdLoc(self.unit, i_order, loc_whichLocation) end
function Unit:issueTargetOrder(s_order, widget_targetWidget) return IssueTargetOrder(self.unit, s_order, widget_targetWidget) end
function Unit:issueTargetOrderById(i_order, widget_targetWidget) return IssueTargetOrderById(self.unit, i_order, widget_targetWidget) end
function Unit:issueInstantPointOrder(s_order, r_x, r_y, widget_instantTargetWidget) return IssueInstantPointOrder(self.unit, s_order, r_x, r_y, widget_instantTargetWidget) end
function Unit:issueInstantPointOrderById(i_order, r_x, r_y, widget_instantTargetWidget) return IssueInstantPointOrderById(self.unit, i_order, r_x, r_y, widget_instantTargetWidget) end
function Unit:issueInstantTargetOrder(s_order, widget_targetWidget, widget_instantTargetWidget) return IssueInstantTargetOrder(self.unit, s_order, widget_targetWidget, widget_instantTargetWidget) end

function Unit.issueBuildOrder(unit_whichPeon, s_unitToBuild, r_x, r_y) return IssueBuildOrder(unit_whichPeon, s_unitToBuild, r_x, r_y) end
function Unit.issueBuildOrderById(unit_whichPeon, id_unitType, r_x, r_y) return IssueBuildOrderById(unit_whichPeon, id_unitType, r_x, r_y) end
function Unit.issueNeutralImmediateOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild) return IssueNeutralImmediateOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild) end
function Unit.issueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType) return IssueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType) end
function Unit.issueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, r_x, r_y) return IssueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, r_x, r_y) end
function Unit.issueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType, r_x, r_y) return IssueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType, r_x, r_y) end
function Unit.issueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, widget_target) return IssueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, widget_target) end
function Unit.issueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType, widget_target) return IssueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType, widget_target) end
function Unit:issueInstantTargetOrderById(i_order, widget_targetWidget, widget_instantTargetWidget) return IssueInstantTargetOrderById(self.unit, i_order, widget_targetWidget, widget_instantTargetWidget) end


function Unit.isHero(id_unitType) return IsHeroUnitId(id_unitType) end

function Unit.clearSelection() ClearSelection() end
function Unit.getPointValueByType(i_unitType) return GetUnitPointValueByType(i_unitType) end
function Unit.getFoodMade(id_unitType) return GetFoodMade(id_unitType) end
function Unit.getFoodUsed(id_unitType) return GetFoodUsed(id_unitType) end

function Unit.isIdType(id_unitType, unittype_whichUnitType) return IsUnitIdType(id_unitType, unittype_whichUnitType) end

function Unit.addItemToAllStock(i_itemId, i_currentStock, i_stockMax) AddItemToAllStock(i_itemId, i_currentStock, i_stockMax) end
function Unit:addToStock(id_unitType, i_currentStock, i_stockMax) AddUnitToStock(self.unit, id_unitType, i_currentStock, i_stockMax) end

function Unit.addToAllStock(id_unitType, i_currentStock, i_stockMax) AddUnitToAllStock(id_unitType, i_currentStock, i_stockMax) end
function Unit.removeItemFromAllStock(i_itemId) RemoveItemFromAllStock(i_itemId) end
function Unit.removeFromAllStock(id_unitType) RemoveUnitFromAllStock(id_unitType) end
function Unit.setAllItemTypeSlots(i_slots) SetAllItemTypeSlots(i_slots) end
function Unit.setAllTypeSlots(i_slots) SetAllUnitTypeSlots(i_slots) end
]]--

return Unit