modules_Unit = {
    unit = nil
}

local modules_Unit_mt = {__index = modules_Unit}

function modules_Unit.new(--[[Enter arguments--]])
    local instance = {}
    setmetatable(instance, modules_Unit_mt)
    instance.unit = --Add constructor
    return instance
end

--============================================================================

-- modules_Unit API

-- Facing arguments are specified in degrees

function modules_Unit.create(player_id, i_unitid, r_x, r_y, r_face) return CreateUnit(player_id, i_unitid, r_x, r_y, r_face) end
function modules_Unit.createByName(player_whichPlayer, s_unitname, r_x, r_y, r_face) return CreateUnitByName(player_whichPlayer, s_unitname, r_x, r_y, r_face) end
function modules_Unit.createAtLoc(player_id, i_unitid, location_whichLocation, r_face) return CreateUnitAtLoc(player_id, i_unitid, location_whichLocation, r_face) end
function modules_Unit.createAtLocByName(player_id, s_unitname, location_whichLocation, r_face) return CreateUnitAtLocByName(player_id, s_unitname, location_whichLocation, r_face) end
function modules_Unit.createCorpse(player_whichPlayer, i_unitid, r_x, r_y, r_face) return CreateCorpse(player_whichPlayer, i_unitid, r_x, r_y, r_face) end
function modules_Unit:kill() KillUnit(self.unit) end
function modules_Unit:remove() RemoveUnit(self.unit) end
function modules_Unit:show(b_show) ShowUnit(self.unit, b_show) end
function modules_Unit:setState(unitstate_whichUnitState, r_newVal) SetUnitState(self.unit, unitstate_whichUnitState, r_newVal) end
function modules_Unit:setX(r_newX) SetUnitX(self.unit, r_newX) end
function modules_Unit:setY(r_newY) SetUnitY(self.unit, r_newY) end
function modules_Unit:setPosition(r_newX, r_newY) SetUnitPosition(self.unit, r_newX, r_newY) end
function modules_Unit:setPositionLoc(location_whichLocation) SetUnitPositionLoc(self.unit, location_whichLocation) end
function modules_Unit:setFacing(r_facingAngle) SetUnitFacing(self.unit, r_facingAngle) end
function modules_Unit:setFacingTimed(r_facingAngle, r_duration) SetUnitFacingTimed(self.unit, r_facingAngle, r_duration) end
function modules_Unit:setMoveSpeed(r_newSpeed) SetUnitMoveSpeed(self.unit, r_newSpeed) end
function modules_Unit:setFlyHeight(r_newHeight, r_rate) SetUnitFlyHeight(self.unit, r_newHeight, r_rate) end
function modules_Unit:setTurnSpeed(r_newTurnSpeed) SetUnitTurnSpeed(self.unit, r_newTurnSpeed) end
function modules_Unit:setPropWindow(r_newPropWindowAngle) SetUnitPropWindow(self.unit, r_newPropWindowAngle) end
function modules_Unit:setAcquireRange(r_newAcquireRange) SetUnitAcquireRange(self.unit, r_newAcquireRange) end
function modules_Unit:setCreepGuard(b_creepGuard) SetUnitCreepGuard(self.unit, b_creepGuard) end
function modules_Unit:getAcquireRange() return GetUnitAcquireRange(self.unit) end
function modules_Unit:getTurnSpeed() return GetUnitTurnSpeed(self.unit) end
function modules_Unit:getPropWindow() return GetUnitPropWindow(self.unit) end
function modules_Unit:getFlyHeight() return GetUnitFlyHeight(self.unit) end
function modules_Unit:getDefaultAcquireRange() return GetUnitDefaultAcquireRange(self.unit) end
function modules_Unit:getDefaultTurnSpeed() return GetUnitDefaultTurnSpeed(self.unit) end
function modules_Unit:getDefaultPropWindow() return GetUnitDefaultPropWindow(self.unit) end
function modules_Unit:getDefaultFlyHeight() return GetUnitDefaultFlyHeight(self.unit) end
function modules_Unit:setOwner(player_whichPlayer, b_changeColor) SetUnitOwner(self.unit, player_whichPlayer, b_changeColor) end
function modules_Unit:setColor(playercolor_whichColor) SetUnitColor(self.unit, playercolor_whichColor) end
function modules_Unit:setScale(r_scaleX, r_scaleY, r_scaleZ) SetUnitScale(self.unit, r_scaleX, r_scaleY, r_scaleZ) end
function modules_Unit:setTimeScale(r_timeScale) SetUnitTimeScale(self.unit, r_timeScale) end
function modules_Unit:setBlendTime(r_blendTime) SetUnitBlendTime(self.unit, r_blendTime) end
function modules_Unit:setVertexColor(i_red, i_green, i_blue, i_alpha) SetUnitVertexColor(self.unit, i_red, i_green, i_blue, i_alpha) end
function modules_Unit:queueAnimation(s_whichAnimation) QueueUnitAnimation(self.unit, s_whichAnimation) end
function modules_Unit:setAnimation(s_whichAnimation) SetUnitAnimation(self.unit, s_whichAnimation) end
function modules_Unit:setAnimationByIndex(i_whichAnimation) SetUnitAnimationByIndex(self.unit, i_whichAnimation) end
function modules_Unit:setAnimationWithRarity(s_whichAnimation, raritycontrol_rarity) SetUnitAnimationWithRarity(self.unit, s_whichAnimation, raritycontrol_rarity) end
function modules_Unit:addAnimationProperties(s_animProperties, b_add) AddUnitAnimationProperties(self.unit, s_animProperties, b_add) end
function modules_Unit:setLookAt(s_whichBone, unit_lookAtTarget, r_offsetX, r_offsetY, r_offsetZ) SetUnitLookAt(self.unit, s_whichBone, unit_lookAtTarget, r_offsetX, r_offsetY, r_offsetZ) end
function modules_Unit:resetLookAt() ResetUnitLookAt(self.unit) end
function modules_Unit:setRescuable(player_byWhichPlayer, b_flag) SetUnitRescuable(self.unit, player_byWhichPlayer, b_flag) end
function modules_Unit:setRescueRange(r_range) SetUnitRescueRange(self.unit, r_range) end
function modules_Unit.setHeroStr(unit_whichHero, i_newStr, b_permanent) SetHeroStr(unit_whichHero, i_newStr, b_permanent) end
function modules_Unit.setHeroAgi(unit_whichHero, i_newAgi, b_permanent) SetHeroAgi(unit_whichHero, i_newAgi, b_permanent) end
function modules_Unit.setHeroInt(unit_whichHero, i_newInt, b_permanent) SetHeroInt(unit_whichHero, i_newInt, b_permanent) end
function modules_Unit.getHeroStr(unit_whichHero, b_includeBonuses) return GetHeroStr(unit_whichHero, b_includeBonuses) end
function modules_Unit.getHeroAgi(unit_whichHero, b_includeBonuses) return GetHeroAgi(unit_whichHero, b_includeBonuses) end
function modules_Unit.getHeroInt(unit_whichHero, b_includeBonuses) return GetHeroInt(unit_whichHero, b_includeBonuses) end
function modules_Unit.stripHeroLevel(unit_whichHero, i_howManyLevels) return modules_UnitStripHeroLevel(unit_whichHero, i_howManyLevels) end
function modules_Unit.getHeroXP(unit_whichHero) return GetHeroXP(unit_whichHero) end
function modules_Unit.setHeroXP(unit_whichHero, i_newXpVal, b_showEyeCandy) SetHeroXP(unit_whichHero, i_newXpVal, b_showEyeCandy) end
function modules_Unit.getHeroSkillPoints(unit_whichHero) return GetHeroSkillPoints(unit_whichHero) end
function modules_Unit.modifySkillPoints(unit_whichHero, i_skillPointDelta) return modules_UnitModifySkillPoints(unit_whichHero, i_skillPointDelta) end
function modules_Unit.addHeroXP(unit_whichHero, i_xpToAdd, b_showEyeCandy) AddHeroXP(unit_whichHero, i_xpToAdd, b_showEyeCandy) end
function modules_Unit.setHeroLevel(unit_whichHero, i_level, b_showEyeCandy) SetHeroLevel(unit_whichHero, i_level, b_showEyeCandy) end
function modules_Unit.getHeroLevel(unit_whichHero) return GetHeroLevel(unit_whichHero) end
function modules_Unit:getLevel() return GetUnitLevel(self.unit) end
function modules_Unit.getHeroProperName(unit_whichHero) return GetHeroProperName(unit_whichHero) end
function modules_Unit.suspendHeroXP(unit_whichHero, b_flag) SuspendHeroXP(unit_whichHero, b_flag) end
function modules_Unit.isSuspendedXP(unit_whichHero) return IsSuspendedXP(unit_whichHero) end
function modules_Unit.selectHeroSkill(unit_whichHero, i_abilcode) SelectHeroSkill(unit_whichHero, i_abilcode) end
function modules_Unit:getAbilityLevel(i_abilcode) return GetUnitAbilityLevel(self.unit, i_abilcode) end
function modules_Unit:decAbilityLevel(i_abilcode) return DecUnitAbilityLevel(self.unit, i_abilcode) end
function modules_Unit:incAbilityLevel(i_abilcode) return IncUnitAbilityLevel(self.unit, i_abilcode) end
function modules_Unit:setAbilityLevel(i_abilcode, i_level) return SetUnitAbilityLevel(self.unit, i_abilcode, i_level) end
function modules_Unit.reviveHero(unit_whichHero, r_x, r_y, b_doEyecandy) return ReviveHero(unit_whichHero, r_x, r_y, b_doEyecandy) end
function modules_Unit.reviveHeroLoc(unit_whichHero, location_loc, b_doEyecandy) return ReviveHeroLoc(unit_whichHero, location_loc, b_doEyecandy) end
function modules_Unit:setExploded(b_exploded) SetUnitExploded(self.unit, b_exploded) end
function modules_Unit:setInvulnerable(b_flag) SetUnitInvulnerable(self.unit, b_flag) end
function modules_Unit:pause(b_flag) PauseUnit(self.unit, b_flag) end
function modules_Unit.isPaused(unit_whichHero) return IsUnitPaused(unit_whichHero) end
function modules_Unit:setPathing(b_flag) SetUnitPathing(self.unit, b_flag) end
function modules_Unit.clearSelection() ClearSelection() end
function modules_Unit:select(b_flag) SelectUnit(self.unit, b_flag) end
function modules_Unit:getPointValue() return GetUnitPointValue(self.unit) end
function modules_Unit.getPointValueByType(i_unitType) return GetUnitPointValueByType(i_unitType) end
--native SetUnitPointValueByType takes integer unitType, integer newPointValue returns

function modules_Unit:addItem(item_whichItem) return modules_UnitAddItem(self.unit, item_whichItem) end
function modules_Unit:addItemById(i_itemId) return modules_UnitAddItemById(self.unit, i_itemId) end
function modules_Unit:addItemToSlotById(i_itemId, i_itemSlot) return modules_UnitAddItemToSlotById(self.unit, i_itemId, i_itemSlot) end
function modules_Unit:removeItem(item_whichItem) modules_UnitRemoveItem(self.unit, item_whichItem) end
function modules_Unit:removeItemFromSlot(i_itemSlot) return modules_UnitRemoveItemFromSlot(self.unit, i_itemSlot) end
function modules_Unit:hasItem(item_whichItem) return modules_UnitHasItem(self.unit, item_whichItem) end
function modules_Unit:itemInSlot(i_itemSlot) return modules_UnitItemInSlot(self.unit, i_itemSlot) end
function modules_Unit:inventorySize() return modules_UnitInventorySize(self.unit) end
function modules_Unit:dropItemPoint(item_whichItem, r_x, r_y) return modules_UnitDropItemPoint(self.unit, item_whichItem, r_x, r_y) end
function modules_Unit:dropItemSlot(item_whichItem, i_slot) return modules_UnitDropItemSlot(self.unit, item_whichItem, i_slot) end
function modules_Unit:dropItemTarget(item_whichItem, widget_target) return modules_UnitDropItemTarget(self.unit, item_whichItem, widget_target) end
function modules_Unit:useItem(item_whichItem) return modules_UnitUseItem(self.unit, item_whichItem) end
function modules_Unit:useItemPoint(item_whichItem, r_x, r_y) return modules_UnitUseItemPoint(self.unit, item_whichItem, r_x, r_y) end
function modules_Unit:useItemTarget(item_whichItem, widget_target) return modules_UnitUseItemTarget(self.unit, item_whichItem, widget_target) end
function modules_Unit:getX() return GetUnitX(self.unit) end
function modules_Unit:getY() return GetUnitY(self.unit) end
function modules_Unit:getLoc() return GetUnitLoc(self.unit) end
function modules_Unit:getFacing() return GetUnitFacing(self.unit) end
function modules_Unit:getMoveSpeed() return GetUnitMoveSpeed(self.unit) end
function modules_Unit:getDefaultMoveSpeed() return GetUnitDefaultMoveSpeed(self.unit) end
function modules_Unit:getState(unitstate_whichUnitState) return GetUnitState(self.unit, unitstate_whichUnitState) end
function modules_Unit:getOwningPlayer() return GetOwningPlayer(self.unit) end
function modules_Unit:getTypeId() return GetUnitTypeId(self.unit) end
function modules_Unit:getRace() return GetUnitRace(self.unit) end
function modules_Unit:getName() return GetUnitName(self.unit) end
function modules_Unit:getFoodUsed() return GetUnitFoodUsed(self.unit) end
function modules_Unit:getFoodMade() return GetUnitFoodMade(self.unit) end
function modules_Unit.getFoodMade(i_unitId) return GetFoodMade(i_unitId) end
function modules_Unit.getFoodUsed(i_unitId) return GetFoodUsed(i_unitId) end
function modules_Unit:setUseFood(b_useFood) SetUnitUseFood(self.unit, b_useFood) end
function modules_Unit:getRallyPoint() return GetUnitRallyPoint(self.unit) end
function modules_Unit:getRally() return GetUnitRallyUnit(self.unit) end
function modules_Unit:getRallyDestructable() return GetUnitRallyDestructable(self.unit) end
function modules_Unit:isInGroup(group_whichGroup) return IsUnitInGroup(self.unit, group_whichGroup) end
function modules_Unit:isInForce(force_whichForce) return IsUnitInForce(self.unit, force_whichForce) end
function modules_Unit:isOwnedByPlayer(player_whichPlayer) return IsUnitOwnedByPlayer(self.unit, player_whichPlayer) end
function modules_Unit:isAlly(player_whichPlayer) return IsUnitAlly(self.unit, player_whichPlayer) end
function modules_Unit:isEnemy(player_whichPlayer) return IsUnitEnemy(self.unit, player_whichPlayer) end
function modules_Unit:isVisible(player_whichPlayer) return IsUnitVisible(self.unit, player_whichPlayer) end
function modules_Unit:isDetected(player_whichPlayer) return IsUnitDetected(self.unit, player_whichPlayer) end
function modules_Unit:isInvisible(player_whichPlayer) return IsUnitInvisible(self.unit, player_whichPlayer) end
function modules_Unit:isFogged(player_whichPlayer) return IsUnitFogged(self.unit, player_whichPlayer) end
function modules_Unit:isMasked(player_whichPlayer) return IsUnitMasked(self.unit, player_whichPlayer) end
function modules_Unit:isSelected(player_whichPlayer) return IsUnitSelected(self.unit, player_whichPlayer) end
function modules_Unit:isRace(race_whichRace) return IsUnitRace(self.unit, race_whichRace) end
function modules_Unit:isType(unittype_whichUnitType) return IsUnitType(self.unit, unittype_whichUnitType) end
function modules_Unit:is(unit_whichSpecifiedUnit) return IsUnit(self.unit, unit_whichSpecifiedUnit) end
function modules_Unit:isInRange(unit_otherUnit, r_distance) return IsUnitInRange(self.unit, unit_otherUnit, r_distance) end
function modules_Unit:isInRangeXY(r_x, r_y, r_distance) return IsUnitInRangeXY(self.unit, r_x, r_y, r_distance) end
function modules_Unit:isInRangeLoc(location_whichLocation, r_distance) return IsUnitInRangeLoc(self.unit, location_whichLocation, r_distance) end
function modules_Unit:isHidden() return IsUnitHidden(self.unit) end
function modules_Unit:isIllusion() return IsUnitIllusion(self.unit) end
function modules_Unit:isInTransport(unit_whichTransport) return IsUnitInTransport(self.unit, unit_whichTransport) end
function modules_Unit:isLoaded() return IsUnitLoaded(self.unit) end
function modules_Unit.isHeroId(i_unitId) return IsHeroUnitId(i_unitId) end
function modules_Unit.isIdType(i_unitId, unittype_whichUnitType) return IsUnitIdType(i_unitId, unittype_whichUnitType) end
function modules_Unit:shareVision(player_whichPlayer, b_share) modules_UnitShareVision(self.unit, player_whichPlayer, b_share) end
function modules_Unit:suspendDecay(b_suspend) modules_UnitSuspendDecay(self.unit, b_suspend) end
function modules_Unit:addType(unittype_whichUnitType) return modules_UnitAddType(self.unit, unittype_whichUnitType) end
function modules_Unit:removeType(unittype_whichUnitType) return modules_UnitRemoveType(self.unit, unittype_whichUnitType) end
function modules_Unit:addAbility(i_abilityId) return modules_UnitAddAbility(self.unit, i_abilityId) end
function modules_Unit:removeAbility(i_abilityId) return modules_UnitRemoveAbility(self.unit, i_abilityId) end
function modules_Unit:makeAbilityPermanent(b_permanent, i_abilityId) return modules_UnitMakeAbilityPermanent(self.unit, b_permanent, i_abilityId) end
function modules_Unit:removeBuffs(b_removePositive, b_removeNegative) modules_UnitRemoveBuffs(self.unit, b_removePositive, b_removeNegative) end
function modules_Unit:removeBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) modules_UnitRemoveBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function modules_Unit:hasBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return modules_UnitHasBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function modules_Unit:countBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return modules_UnitCountBuffsEx(self.unit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function modules_Unit:addSleep(b_add) modules_UnitAddSleep(self.unit, b_add) end
function modules_Unit:canSleep() return modules_UnitCanSleep(self.unit) end
function modules_Unit:addSleepPerm(b_add) modules_UnitAddSleepPerm(self.unit, b_add) end
function modules_Unit:canSleepPerm() return modules_UnitCanSleepPerm(self.unit) end
function modules_Unit:isSleeping() return modules_UnitIsSleeping(self.unit) end
function modules_Unit:wakeUp() modules_UnitWakeUp(self.unit) end
function modules_Unit:applyTimedLife(i_buffId, r_duration) modules_UnitApplyTimedLife(self.unit, i_buffId, r_duration) end
function modules_Unit:ignoreAlarm(b_flag) return modules_UnitIgnoreAlarm(self.unit, b_flag) end
function modules_Unit:ignoreAlarmToggled() return modules_UnitIgnoreAlarmToggled(self.unit) end
function modules_Unit:resetCooldown() modules_UnitResetCooldown(self.unit) end
function modules_Unit:setConstructionProgress(i_constructionPercentage) modules_UnitSetConstructionProgress(self.unit, i_constructionPercentage) end
function modules_Unit:setUpgradeProgress(i_upgradePercentage) modules_UnitSetUpgradeProgress(self.unit, i_upgradePercentage) end
function modules_Unit:pauseTimedLife(b_flag) modules_UnitPauseTimedLife(self.unit, b_flag) end
function modules_Unit:setUsesAltIcon(b_flag) modules_UnitSetUsesAltIcon(self.unit, b_flag) end
function modules_Unit:damagePoint(r_delay, r_radius, r_x, r_y, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return modules_UnitDamagePoint(self.unit, r_delay, r_radius, r_x, r_y, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) end
function modules_Unit:damageTarget(widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return modules_UnitDamageTarget(self.unit, widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) end
function modules_Unit:issueImmediateOrder(s_order) return IssueImmediateOrder(self.unit, s_order) end
function modules_Unit:issueImmediateOrderById(i_order) return IssueImmediateOrderById(self.unit, i_order) end
function modules_Unit:issuePointOrder(s_order, r_x, r_y) return IssuePointOrder(self.unit, s_order, r_x, r_y) end
function modules_Unit:issuePointOrderLoc(s_order, location_whichLocation) return IssuePointOrderLoc(self.unit, s_order, location_whichLocation) end
function modules_Unit:issuePointOrderById(i_order, r_x, r_y) return IssuePointOrderById(self.unit, i_order, r_x, r_y) end
function modules_Unit:issuePointOrderByIdLoc(i_order, location_whichLocation) return IssuePointOrderByIdLoc(self.unit, i_order, location_whichLocation) end
function modules_Unit:issueTargetOrder(s_order, widget_targetWidget) return IssueTargetOrder(self.unit, s_order, widget_targetWidget) end
function modules_Unit:issueTargetOrderById(i_order, widget_targetWidget) return IssueTargetOrderById(self.unit, i_order, widget_targetWidget) end
function modules_Unit:issueInstantPointOrder(s_order, r_x, r_y, widget_instantTargetWidget) return IssueInstantPointOrder(self.unit, s_order, r_x, r_y, widget_instantTargetWidget) end
function modules_Unit:issueInstantPointOrderById(i_order, r_x, r_y, widget_instantTargetWidget) return IssueInstantPointOrderById(self.unit, i_order, r_x, r_y, widget_instantTargetWidget) end
function modules_Unit:issueInstantTargetOrder(s_order, widget_targetWidget, widget_instantTargetWidget) return IssueInstantTargetOrder(self.unit, s_order, widget_targetWidget, widget_instantTargetWidget) end
function modules_Unit:issueInstantTargetOrderById(i_order, widget_targetWidget, widget_instantTargetWidget) return IssueInstantTargetOrderById(self.unit, i_order, widget_targetWidget, widget_instantTargetWidget) end
function modules_Unit.issueBuildOrder(unit_whichPeon, s_unitToBuild, r_x, r_y) return IssueBuildOrder(unit_whichPeon, s_unitToBuild, r_x, r_y) end
function modules_Unit.issueBuildOrderById(unit_whichPeon, i_unitId, r_x, r_y) return IssueBuildOrderById(unit_whichPeon, i_unitId, r_x, r_y) end
function modules_Unit.issueNeutralImmediateOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild) return IssueNeutralImmediateOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild) end
function modules_Unit.issueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId) return IssueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId) end
function modules_Unit.issueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, r_x, r_y) return IssueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, r_x, r_y) end
function modules_Unit.issueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId, r_x, r_y) return IssueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId, r_x, r_y) end
function modules_Unit.issueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, widget_target) return IssueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, widget_target) end
function modules_Unit.issueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId, widget_target) return IssueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, i_unitId, widget_target) end
function modules_Unit:getCurrentOrder() return GetUnitCurrentOrder(self.unit) end
function modules_Unit:setResourceAmount(i_amount) SetResourceAmount(self.unit, i_amount) end
function modules_Unit:addResourceAmount(i_amount) AddResourceAmount(self.unit, i_amount) end
function modules_Unit:getResourceAmount() return GetResourceAmount(self.unit) end
function modules_Unit.waygateGetDestinationX(unit_waygate) return WaygateGetDestinationX(unit_waygate) end
function modules_Unit.waygateGetDestinationY(unit_waygate) return WaygateGetDestinationY(unit_waygate) end
function modules_Unit.waygateSetDestination(unit_waygate, r_x, r_y) WaygateSetDestination(unit_waygate, r_x, r_y) end
function modules_Unit.waygateActivate(unit_waygate, b_activate) WaygateActivate(unit_waygate, b_activate) end
function modules_Unit.waygateIsActive(unit_waygate) return WaygateIsActive(unit_waygate) end
function modules_Unit.addItemToAllStock(i_itemId, i_currentStock, i_stockMax) AddItemToAllStock(i_itemId, i_currentStock, i_stockMax) end
function modules_Unit:addItemToStock(i_itemId, i_currentStock, i_stockMax) AddItemToStock(self.unit, i_itemId, i_currentStock, i_stockMax) end
function modules_Unit.addToAllStock(i_unitId, i_currentStock, i_stockMax) AddUnitToAllStock(i_unitId, i_currentStock, i_stockMax) end
function modules_Unit:addToStock(i_unitId, i_currentStock, i_stockMax) AddUnitToStock(self.unit, i_unitId, i_currentStock, i_stockMax) end
function modules_Unit.removeItemFromAllStock(i_itemId) RemoveItemFromAllStock(i_itemId) end
function modules_Unit:removeItemFromStock(i_itemId) RemoveItemFromStock(self.unit, i_itemId) end
function modules_Unit.removeFromAllStock(i_unitId) RemoveUnitFromAllStock(i_unitId) end
function modules_Unit:removeFromStock(i_unitId) RemoveUnitFromStock(self.unit, i_unitId) end
function modules_Unit.setAllItemTypeSlots(i_slots) SetAllItemTypeSlots(i_slots) end
function modules_Unit.setAllTypeSlots(i_slots) SetAllUnitTypeSlots(i_slots) end
function modules_Unit:setItemTypeSlots(i_slots) SetItemTypeSlots(self.unit, i_slots) end
function modules_Unit:setTypeSlots(i_slots) SetUnitTypeSlots(self.unit, i_slots) end
function modules_Unit:getUserData() return GetUnitUserData(self.unit) end
function modules_Unit:setUserData(i_data) SetUnitUserData(self.unit, i_data) end
