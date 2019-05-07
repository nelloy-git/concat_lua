local modules_Unit = {}
    unit = nil;
    show = nil;
}

Unit.__index = Unit


local function show(this, bool) ShowUnit(this.unit, bool) end
Unit.show = show

function Unit:setX(x) SetUnitX(self.unit, x) end
function Unit:setY(y) SetUnitY(self.unit, y) end
function Unit:setPos(x, y) SetUnitPosition(self.unit, x, y) end
function Unit:setFacing(angle) SetUnitFacing(self.unit, angle) end
function Unit:setFacingTimed(angle, duration) SetUnitFacingTimed(self.unit, angle, duration) end
function Unit:setMoveSpeed(speed) SetUnitMoveSpeed(self.unit, speed) end
function Unit:setFlyHeight(height, rate) SetUnitFlyHeight(self.unit, height, rate) end
function Unit:setTurnSpeed(turnSpeed) SetUnitTurnSpeed(self.unit, turnSpeed) end
function Unit:setPropWindowAngle(angle) SetUnitPropWindow(self.unit, angle) end
function Unit:setAcquireRange(range) SetUnitAcquireRange(self.unit, range) end

function Unit:SetUnitCreepGuard(unit_whichUnit, b_creepGuard) end
function GetUnitTurnSpeed(unit_whichUnit) return real end
function GetUnitPropWindow(unit_whichUnit) return real end
function GetUnitFlyHeight(unit_whichUnit) return real end
function GetUnitDefaultTurnSpeed(unit_whichUnit) return real end
function GetUnitDefaultPropWindow(unit_whichUnit) return real end
function GetUnitDefaultFlyHeight(unit_whichUnit) return real end
function SetUnitColor(unit_whichUnit, playercolor_whichColor) end
function SetUnitTimeScale(unit_whichUnit, r_timeScale) end
function SetUnitBlendTime(unit_whichUnit, r_blendTime) end
function SetUnitVertexColor(unit_whichUnit, int_red, int_green, int_blue, int_alpha) end
function SetUnitAnimation(unit_whichUnit, str_whichAnimation) end
function SetUnitAnimationByIndex(unit_whichUnit, int_whichAnimation) end
function SetUnitAnimationWithRarity(unit_whichUnit, str_whichAnimation, raritycontrol_rarity) end
function AddUnitAnimationProperties(unit_whichUnit, str_animProperties, b_add) end
function ResetUnitLookAt(unit_whichUnit) end
function SetUnitRescueRange(unit_whichUnit, r_range) end
function SetHeroAgi(unit_whichHero, int_newAgi, b_permanent) end
function SetHeroInt(unit_whichHero, int_newInt, b_permanent) end
function GetHeroAgi(unit_whichHero, b_includeBonuses) return integer end
function GetHeroInt(unit_whichHero, b_includeBonuses) return integer end
function SetHeroXP(unit_whichHero, int_newXpVal, b_showEyeCandy) end
function UnitModifySkillPoints(unit_whichHero, int_skillPointDelta) return boolean end
function SetHeroLevel(unit_whichHero, int_level, b_showEyeCandy) end
function GetHeroLevel(unit_whichHero) return integer end
function GetUnitLevel(unit_whichUnit) return integer end
function GetHeroProperName(unit_whichHero) return string end
function SuspendHeroXP(unit_whichHero, b_flag) end
function IsSuspendedXP(unit_whichHero) return boolean end
function SelectHeroSkill(unit_whichHero, int_abilcode) end
function GetUnitAbilityLevel(unit_whichUnit, int_abilcode) return integer end
function DecUnitAbilityLevel(unit_whichUnit, int_abilcode) return integer end
function IncUnitAbilityLevel(unit_whichUnit, int_abilcode) return integer end
function SetUnitAbilityLevel(unit_whichUnit, int_abilcode, int_level) return integer end
function ReviveHero(unit_whichHero, r_x, r_y, b_doEyecandy) return boolean end
function ReviveHeroLoc(unit_whichHero, location_loc, b_doEyecandy) return boolean end
function SetUnitExploded(unit_whichUnit, b_exploded) end
function SetUnitInvulnerable(unit_whichUnit, b_flag) end
function PauseUnit(unit_whichUnit, b_flag) end
function IsUnitPaused(unit_whichHero) return boolean end
function SetUnitPathing(unit_whichUnit, b_flag) end
function SelectUnit(unit_whichUnit, b_flag) end
function GetUnitPointValueByType(int_unitType) return integer end
--native SetUnitPointValueByType takes integer unitType, integer newPointValue returns
function UnitAddItemById(unit_whichUnit, int_itemId) return item end
function UnitAddItemToSlotById(unit_whichUnit, int_itemId, int_itemSlot) return boolean end
function UnitRemoveItem(unit_whichUnit, item_whichItem) end
function UnitRemoveItemFromSlot(unit_whichUnit, int_itemSlot) return item end
function UnitHasItem(unit_whichUnit, item_whichItem) return boolean end
function UnitItemInSlot(unit_whichUnit, int_itemSlot) return item end
function UnitInventorySize(unit_whichUnit) return integer end
function UnitDropItemSlot(unit_whichUnit, item_whichItem, int_slot) return boolean end
function UnitDropItemTarget(unit_whichUnit, item_whichItem, widget_target) return boolean end
function UnitUseItemPoint(unit_whichUnit, item_whichItem, r_x, r_y) return boolean end
function UnitUseItemTarget(unit_whichUnit, item_whichItem, widget_target) return boolean end
function GetUnitY(unit_whichUnit) return real end
function GetUnitLoc(unit_whichUnit) return location end
function GetUnitFacing(unit_whichUnit) return real end
function GetUnitMoveSpeed(unit_whichUnit) return real end
function GetUnitDefaultMoveSpeed(unit_whichUnit) return real end
function GetUnitState(unit_whichUnit, unitstate_whichUnitState) return real end
function GetOwningPlayer(unit_whichUnit) return player end
function GetUnitTypeId(unit_whichUnit) return integer end
function GetUnitRace(unit_whichUnit) return race end
function GetUnitName(unit_whichUnit) return string end
function GetUnitFoodUsed(unit_whichUnit) return integer end
function GetUnitFoodMade(unit_whichUnit) return integer end
function GetFoodMade(int_unitId) return integer end
function GetFoodUsed(int_unitId) return integer end
function SetUnitUseFood(unit_whichUnit, b_useFood) end
function GetUnitRallyUnit(unit_whichUnit) return unit end
function GetUnitRallyDestructable(unit_whichUnit) return destructable end
function IsUnitInForce(unit_whichUnit, force_whichForce) return boolean end
function IsUnitOwnedByPlayer(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitAlly(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitEnemy(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitVisible(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitDetected(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitInvisible(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitFogged(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitMasked(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitSelected(unit_whichUnit, player_whichPlayer) return boolean end
function IsUnitRace(unit_whichUnit, race_whichRace) return boolean end
function IsUnitType(unit_whichUnit, unittype_whichUnitType) return boolean end
function IsUnit(unit_whichUnit, unit_whichSpecifiedUnit) return boolean end
function IsUnitInRange(unit_whichUnit, unit_otherUnit, r_distance) return boolean end
function IsUnitInRangeXY(unit_whichUnit, r_x, r_y, r_distance) return boolean end
function IsUnitInRangeLoc(unit_whichUnit, location_whichLocation, r_distance) return boolean end
function IsUnitHidden(unit_whichUnit) return boolean end
function IsUnitIllusion(unit_whichUnit) return boolean end
function IsUnitLoaded(unit_whichUnit) return boolean end
function IsUnitIdType(int_unitId, unittype_whichUnitType) return boolean end
function UnitSuspendDecay(unit_whichUnit, b_suspend) end
function UnitAddType(unit_whichUnit, unittype_whichUnitType) return boolean end
function UnitRemoveType(unit_whichUnit, unittype_whichUnitType) return boolean end
function UnitRemoveAbility(unit_whichUnit, int_abilityId) return boolean end
function UnitMakeAbilityPermanent(unit_whichUnit, b_permanent, int_abilityId) return boolean end
function UnitRemoveBuffs(unit_whichUnit, b_removePositive, b_removeNegative) end
function UnitRemoveBuffsEx(unit_whichUnit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) end
function UnitHasBuffsEx(unit_whichUnit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return boolean end
function UnitCountBuffsEx(unit_whichUnit, b_removePositive, b_removeNegative, b_magic, b_physical, b_timedLife, b_aura, b_autoDispel) return integer end
function UnitAddSleep(unit_whichUnit, b_add) end
function UnitCanSleep(unit_whichUnit) return boolean end
function UnitAddSleepPerm(unit_whichUnit, b_add) end
function UnitCanSleepPerm(unit_whichUnit) return boolean end
function UnitIsSleeping(unit_whichUnit) return boolean end
function UnitWakeUp(unit_whichUnit) end
function UnitApplyTimedLife(unit_whichUnit, int_buffId, r_duration) end
function UnitIgnoreAlarm(unit_whichUnit, b_flag) return boolean end
function UnitIgnoreAlarmToggled(unit_whichUnit) return boolean end
function UnitResetCooldown(unit_whichUnit) end
function UnitSetConstructionProgress(unit_whichUnit, int_constructionPercentage) end
function UnitSetUpgradeProgress(unit_whichUnit, int_upgradePercentage) end
function UnitPauseTimedLife(unit_whichUnit, b_flag) end
function UnitSetUsesAltIcon(unit_whichUnit, b_flag) end
function UnitDamageTarget(unit_whichUnit, widget_target, r_amount, b_attack, b_ranged, attacktype_attackType, damagetype_damageType, weapontype_weaponType) return boolean end
function IssueImmediateOrderById(unit_whichUnit, int_order) return boolean end
function IssuePointOrder(unit_whichUnit, str_order, r_x, r_y) return boolean end
function IssuePointOrderLoc(unit_whichUnit, str_order, location_whichLocation) return boolean end
function IssuePointOrderById(unit_whichUnit, int_order, r_x, r_y) return boolean end
function IssuePointOrderByIdLoc(unit_whichUnit, int_order, location_whichLocation) return boolean end
function IssueTargetOrder(unit_whichUnit, str_order, widget_targetWidget) return boolean end
function IssueTargetOrderById(unit_whichUnit, int_order, widget_targetWidget) return boolean end
function IssueInstantPointOrder(unit_whichUnit, str_order, r_x, r_y, widget_instantTargetWidget) return boolean end
function IssueInstantPointOrderById(unit_whichUnit, int_order, r_x, r_y, widget_instantTargetWidget) return boolean end
function IssueInstantTargetOrder(unit_whichUnit, str_order, widget_targetWidget, widget_instantTargetWidget) return boolean end
function IssueInstantTargetOrderById(unit_whichUnit, int_order, widget_targetWidget, widget_instantTargetWidget) return boolean end
function IssueBuildOrder(unit_whichPeon, str_unitToBuild, r_x, r_y) return boolean end
function IssueBuildOrderById(unit_whichPeon, int_unitId, r_x, r_y) return boolean end
function IssueNeutralImmediateOrderById(player_forWhichPlayer, unit_neutralStructure, int_unitId) return boolean end
function IssueNeutralPointOrder(player_forWhichPlayer, unit_neutralStructure, str_unitToBuild, r_x, r_y) return boolean end
function IssueNeutralPointOrderById(player_forWhichPlayer, unit_neutralStructure, int_unitId, r_x, r_y) return boolean end
function IssueNeutralTargetOrder(player_forWhichPlayer, unit_neutralStructure, str_unitToBuild, widget_target) return boolean end
function IssueNeutralTargetOrderById(player_forWhichPlayer, unit_neutralStructure, int_unitId, widget_target) return boolean end
function AddResourceAmount(unit_whichUnit, int_amount) end
function GetResourceAmount(unit_whichUnit) return integer end
function WaygateGetDestinationY(unit_waygate) return real end
function WaygateSetDestination(unit_waygate, r_x, r_y) end
function WaygateActivate(unit_waygate, b_activate) end
function WaygateIsActive(unit_waygate) return boolean end
function AddItemToStock(unit_whichUnit, int_itemId, int_currentStock, int_stockMax) end
function AddUnitToAllStock(int_unitId, int_currentStock, int_stockMax) end
function AddUnitToStock(unit_whichUnit, int_unitId, int_currentStock, int_stockMax) end
function RemoveItemFromStock(unit_whichUnit, int_itemId) end
function RemoveUnitFromAllStock(int_unitId) end
function RemoveUnitFromStock(unit_whichUnit, int_unitId) end
function SetAllUnitTypeSlots(int_slots) end
function SetItemTypeSlots(unit_whichUnit, int_slots) end
function SetUnitTypeSlots(unit_whichUnit, int_slots) end
function SetUnitUserData(unit_whichUnit, int_data) end


function Unit.new(player, unitId, x, y, face)
    local u = {}
    setmetatable(u, Unit)
    u.unit = CreateUnit(player, unitId, x, y, face)
    return u
end

local Unit = modules_Unit

gg_trg_Melee_Initialization = nil
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
    foot = Unit.new(Player(0), 'hfoo', 0, 0, 0)
    foot
end

function InitTrig_Melee_Initialization()
    gg_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(gg_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
end

function InitCustomTriggers()
    InitTrig_Melee_Initialization()
end

function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_Melee_Initialization)
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
    SetCameraBounds(
        -15616.0 + GetCameraMargin(CAMERA_MARGIN_LEFT),
        -15872.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM),
        15616.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT),
        15360.0 - GetCameraMargin(CAMERA_MARGIN_TOP),
        -15616.0 + GetCameraMargin(CAMERA_MARGIN_LEFT),
        15360.0 - GetCameraMargin(CAMERA_MARGIN_TOP),
        15616.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT),
        -15872.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM)
    )
    SetDayNightModels(
        "Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl",
        "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl"
    )
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
    DefineStartLocation(0, 6464.0, -9472.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end
