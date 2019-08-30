---@type UnitParameterContainer
local ParameterContainer = require('unitParameter.UnitParameterContainer')
---@type DataBase
local DataBase = require('utils.DataBase')

---@class Unit
local Unit = {
    __type = 'ClassUnit',
    __db = DataBase.new('userdata', 'Unit')
}

local Unit_meta = {
    __type = 'Unit',
    __index = Unit,
    __tostring = function(self)
        return string.format('Unit %s (%s) at [%.2f, %.2f, %.2f]', self:getName(), ID2str(self:getId()), self:getX(), self:getY(), self:getZ())
    end,
    __gc = Unit.destroy
}

---@param player player
---@param id string | integer
---@param x number
---@param y number
---@param face number
---@return Unit
function Unit.new(player, id, x, y, face, is_dead)
    id = ID(id)
    local unit_obj
    if is_dead then
        unit_obj = CreateCorpse(player, id, x, y, face)
    else
        unit_obj = CreateUnit(player, id, x, y, face)
    end
    ---@type Unit
    local unit = {
        __id = id,
        __unit_obj = unit_obj
    }
    setmetatable(unit, Unit_meta)
    Unit.__db:add(unit.__unit_obj, unit)

    unit:initCustomData()

    return unit
end

---@param unit unit
function Unit.get(unit)
    Unit.__db:get(unit)
end

function Unit:destroy()
    self:destroyCustomData()

    Unit.__db:rm(self.__unit_obj)
    RemoveUnit(self.__unit_obj)
    self.__unit_obj = nil
end

---@return unit
function Unit:getObj()
    return self.__unit_obj
end

---Initialize unit custom data.
function Unit:initCustomData()
    ---@type UnitParameterContainer
    self.parameter = runFuncInDebug(ParameterContainer.new, self.__unit_obj)
end

---Destroy unit custom data.
function Unit:destroyCustomData()
end

---@return integer
function Unit:getId()
    return self.__id
end

---@return string
function Unit:getName()
    return GetUnitName(self.__unit_obj)
end

---Function sets unit color. Colors should be in range [0 : 1].
---@param red number
---@param green number
---@param blue number
---@param alpha number
function Unit:setVertexColor(red, green, blue, alpha)
    red = math.floor(255 * torange(red, 0, 1))
    green = math.floor(255 * torange(green, 0, 1))
    blue = math.floor(255 * torange(blue, 0, 1))
    alpha = math.floor(255 * torange(alpha, 0, 1))
    SetUnitVertexColor(self.__unit_obj, red, green, blue, alpha)
end

---@return integer
function Unit:getOwningPlayer()
    return GetOwningPlayer(self.__unit_obj)
end

---@param pos Vec2
function Unit:setPos2(pos)
    self:setX(pos.x)
    self:setY(pos.y)
end

---@param pos Vec3
function Unit:setPos3(pos)
    self:setX(pos.x)
    self:setY(pos.y)
    self:setZ(pos.z)
end

---@param x number
function Unit:setX(x)
    SetUnitX(self.__unit_obj, x)
end

---@param y number
function Unit:setY(y)
    SetUnitY(self.__unit_obj, y)
end

---@param z number
function Unit:setZ(z)
    self:setFlyHeight(z - GetTerrainZ(self:getX(), self:getY()))
end

---@return Vec2
function Unit:getPos2()
    return Vec2.new(self:getX(), self:getY())
end

---@return Vec3
function Unit:getPos3()
    return Vec3.new(self:getX(), self:getY(), self:getZ())
end

---@return number
function Unit:getX()
    return GetUnitX(self.__unit_obj)
end

---@return number
function Unit:getY()
    return GetUnitY(self.__unit_obj)
end

---@return number
function Unit:getZ()
    return GetTerrainZ(self:getX(), self:getY()) + self:getFlyHeight()
end

---@return number
function Unit:getFlyHeight()
    return GetUnitFlyHeight(self.__unit_obj)
end

---@return number
function Unit:setFlyHeigth(height)
    return SetUnitFlyHeight(self.__unit_obj, height)
end

---@return number
function Unit:getDefaultsFlyHeight()
    return GetUnitDefaultFlyHeight(self.__unit_obj)
end

---@param angle number
---@param time number|nil
function Unit:setFacing(angle, time)
    if time == nil or time <= 0 then
        SetUnitFacing(self.__unit_obj, angle)
    else
        SetUnitFacingTimed(self.__unit_obj, angle, time)
    end
end

---@param target Vec2
---@param time number|nil
function Unit:setFacingTo(target, time)
    local x, y = self:getPos()
    local angle = 180 + (180 / math.pi) * math.atan(y - target.y, x - target.x)
    self:setFacing(angle, time)
end

---@return number
function Unit:getFacing()
    return GetUnitFacing(self.__unit_obj)
end

---@return number
function Unit:getMoveSpeed()
    return GetUnitMoveSpeed(self.__unit_obj)
end

---@param speed number
function Unit:setMoveSpeed(speed)
    SetUnitMoveSpeed(self.__unit_obj, speed)
end

---@return number
function Unit:getTurnSpeed()
    return GetUnitTurnSpeed(self.__unit_obj)
end

---@param speed number
function Unit:setTurnSpeed(speed)
    SetUnitTurnSpeed(self.__unit_obj, speed)
end

---@return number
function Unit:getDefaultTurnSpeed()
    return GetUnitDefaultTurnSpeed(self.__unit_obj)
end

---@param ability_id integer
function Unit:addAbility(ability_id)
    UnitAddAbility(self.__unit_obj, ability_id)
end

---@param ability_id integer
function Unit:removeAbility(ability_id)
    UnitRemoveAbility(self.__unit_obj, ability_id)
end

---@param ability_id integer
---@return integer
function Unit:getAbilityLevel(ability_id)
    return GetUnitAbilityLevel(self.__unit_obj, ability_id)
end

---@param ability_id integer
function Unit:setAbilityLevel(ability_id)
    SetUnitAbilityLevel(self.__unit_obj, ability_id)
end

---@param flag boolean
function Unit:setInvulnerable(flag)
    SetUnitInvulnerable(self.__unit_obj, flag)
end

---@param time number
function Unit:applyTimedLife(time)
    UnitApplyTimedLife(self.__unit_obj, 0, time)
end

---@param order_id integer
function Unit:issueImmediateOrderById(order_id)
    IssueImmediateOrderById(self.__unit_obj, order_id)
end

function Unit:orderStop()
    self:issueImmediateOrderById(851972)
end

---@param order_id integer
---@param x number
---@param y number
function Unit:issuePointOrderById(order_id, x, y)
    IssuePointOrderById(self.__unit_obj, order_id, x, y)
end

---@param speed number
function Unit:setMoveSpeed(speed)
    SetUnitMoveSpeed(self.__unit_obj, speed)
end

---@param speed number
function Unit:setTurnSpeed(speed)
    SetUnitTurnSpeed(self.__unit_obj, speed)
end

---@param animation string
function Unit:playAnimation(animation)
    SetUnitAnimation(self.__unit_obj, animation)
end

---@param scale number
function Unit:setAnimationSpeed(scale)
    SetUnitTimeScale(self.__unit_obj, scale)
end

function Unit:pause()
    PauseUnit(self.__unit_obj, true)
end

function Unit:unpause()
    PauseUnit(self.__unit_obj, false)
end

---@return Unit
function Unit.get(wc3_unit)
    return UnitDB:get(wc3_unit)
end
---@return Unit
function Unit.GetLevelingUnit()
    return UnitDB:get(GetLevelingUnit())
end
---@return Unit
function Unit.GetLearningUnit()
    return UnitDB:get(GetLearningUnit())
end
---@return Unit
function Unit.GetRevivableUnit()
    return UnitDB:get(GetRevivableUnit())
end
---@return Unit
function Unit.GetRevivingUnit()
    return UnitDB:get(GetRevivingUnit())
end
---@return Unit
function Unit.GetAttacker()
    return UnitDB:get(GetAttacker())
end
---@return Unit
function Unit.GetRescuer()
    return UnitDB:get(GetRescuer())
end
---@return Unit
function Unit.GetDyingUnit()
    return UnitDB:get(GetDyingUnit())
end
---@return Unit
function Unit.GetKillingUnit()
    return UnitDB:get(GetKillingUnit())
end
---@return Unit
function Unit.GetDecayingUnit()
    return UnitDB:get(GetDecayingUnit())
end
---@return Unit
function Unit.GetConstructingStructure()
    return UnitDB:get(GetConstructingStructure())
end
---@return Unit
function Unit.GetCancelledStructure()
    return UnitDB:get(GetCancelledStructure())
end
---@return Unit
function Unit.GetConstructedStructure()
    return UnitDB:get(GetConstructedStructure())
end
---@return Unit
function Unit.GetResearchingUnit()
    return UnitDB:get(GetResearchingUnit())
end
---@return Unit
function Unit.GetTrainedUnit()
    return UnitDB:get(GetTrainedUnit())
end
---@return Unit
function Unit.GetDetectedUnit()
    return UnitDB:get(GetDetectedUnit())
end
---@return Unit
function Unit.GetSummoningUnit()
    return UnitDB:get(GetSummoningUnit())
end
---@return Unit
function Unit.GetSummonedUnit()
    return UnitDB:get(GetSummonedUnit())
end
---@return Unit
function Unit.GetTransportUnit()
    return UnitDB:get(GetTransportUnit())
end
---@return Unit
function Unit.GetLoadedUnit()
    return UnitDB:get(GetLoadedUnit())
end
---@return Unit
function Unit.GetSellingUnit()
    return UnitDB:get(GetSellingUnit())
end
---@return Unit
function Unit.GetSoldUnit()
    return UnitDB:get(GetSoldUnit())
end
---@return Unit
function Unit.GetBuyingUnit()
    return UnitDB:get(GetBuyingUnit())
end
---@return Unit
function Unit.GetChangingUnit()
    return UnitDB:get(GetChangingUnit())
end
---@return Unit
function Unit.GetManipulatingUnit()
    return UnitDB:get(GetManipulatingUnit())
end
---@return Unit
function Unit.GetOrderedUnit()
    return UnitDB:get(GetOrderedUnit())
end
---@return Unit
function Unit.GetOrderTargetUnit()
    return UnitDB:get(GetOrderTargetUnit())
end
---@return Unit
function Unit.GetSpellAbilityUnit()
    return UnitDB:get(GetSpellAbilityUnit())
end
---@return Unit
function Unit.GetSpellTargetUnit()
    return UnitDB:get(GetSpellTargetUnit())
end
---@return Unit
function Unit.GetTriggerUnit()
    return UnitDB:get(GetTriggerUnit())
end
---@return Unit
function Unit.GetEventDamage()
    return UnitDB:get(GetEventDamage())
end
---@return Unit
function Unit.GetEventDamageSource()
    return UnitDB:get(GetEventDamageSource())
end
---@return Unit
function Unit.GetEventTargetUnit()
    return UnitDB:get(GetEventTargetUnit())
end
--============================================================================
-- Unit API
--============================================================================
-- Movement
--[[

-- Abilities
function Unit:getAbilityLevel(id_abil) return GetUnitAbilityLevel(self.__unit_obj, Unit.Utils.S2ID(id_abil)) end
function Unit:decAbilityLevel(id_abil) return DecUnitAbilityLevel(self.__unit_obj, Unit.Utils.S2ID(id_abil)) end
function Unit:incAbilityLevel(id_abil) return IncUnitAbilityLevel(self.__unit_obj, Unit.Utils.S2ID(id_abil)) end
function Unit:setAbilityLevel(id_abil, i_level) return SetUnitAbilityLevel(self.__unit_obj, Unit.Utils.S2ID(id_abil), i_level) end

function Unit:setRescueRange(r_range) SetUnitRescueRange(self.__unit_obj, r_range) end
function Unit:setState(unitstate_whichUnitState, r_newVal) SetUnitState(self.__unit_obj, unitstate_whichUnitState, r_newVal) end
function Unit:kill() KillUnit(self.__unit_obj) end
function Unit:remove() RemoveUnit(self.__unit_obj) end
function Unit:show(b_show) ShowUnit(self.__unit_obj, b_show) end
function Unit:setPropWindow(r_newPropWindowAngle) SetUnitPropWindow(self.__unit_obj, r_newPropWindowAngle) end
function Unit:setAcquireRange(r_newAcquireRange) SetUnitAcquireRange(self.__unit_obj, r_newAcquireRange) end
function Unit:setCreepGuard(b_creepGuard) SetUnitCreepGuard(self.__unit_obj, b_creepGuard) end
function Unit:getAcquireRange() return GetUnitAcquireRange(self.__unit_obj) end
function Unit:getPropWindow() return GetUnitPropWindow(self.__unit_obj) end
function Unit:getDefaultAcquireRange() return GetUnitDefaultAcquireRange(self.__unit_obj) end
function Unit:getDefaultPropWindow() return GetUnitDefaultPropWindow(self.__unit_obj) end
function Unit:setOwner(player_whichPlayer, b_changeColor) SetUnitOwner(self.__unit_obj, player_whichPlayer, b_changeColor) end
function Unit:setColor(playercolor_whichColor) SetUnitColor(self.__unit_obj, playercolor_whichColor) end
function Unit:setScale(r_scaleX, r_scaleY, r_scaleZ) SetUnitScale(self.__unit_obj, r_scaleX, r_scaleY, r_scaleZ) end
function Unit:setTimeScale(r_timeScale) SetUnitTimeScale(self.__unit_obj, r_timeScale) end
function Unit:setBlendTime(r_blendTime) SetUnitBlendTime(self.__unit_obj, r_blendTime) end
function Unit:setVertexColor(i_red, i_green, i_blue, i_alpha) SetUnitVertexColor(self.__unit_obj, i_red, i_green, i_blue, i_alpha) end
function Unit:queueAnimation(s_whichAnimation) QueueUnitAnimation(self.__unit_obj, s_whichAnimation) end
function Unit:setAnimation(s_whichAnimation) SetUnitAnimation(self.__unit_obj, s_whichAnimation) end
function Unit:setAnimationByIndex(i_whichAnimation) SetUnitAnimationByIndex(self.__unit_obj, i_whichAnimation) end
function Unit:setAnimationWithRarity(s_whichAnimation, raritycontrol_rarity) SetUnitAnimationWithRarity(self.__unit_obj, s_whichAnimation, raritycontrol_rarity) end
function Unit:addAnimationProperties(s_animProperties, b_add) AddUnitAnimationProperties(self.__unit_obj, s_animProperties, b_add) end
function Unit:setLookAt(s_whichBone, unit_lookAtTarget, r_offsetX, r_offsetY, r_offsetZ) SetUnitLookAt(self.__unit_obj, s_whichBone, unit_lookAtTarget, r_offsetX, r_offsetY, r_offsetZ) end
function Unit:resetLookAt() ResetUnitLookAt(self.__unit_obj) end
function Unit:setRescuable(player_byWhichPlayer, b_flag) SetUnitRescuable(self.__unit_obj, player_byWhichPlayer, b_flag) end
function Unit:setExploded(b_exploded) SetUnitExploded(self.__unit_obj, b_exploded) end
function Unit:setInvulnerable(b_flag) SetUnitInvulnerable(self.__unit_obj, b_flag) end
function Unit:pause(b_flag) PauseUnit(self.__unit_obj, b_flag) end
function Unit:isPaused() return IsUnitPaused(self.__unit_obj) end
function Unit:setPathing(b_flag) SetUnitPathing(self.__unit_obj, b_flag) end
function Unit:select(b_flag) SelectUnit(self.__unit_obj, b_flag) end
function Unit:getPointValue() return GetUnitPointValue(self.__unit_obj) end
--native SetUnitPointValueByType takes integer unitType, integer newPointValue returns
function Unit:addItem(item_whichItem) return UnitAddItem(self.__unit_obj, item_whichItem) end
function Unit:addItemById(i_itemId) return UnitAddItemById(self.__unit_obj, i_itemId) end
function Unit:addItemToSlotById(i_itemId, i_itemSlot) return UnitAddItemToSlotById(self.__unit_obj, i_itemId, i_itemSlot) end
function Unit:removeItem(item_whichItem) UnitRemoveItem(self.__unit_obj, item_whichItem) end
function Unit:removeItemFromSlot(i_itemSlot) return UnitRemoveItemFromSlot(self.__unit_obj, i_itemSlot) end
function Unit:hasItem(item_whichItem) return UnitHasItem(self.__unit_obj, item_whichItem) end
function Unit:itemInSlot(i_itemSlot) return UnitItemInSlot(self.__unit_obj, i_itemSlot) end
function Unit:inventorySize() return UnitInventorySize(self.__unit_obj) end
function Unit:dropItemPoint(item_whichItem, r_x, r_y) return UnitDropItemPoint(self.__unit_obj, item_whichItem, r_x, r_y) end
function Unit:dropItemSlot(item_whichItem, i_slot) return UnitDropItemSlot(self.__unit_obj, item_whichItem, i_slot) end
function Unit:dropItemTarget(item_whichItem, widget_target) return UnitDropItemTarget(self.__unit_obj, item_whichItem, widget_target) end
function Unit:useItem(item_whichItem) return UnitUseItem(self.__unit_obj, item_whichItem) end
function Unit:useItemPoint(item_whichItem, r_x, r_y) return UnitUseItemPoint(self.__unit_obj, item_whichItem, r_x, r_y) end
function Unit:useItemTarget(item_whichItem, widget_target) return UnitUseItemTarget(self.__unit_obj, item_whichItem, widget_target) end
function Unit:getDefaultMoveSpeed() return GetUnitDefaultMoveSpeed(self.__unit_obj) end
function Unit:getState(unitstate_whichUnitState) return GetUnitState(self.__unit_obj, unitstate_whichUnitState) end
function Unit:getOwningPlayer() return GetOwningPlayer(self.__unit_obj) end
function Unit:getTypeId() return GetUnitTypeId(self.__unit_obj) end
function Unit:getRace() return GetUnitRace(self.__unit_obj) end
function Unit:getName() return GetUnitName(self.__unit_obj) end
function Unit:getFoodUsed() return GetUnitFoodUsed(self.__unit_obj) end
function Unit:getFoodMade() return GetUnitFoodMade(self.__unit_obj) end
function Unit:setUseFood(b_useFood) SetUnitUseFood(self.__unit_obj, b_useFood) end
function Unit:getRallyPoint() return GetUnitRallyPoint(self.__unit_obj) end
function Unit:getRally() return GetUnitRallyUnit(self.__unit_obj) end
function Unit:getRallyDestructable() return GetUnitRallyDestructable(self.__unit_obj) end
function Unit:isInGroup(group_whichGroup) return IsUnitInGroup(self.__unit_obj, group_whichGroup) end
function Unit:isInForce(force_whichForce) return IsUnitInForce(self.__unit_obj, force_whichForce) end
function Unit:isOwnedByPlayer(player_whichPlayer) return IsUnitOwnedByPlayer(self.__unit_obj, player_whichPlayer) end
function Unit:isAlly(player_whichPlayer) return IsUnitAlly(self.__unit_obj, player_whichPlayer) end
function Unit:isEnemy(player_whichPlayer) return IsUnitEnemy(self.__unit_obj, player_whichPlayer) end
function Unit:isVisible(player_whichPlayer) return IsUnitVisible(self.__unit_obj, player_whichPlayer) end
function Unit:isDetected(player_whichPlayer) return IsUnitDetected(self.__unit_obj, player_whichPlayer) end
function Unit:isInvisible(player_whichPlayer) return IsUnitInvisible(self.__unit_obj, player_whichPlayer) end
function Unit:isFogged(player_whichPlayer) return IsUnitFogged(self.__unit_obj, player_whichPlayer) end
function Unit:isMasked(player_whichPlayer) return IsUnitMasked(self.__unit_obj, player_whichPlayer) end
function Unit:isSelected(player_whichPlayer) return IsUnitSelected(self.__unit_obj, player_whichPlayer) end
function Unit:isRace(race_whichRace) return IsUnitRace(self.__unit_obj, race_whichRace) end
function Unit:isType(unittype_whichUnitType) return IsUnitType(self.__unit_obj, unittype_whichUnitType) end
function Unit:is(unit_whichSpecifiedUnit) return IsUnit(self.__unit_obj, unit_whichSpecifiedUnit) end
function Unit:isInRange(unit_otherUnit, r_distance) return IsUnitInRange(self.__unit_obj, unit_otherUnit, r_distance) end
function Unit:isInRangeXY(r_x, r_y, r_distance) return IsUnitInRangeXY(self.__unit_obj, r_x, r_y, r_distance) end
function Unit:isInRangeLoc(loc_whichLocation, r_distance) return IsUnitInRangeLoc(self.__unit_obj, loc_whichLocation, r_distance) end
function Unit:isHidden() return IsUnitHidden(self.__unit_obj) end
function Unit:isIllusion() return IsUnitIllusion(self.__unit_obj) end
function Unit:isInTransport(unit_whichTransport) return IsUnitInTransport(self.__unit_obj, unit_whichTransport) end
function Unit:isLoaded() return IsUnitLoaded(self.__unit_obj) end
function Unit:shareVision(player_whichPlayer, b_share) UnitShareVision(self.__unit_obj, player_whichPlayer, b_share) end
function Unit:suspendDecay(b_suspend) UnitSuspendDecay(self.__unit_obj, b_suspend) end
function Unit:addType(unittype_whichUnitType) return UnitAddType(self.__unit_obj, unittype_whichUnitType) end
function Unit:removeType(unittype_whichUnitType) return UnitRemoveType(self.__unit_obj, unittype_whichUnitType) end
function Unit:addAbility(i_abilityId) return UnitAddAbility(self.__unit_obj, i_abilityId) end
function Unit:removeAbility(i_abilityId) return UnitRemoveAbility(self.__unit_obj, i_abilityId) end
function Unit:makeAbilityPermanent(b_permanent, i_abilityId) return UnitMakeAbilityPermanent(self.__unit_obj, b_permanent, i_abilityId) end
function Unit:removeBuffs(b_removePositive, b_removeNegative) UnitRemoveBuffs(self.__unit_obj, b_removePositive, b_removeNegative) end
function Unit:removeBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) UnitRemoveBuffsEx(self.__unit_obj, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:hasBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return UnitHasBuffsEx(self.__unit_obj, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:countBuffsEx(b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return UnitCountBuffsEx(self.__unit_obj, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function Unit:addSleep(b_add) UnitAddSleep(self.__unit_obj, b_add) end
function Unit:canSleep() return UnitCanSleep(self.__unit_obj) end
function Unit:addSleepPerm(b_add) UnitAddSleepPerm(self.__unit_obj, b_add) end
function Unit:canSleepPerm() return UnitCanSleepPerm(self.__unit_obj) end
function Unit:isSleeping() return UnitIsSleeping(self.__unit_obj) end
function Unit:wakeUp() UnitWakeUp(self.__unit_obj) end
function Unit:applyTimedLife(i_buffId, r_duration) UnitApplyTimedLife(self.__unit_obj, i_buffId, r_duration) end
function Unit:ignoreAlarm(b_flag) return UnitIgnoreAlarm(self.__unit_obj, b_flag) end
function Unit:ignoreAlarmToggled() return UnitIgnoreAlarmToggled(self.__unit_obj) end
function Unit:resetCooldown() UnitResetCooldown(self.__unit_obj) end
function Unit:setConstructionProgress(i_constructionPercentage) UnitSetConstructionProgress(self.__unit_obj, i_constructionPercentage) end
function Unit:setUpgradeProgress(i_upgradePercentage) UnitSetUpgradeProgress(self.__unit_obj, i_upgradePercentage) end
function Unit:pauseTimedLife(b_flag) UnitPauseTimedLife(self.__unit_obj, b_flag) end
function Unit:setUsesAltIcon(b_flag) UnitSetUsesAltIcon(self.__unit_obj, b_flag) end
function Unit:damagePoint(r_delay, r_radius, r_x, r_y, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return UnitDamagePoint(self.__unit_obj, r_delay, r_radius, r_x, r_y, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) end
function Unit:damageTarget(widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return UnitDamageTarget(self.__unit_obj, widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) end
function Unit:setResourceAmount(i_amount) SetResourceAmount(self.__unit_obj, i_amount) end
function Unit:addResourceAmount(i_amount) AddResourceAmount(self.__unit_obj, i_amount) end
function Unit:getResourceAmount() return GetResourceAmount(self.__unit_obj) end
function Unit:addItemToStock(i_itemId, i_currentStock, i_stockMax) AddItemToStock(self.__unit_obj, i_itemId, i_currentStock, i_stockMax) end
function Unit:removeItemFromStock(i_itemId) RemoveItemFromStock(self.__unit_obj, i_itemId) end
function Unit:removeFromStock(id_unitType) RemoveUnitFromStock(self.__unit_obj, id_unitType) end
function Unit:setItemTypeSlots(i_slots) SetItemTypeSlots(self.__unit_obj, i_slots) end
function Unit:setTypeSlots(i_slots) SetUnitTypeSlots(self.__unit_obj, i_slots) end
function Unit:getUserData() return GetUnitUserData(self.__unit_obj) end
function Unit:setUserData(i_data) SetUnitUserData(self.__unit_obj, i_data) end
function Unit:getLevel() return GetUnitLevel(self.__unit_obj) end
function Unit:isInRegion(region_which) return IsUnitInRegion(region_which, self.__unit_obj) end

--============================================================================
-- Hero API
--============================================================================
function Unit:getHeroProperName() return GetHeroProperName(self.__unit_obj) end

function Unit:setHeroStr(i_str, b_permanent) SetHeroStr(self.__unit_obj, i_str, b_permanent) end
function Unit:setHeroAgi(i_agi, b_permanent) SetHeroAgi(self.__unit_obj, i_agi, b_permanent) end
function Unit:setHeroInt(i_int, b_permanent) SetHeroInt(self.__unit_obj, i_int, b_permanent) end
function Unit:getHeroStr(b_includeBonuses) return GetHeroStr(self.__unit_obj, b_includeBonuses) end
function Unit:getHeroAgi(b_includeBonuses) return GetHeroAgi(self.__unit_obj, b_includeBonuses) end
function Unit:getHeroInt(b_includeBonuses) return GetHeroInt(self.__unit_obj, b_includeBonuses) end

function Unit:getHeroXP() return GetHeroXP(self.__unit_obj) end
function Unit:setHeroXP(i_xpVal, b_showEyeCandy) SetHeroXP(self.__unit_obj, i_xpVal, b_showEyeCandy) end
function Unit:addHeroXP(i_xpToAdd, b_showEyeCandy) AddHeroXP(self.__unit_obj, i_xpToAdd, b_showEyeCandy) end
function Unit:suspendHeroXP(b_flag) SuspendHeroXP(self.__unit_obj, b_flag) end
function Unit:isSuspendedXP() return IsSuspendedXP(self.__unit_obj) end
function Unit:setHeroLevel(i_level, b_showEyeCandy) SetHeroLevel(self.__unit_obj, i_level, b_showEyeCandy) end
function Unit:getHeroLevel() return GetHeroLevel(self.__unit_obj) end
function Unit:stripHeroLevel(i_howManyLevels) return UnitStripHeroLevel(self.__unit_obj, i_howManyLevels) end
function Unit:getHeroSkillPoints() return GetHeroSkillPoints(self.__unit_obj) end
function Unit:modifySkillPoints(i_skillPointDelta) return UnitModifySkillPoints(self.__unit_obj, i_skillPointDelta) end
function Unit:selectHeroSkill(id_abil) SelectHeroSkill(self.__unit_obj, id_abil) end

function Unit:reviveHero(r_x, r_y, b_doEyecandy) return ReviveHero(self.__unit_obj, r_x, r_y, b_doEyecandy) end
function Unit:reviveHeroLoc(loc_loc, b_doEyecandy) return ReviveHeroLoc(self.__unit_obj, loc_loc, b_doEyecandy) end

--============================================================================
-- Waygate API
--============================================================================
function Unit.waygateGetDestinationX() return WaygateGetDestinationX(self.__unit_obj) end
function Unit.waygateGetDestinationY() return WaygateGetDestinationY(self.__unit_obj) end
function Unit.waygateSetDestination(r_x, r_y) WaygateSetDestination(self.__unit_obj, r_x, r_y) end
function Unit.waygateActivate(b_activate) WaygateActivate(self.__unit_obj, b_activate) end
function Unit.waygateIsActive() return WaygateIsActive(self.__unit_obj) end

--============================================================================
-- Order API
--============================================================================
function Unit:getCurrentOrder() return GetUnitCurrentOrder(self.__unit_obj) end

function Unit:issueImmediateOrder(s_order) return IssueImmediateOrder(self.__unit_obj, s_order) end
function Unit:issueImmediateOrderById(i_order) return IssueImmediateOrderById(self.__unit_obj, i_order) end
function Unit:issuePointOrder(s_order, r_x, r_y) return IssuePointOrder(self.__unit_obj, s_order, r_x, r_y) end
function Unit:issuePointOrderLoc(s_order, loc_whichLocation) return IssuePointOrderLoc(self.__unit_obj, s_order, loc_whichLocation) end
function Unit:issuePointOrderById(i_order, r_x, r_y) return IssuePointOrderById(self.__unit_obj, i_order, r_x, r_y) end
function Unit:issuePointOrderByIdLoc(i_order, loc_whichLocation) return IssuePointOrderByIdLoc(self.__unit_obj, i_order, loc_whichLocation) end
function Unit:issueTargetOrder(s_order, widget_targetWidget) return IssueTargetOrder(self.__unit_obj, s_order, widget_targetWidget) end
function Unit:issueTargetOrderById(i_order, widget_targetWidget) return IssueTargetOrderById(self.__unit_obj, i_order, widget_targetWidget) end
function Unit:issueInstantPointOrder(s_order, r_x, r_y, widget_instantTargetWidget) return IssueInstantPointOrder(self.__unit_obj, s_order, r_x, r_y, widget_instantTargetWidget) end
function Unit:issueInstantPointOrderById(i_order, r_x, r_y, widget_instantTargetWidget) return IssueInstantPointOrderById(self.__unit_obj, i_order, r_x, r_y, widget_instantTargetWidget) end
function Unit:issueInstantTargetOrder(s_order, widget_targetWidget, widget_instantTargetWidget) return IssueInstantTargetOrder(self.__unit_obj, s_order, widget_targetWidget, widget_instantTargetWidget) end

function Unit.issueBuildOrder(unit_whichPeon, s_unitToBuild, r_x, r_y) return IssueBuildOrder(unit_whichPeon, s_unitToBuild, r_x, r_y) end
function Unit.issueBuildOrderById(unit_whichPeon, id_unitType, r_x, r_y) return IssueBuildOrderById(unit_whichPeon, id_unitType, r_x, r_y) end
function Unit.issueNeutralImmediateOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild) return IssueNeutralImmediateOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild) end
function Unit.issueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType) return IssueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType) end
function Unit.issueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, r_x, r_y) return IssueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, r_x, r_y) end
function Unit.issueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType, r_x, r_y) return IssueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType, r_x, r_y) end
function Unit.issueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, widget_target) return IssueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, s_unitToBuild, widget_target) end
function Unit.issueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType, widget_target) return IssueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, id_unitType, widget_target) end
function Unit:issueInstantTargetOrderById(i_order, widget_targetWidget, widget_instantTargetWidget) return IssueInstantTargetOrderById(self.__unit_obj, i_order, widget_targetWidget, widget_instantTargetWidget) end


function Unit.isHero(id_unitType) return IsHeroUnitId(id_unitType) end

function Unit.clearSelection() ClearSelection() end
function Unit.getPointValueByType(i_unitType) return GetUnitPointValueByType(i_unitType) end
function Unit.getFoodMade(id_unitType) return GetFoodMade(id_unitType) end
function Unit.getFoodUsed(id_unitType) return GetFoodUsed(id_unitType) end

function Unit.isIdType(id_unitType, unittype_whichUnitType) return IsUnitIdType(id_unitType, unittype_whichUnitType) end

function Unit.addItemToAllStock(i_itemId, i_currentStock, i_stockMax) AddItemToAllStock(i_itemId, i_currentStock, i_stockMax) end
function Unit:addToStock(id_unitType, i_currentStock, i_stockMax) AddUnitToStock(self.__unit_obj, id_unitType, i_currentStock, i_stockMax) end

function Unit.addToAllStock(id_unitType, i_currentStock, i_stockMax) AddUnitToAllStock(id_unitType, i_currentStock, i_stockMax) end
function Unit.removeItemFromAllStock(i_itemId) RemoveItemFromAllStock(i_itemId) end
function Unit.removeFromAllStock(id_unitType) RemoveUnitFromAllStock(id_unitType) end
function Unit.setAllItemTypeSlots(i_slots) SetAllItemTypeSlots(i_slots) end
function Unit.setAllTypeSlots(i_slots) SetAllUnitTypeSlots(i_slots) end
]]--

return Unit