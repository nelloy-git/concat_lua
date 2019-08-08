---@type UnitParameterContainer
local ParameterContainer = require('unit.parameters.unitParameterContainer')
---@type Ability
local Ability = require('ability.ability')

---@class UnitObject : userdata

---@class Unit
---@field unit_obj UnitObject
---@field id string
local Unit = {}

---@type table<UnitObject, Unit>
local UnitDB = {}
---@param unit Unit
function UnitDB.add(unit) UnitDB[unit.unit_obj] = unit end
---@param unit Unit
function UnitDB.rm(unit) UnitDB[unit.unit_obj] = nil end
---@param unit_obj UnitObject
---@return Unit
function UnitDB.get(unit_obj) return UnitDB[unit_obj] end

---@param player_id integer
---@param unit_id string | integer
---@param x number
---@param y number
---@param face number
---@return Unit
function Unit.new(player_id, unit_id, x, y, face)
    unit_id = ID(unit_id)

    ---@type Unit
    local instance = {
        id = unit_id,
        unit_obj = CreateUnit(Player(player_id), unit_id, x, y, face)
    }
    setmetatable(instance, {__index = Unit})

    instance:prepareCustomData()
    UnitDB.add(instance)

    return instance
end

---@param player_id integer
---@param unit_id string | integer
---@param x number
---@param y number
---@param face number
---@return Unit
function Unit.newCorpse(player_id, unit_id, x, y, face)
    unit_id = ID(unit_id)

    local instance = {
        id = unit_id,
        ---@type UnitObject
        unit_obj = CreateCorpse(Player(player_id), unit_id, x, y, face)
    }
    setmetatable(instance, {__index = Unit})

    instance:prepareCustomData()
    UnitDB.add(instance)

    return instance
end

function Unit:prepareCustomData()
    ---@type UnitParameterContainer
    self.parameter = ParameterContainer.new(self)
end

---@return integer
function Unit:getId()
    return self.id
end

local function to_range(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end

---Function sets unit color. Colors should be in range [0 : 1].
---@param red number
---@param green number
---@param blue number
---@param alpha number
function Unit:setVertexColor(red, green, blue, alpha)
    red = math.floor(255 * to_range(red, 0, 1))
    green = math.floor(255 * to_range(green, 0, 1))
    blue = math.floor(255 * to_range(blue, 0, 1))
    alpha = math.floor(255 * to_range(alpha, 0, 1))
    SetUnitVertexColor(self.unit_obj, red, green, blue, alpha)
end

---@return integer
function Unit:getOwningPlayerIndex() return player2index(GetOwningPlayer(self.unit_obj)) end

---@return number
function Unit:getFacing() return GetUnitFacing(self.unit_obj) end

---@param ability Ability
function Unit:addAbility(ability)
    UnitAddAbility(self.unit_obj, ability:getId())
end

---@param flag boolean
function Unit:setInvulnerable(flag)
    SetUnitInvulnerable(self.unit_obj, flag)
end

function Unit:applyTimedLife(time)
    UnitApplyTimedLife(self.unit_obj, 0, time)
end

function Unit:issueImmediateOrderById(order_id)
    IssueImmediateOrderById(self.unit_obj, order_id)
end

---@param order_id integer
---@param x number
---@param y number
function Unit:issuePointOrderById(order_id, x, y)
    IssuePointOrderById(self.unit_obj, order_id, x, y)
end

---@param speed number
function Unit:setMoveSpeed(speed)
    SetUnitMoveSpeed(self.unit_obj, speed)
end

---@param speed number
function Unit:setTurnSpeed(speed)
    SetUnitTurnSpeed(self.unit_obj, speed)
end

---@param animation string
function Unit:playAnimation(animation)
    SetUnitAnimation(self.unit_obj, animation)
end

function Unit:pause()
    PauseUnit(self.unit_obj, true)
end

function Unit:unpause()
    PauseUnit(self.unit_obj, false)
end

local __replaced_functions = {
    GetLevelingUnit = GetLevelingUnit,
    GetLearningUnit = GetLearningUnit,
    GetRevivableUnit = GetRevivableUnit,
    GetRevivingUnit = GetRevivingUnit,
    GetAttacker = GetAttacker,
    GetRescuer = GetRescuer,
    GetDyingUnit = GetDyingUnit,
    GetKillingUnit = GetKillingUnit,
    GetDecayingUnit = GetDecayingUnit,
    GetConstructingStructure = GetConstructingStructure,
    GetCancelledStructure = GetCancelledStructure,
    GetConstructedStructure = GetConstructedStructure,
    GetResearchingUnit = GetResearchingUnit,
    GetTrainedUnit = GetTrainedUnit,
    GetDetectedUnit = GetDetectedUnit,
    GetSummoningUnit = GetSummoningUnit,
    GetSummonedUnit = GetSummonedUnit,
    GetTransportUnit = GetTransportUnit,
    GetLoadedUnit = GetLoadedUnit,
    GetSellingUnit = GetSellingUnit,
    GetSoldUnit = GetSoldUnit,
    GetBuyingUnit = GetBuyingUnit,
    GetChangingUnit = GetChangingUnit,
    GetManipulatingUnit = GetManipulatingUnit,
    GetOrderedUnit = GetOrderedUnit,
    GetOrderTargetUnit = GetOrderTargetUnit,
    GetSpellAbilityUnit = GetSpellAbilityUnit,
    GetSpellTargetUnit = GetSpellTargetUnit,
    GetTriggerUnit = GetTriggerUnit,
    GetEventDamage = GetEventDamage,
    GetEventDamageSource = GetEventDamageSource,
    GetEventTargetUnit = GetEventTargetUnit,
}

function GetLevelingUnit() return UnitDB.get(__replaced_functions.GetLevelingUnit()) end
function GetLearningUnit() return UnitDB.get(__replaced_functions.GetLearningUnit()) end
function GetRevivableUnit() return UnitDB.get(__replaced_functions.GetRevivableUnit()) end
function GetRevivingUnit() return UnitDB.get(__replaced_functions.GetRevivingUnit()) end
function GetAttacker() return UnitDB.get(__replaced_functions.GetAttacker()) end
function GetRescuer() return UnitDB.get(__replaced_functions.GetRescuer()) end
function GetDyingUnit() return UnitDB.get(__replaced_functions.GetDyingUnit()) end
function GetKillingUnit() return UnitDB.get(__replaced_functions.GetKillingUnit()) end
function GetDecayingUnit() return UnitDB.get(__replaced_functions.GetDecayingUnit()) end
function GetConstructingStructure() return UnitDB.get(__replaced_functions.GetConstructingStructure()) end
function GetCancelledStructure() return UnitDB.get(__replaced_functions.GetCancelledStructure()) end
function GetConstructedStructure() return UnitDB.get(__replaced_functions.GetConstructedStructure()) end
function GetResearchingUnit() return UnitDB.get(__replaced_functions.GetResearchingUnit()) end
function GetTrainedUnit() return UnitDB.get(__replaced_functions.GetTrainedUnit()) end
function GetDetectedUnit() return UnitDB.get(__replaced_functions.GetDetectedUnit()) end
function GetSummoningUnit() return UnitDB.get(__replaced_functions.GetSummoningUnit()) end
function GetSummonedUnit() return UnitDB.get(__replaced_functions.GetSummonedUnit()) end
function GetTransportUnit() return UnitDB.get(__replaced_functions.GetTransportUnit()) end
function GetLoadedUnit() return UnitDB.get(__replaced_functions.GetLoadedUnit()) end
function GetSellingUnit() return UnitDB.get(__replaced_functions.GetSellingUnit()) end
function GetSoldUnit() return UnitDB.get(__replaced_functions.GetSoldUnit()) end
function GetBuyingUnit() return UnitDB.get(__replaced_functions.GetBuyingUnit()) end
function GetChangingUnit() return UnitDB.get(__replaced_functions.GetChangingUnit()) end
function GetManipulatingUnit() return UnitDB.get(__replaced_functions.GetManipulatingUnit()) end
function GetOrderedUnit() return UnitDB.get(__replaced_functions.GetOrderedUnit()) end
function GetOrderTargetUnit() return UnitDB.get(__replaced_functions.GetOrderTargetUnit()) end
function GetSpellAbilityUnit() return UnitDB.get(__replaced_functions.GetSpellAbilityUnit()) end
function GetSpellTargetUnit() return UnitDB.get(__replaced_functions.GetSpellTargetUnit()) end
function GetTriggerUnit() return UnitDB.get(__replaced_functions.GetTriggerUnit()) end
function GetEventDamage() return UnitDB.get(__replaced_functions.GetEventDamage()) end
function GetEventDamageSource() return UnitDB.get(__replaced_functions.GetEventDamageSource()) end
function GetEventTargetUnit() return UnitDB.get(__replaced_functions.GetEventTargetUnit()) end
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