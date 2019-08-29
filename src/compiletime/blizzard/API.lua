---@alias wc3_agent userdata
---@alias wc3_event userdata
---@alias wc3_player userdata
---@alias wc3_widget userdata
---@alias wc3_unit userdata
---@alias wc3_destructable userdata
---@alias wc3_item userdata
---@alias wc3_ability userdata
---@alias wc3_buff userdata
---@alias wc3_force userdata
---@alias wc3_group userdata
---@alias wc3_trigger userdata
---@alias wc3_triggercondition userdata
---@alias wc3_triggeraction userdata
---@alias wc3_timer userdata
---@alias wc3_location userdata
---@alias wc3_region userdata
---@alias wc3_rect userdata
---@alias wc3_boolexpr userdata
---@alias wc3_sound userdata
---@alias wc3_conditionfunc userdata
---@alias wc3_filterfunc userdata
---@alias wc3_unitpool userdata
---@alias wc3_itempool userdata
---@alias wc3_race userdata
---@alias wc3_alliancetype userdata
---@alias wc3_racepreference userdata
---@alias wc3_gamestate userdata
---@alias wc3_igamestate userdata
---@alias wc3_fgamestate userdata
---@alias wc3_playerstate userdata
---@alias wc3_playerscore userdata
---@alias wc3_playergameresult userdata
---@alias wc3_unitstate userdata
---@alias wc3_aidifficulty userdata
---@alias wc3_eventid userdata
---@alias wc3_gameevent userdata
---@alias wc3_playerevent userdata
---@alias wc3_playerunitevent userdata
---@alias wc3_unitevent userdata
---@alias wc3_limitop userdata
---@alias wc3_widgetevent userdata
---@alias wc3_dialogevent userdata
---@alias wc3_unittype userdata
---@alias wc3_gamespeed userdata
---@alias wc3_gamedifficulty userdata
---@alias wc3_gametype userdata
---@alias wc3_mapflag userdata
---@alias wc3_mapvisibility userdata
---@alias wc3_mapsetting userdata
---@alias wc3_mapdensity userdata
---@alias wc3_mapcontrol userdata
---@alias wc3_playerslotstate userdata
---@alias wc3_volumegroup userdata
---@alias wc3_camerafield userdata
---@alias wc3_camerasetup userdata
---@alias wc3_playercolor userdata
---@alias wc3_placement userdata
---@alias wc3_startlocprio userdata
---@alias wc3_raritycontrol userdata
---@alias wc3_blendmode userdata
---@alias wc3_texmapflags userdata
---@alias wc3_effect userdata
---@alias wc3_effecttype userdata
---@alias wc3_weathereffect userdata
---@alias wc3_terraindeformation userdata
---@alias wc3_fogstate userdata
---@alias wc3_fogmodifier userdata
---@alias wc3_dialog userdata
---@alias wc3_button userdata
---@alias wc3_quest userdata
---@alias wc3_questitem userdata
---@alias wc3_defeatcondition userdata
---@alias wc3_timerdialog userdata
---@alias wc3_leaderboard userdata
---@alias wc3_multiboard userdata
---@alias wc3_multiboarditem userdata
---@alias wc3_trackable userdata
---@alias wc3_gamecache userdata
---@alias wc3_version userdata
---@alias wc3_itemtype userdata
---@alias wc3_texttag userdata
---@alias wc3_attacktype userdata
---@alias wc3_damagetype userdata
---@alias wc3_weapontype userdata
---@alias wc3_soundtype userdata
---@alias wc3_lightning userdata
---@alias wc3_pathingtype userdata
---@alias wc3_mousebuttontype userdata
---@alias wc3_animtype userdata
---@alias wc3_subanimtype userdata
---@alias wc3_image userdata
---@alias wc3_ubersplat userdata
---@alias wc3_hashtable userdata
---@alias wc3_framehandle userdata
---@alias wc3_originframetype userdata
---@alias wc3_framepointtype userdata
---@alias wc3_textaligntype userdata
---@alias wc3_frameeventtype userdata
---@alias wc3_oskeytype userdata
---@alias wc3_abilityintegerfield userdata
---@alias wc3_abilityrealfield userdata
---@alias wc3_abilitybooleanfield userdata
---@alias wc3_abilitystringfield userdata
---@alias wc3_abilityintegerlevelfield userdata
---@alias wc3_abilityreallevelfield userdata
---@alias wc3_abilitybooleanlevelfield userdata
---@alias wc3_abilitystringlevelfield userdata
---@alias wc3_abilityintegerlevelarrayfield userdata
---@alias wc3_abilityreallevelarrayfield userdata
---@alias wc3_abilitybooleanlevelarrayfield userdata
---@alias wc3_abilitystringlevelarrayfield userdata
---@alias wc3_unitintegerfield userdata
---@alias wc3_unitrealfield userdata
---@alias wc3_unitbooleanfield userdata
---@alias wc3_unitstringfield userdata
---@alias wc3_unitweaponintegerfield userdata
---@alias wc3_unitweaponrealfield userdata
---@alias wc3_unitweaponbooleanfield userdata
---@alias wc3_unitweaponstringfield userdata
---@alias wc3_itemintegerfield userdata
---@alias wc3_itemrealfield userdata
---@alias wc3_itembooleanfield userdata
---@alias wc3_itemstringfield userdata
---@alias wc3_movetype userdata
---@alias wc3_targetflag userdata
---@alias wc3_armortype userdata
---@alias wc3_heroattribute userdata
---@alias wc3_defensetype userdata
---@alias wc3_regentype userdata
---@alias wc3_unitcategory userdata
---@alias wc3_pathingflag userdata



---@param i integer
---@return wc3_race
function ConvertRace(i) end
---@param i integer
---@return wc3_alliancetype
function ConvertAllianceType(i) end
---@param i integer
---@return wc3_racepreference
function ConvertRacePref(i) end
---@param i integer
---@return wc3_igamestate
function ConvertIGameState(i) end
---@param i integer
---@return wc3_fgamestate
function ConvertFGameState(i) end
---@param i integer
---@return wc3_playerstate
function ConvertPlayerState(i) end
---@param i integer
---@return wc3_playerscore
function ConvertPlayerScore(i) end
---@param i integer
---@return wc3_playergameresult
function ConvertPlayerGameResult(i) end
---@param i integer
---@return wc3_unitstate
function ConvertUnitState(i) end
---@param i integer
---@return wc3_aidifficulty
function ConvertAIDifficulty(i) end
---@param i integer
---@return wc3_gameevent
function ConvertGameEvent(i) end
---@param i integer
---@return wc3_playerevent
function ConvertPlayerEvent(i) end
---@param i integer
---@return wc3_playerunitevent
function ConvertPlayerUnitEvent(i) end
---@param i integer
---@return wc3_widgetevent
function ConvertWidgetEvent(i) end
---@param i integer
---@return wc3_dialogevent
function ConvertDialogEvent(i) end
---@param i integer
---@return wc3_unitevent
function ConvertUnitEvent(i) end
---@param i integer
---@return wc3_limitop
function ConvertLimitOp(i) end
---@param i integer
---@return wc3_unittype
function ConvertUnitType(i) end
---@param i integer
---@return wc3_gamespeed
function ConvertGameSpeed(i) end
---@param i integer
---@return wc3_placement
function ConvertPlacement(i) end
---@param i integer
---@return wc3_startlocprio
function ConvertStartLocPrio(i) end
---@param i integer
---@return wc3_gamedifficulty
function ConvertGameDifficulty(i) end
---@param i integer
---@return wc3_gametype
function ConvertGameType(i) end
---@param i integer
---@return wc3_mapflag
function ConvertMapFlag(i) end
---@param i integer
---@return wc3_mapvisibility
function ConvertMapVisibility(i) end
---@param i integer
---@return wc3_mapsetting
function ConvertMapSetting(i) end
---@param i integer
---@return wc3_mapdensity
function ConvertMapDensity(i) end
---@param i integer
---@return wc3_mapcontrol
function ConvertMapControl(i) end
---@param i integer
---@return wc3_playercolor
function ConvertPlayerColor(i) end
---@param i integer
---@return wc3_playerslotstate
function ConvertPlayerSlotState(i) end
---@param i integer
---@return wc3_volumegroup
function ConvertVolumeGroup(i) end
---@param i integer
---@return wc3_camerafield
function ConvertCameraField(i) end
---@param i integer
---@return wc3_blendmode
function ConvertBlendMode(i) end
---@param i integer
---@return wc3_raritycontrol
function ConvertRarityControl(i) end
---@param i integer
---@return wc3_texmapflags
function ConvertTexMapFlags(i) end
---@param i integer
---@return wc3_fogstate
function ConvertFogState(i) end
---@param i integer
---@return wc3_effecttype
function ConvertEffectType(i) end
---@param i integer
---@return wc3_version
function ConvertVersion(i) end
---@param i integer
---@return wc3_itemtype
function ConvertItemType(i) end
---@param i integer
---@return wc3_attacktype
function ConvertAttackType(i) end
---@param i integer
---@return wc3_damagetype
function ConvertDamageType(i) end
---@param i integer
---@return wc3_weapontype
function ConvertWeaponType(i) end
---@param i integer
---@return wc3_soundtype
function ConvertSoundType(i) end
---@param i integer
---@return wc3_pathingtype
function ConvertPathingType(i) end
---@param i integer
---@return wc3_mousebuttontype
function ConvertMouseButtonType(i) end
---@param i integer
---@return wc3_animtype
function ConvertAnimType(i) end
---@param i integer
---@return wc3_subanimtype
function ConvertSubAnimType(i) end
---@param i integer
---@return wc3_originframetype
function ConvertOriginFrameType(i) end
---@param i integer
---@return wc3_framepointtype
function ConvertFramePointType(i) end
---@param i integer
---@return wc3_textaligntype
function ConvertTextAlignType(i) end
---@param i integer
---@return wc3_frameeventtype
function ConvertFrameEventType(i) end
---@param i integer
---@return wc3_oskeytype
function ConvertOsKeyType(i) end
---@param i integer
---@return wc3_abilityintegerfield
function ConvertAbilityIntegerField(i) end
---@param i integer
---@return wc3_abilityrealfield
function ConvertAbilityRealField(i) end
---@param i integer
---@return wc3_abilitybooleanfield
function ConvertAbilityBooleanField(i) end
---@param i integer
---@return wc3_abilitystringfield
function ConvertAbilityStringField(i) end
---@param i integer
---@return wc3_abilityintegerlevelfield
function ConvertAbilityIntegerLevelField(i) end
---@param i integer
---@return wc3_abilityreallevelfield
function ConvertAbilityRealLevelField(i) end
---@param i integer
---@return wc3_abilitybooleanlevelfield
function ConvertAbilityBooleanLevelField(i) end
---@param i integer
---@return wc3_abilitystringlevelfield
function ConvertAbilityStringLevelField(i) end
---@param i integer
---@return wc3_abilityintegerlevelarrayfield
function ConvertAbilityIntegerLevelArrayField(i) end
---@param i integer
---@return wc3_abilityreallevelarrayfield
function ConvertAbilityRealLevelArrayField(i) end
---@param i integer
---@return wc3_abilitybooleanlevelarrayfield
function ConvertAbilityBooleanLevelArrayField(i) end
---@param i integer
---@return wc3_abilitystringlevelarrayfield
function ConvertAbilityStringLevelArrayField(i) end
---@param i integer
---@return wc3_unitintegerfield
function ConvertUnitIntegerField(i) end
---@param i integer
---@return wc3_unitrealfield
function ConvertUnitRealField(i) end
---@param i integer
---@return wc3_unitbooleanfield
function ConvertUnitBooleanField(i) end
---@param i integer
---@return wc3_unitstringfield
function ConvertUnitStringField(i) end
---@param i integer
---@return wc3_unitweaponintegerfield
function ConvertUnitWeaponIntegerField(i) end
---@param i integer
---@return wc3_unitweaponrealfield
function ConvertUnitWeaponRealField(i) end
---@param i integer
---@return wc3_unitweaponbooleanfield
function ConvertUnitWeaponBooleanField(i) end
---@param i integer
---@return wc3_unitweaponstringfield
function ConvertUnitWeaponStringField(i) end
---@param i integer
---@return wc3_itemintegerfield
function ConvertItemIntegerField(i) end
---@param i integer
---@return wc3_itemrealfield
function ConvertItemRealField(i) end
---@param i integer
---@return wc3_itembooleanfield
function ConvertItemBooleanField(i) end
---@param i integer
---@return wc3_itemstringfield
function ConvertItemStringField(i) end
---@param i integer
---@return wc3_movetype
function ConvertMoveType(i) end
---@param i integer
---@return wc3_targetflag
function ConvertTargetFlag(i) end
---@param i integer
---@return wc3_armortype
function ConvertArmorType(i) end
---@param i integer
---@return wc3_heroattribute
function ConvertHeroAttribute(i) end
---@param i integer
---@return wc3_defensetype
function ConvertDefenseType(i) end
---@param i integer
---@return wc3_regentype
function ConvertRegenType(i) end
---@param i integer
---@return wc3_unitcategory
function ConvertUnitCategory(i) end
---@param i integer
---@return wc3_pathingflag
function ConvertPathingFlag(i) end
---@param orderIdString string
---@return integer
function OrderId(orderIdString) end
---@param orderId integer
---@return string
function OrderId2String(orderId) end
---@param unitIdString string
---@return integer
function UnitId(unitIdString) end
---@param unitId integer
---@return string
function UnitId2String(unitId) end
---@param abilityIdString string
---@return integer
function AbilityId(abilityIdString) end
---@param abilityId integer
---@return string
function AbilityId2String(abilityId) end
---@param objectId integer
---@return string
function GetObjectName(objectId) end
--[[
function GetBJMaxPlayers()             takes nothing returns integer
function GetBJPlayerNeutralVictim()    takes nothing returns integer
function GetBJPlayerNeutralExtra()     takes nothing returns integer
function GetBJMaxPlayerSlots()         takes nothing returns integer
function GetPlayerNeutralPassive()     takes nothing returns integer
function GetPlayerNeutralAggressive()  takes nothing returns integer
function GetGamePlacement()     takes nothing returns placement
function GetGameSpeed()         takes nothing returns gamespeed
function GetGameDifficulty()    takes nothing returns gamedifficulty
function GetResourceDensity()   takes nothing returns mapdensity
function GetCreatureDensity()   takes nothing returns mapdensity
function GetStartLocationX()    takes integer whichStartLocation returns real
function GetStartLocationY()    takes integer whichStartLocation returns real
function GetStartLocationLoc()  takes integer whichStartLocation returns location
function GetFilterUnit()       takes nothing returns unit
function GetEnumUnit()         takes nothing returns unit
function GetFilterDestructable()   takes nothing returns destructable
function GetEnumDestructable()     takes nothing returns destructable
function GetFilterItem()           takes nothing returns item
function GetEnumItem()             takes nothing returns item
function GetFilterPlayer()     takes nothing returns player
function GetEnumPlayer()       takes nothing returns player
function GetTriggeringTrigger()    takes nothing returns trigger
function GetTriggerEventId()       takes nothing returns eventid
function GetTriggerEvalCount()     takes trigger whichTrigger returns integer
function GetTriggerExecCount()     takes trigger whichTrigger returns integer
function GetEventGameState() takes nothing returns gamestate
function GetWinningPlayer() takes nothing returns player
function GetTriggeringRegion() takes nothing returns region
function GetEnteringUnit() takes nothing returns unit
function GetLeavingUnit() takes nothing returns unit
function GetTriggeringTrackable() takes nothing returns trackable
function GetClickedButton() takes nothing returns button
function GetClickedDialog()    takes nothing returns dialog
function GetTournamentFinishSoonTimeRemaining() takes nothing returns real
function GetTournamentFinishNowRule() takes nothing returns integer
function GetTournamentFinishNowPlayer() takes nothing returns player
function GetTournamentScore() takes player whichPlayer returns integer
function GetSaveBasicFilename() takes nothing returns string
function GetTriggerPlayer() takes nothing returns player
function GetLevelingUnit() takes nothing returns unit
function GetLearningUnit()      takes nothing returns unit
function GetLearnedSkill()      takes nothing returns integer
function GetLearnedSkillLevel() takes nothing returns integer
function GetRevivableUnit() takes nothing returns unit
function GetRevivingUnit() takes nothing returns unit
function GetAttacker() takes nothing returns unit
function GetRescuer()  takes nothing returns unit
function GetDyingUnit() takes nothing returns unit
function GetKillingUnit() takes nothing returns unit
function GetDecayingUnit() takes nothing returns unit
function GetConstructingStructure() takes nothing returns unit
function GetCancelledStructure() takes nothing returns unit
function GetConstructedStructure() takes nothing returns unit
function GetResearchingUnit() takes nothing returns unit
function GetResearched() takes nothing returns integer
function GetTrainedUnitType() takes nothing returns integer
function GetTrainedUnit() takes nothing returns unit
function GetDetectedUnit() takes nothing returns unit
function GetSummoningUnit()    takes nothing returns unit
function GetSummonedUnit()     takes nothing returns unit
function GetTransportUnit()    takes nothing returns unit
function GetLoadedUnit()       takes nothing returns unit
function GetSellingUnit()      takes nothing returns unit
function GetSoldUnit()         takes nothing returns unit
function GetBuyingUnit()       takes nothing returns unit
function GetSoldItem()         takes nothing returns item
function GetChangingUnit()             takes nothing returns unit
function GetChangingUnitPrevOwner()    takes nothing returns player
function GetManipulatingUnit() takes nothing returns unit
function GetManipulatedItem()  takes nothing returns item
function GetOrderedUnit() takes nothing returns unit
function GetIssuedOrderId() takes nothing returns integer
function GetOrderPointX() takes nothing returns real
function GetOrderPointY() takes nothing returns real
function GetOrderPointLoc() takes nothing returns location
function GetOrderTarget()              takes nothing returns widget
function GetOrderTargetDestructable()  takes nothing returns destructable
function GetOrderTargetItem()          takes nothing returns item
function GetOrderTargetUnit()          takes nothing returns unit
function GetSpellAbilityUnit()         takes nothing returns unit
function GetSpellAbilityId()           takes nothing returns integer
function GetSpellAbility()             takes nothing returns ability
function GetSpellTargetLoc()           takes nothing returns location
function GetSpellTargetX()				takes nothing returns real
function GetSpellTargetY()				takes nothing returns real
function GetSpellTargetDestructable()  takes nothing returns destructable
function GetSpellTargetItem()          takes nothing returns item
function GetSpellTargetUnit()          takes nothing returns unit
function GetEventPlayerState() takes nothing returns playerstate
function GetEventPlayerChatString() takes nothing returns string
function GetEventPlayerChatStringMatched() takes nothing returns string
function GetTriggerUnit() takes nothing returns unit
function GetEventUnitState() takes nothing returns unitstate
function GetEventDamage() takes nothing returns real
function GetEventDamageSource() takes nothing returns unit
function GetEventDetectingPlayer() takes nothing returns player
function GetEventTargetUnit() takes nothing returns unit
function GetTriggerWidget() takes nothing returns widget
function GetTriggerDestructable() takes nothing returns destructable
function GetItemName()     takes item whichItem returns string
function GetHeroLevel()        takes unit whichHero returns integer
function GetUnitLevel()        takes unit whichUnit returns integer
function GetUnitX()            takes unit whichUnit returns real
function GetUnitY()            takes unit whichUnit returns real
function GetUnitLoc()          takes unit whichUnit returns location
function GetUnitFacing()       takes unit whichUnit returns real
function GetUnitMoveSpeed()    takes unit whichUnit returns real
function GetUnitDefaultMoveSpeed() takes unit whichUnit returns real
function GetUnitState()        takes unit whichUnit, unitstate whichUnitState returns real
function GetOwningPlayer()     takes unit whichUnit returns player
function GetUnitTypeId()       takes unit whichUnit returns integer
function GetUnitRace()         takes unit whichUnit returns race
function GetUnitName()         takes unit whichUnit returns string
function GetUnitFoodUsed()     takes unit whichUnit returns integer
function GetUnitFoodMade()     takes unit whichUnit returns integer
function GetFoodMade()         takes integer unitId returns integer
function GetFoodUsed()         takes integer unitId returns integer
function GetUnitRallyPoint()           takes unit whichUnit returns location
function GetUnitRallyUnit()            takes unit whichUnit returns unit
function GetUnitRallyDestructable()    takes unit whichUnit returns destructable
function IsUnitInGroup()       takes unit whichUnit, group whichGroup returns boolean
function IsUnitInForce()       takes unit whichUnit, force whichForce returns boolean
function IsUnitOwnedByPlayer() takes unit whichUnit, player whichPlayer returns boolean
function IsUnitAlly()          takes unit whichUnit, player whichPlayer returns boolean
function IsUnitEnemy()         takes unit whichUnit, player whichPlayer returns boolean
function IsUnitVisible()       takes unit whichUnit, player whichPlayer returns boolean
function IsUnitDetected()      takes unit whichUnit, player whichPlayer returns boolean
function IsUnitInvisible()     takes unit whichUnit, player whichPlayer returns boolean
function IsUnitFogged()        takes unit whichUnit, player whichPlayer returns boolean
function IsUnitMasked()        takes unit whichUnit, player whichPlayer returns boolean
function IsUnitSelected()      takes unit whichUnit, player whichPlayer returns boolean
function IsUnitRace()          takes unit whichUnit, race whichRace returns boolean
function IsUnitType()          takes unit whichUnit, unittype whichUnitType returns boolean
function IsUnit()              takes unit whichUnit, unit whichSpecifiedUnit returns boolean
function IsUnitInRange()       takes unit whichUnit, unit otherUnit, real distance returns boolean
function IsUnitInRangeXY()     takes unit whichUnit, real x, real y, real distance returns boolean
function IsUnitInRangeLoc()    takes unit whichUnit, location whichLocation, real distance returns boolean
function IsUnitHidden()        takes unit whichUnit returns boolean
function IsUnitIllusion()      takes unit whichUnit returns boolean
function IsUnitInTransport()   takes unit whichUnit, unit whichTransport returns boolean
function IsUnitLoaded()        takes unit whichUnit returns boolean
function IsHeroUnitId()        takes integer unitId returns boolean
function IsUnitIdType()        takes integer unitId, unittype whichUnitType returns boolean
function Player()              takes integer number returns player
function GetLocalPlayer()      takes nothing returns player
function IsPlayerAlly()        takes player whichPlayer, player otherPlayer returns boolean
function IsPlayerEnemy()       takes player whichPlayer, player otherPlayer returns boolean
function IsPlayerInForce()     takes player whichPlayer, force whichForce returns boolean
function IsPlayerObserver()    takes player whichPlayer returns boolean
function IsVisibleToPlayer()           takes real x, real y, player whichPlayer returns boolean
function IsLocationVisibleToPlayer()   takes location whichLocation, player whichPlayer returns boolean
function IsFoggedToPlayer()            takes real x, real y, player whichPlayer returns boolean
function IsLocationFoggedToPlayer()    takes location whichLocation, player whichPlayer returns boolean
function IsMaskedToPlayer()            takes real x, real y, player whichPlayer returns boolean
function IsLocationMaskedToPlayer()    takes location whichLocation, player whichPlayer returns boolean
function GetPlayerRace()           takes player whichPlayer returns race
function GetPlayerId()             takes player whichPlayer returns integer
function GetPlayerUnitCount()      takes player whichPlayer, boolean includeIncomplete returns integer
function GetPlayerTypedUnitCount() takes player whichPlayer, string unitName, boolean includeIncomplete, boolean includeUpgrades returns integer
function GetPlayerStructureCount() takes player whichPlayer, boolean includeIncomplete returns integer
function GetPlayerState()          takes player whichPlayer, playerstate whichPlayerState returns integer
function GetPlayerScore()          takes player whichPlayer, playerscore whichPlayerScore returns integer
function GetPlayerAlliance()       takes player sourcePlayer, player otherPlayer, alliancetype whichAllianceSetting returns boolean
function GetPlayerHandicap()       takes player whichPlayer returns real
function GetPlayerHandicapXP()     takes player whichPlayer returns real
function SetPlayerHandicap()       takes player whichPlayer, real handicap returns nothing
function SetPlayerHandicapXP()     takes player whichPlayer, real handicap returns nothing
function SetPlayerTechMaxAllowed() takes player whichPlayer, integer techid, integer maximum returns nothing
function GetPlayerTechMaxAllowed() takes player whichPlayer, integer techid returns integer
function AddPlayerTechResearched() takes player whichPlayer, integer techid, integer levels returns nothing
function SetPlayerTechResearched() takes player whichPlayer, integer techid, integer setToLevel returns nothing
function GetPlayerTechResearched() takes player whichPlayer, integer techid, boolean specificonly returns boolean
function GetPlayerTechCount()      takes player whichPlayer, integer techid, boolean specificonly returns integer
function GetFloatGameState()   takes fgamestate whichFloatGameState returns real
function GetIntegerGameState() takes igamestate whichIntegerGameState returns integer
function GetCameraBoundMinX()          takes nothing returns real
function GetCameraBoundMinY()          takes nothing returns real
function GetCameraBoundMaxX()          takes nothing returns real
function GetCameraBoundMaxY()          takes nothing returns real
function GetCameraField()              takes camerafield whichField returns real
function GetCameraTargetPositionX()    takes nothing returns real
function GetCameraTargetPositionY()    takes nothing returns real
function GetCameraTargetPositionZ()    takes nothing returns real
function GetCameraTargetPositionLoc()  takes nothing returns location
function GetCameraEyePositionX()       takes nothing returns real
function GetCameraEyePositionY()       takes nothing returns real
function GetCameraEyePositionZ()       takes nothing returns real
function GetCameraEyePositionLoc()     takes nothing returns location

native Deg2Rad  takes real degrees returns real
native Rad2Deg  takes real radians returns real
native Sin      takes real radians returns real
native Cos      takes real radians returns real
native Tan      takes real radians returns real
native Asin     takes real y returns real
native Acos     takes real x returns real
native Atan     takes real x returns real
native Atan2    takes real y, real x returns real
native SquareRoot takes real x returns real
native Pow      takes real x, real power returns real
native I2R  takes integer i returns real
native R2I  takes real r returns integer
native I2S  takes integer i returns string
native R2S  takes real r returns string
native R2SW takes real r, integer width, integer precision returns string
native S2I  takes string s returns integer
native S2R  takes string s returns real
native GetHandleId takes handle h returns integer
native SubString takes string source, integer start, integer end returns string
native StringLength takes string s returns integer
native StringCase takes string source, boolean upper returns string
native StringHash takes string s returns integer
native GetLocalizedString takes string source returns string
native GetLocalizedHotkey takes string source returns integer
native SetMapName           takes string name returns nothing
native SetMapDescription    takes string description returns nothing
native SetTeams             takes integer teamcount returns nothing
native SetPlayers           takes integer playercount returns nothing
native DefineStartLocation      takes integer whichStartLoc, real x, real y returns nothing
native DefineStartLocationLoc   takes integer whichStartLoc, location whichLocation returns nothing
native SetStartLocPrioCount     takes integer whichStartLoc, integer prioSlotCount returns nothing
native SetStartLocPrio          takes integer whichStartLoc, integer prioSlotIndex, integer otherStartLocIndex, startlocprio priority returns nothing
native GetStartLocPrioSlot      takes integer whichStartLoc, integer prioSlotIndex returns integer
native GetStartLocPrio          takes integer whichStartLoc, integer prioSlotIndex returns startlocprio
native SetGameTypeSupported takes gametype whichGameType, boolean value returns nothing
native SetMapFlag           takes mapflag whichMapFlag, boolean value returns nothing
native SetGamePlacement     takes placement whichPlacementType returns nothing
native SetGameSpeed         takes gamespeed whichspeed returns nothing
native SetGameDifficulty    takes gamedifficulty whichdifficulty returns nothing
native SetResourceDensity   takes mapdensity whichdensity returns nothing
native SetCreatureDensity   takes mapdensity whichdensity returns nothing
native GetTeams             takes nothing returns integer
native GetPlayers           takes nothing returns integer
native IsGameTypeSupported  takes gametype whichGameType returns boolean
native GetGameTypeSelected  takes nothing returns gametype
native IsMapFlagSet         takes mapflag whichMapFlag returns boolean
native SetPlayerTeam            takes player whichPlayer, integer whichTeam returns nothing
native SetPlayerStartLocation   takes player whichPlayer, integer startLocIndex returns nothing
native ForcePlayerStartLocation takes player whichPlayer, integer startLocIndex returns nothing 
native SetPlayerColor           takes player whichPlayer, playercolor color returns nothing
native SetPlayerAlliance        takes player sourcePlayer, player otherPlayer, alliancetype whichAllianceSetting, boolean value returns nothing
native SetPlayerTaxRate         takes player sourcePlayer, player otherPlayer, playerstate whichResource, integer rate returns nothing
native SetPlayerRacePreference  takes player whichPlayer, racepreference whichRacePreference returns nothing
native SetPlayerRaceSelectable  takes player whichPlayer, boolean value returns nothing
native SetPlayerController      takes player whichPlayer, mapcontrol controlType returns nothing
native SetPlayerName            takes player whichPlayer, string name returns nothing
native SetPlayerOnScoreScreen   takes player whichPlayer, boolean flag returns nothing
native GetPlayerTeam            takes player whichPlayer returns integer
native GetPlayerStartLocation   takes player whichPlayer returns integer
native GetPlayerColor           takes player whichPlayer returns playercolor
native GetPlayerSelectable      takes player whichPlayer returns boolean
native GetPlayerController      takes player whichPlayer returns mapcontrol
native GetPlayerSlotState       takes player whichPlayer returns playerslotstate
native GetPlayerTaxRate         takes player sourcePlayer, player otherPlayer, playerstate whichResource returns integer
native IsPlayerRacePrefSet      takes player whichPlayer, racepreference pref returns boolean
native GetPlayerName            takes player whichPlayer returns string
native CreateTimer          takes nothing returns timer
native DestroyTimer         takes timer whichTimer returns nothing
native TimerStart           takes timer whichTimer, real timeout, boolean periodic, code handlerFunc returns nothing
native TimerGetElapsed      takes timer whichTimer returns real
native TimerGetRemaining    takes timer whichTimer returns real
native TimerGetTimeout      takes timer whichTimer returns real
native PauseTimer           takes timer whichTimer returns nothing
native ResumeTimer          takes timer whichTimer returns nothing
native GetExpiredTimer      takes nothing returns timer
native CreateGroup                          takes nothing returns group
native DestroyGroup                         takes group whichGroup returns nothing
native GroupAddUnit                         takes group whichGroup, unit whichUnit returns boolean
native GroupRemoveUnit                      takes group whichGroup, unit whichUnit returns boolean
native BlzGroupAddGroupFast                 takes group whichGroup, group addGroup returns integer
native BlzGroupRemoveGroupFast              takes group whichGroup, group removeGroup returns integer
native GroupClear                           takes group whichGroup returns nothing
native BlzGroupGetSize                      takes group whichGroup returns integer
native BlzGroupUnitAt                       takes group whichGroup, integer index returns unit
native GroupEnumUnitsOfType                 takes group whichGroup, string unitname, boolexpr filter returns nothing
native GroupEnumUnitsOfPlayer               takes group whichGroup, player whichPlayer, boolexpr filter returns nothing
native GroupEnumUnitsOfTypeCounted          takes group whichGroup, string unitname, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRect                 takes group whichGroup, rect r, boolexpr filter returns nothing
native GroupEnumUnitsInRectCounted          takes group whichGroup, rect r, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRange                takes group whichGroup, real x, real y, real radius, boolexpr filter returns nothing
native GroupEnumUnitsInRangeOfLoc           takes group whichGroup, location whichLocation, real radius, boolexpr filter returns nothing
native GroupEnumUnitsInRangeCounted         takes group whichGroup, real x, real y, real radius, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsInRangeOfLocCounted    takes group whichGroup, location whichLocation, real radius, boolexpr filter, integer countLimit returns nothing
native GroupEnumUnitsSelected               takes group whichGroup, player whichPlayer, boolexpr filter returns nothing
native GroupImmediateOrder                  takes group whichGroup, string order returns boolean
native GroupImmediateOrderById              takes group whichGroup, integer order returns boolean
native GroupPointOrder                      takes group whichGroup, string order, real x, real y returns boolean
native GroupPointOrderLoc                   takes group whichGroup, string order, location whichLocation returns boolean
native GroupPointOrderById                  takes group whichGroup, integer order, real x, real y returns boolean
native GroupPointOrderByIdLoc               takes group whichGroup, integer order, location whichLocation returns boolean
native GroupTargetOrder                     takes group whichGroup, string order, widget targetWidget returns boolean
native GroupTargetOrderById                 takes group whichGroup, integer order, widget targetWidget returns boolean
native ForGroup                 takes group whichGroup, code callback returns nothing
native FirstOfGroup             takes group whichGroup returns unit
native CreateForce              takes nothing returns force
native DestroyForce             takes force whichForce returns nothing
native ForceAddPlayer           takes force whichForce, player whichPlayer returns nothing
native ForceRemovePlayer        takes force whichForce, player whichPlayer returns nothing
native BlzForceHasPlayer        takes force whichForce, player whichPlayer returns boolean
native ForceClear               takes force whichForce returns nothing
native ForceEnumPlayers         takes force whichForce, boolexpr filter returns nothing
native ForceEnumPlayersCounted  takes force whichForce, boolexpr filter, integer countLimit returns nothing
native ForceEnumAllies          takes force whichForce, player whichPlayer, boolexpr filter returns nothing
native ForceEnumEnemies         takes force whichForce, player whichPlayer, boolexpr filter returns nothing
native ForForce                 takes force whichForce, code callback returns nothing
native Rect                     takes real minx, real miny, real maxx, real maxy returns rect
native RectFromLoc              takes location min, location max returns rect
native RemoveRect               takes rect whichRect returns nothing
native SetRect                  takes rect whichRect, real minx, real miny, real maxx, real maxy returns nothing
native SetRectFromLoc           takes rect whichRect, location min, location max returns nothing
native MoveRectTo               takes rect whichRect, real newCenterX, real newCenterY returns nothing
native MoveRectToLoc            takes rect whichRect, location newCenterLoc returns nothing
native GetRectCenterX           takes rect whichRect returns real
native GetRectCenterY           takes rect whichRect returns real
native GetRectMinX              takes rect whichRect returns real
native GetRectMinY              takes rect whichRect returns real
native GetRectMaxX              takes rect whichRect returns real
native GetRectMaxY              takes rect whichRect returns real
native CreateRegion             takes nothing returns region
native RemoveRegion             takes region whichRegion returns nothing
native RegionAddRect            takes region whichRegion, rect r returns nothing
native RegionClearRect          takes region whichRegion, rect r returns nothing
native RegionAddCell           takes region whichRegion, real x, real y returns nothing
native RegionAddCellAtLoc      takes region whichRegion, location whichLocation returns nothing
native RegionClearCell         takes region whichRegion, real x, real y returns nothing
native RegionClearCellAtLoc    takes region whichRegion, location whichLocation returns nothing
native Location                 takes real x, real y returns location
native RemoveLocation           takes location whichLocation returns nothing
native MoveLocation             takes location whichLocation, real newX, real newY returns nothing
native GetLocationX             takes location whichLocation returns real
native GetLocationY             takes location whichLocation returns real
native GetLocationZ             takes location whichLocation returns real
native IsUnitInRegion               takes region whichRegion, unit whichUnit returns boolean
native IsPointInRegion              takes region whichRegion, real x, real y returns boolean
native IsLocationInRegion           takes region whichRegion, location whichLocation returns boolean
native GetWorldBounds           takes nothing returns rect
native CreateTrigger    takes nothing returns trigger
native DestroyTrigger   takes trigger whichTrigger returns nothing
native ResetTrigger     takes trigger whichTrigger returns nothing
native EnableTrigger    takes trigger whichTrigger returns nothing
native DisableTrigger   takes trigger whichTrigger returns nothing
native IsTriggerEnabled takes trigger whichTrigger returns boolean
native TriggerWaitOnSleeps   takes trigger whichTrigger, boolean flag returns nothing
native IsTriggerWaitOnSleeps takes trigger whichTrigger returns boolean
native ExecuteFunc          takes string funcName returns nothing
native And              takes boolexpr operandA, boolexpr operandB returns boolexpr
native Or               takes boolexpr operandA, boolexpr operandB returns boolexpr
native Not              takes boolexpr operand returns boolexpr
native Condition        takes code func returns conditionfunc
native DestroyCondition takes conditionfunc c returns nothing
native Filter           takes code func returns filterfunc
native DestroyFilter    takes filterfunc f returns nothing
native DestroyBoolExpr  takes boolexpr e returns nothing
native TriggerRegisterVariableEvent takes trigger whichTrigger, string varName, limitop opcode, real limitval returns event
native TriggerRegisterTimerEvent takes trigger whichTrigger, real timeout, boolean periodic returns event
native TriggerRegisterTimerExpireEvent takes trigger whichTrigger, timer t returns event
native TriggerRegisterGameStateEvent takes trigger whichTrigger, gamestate whichState, limitop opcode, real limitval returns event
native TriggerRegisterDialogEvent       takes trigger whichTrigger, dialog whichDialog returns event
native TriggerRegisterDialogButtonEvent takes trigger whichTrigger, button whichButton returns event
native TriggerRegisterGameEvent takes trigger whichTrigger, gameevent whichGameEvent returns event
native TriggerRegisterEnterRegion takes trigger whichTrigger, region whichRegion, boolexpr filter returns event
native TriggerRegisterLeaveRegion takes trigger whichTrigger, region whichRegion, boolexpr filter returns event
native TriggerRegisterTrackableHitEvent takes trigger whichTrigger, trackable t returns event
native TriggerRegisterTrackableTrackEvent takes trigger whichTrigger, trackable t returns event
native TriggerRegisterPlayerEvent takes trigger whichTrigger, player  whichPlayer, playerevent whichPlayerEvent returns event
native TriggerRegisterPlayerUnitEvent takes trigger whichTrigger, player whichPlayer, playerunitevent whichPlayerUnitEvent, boolexpr filter returns event
native TriggerRegisterPlayerAllianceChange takes trigger whichTrigger, player whichPlayer, alliancetype whichAlliance returns event
native TriggerRegisterPlayerStateEvent takes trigger whichTrigger, player whichPlayer, playerstate whichState, limitop opcode, real limitval returns event
native TriggerRegisterPlayerChatEvent takes trigger whichTrigger, player whichPlayer, string chatMessageToDetect, boolean exactMatchOnly returns event
native TriggerRegisterDeathEvent takes trigger whichTrigger, widget whichWidget returns event
native TriggerRegisterUnitStateEvent takes trigger whichTrigger, unit whichUnit, unitstate whichState, limitop opcode, real limitval returns event
native TriggerRegisterUnitEvent takes trigger whichTrigger, unit whichUnit, unitevent whichEvent returns event
native TriggerRegisterFilterUnitEvent takes trigger whichTrigger, unit whichUnit, unitevent whichEvent, boolexpr filter returns event
native TriggerRegisterUnitInRange takes trigger whichTrigger, unit whichUnit, real range, boolexpr filter returns event
native TriggerAddCondition    takes trigger whichTrigger, boolexpr condition returns triggercondition
native TriggerRemoveCondition takes trigger whichTrigger, triggercondition whichCondition returns nothing
native TriggerClearConditions takes trigger whichTrigger returns nothing
native TriggerAddAction     takes trigger whichTrigger, code actionFunc returns triggeraction
native TriggerRemoveAction  takes trigger whichTrigger, triggeraction whichAction returns nothing
native TriggerClearActions  takes trigger whichTrigger returns nothing
native TriggerSleepAction   takes real timeout returns nothing
native TriggerWaitForSound  takes sound s, real offset returns nothing
native TriggerEvaluate      takes trigger whichTrigger returns boolean
native TriggerExecute       takes trigger whichTrigger returns nothing
native TriggerExecuteWait   takes trigger whichTrigger returns nothing
native TriggerSyncStart     takes nothing returns nothing
native TriggerSyncReady     takes nothing returns nothing
native  GetWidgetLife   takes widget whichWidget returns real
native  SetWidgetLife   takes widget whichWidget, real newLife returns nothing
native  GetWidgetX      takes widget whichWidget returns real
native  GetWidgetY      takes widget whichWidget returns real
native          CreateDestructable          takes integer objectid, real x, real y, real face, real scale, integer variation returns destructable
native          CreateDestructableZ         takes integer objectid, real x, real y, real z, real face, real scale, integer variation returns destructable
native          CreateDeadDestructable      takes integer objectid, real x, real y, real face, real scale, integer variation returns destructable
native          CreateDeadDestructableZ     takes integer objectid, real x, real y, real z, real face, real scale, integer variation returns destructable
native          RemoveDestructable          takes destructable d returns nothing
native          KillDestructable            takes destructable d returns nothing
native          SetDestructableInvulnerable takes destructable d, boolean flag returns nothing
native          IsDestructableInvulnerable  takes destructable d returns boolean
native          EnumDestructablesInRect     takes rect r, boolexpr filter, code actionFunc returns nothing
native          GetDestructableTypeId       takes destructable d returns integer
native          GetDestructableX            takes destructable d returns real
native          GetDestructableY            takes destructable d returns real
native          SetDestructableLife         takes destructable d, real life returns nothing
native          GetDestructableLife         takes destructable d returns real
native          SetDestructableMaxLife      takes destructable d, real max returns nothing
native          GetDestructableMaxLife      takes destructable d returns real
native          DestructableRestoreLife     takes destructable d, real life, boolean birth returns nothing
native          QueueDestructableAnimation  takes destructable d, string whichAnimation returns nothing
native          SetDestructableAnimation    takes destructable d, string whichAnimation returns nothing
native          SetDestructableAnimationSpeed takes destructable d, real speedFactor returns nothing
native          ShowDestructable            takes destructable d, boolean flag returns nothing
native          GetDestructableOccluderHeight takes destructable d returns real
native          SetDestructableOccluderHeight takes destructable d, real height returns nothing
native          GetDestructableName         takes destructable d returns string
native          CreateItem      takes integer itemid, real x, real y returns item
native          RemoveItem      takes item whichItem returns nothing
native          GetItemPlayer   takes item whichItem returns player
native          GetItemTypeId   takes item i returns integer
native          GetItemX        takes item i returns real
native          GetItemY        takes item i returns real
native          SetItemPosition takes item i, real x, real y returns nothing
native          SetItemDropOnDeath  takes item whichItem, boolean flag returns nothing
native          SetItemDroppable takes item i, boolean flag returns nothing
native          SetItemPawnable takes item i, boolean flag returns nothing
native          SetItemPlayer    takes item whichItem, player whichPlayer, boolean changeColor returns nothing
native          SetItemInvulnerable takes item whichItem, boolean flag returns nothing
native          IsItemInvulnerable  takes item whichItem returns boolean
native          SetItemVisible  takes item whichItem, boolean show returns nothing
native          IsItemVisible   takes item whichItem returns boolean
native          IsItemOwned     takes item whichItem returns boolean
native          IsItemPowerup   takes item whichItem returns boolean
native          IsItemSellable  takes item whichItem returns boolean
native          IsItemPawnable  takes item whichItem returns boolean
native          IsItemIdPowerup takes integer itemId returns boolean
native          IsItemIdSellable takes integer itemId returns boolean
native          IsItemIdPawnable takes integer itemId returns boolean
native          EnumItemsInRect     takes rect r, boolexpr filter, code actionFunc returns nothing
native          GetItemLevel    takes item whichItem returns integer
native          GetItemType     takes item whichItem returns itemtype
native          SetItemDropID   takes item whichItem, integer unitId returns nothing
native          GetItemCharges  takes item whichItem returns integer
native          SetItemCharges  takes item whichItem, integer charges returns nothing
native          GetItemUserData takes item whichItem returns integer
native          SetItemUserData takes item whichItem, integer data returns nothing
native          CreateUnit              takes player id, integer unitid, real x, real y, real face returns unit
native          CreateUnitByName        takes player whichPlayer, string unitname, real x, real y, real face returns unit
native          CreateUnitAtLoc         takes player id, integer unitid, location whichLocation, real face returns unit
native          CreateUnitAtLocByName   takes player id, string unitname, location whichLocation, real face returns unit
native          CreateCorpse            takes player whichPlayer, integer unitid, real x, real y, real face returns unit
native          KillUnit            takes unit whichUnit returns nothing
native          RemoveUnit          takes unit whichUnit returns nothing
native          ShowUnit            takes unit whichUnit, boolean show returns nothing
native          SetUnitState        takes unit whichUnit, unitstate whichUnitState, real newVal returns nothing
native          SetUnitX            takes unit whichUnit, real newX returns nothing
native          SetUnitY            takes unit whichUnit, real newY returns nothing
native          SetUnitPosition     takes unit whichUnit, real newX, real newY returns nothing
native          SetUnitPositionLoc  takes unit whichUnit, location whichLocation returns nothing
native          SetUnitFacing       takes unit whichUnit, real facingAngle returns nothing
native          SetUnitFacingTimed  takes unit whichUnit, real facingAngle, real duration returns nothing
native          SetUnitMoveSpeed    takes unit whichUnit, real newSpeed returns nothing
native          SetUnitFlyHeight    takes unit whichUnit, real newHeight, real rate returns nothing
native          SetUnitTurnSpeed    takes unit whichUnit, real newTurnSpeed returns nothing
native          SetUnitPropWindow   takes unit whichUnit, real newPropWindowAngle returns nothing
native          SetUnitAcquireRange takes unit whichUnit, real newAcquireRange returns nothing
native          SetUnitCreepGuard   takes unit whichUnit, boolean creepGuard returns nothing
native          GetUnitAcquireRange     takes unit whichUnit returns real
native          GetUnitTurnSpeed        takes unit whichUnit returns real
native          GetUnitPropWindow       takes unit whichUnit returns real
native          GetUnitFlyHeight        takes unit whichUnit returns real
native          GetUnitDefaultAcquireRange      takes unit whichUnit returns real
native          GetUnitDefaultTurnSpeed         takes unit whichUnit returns real
native          GetUnitDefaultPropWindow        takes unit whichUnit returns real
native          GetUnitDefaultFlyHeight         takes unit whichUnit returns real
native          SetUnitOwner        takes unit whichUnit, player whichPlayer, boolean changeColor returns nothing
native          SetUnitColor        takes unit whichUnit, playercolor whichColor returns nothing
native          SetUnitScale        takes unit whichUnit, real scaleX, real scaleY, real scaleZ returns nothing
native          SetUnitTimeScale    takes unit whichUnit, real timeScale returns nothing
native          SetUnitBlendTime    takes unit whichUnit, real blendTime returns nothing
native          SetUnitVertexColor  takes unit whichUnit, integer red, integer green, integer blue, integer alpha returns nothing
native          QueueUnitAnimation          takes unit whichUnit, string whichAnimation returns nothing
native          SetUnitAnimation            takes unit whichUnit, string whichAnimation returns nothing
native          SetUnitAnimationByIndex     takes unit whichUnit, integer whichAnimation returns nothing
native          SetUnitAnimationWithRarity  takes unit whichUnit, string whichAnimation, raritycontrol rarity returns nothing
native          AddUnitAnimationProperties  takes unit whichUnit, string animProperties, boolean add returns nothing
native          SetUnitLookAt       takes unit whichUnit, string whichBone, unit lookAtTarget, real offsetX, real offsetY, real offsetZ returns nothing
native          ResetUnitLookAt     takes unit whichUnit returns nothing
native          SetUnitRescuable    takes unit whichUnit, player byWhichPlayer, boolean flag returns nothing
native          SetUnitRescueRange  takes unit whichUnit, real range returns nothing
native          SetHeroStr          takes unit whichHero, integer newStr, boolean permanent returns nothing
native          SetHeroAgi          takes unit whichHero, integer newAgi, boolean permanent returns nothing
native          SetHeroInt          takes unit whichHero, integer newInt, boolean permanent returns nothing
native          GetHeroStr          takes unit whichHero, boolean includeBonuses returns integer
native          GetHeroAgi          takes unit whichHero, boolean includeBonuses returns integer
native          GetHeroInt          takes unit whichHero, boolean includeBonuses returns integer
native          UnitStripHeroLevel  takes unit whichHero, integer howManyLevels returns boolean
native          GetHeroXP           takes unit whichHero returns integer
native          SetHeroXP           takes unit whichHero, integer newXpVal,  boolean showEyeCandy returns nothing
native          GetHeroSkillPoints      takes unit whichHero returns integer
native          UnitModifySkillPoints   takes unit whichHero, integer skillPointDelta returns boolean
native          AddHeroXP           takes unit whichHero, integer xpToAdd,   boolean showEyeCandy returns nothing
native          SetHeroLevel        takes unit whichHero, integer level,  boolean showEyeCandy returns nothing
native          GetHeroProperName   takes unit whichHero returns string
native          SuspendHeroXP       takes unit whichHero, boolean flag returns nothing
native          IsSuspendedXP       takes unit whichHero returns boolean
native          SelectHeroSkill     takes unit whichHero, integer abilcode returns nothing
native          GetUnitAbilityLevel takes unit whichUnit, integer abilcode returns integer
native          DecUnitAbilityLevel takes unit whichUnit, integer abilcode returns integer
native          IncUnitAbilityLevel takes unit whichUnit, integer abilcode returns integer
native          SetUnitAbilityLevel takes unit whichUnit, integer abilcode, integer level returns integer
native          ReviveHero          takes unit whichHero, real x, real y, boolean doEyecandy returns boolean
native          ReviveHeroLoc       takes unit whichHero, location loc, boolean doEyecandy returns boolean
native          SetUnitExploded     takes unit whichUnit, boolean exploded returns nothing
native          SetUnitInvulnerable takes unit whichUnit, boolean flag returns nothing
native          PauseUnit           takes unit whichUnit, boolean flag returns nothing
native          IsUnitPaused        takes unit whichHero returns boolean
native          SetUnitPathing      takes unit whichUnit, boolean flag returns nothing
native          ClearSelection      takes nothing returns nothing
native          SelectUnit          takes unit whichUnit, boolean flag returns nothing
native          GetUnitPointValue       takes unit whichUnit returns integer
native          GetUnitPointValueByType takes integer unitType returns integer
native          UnitAddItem             takes unit whichUnit, item whichItem returns boolean
native          UnitAddItemById         takes unit whichUnit, integer itemId returns item
native          UnitAddItemToSlotById   takes unit whichUnit, integer itemId, integer itemSlot returns boolean
native          UnitRemoveItem          takes unit whichUnit, item whichItem returns nothing
native          UnitRemoveItemFromSlot  takes unit whichUnit, integer itemSlot returns item
native          UnitHasItem             takes unit whichUnit, item whichItem returns boolean
native          UnitItemInSlot          takes unit whichUnit, integer itemSlot returns item
native          UnitInventorySize       takes unit whichUnit returns integer
native          UnitDropItemPoint       takes unit whichUnit, item whichItem, real x, real y returns boolean
native          UnitDropItemSlot        takes unit whichUnit, item whichItem, integer slot returns boolean
native          UnitDropItemTarget      takes unit whichUnit, item whichItem, widget target returns boolean
native          UnitUseItem             takes unit whichUnit, item whichItem returns boolean
native          UnitUseItemPoint        takes unit whichUnit, item whichItem, real x, real y returns boolean
native          UnitUseItemTarget       takes unit whichUnit, item whichItem, widget target returns boolean
native          SetUnitUseFood      takes unit whichUnit, boolean useFood returns nothing
native UnitShareVision              takes unit whichUnit, player whichPlayer, boolean share returns nothing
native UnitSuspendDecay             takes unit whichUnit, boolean suspend returns nothing
native UnitAddType                  takes unit whichUnit, unittype whichUnitType returns boolean
native UnitRemoveType               takes unit whichUnit, unittype whichUnitType returns boolean
native UnitAddAbility               takes unit whichUnit, integer abilityId returns boolean
native UnitRemoveAbility            takes unit whichUnit, integer abilityId returns boolean
native UnitMakeAbilityPermanent     takes unit whichUnit, boolean permanent, integer abilityId returns boolean
native UnitRemoveBuffs              takes unit whichUnit, boolean removePositive, boolean removeNegative returns nothing
native UnitRemoveBuffsEx            takes unit whichUnit, boolean removePositive, boolean removeNegative, boolean magic, boolean physical, boolean timedLife, boolean aura, boolean autoDispel returns nothing
native UnitHasBuffsEx               takes unit whichUnit, boolean removePositive, boolean removeNegative, boolean magic, boolean physical, boolean timedLife, boolean aura, boolean autoDispel returns boolean
native UnitCountBuffsEx             takes unit whichUnit, boolean removePositive, boolean removeNegative, boolean magic, boolean physical, boolean timedLife, boolean aura, boolean autoDispel returns integer
native UnitAddSleep                 takes unit whichUnit, boolean add returns nothing
native UnitCanSleep                 takes unit whichUnit returns boolean
native UnitAddSleepPerm             takes unit whichUnit, boolean add returns nothing
native UnitCanSleepPerm             takes unit whichUnit returns boolean
native UnitIsSleeping               takes unit whichUnit returns boolean
native UnitWakeUp                   takes unit whichUnit returns nothing
native UnitApplyTimedLife           takes unit whichUnit, integer buffId, real duration returns nothing
native UnitIgnoreAlarm              takes unit whichUnit, boolean flag returns boolean
native UnitIgnoreAlarmToggled       takes unit whichUnit returns boolean
native UnitResetCooldown            takes unit whichUnit returns nothing
native UnitSetConstructionProgress  takes unit whichUnit, integer constructionPercentage returns nothing
native UnitSetUpgradeProgress       takes unit whichUnit, integer upgradePercentage returns nothing
native UnitPauseTimedLife           takes unit whichUnit, boolean flag returns nothing
native UnitSetUsesAltIcon           takes unit whichUnit, boolean flag returns nothing
native UnitDamagePoint              takes unit whichUnit, real delay, real radius, real x, real y, real amount, boolean attack, boolean ranged, attacktype attackType, damagetype damageType, weapontype weaponType returns boolean
native UnitDamageTarget             takes unit whichUnit, widget target, real amount, boolean attack, boolean ranged, attacktype attackType, damagetype damageType, weapontype weaponType returns boolean
native IssueImmediateOrder          takes unit whichUnit, string order returns boolean
native IssueImmediateOrderById      takes unit whichUnit, integer order returns boolean
native IssuePointOrder              takes unit whichUnit, string order, real x, real y returns boolean
native IssuePointOrderLoc           takes unit whichUnit, string order, location whichLocation returns boolean
native IssuePointOrderById          takes unit whichUnit, integer order, real x, real y returns boolean
native IssuePointOrderByIdLoc       takes unit whichUnit, integer order, location whichLocation returns boolean
native IssueTargetOrder             takes unit whichUnit, string order, widget targetWidget returns boolean
native IssueTargetOrderById         takes unit whichUnit, integer order, widget targetWidget returns boolean
native IssueInstantPointOrder       takes unit whichUnit, string order, real x, real y, widget instantTargetWidget returns boolean
native IssueInstantPointOrderById   takes unit whichUnit, integer order, real x, real y, widget instantTargetWidget returns boolean
native IssueInstantTargetOrder      takes unit whichUnit, string order, widget targetWidget, widget instantTargetWidget returns boolean
native IssueInstantTargetOrderById  takes unit whichUnit, integer order, widget targetWidget, widget instantTargetWidget returns boolean
native IssueBuildOrder              takes unit whichPeon, string unitToBuild, real x, real y returns boolean
native IssueBuildOrderById          takes unit whichPeon, integer unitId, real x, real y returns boolean
native IssueNeutralImmediateOrder       takes player forWhichPlayer, unit neutralStructure, string unitToBuild returns boolean
native IssueNeutralImmediateOrderById   takes player forWhichPlayer,unit neutralStructure, integer unitId returns boolean
native IssueNeutralPointOrder           takes player forWhichPlayer,unit neutralStructure, string unitToBuild, real x, real y returns boolean
native IssueNeutralPointOrderById       takes player forWhichPlayer,unit neutralStructure, integer unitId, real x, real y returns boolean
native IssueNeutralTargetOrder          takes player forWhichPlayer,unit neutralStructure, string unitToBuild, widget target returns boolean
native IssueNeutralTargetOrderById      takes player forWhichPlayer,unit neutralStructure, integer unitId, widget target returns boolean
native GetUnitCurrentOrder          takes unit whichUnit returns integer
native SetResourceAmount            takes unit whichUnit, integer amount returns nothing
native AddResourceAmount            takes unit whichUnit, integer amount returns nothing
native GetResourceAmount            takes unit whichUnit returns integer
native WaygateGetDestinationX       takes unit waygate returns real
native WaygateGetDestinationY       takes unit waygate returns real
native WaygateSetDestination        takes unit waygate, real x, real y returns nothing
native WaygateActivate              takes unit waygate, boolean activate returns nothing
native WaygateIsActive              takes unit waygate returns boolean
native AddItemToAllStock            takes integer itemId, integer currentStock, integer stockMax returns nothing
native AddItemToStock               takes unit whichUnit, integer itemId, integer currentStock, integer stockMax returns nothing
native AddUnitToAllStock            takes integer unitId, integer currentStock, integer stockMax returns nothing
native AddUnitToStock               takes unit whichUnit, integer unitId, integer currentStock, integer stockMax returns nothing
native RemoveItemFromAllStock       takes integer itemId returns nothing
native RemoveItemFromStock          takes unit whichUnit, integer itemId returns nothing
native RemoveUnitFromAllStock       takes integer unitId returns nothing
native RemoveUnitFromStock          takes unit whichUnit, integer unitId returns nothing
native SetAllItemTypeSlots          takes integer slots returns nothing
native SetAllUnitTypeSlots          takes integer slots returns nothing
native SetItemTypeSlots             takes unit whichUnit, integer slots returns nothing
native SetUnitTypeSlots             takes unit whichUnit, integer slots returns nothing
native GetUnitUserData              takes unit whichUnit returns integer
native SetUnitUserData              takes unit whichUnit, integer data returns nothing
native SetPlayerUnitsOwner takes player whichPlayer, integer newOwner returns nothing
native CripplePlayer takes player whichPlayer, force toWhichPlayers, boolean flag returns nothing
native SetPlayerAbilityAvailable        takes player whichPlayer, integer abilid, boolean avail returns nothing
native SetPlayerState   takes player whichPlayer, playerstate whichPlayerState, integer value returns nothing
native RemovePlayer     takes player whichPlayer, playergameresult gameResult returns nothing
native CachePlayerHeroData takes player whichPlayer returns nothing
native  SetFogStateRect      takes player forWhichPlayer, fogstate whichState, rect where, boolean useSharedVision returns nothing
native  SetFogStateRadius    takes player forWhichPlayer, fogstate whichState, real centerx, real centerY, real radius, boolean useSharedVision returns nothing
native  SetFogStateRadiusLoc takes player forWhichPlayer, fogstate whichState, location center, real radius, boolean useSharedVision returns nothing
native  FogMaskEnable        takes boolean enable returns nothing
native  IsFogMaskEnabled     takes nothing returns boolean
native  FogEnable            takes boolean enable returns nothing
native  IsFogEnabled         takes nothing returns boolean
native CreateFogModifierRect        takes player forWhichPlayer, fogstate whichState, rect where, boolean useSharedVision, boolean afterUnits returns fogmodifier
native CreateFogModifierRadius      takes player forWhichPlayer, fogstate whichState, real centerx, real centerY, real radius, boolean useSharedVision, boolean afterUnits returns fogmodifier
native CreateFogModifierRadiusLoc   takes player forWhichPlayer, fogstate whichState, location center, real radius, boolean useSharedVision, boolean afterUnits returns fogmodifier
native DestroyFogModifier           takes fogmodifier whichFogModifier returns nothing
native FogModifierStart             takes fogmodifier whichFogModifier returns nothing
native FogModifierStop              takes fogmodifier whichFogModifier returns nothing
native VersionGet takes nothing returns version
native VersionCompatible takes version whichVersion returns boolean
native VersionSupported takes version whichVersion returns boolean
native EndGame takes boolean doScoreScreen returns nothing
native          ChangeLevel         takes string newLevel, boolean doScoreScreen returns nothing
native          RestartGame         takes boolean doScoreScreen returns nothing
native          ReloadGame          takes nothing returns nothing
native          SetCampaignMenuRace takes race r returns nothing
native          SetCampaignMenuRaceEx takes integer campaignIndex returns nothing
native          ForceCampaignSelectScreen takes nothing returns nothing
native          LoadGame            takes string saveFileName, boolean doScoreScreen returns nothing
native          SaveGame            takes string saveFileName returns nothing
native          RenameSaveDirectory takes string sourceDirName, string destDirName returns boolean
native          RemoveSaveDirectory takes string sourceDirName returns boolean
native          CopySaveGame        takes string sourceSaveName, string destSaveName returns boolean
native          SaveGameExists      takes string saveName returns boolean
native          SyncSelections      takes nothing returns nothing
native          SetFloatGameState   takes fgamestate whichFloatGameState, real value returns nothing
native          SetIntegerGameState takes igamestate whichIntegerGameState, integer value returns nothing
native  SetTutorialCleared      takes boolean cleared returns nothing
native  SetMissionAvailable     takes integer campaignNumber, integer missionNumber, boolean available returns nothing
native  SetCampaignAvailable    takes integer campaignNumber, boolean available  returns nothing
native  SetOpCinematicAvailable takes integer campaignNumber, boolean available  returns nothing
native  SetEdCinematicAvailable takes integer campaignNumber, boolean available  returns nothing
native  GetDefaultDifficulty    takes nothing returns gamedifficulty
native  SetDefaultDifficulty    takes gamedifficulty g returns nothing
native  SetCustomCampaignButtonVisible  takes integer whichButton, boolean visible returns nothing
native  GetCustomCampaignButtonVisible  takes integer whichButton returns boolean
native  DoNotSaveReplay         takes nothing returns nothing
native DialogCreate                 takes nothing returns dialog
native DialogDestroy                takes dialog whichDialog returns nothing
native DialogClear                  takes dialog whichDialog returns nothing
native DialogSetMessage             takes dialog whichDialog, string messageText returns nothing
native DialogAddButton              takes dialog whichDialog, string buttonText, integer hotkey returns button
native DialogAddQuitButton          takes dialog whichDialog, boolean doScoreScreen, string buttonText, integer hotkey returns button
native DialogDisplay                takes player whichPlayer, dialog whichDialog, boolean flag returns nothing
native  ReloadGameCachesFromDisk takes nothing returns boolean
native  InitGameCache    takes string campaignFile returns gamecache
native  SaveGameCache    takes gamecache whichCache returns boolean
native  StoreInteger					takes gamecache cache, string missionKey, string key, integer value returns nothing
native  StoreReal						takes gamecache cache, string missionKey, string key, real value returns nothing
native  StoreBoolean					takes gamecache cache, string missionKey, string key, boolean value returns nothing
native  StoreUnit						takes gamecache cache, string missionKey, string key, unit whichUnit returns boolean
native  StoreString						takes gamecache cache, string missionKey, string key, string value returns boolean
native SyncStoredInteger        takes gamecache cache, string missionKey, string key returns nothing
native SyncStoredReal           takes gamecache cache, string missionKey, string key returns nothing
native SyncStoredBoolean        takes gamecache cache, string missionKey, string key returns nothing
native SyncStoredUnit           takes gamecache cache, string missionKey, string key returns nothing
native SyncStoredString         takes gamecache cache, string missionKey, string key returns nothing
native  HaveStoredInteger					takes gamecache cache, string missionKey, string key returns boolean
native  HaveStoredReal						takes gamecache cache, string missionKey, string key returns boolean
native  HaveStoredBoolean					takes gamecache cache, string missionKey, string key returns boolean
native  HaveStoredUnit						takes gamecache cache, string missionKey, string key returns boolean
native  HaveStoredString					takes gamecache cache, string missionKey, string key returns boolean
native  FlushGameCache						takes gamecache cache returns nothing
native  FlushStoredMission					takes gamecache cache, string missionKey returns nothing
native  FlushStoredInteger					takes gamecache cache, string missionKey, string key returns nothing
native  FlushStoredReal						takes gamecache cache, string missionKey, string key returns nothing
native  FlushStoredBoolean					takes gamecache cache, string missionKey, string key returns nothing
native  FlushStoredUnit						takes gamecache cache, string missionKey, string key returns nothing
native  FlushStoredString					takes gamecache cache, string missionKey, string key returns nothing
native  GetStoredInteger				takes gamecache cache, string missionKey, string key returns integer
native  GetStoredReal					takes gamecache cache, string missionKey, string key returns real
native  GetStoredBoolean				takes gamecache cache, string missionKey, string key returns boolean
native  GetStoredString					takes gamecache cache, string missionKey, string key returns string
native  RestoreUnit						takes gamecache cache, string missionKey, string key, player forWhichPlayer, real x, real y, real facing returns unit
native  InitHashtable    takes nothing returns hashtable
native  SaveInteger						takes hashtable table, integer parentKey, integer childKey, integer value returns nothing
native  SaveReal						takes hashtable table, integer parentKey, integer childKey, real value returns nothing
native  SaveBoolean						takes hashtable table, integer parentKey, integer childKey, boolean value returns nothing
native  SaveStr							takes hashtable table, integer parentKey, integer childKey, string value returns boolean
native  SavePlayerHandle				takes hashtable table, integer parentKey, integer childKey, player whichPlayer returns boolean
native  SaveWidgetHandle				takes hashtable table, integer parentKey, integer childKey, widget whichWidget returns boolean
native  SaveDestructableHandle			takes hashtable table, integer parentKey, integer childKey, destructable whichDestructable returns boolean
native  SaveItemHandle					takes hashtable table, integer parentKey, integer childKey, item whichItem returns boolean
native  SaveUnitHandle					takes hashtable table, integer parentKey, integer childKey, unit whichUnit returns boolean
native  SaveAbilityHandle				takes hashtable table, integer parentKey, integer childKey, ability whichAbility returns boolean
native  SaveTimerHandle					takes hashtable table, integer parentKey, integer childKey, timer whichTimer returns boolean
native  SaveTriggerHandle				takes hashtable table, integer parentKey, integer childKey, trigger whichTrigger returns boolean
native  SaveTriggerConditionHandle		takes hashtable table, integer parentKey, integer childKey, triggercondition whichTriggercondition returns boolean
native  SaveTriggerActionHandle			takes hashtable table, integer parentKey, integer childKey, triggeraction whichTriggeraction returns boolean
native  SaveTriggerEventHandle			takes hashtable table, integer parentKey, integer childKey, event whichEvent returns boolean
native  SaveForceHandle					takes hashtable table, integer parentKey, integer childKey, force whichForce returns boolean
native  SaveGroupHandle					takes hashtable table, integer parentKey, integer childKey, group whichGroup returns boolean
native  SaveLocationHandle				takes hashtable table, integer parentKey, integer childKey, location whichLocation returns boolean
native  SaveRectHandle					takes hashtable table, integer parentKey, integer childKey, rect whichRect returns boolean
native  SaveBooleanExprHandle			takes hashtable table, integer parentKey, integer childKey, boolexpr whichBoolexpr returns boolean
native  SaveSoundHandle					takes hashtable table, integer parentKey, integer childKey, sound whichSound returns boolean
native  SaveEffectHandle				takes hashtable table, integer parentKey, integer childKey, effect whichEffect returns boolean
native  SaveUnitPoolHandle				takes hashtable table, integer parentKey, integer childKey, unitpool whichUnitpool returns boolean
native  SaveItemPoolHandle				takes hashtable table, integer parentKey, integer childKey, itempool whichItempool returns boolean
native  SaveQuestHandle					takes hashtable table, integer parentKey, integer childKey, quest whichQuest returns boolean
native  SaveQuestItemHandle				takes hashtable table, integer parentKey, integer childKey, questitem whichQuestitem returns boolean
native  SaveDefeatConditionHandle		takes hashtable table, integer parentKey, integer childKey, defeatcondition whichDefeatcondition returns boolean
native  SaveTimerDialogHandle			takes hashtable table, integer parentKey, integer childKey, timerdialog whichTimerdialog returns boolean
native  SaveLeaderboardHandle			takes hashtable table, integer parentKey, integer childKey, leaderboard whichLeaderboard returns boolean
native  SaveMultiboardHandle			takes hashtable table, integer parentKey, integer childKey, multiboard whichMultiboard returns boolean
native  SaveMultiboardItemHandle		takes hashtable table, integer parentKey, integer childKey, multiboarditem whichMultiboarditem returns boolean
native  SaveTrackableHandle				takes hashtable table, integer parentKey, integer childKey, trackable whichTrackable returns boolean
native  SaveDialogHandle				takes hashtable table, integer parentKey, integer childKey, dialog whichDialog returns boolean
native  SaveButtonHandle				takes hashtable table, integer parentKey, integer childKey, button whichButton returns boolean
native  SaveTextTagHandle				takes hashtable table, integer parentKey, integer childKey, texttag whichTexttag returns boolean
native  SaveLightningHandle				takes hashtable table, integer parentKey, integer childKey, lightning whichLightning returns boolean
native  SaveImageHandle					takes hashtable table, integer parentKey, integer childKey, image whichImage returns boolean
native  SaveUbersplatHandle				takes hashtable table, integer parentKey, integer childKey, ubersplat whichUbersplat returns boolean
native  SaveRegionHandle				takes hashtable table, integer parentKey, integer childKey, region whichRegion returns boolean
native  SaveFogStateHandle				takes hashtable table, integer parentKey, integer childKey, fogstate whichFogState returns boolean
native  SaveFogModifierHandle			takes hashtable table, integer parentKey, integer childKey, fogmodifier whichFogModifier returns boolean
native  SaveAgentHandle					takes hashtable table, integer parentKey, integer childKey, agent whichAgent returns boolean
native  SaveHashtableHandle				takes hashtable table, integer parentKey, integer childKey, hashtable whichHashtable returns boolean
native  SaveFrameHandle					takes hashtable table, integer parentKey, integer childKey, framehandle whichFrameHandle returns boolean
native  LoadInteger					takes hashtable table, integer parentKey, integer childKey returns integer
native  LoadReal					takes hashtable table, integer parentKey, integer childKey returns real
native  LoadBoolean				    takes hashtable table, integer parentKey, integer childKey returns boolean
native  LoadStr 					takes hashtable table, integer parentKey, integer childKey returns string
native  LoadPlayerHandle			takes hashtable table, integer parentKey, integer childKey returns player
native  LoadWidgetHandle			takes hashtable table, integer parentKey, integer childKey returns widget
native  LoadDestructableHandle		takes hashtable table, integer parentKey, integer childKey returns destructable
native  LoadItemHandle				takes hashtable table, integer parentKey, integer childKey returns item
native  LoadUnitHandle				takes hashtable table, integer parentKey, integer childKey returns unit
native  LoadAbilityHandle			takes hashtable table, integer parentKey, integer childKey returns ability
native  LoadTimerHandle				takes hashtable table, integer parentKey, integer childKey returns timer
native  LoadTriggerHandle			takes hashtable table, integer parentKey, integer childKey returns trigger
native  LoadTriggerConditionHandle	takes hashtable table, integer parentKey, integer childKey returns triggercondition
native  LoadTriggerActionHandle		takes hashtable table, integer parentKey, integer childKey returns triggeraction
native  LoadTriggerEventHandle		takes hashtable table, integer parentKey, integer childKey returns event
native  LoadForceHandle				takes hashtable table, integer parentKey, integer childKey returns force
native  LoadGroupHandle				takes hashtable table, integer parentKey, integer childKey returns group
native  LoadLocationHandle			takes hashtable table, integer parentKey, integer childKey returns location
native  LoadRectHandle				takes hashtable table, integer parentKey, integer childKey returns rect
native  LoadBooleanExprHandle		takes hashtable table, integer parentKey, integer childKey returns boolexpr
native  LoadSoundHandle				takes hashtable table, integer parentKey, integer childKey returns sound
native  LoadEffectHandle			takes hashtable table, integer parentKey, integer childKey returns effect
native  LoadUnitPoolHandle			takes hashtable table, integer parentKey, integer childKey returns unitpool
native  LoadItemPoolHandle			takes hashtable table, integer parentKey, integer childKey returns itempool
native  LoadQuestHandle				takes hashtable table, integer parentKey, integer childKey returns quest
native  LoadQuestItemHandle			takes hashtable table, integer parentKey, integer childKey returns questitem
native  LoadDefeatConditionHandle	takes hashtable table, integer parentKey, integer childKey returns defeatcondition
native  LoadTimerDialogHandle		takes hashtable table, integer parentKey, integer childKey returns timerdialog
native  LoadLeaderboardHandle		takes hashtable table, integer parentKey, integer childKey returns leaderboard
native  LoadMultiboardHandle		takes hashtable table, integer parentKey, integer childKey returns multiboard
native  LoadMultiboardItemHandle	takes hashtable table, integer parentKey, integer childKey returns multiboarditem
native  LoadTrackableHandle			takes hashtable table, integer parentKey, integer childKey returns trackable
native  LoadDialogHandle			takes hashtable table, integer parentKey, integer childKey returns dialog
native  LoadButtonHandle			takes hashtable table, integer parentKey, integer childKey returns button
native  LoadTextTagHandle			takes hashtable table, integer parentKey, integer childKey returns texttag
native  LoadLightningHandle			takes hashtable table, integer parentKey, integer childKey returns lightning
native  LoadImageHandle				takes hashtable table, integer parentKey, integer childKey returns image
native  LoadUbersplatHandle			takes hashtable table, integer parentKey, integer childKey returns ubersplat
native  LoadRegionHandle			takes hashtable table, integer parentKey, integer childKey returns region
native  LoadFogStateHandle			takes hashtable table, integer parentKey, integer childKey returns fogstate
native  LoadFogModifierHandle		takes hashtable table, integer parentKey, integer childKey returns fogmodifier
native  LoadHashtableHandle			takes hashtable table, integer parentKey, integer childKey returns hashtable
native  LoadFrameHandle				takes hashtable table, integer parentKey, integer childKey returns framehandle
native  HaveSavedInteger					takes hashtable table, integer parentKey, integer childKey returns boolean
native  HaveSavedReal						takes hashtable table, integer parentKey, integer childKey returns boolean
native  HaveSavedBoolean					takes hashtable table, integer parentKey, integer childKey returns boolean
native  HaveSavedString					    takes hashtable table, integer parentKey, integer childKey returns boolean
native  HaveSavedHandle     				takes hashtable table, integer parentKey, integer childKey returns boolean
native  RemoveSavedInteger					takes hashtable table, integer parentKey, integer childKey returns nothing
native  RemoveSavedReal						takes hashtable table, integer parentKey, integer childKey returns nothing
native  RemoveSavedBoolean					takes hashtable table, integer parentKey, integer childKey returns nothing
native  RemoveSavedString					takes hashtable table, integer parentKey, integer childKey returns nothing
native  RemoveSavedHandle					takes hashtable table, integer parentKey, integer childKey returns nothing
native  FlushParentHashtable						takes hashtable table returns nothing
native  FlushChildHashtable					takes hashtable table, integer parentKey returns nothing
native GetRandomInt takes integer lowBound, integer highBound returns integer
native GetRandomReal takes real lowBound, real highBound returns real
native CreateUnitPool           takes nothing returns unitpool
native DestroyUnitPool          takes unitpool whichPool returns nothing
native UnitPoolAddUnitType      takes unitpool whichPool, integer unitId, real weight returns nothing
native UnitPoolRemoveUnitType   takes unitpool whichPool, integer unitId returns nothing
native PlaceRandomUnit          takes unitpool whichPool, player forWhichPlayer, real x, real y, real facing returns unit
native CreateItemPool           takes nothing returns itempool
native DestroyItemPool          takes itempool whichItemPool returns nothing
native ItemPoolAddItemType      takes itempool whichItemPool, integer itemId, real weight returns nothing
native ItemPoolRemoveItemType   takes itempool whichItemPool, integer itemId returns nothing
native PlaceRandomItem          takes itempool whichItemPool, real x, real y returns item
native ChooseRandomCreep        takes integer level returns integer
native ChooseRandomNPBuilding   takes nothing returns integer
native ChooseRandomItem         takes integer level returns integer
native ChooseRandomItemEx       takes itemtype whichType, integer level returns integer
native SetRandomSeed            takes integer seed returns nothing
native SetTerrainFog                takes real a, real b, real c, real d, real e returns nothing
native ResetTerrainFog              takes nothing returns nothing
native SetUnitFog                   takes real a, real b, real c, real d, real e returns nothing
native SetTerrainFogEx              takes integer style, real zstart, real zend, real density, real red, real green, real blue returns nothing
native DisplayTextToPlayer          takes player toPlayer, real x, real y, string message returns nothing
native DisplayTimedTextToPlayer     takes player toPlayer, real x, real y, real duration, string message returns nothing
native DisplayTimedTextFromPlayer   takes player toPlayer, real x, real y, real duration, string message returns nothing
native ClearTextMessages            takes nothing returns nothing
native SetDayNightModels            takes string terrainDNCFile, string unitDNCFile returns nothing
native SetSkyModel                  takes string skyModelFile returns nothing
native EnableUserControl            takes boolean b returns nothing
native EnableUserUI                 takes boolean b returns nothing
native SuspendTimeOfDay             takes boolean b returns nothing
native SetTimeOfDayScale            takes real r returns nothing
native GetTimeOfDayScale            takes nothing returns real
native ShowInterface                takes boolean flag, real fadeDuration returns nothing
native PauseGame                    takes boolean flag returns nothing
native UnitAddIndicator             takes unit whichUnit, integer red, integer green, integer blue, integer alpha returns nothing
native AddIndicator                 takes widget whichWidget, integer red, integer green, integer blue, integer alpha returns nothing
native PingMinimap                  takes real x, real y, real duration returns nothing
native PingMinimapEx                takes real x, real y, real duration, integer red, integer green, integer blue, boolean extraEffects returns nothing
native EnableOcclusion              takes boolean flag returns nothing
native SetIntroShotText             takes string introText returns nothing
native SetIntroShotModel            takes string introModelPath returns nothing
native EnableWorldFogBoundary       takes boolean b returns nothing
native PlayModelCinematic           takes string modelName returns nothing
native PlayCinematic                takes string movieName returns nothing
native ForceUIKey                   takes string key returns nothing
native ForceUICancel                takes nothing returns nothing
native DisplayLoadDialog            takes nothing returns nothing
native SetAltMinimapIcon            takes string iconPath returns nothing
native DisableRestartMission        takes boolean flag returns nothing
native CreateTextTag                takes nothing returns texttag
native DestroyTextTag               takes texttag t returns nothing
native SetTextTagText               takes texttag t, string s, real height returns nothing
native SetTextTagPos                takes texttag t, real x, real y, real heightOffset returns nothing
native SetTextTagPosUnit            takes texttag t, unit whichUnit, real heightOffset returns nothing
native SetTextTagColor              takes texttag t, integer red, integer green, integer blue, integer alpha returns nothing
native SetTextTagVelocity           takes texttag t, real xvel, real yvel returns nothing
native SetTextTagVisibility         takes texttag t, boolean flag returns nothing
native SetTextTagSuspended          takes texttag t, boolean flag returns nothing
native SetTextTagPermanent          takes texttag t, boolean flag returns nothing
native SetTextTagAge                takes texttag t, real age returns nothing
native SetTextTagLifespan           takes texttag t, real lifespan returns nothing
native SetTextTagFadepoint          takes texttag t, real fadepoint returns nothing
native SetReservedLocalHeroButtons  takes integer reserved returns nothing
native GetAllyColorFilterState      takes nothing returns integer
native SetAllyColorFilterState      takes integer state returns nothing
native GetCreepCampFilterState      takes nothing returns boolean
native SetCreepCampFilterState      takes boolean state returns nothing
native EnableMinimapFilterButtons   takes boolean enableAlly, boolean enableCreep returns nothing
native EnableDragSelect             takes boolean state, boolean ui returns nothing
native EnablePreSelect              takes boolean state, boolean ui returns nothing
native EnableSelect                 takes boolean state, boolean ui returns nothing
native CreateTrackable      takes string trackableModelPath, real x, real y, real facing returns trackable
native CreateQuest          takes nothing returns quest
native DestroyQuest         takes quest whichQuest returns nothing
native QuestSetTitle        takes quest whichQuest, string title returns nothing
native QuestSetDescription  takes quest whichQuest, string description returns nothing
native QuestSetIconPath     takes quest whichQuest, string iconPath returns nothing
native QuestSetRequired     takes quest whichQuest, boolean required   returns nothing
native QuestSetCompleted    takes quest whichQuest, boolean completed  returns nothing
native QuestSetDiscovered   takes quest whichQuest, boolean discovered returns nothing
native QuestSetFailed       takes quest whichQuest, boolean failed     returns nothing
native QuestSetEnabled      takes quest whichQuest, boolean enabled    returns nothing
native IsQuestRequired     takes quest whichQuest returns boolean
native IsQuestCompleted    takes quest whichQuest returns boolean
native IsQuestDiscovered   takes quest whichQuest returns boolean
native IsQuestFailed       takes quest whichQuest returns boolean
native IsQuestEnabled      takes quest whichQuest returns boolean
native QuestCreateItem          takes quest whichQuest returns questitem
native QuestItemSetDescription  takes questitem whichQuestItem, string description returns nothing
native QuestItemSetCompleted    takes questitem whichQuestItem, boolean completed returns nothing
native IsQuestItemCompleted     takes questitem whichQuestItem returns boolean
native CreateDefeatCondition            takes nothing returns defeatcondition
native DestroyDefeatCondition           takes defeatcondition whichCondition returns nothing
native DefeatConditionSetDescription    takes defeatcondition whichCondition, string description returns nothing
native FlashQuestDialogButton   takes nothing returns nothing
native ForceQuestDialogUpdate   takes nothing returns nothing
native CreateTimerDialog                takes timer t returns timerdialog
native DestroyTimerDialog               takes timerdialog whichDialog returns nothing
native TimerDialogSetTitle              takes timerdialog whichDialog, string title returns nothing
native TimerDialogSetTitleColor         takes timerdialog whichDialog, integer red, integer green, integer blue, integer alpha returns nothing
native TimerDialogSetTimeColor          takes timerdialog whichDialog, integer red, integer green, integer blue, integer alpha returns nothing
native TimerDialogSetSpeed              takes timerdialog whichDialog, real speedMultFactor returns nothing
native TimerDialogDisplay               takes timerdialog whichDialog, boolean display returns nothing
native IsTimerDialogDisplayed           takes timerdialog whichDialog returns boolean
native TimerDialogSetRealTimeRemaining  takes timerdialog whichDialog, real timeRemaining returns nothing
native CreateLeaderboard                takes nothing returns leaderboard
native DestroyLeaderboard               takes leaderboard lb returns nothing
native LeaderboardDisplay               takes leaderboard lb, boolean show returns nothing
native IsLeaderboardDisplayed           takes leaderboard lb returns boolean
native LeaderboardGetItemCount          takes leaderboard lb returns integer
native LeaderboardSetSizeByItemCount    takes leaderboard lb, integer count returns nothing
native LeaderboardAddItem               takes leaderboard lb, string label, integer value, player p returns nothing
native LeaderboardRemoveItem            takes leaderboard lb, integer index returns nothing
native LeaderboardRemovePlayerItem      takes leaderboard lb, player p returns nothing
native LeaderboardClear                 takes leaderboard lb returns nothing
native LeaderboardSortItemsByValue      takes leaderboard lb, boolean ascending returns nothing
native LeaderboardSortItemsByPlayer     takes leaderboard lb, boolean ascending returns nothing
native LeaderboardSortItemsByLabel      takes leaderboard lb, boolean ascending returns nothing
native LeaderboardHasPlayerItem         takes leaderboard lb, player p returns boolean
native LeaderboardGetPlayerIndex        takes leaderboard lb, player p returns integer
native LeaderboardSetLabel              takes leaderboard lb, string label returns nothing
native LeaderboardGetLabelText          takes leaderboard lb returns string
native PlayerSetLeaderboard             takes player toPlayer, leaderboard lb returns nothing
native PlayerGetLeaderboard             takes player toPlayer returns leaderboard
native LeaderboardSetLabelColor         takes leaderboard lb, integer red, integer green, integer blue, integer alpha returns nothing
native LeaderboardSetValueColor         takes leaderboard lb, integer red, integer green, integer blue, integer alpha returns nothing
native LeaderboardSetStyle              takes leaderboard lb, boolean showLabel, boolean showNames, boolean showValues, boolean showIcons returns nothing
native LeaderboardSetItemValue          takes leaderboard lb, integer whichItem, integer val returns nothing
native LeaderboardSetItemLabel          takes leaderboard lb, integer whichItem, string val returns nothing
native LeaderboardSetItemStyle          takes leaderboard lb, integer whichItem, boolean showLabel, boolean showValue, boolean showIcon returns nothing
native LeaderboardSetItemLabelColor     takes leaderboard lb, integer whichItem, integer red, integer green, integer blue, integer alpha returns nothing
native LeaderboardSetItemValueColor     takes leaderboard lb, integer whichItem, integer red, integer green, integer blue, integer alpha returns nothing
native CreateMultiboard                 takes nothing returns multiboard
native DestroyMultiboard                takes multiboard lb returns nothing
native MultiboardDisplay                takes multiboard lb, boolean show returns nothing
native IsMultiboardDisplayed            takes multiboard lb returns boolean
native MultiboardMinimize               takes multiboard lb, boolean minimize returns nothing
native IsMultiboardMinimized            takes multiboard lb returns boolean
native MultiboardClear                  takes multiboard lb returns nothing
native MultiboardSetTitleText           takes multiboard lb, string label returns nothing
native MultiboardGetTitleText           takes multiboard lb returns string
native MultiboardSetTitleTextColor      takes multiboard lb, integer red, integer green, integer blue, integer alpha returns nothing
native MultiboardGetRowCount            takes multiboard lb returns integer
native MultiboardGetColumnCount         takes multiboard lb returns integer
native MultiboardSetColumnCount         takes multiboard lb, integer count returns nothing
native MultiboardSetRowCount            takes multiboard lb, integer count returns nothing
native MultiboardSetItemsStyle          takes multiboard lb, boolean showValues, boolean showIcons returns nothing
native MultiboardSetItemsValue          takes multiboard lb, string value returns nothing
native MultiboardSetItemsValueColor     takes multiboard lb, integer red, integer green, integer blue, integer alpha returns nothing
native MultiboardSetItemsWidth          takes multiboard lb, real width returns nothing
native MultiboardSetItemsIcon           takes multiboard lb, string iconPath returns nothing
native MultiboardGetItem                takes multiboard lb, integer row, integer column returns multiboarditem
native MultiboardReleaseItem            takes multiboarditem mbi returns nothing
native MultiboardSetItemStyle           takes multiboarditem mbi, boolean showValue, boolean showIcon returns nothing
native MultiboardSetItemValue           takes multiboarditem mbi, string val returns nothing
native MultiboardSetItemValueColor      takes multiboarditem mbi, integer red, integer green, integer blue, integer alpha returns nothing
native MultiboardSetItemWidth           takes multiboarditem mbi, real width returns nothing
native MultiboardSetItemIcon            takes multiboarditem mbi, string iconFileName returns nothing
native MultiboardSuppressDisplay        takes boolean flag returns nothing
native SetCameraPosition            takes real x, real y returns nothing
native SetCameraQuickPosition       takes real x, real y returns nothing
native SetCameraBounds              takes real x1, real y1, real x2, real y2, real x3, real y3, real x4, real y4 returns nothing
native StopCamera                   takes nothing returns nothing
native ResetToGameCamera            takes real duration returns nothing
native PanCameraTo                  takes real x, real y returns nothing
native PanCameraToTimed             takes real x, real y, real duration returns nothing
native PanCameraToWithZ             takes real x, real y, real zOffsetDest returns nothing
native PanCameraToTimedWithZ        takes real x, real y, real zOffsetDest, real duration returns nothing
native SetCinematicCamera           takes string cameraModelFile returns nothing
native SetCameraRotateMode          takes real x, real y, real radiansToSweep, real duration returns nothing
native SetCameraField               takes camerafield whichField, real value, real duration returns nothing
native AdjustCameraField            takes camerafield whichField, real offset, real duration returns nothing
native SetCameraTargetController    takes unit whichUnit, real xoffset, real yoffset, boolean inheritOrientation returns nothing
native SetCameraOrientController    takes unit whichUnit, real xoffset, real yoffset returns nothing
native CreateCameraSetup                    takes nothing returns camerasetup
native CameraSetupSetField                  takes camerasetup whichSetup, camerafield whichField, real value, real duration returns nothing
native CameraSetupGetField                  takes camerasetup whichSetup, camerafield whichField returns real
native CameraSetupSetDestPosition           takes camerasetup whichSetup, real x, real y, real duration returns nothing
native CameraSetupGetDestPositionLoc        takes camerasetup whichSetup returns location
native CameraSetupGetDestPositionX          takes camerasetup whichSetup returns real
native CameraSetupGetDestPositionY          takes camerasetup whichSetup returns real
native CameraSetupApply                     takes camerasetup whichSetup, boolean doPan, boolean panTimed returns nothing
native CameraSetupApplyWithZ                takes camerasetup whichSetup, real zDestOffset returns nothing
native CameraSetupApplyForceDuration        takes camerasetup whichSetup, boolean doPan, real forceDuration returns nothing
native CameraSetupApplyForceDurationWithZ   takes camerasetup whichSetup, real zDestOffset, real forceDuration returns nothing
native CameraSetTargetNoise             takes real mag, real velocity returns nothing
native CameraSetSourceNoise             takes real mag, real velocity returns nothing
native CameraSetTargetNoiseEx           takes real mag, real velocity, boolean vertOnly returns nothing
native CameraSetSourceNoiseEx           takes real mag, real velocity, boolean vertOnly returns nothing
native CameraSetSmoothingFactor         takes real factor returns nothing
native SetCineFilterTexture             takes string filename returns nothing
native SetCineFilterBlendMode           takes blendmode whichMode returns nothing
native SetCineFilterTexMapFlags         takes texmapflags whichFlags returns nothing
native SetCineFilterStartUV             takes real minu, real minv, real maxu, real maxv returns nothing
native SetCineFilterEndUV               takes real minu, real minv, real maxu, real maxv returns nothing
native SetCineFilterStartColor          takes integer red, integer green, integer blue, integer alpha returns nothing
native SetCineFilterEndColor            takes integer red, integer green, integer blue, integer alpha returns nothing
native SetCineFilterDuration            takes real duration returns nothing
native DisplayCineFilter                takes boolean flag returns nothing
native IsCineFilterDisplayed            takes nothing returns boolean
native SetCinematicScene                takes integer portraitUnitId, playercolor color, string speakerTitle, string text, real sceneDuration, real voiceoverDuration returns nothing
native EndCinematicScene                takes nothing returns nothing
native ForceCinematicSubtitles          takes boolean flag returns nothing
native GetCameraMargin                  takes integer whichMargin returns real
native NewSoundEnvironment          takes string environmentName returns nothing
native CreateSound                  takes string fileName, boolean looping, boolean is3D, boolean stopwhenoutofrange, integer fadeInRate, integer fadeOutRate, string eaxSetting returns sound
native CreateSoundFilenameWithLabel takes string fileName, boolean looping, boolean is3D, boolean stopwhenoutofrange, integer fadeInRate, integer fadeOutRate, string SLKEntryName returns sound
native CreateSoundFromLabel         takes string soundLabel, boolean looping, boolean is3D, boolean stopwhenoutofrange, integer fadeInRate, integer fadeOutRate returns sound
native CreateMIDISound              takes string soundLabel, integer fadeInRate, integer fadeOutRate returns sound
native SetSoundParamsFromLabel      takes sound soundHandle, string soundLabel returns nothing
native SetSoundDistanceCutoff       takes sound soundHandle, real cutoff returns nothing
native SetSoundChannel              takes sound soundHandle, integer channel returns nothing
native SetSoundVolume               takes sound soundHandle, integer volume returns nothing
native SetSoundPitch                takes sound soundHandle, real pitch returns nothing
native SetSoundPlayPosition         takes sound soundHandle, integer millisecs returns nothing
native SetSoundDistances            takes sound soundHandle, real minDist, real maxDist returns nothing
native SetSoundConeAngles           takes sound soundHandle, real inside, real outside, integer outsideVolume returns nothing
native SetSoundConeOrientation      takes sound soundHandle, real x, real y, real z returns nothing
native SetSoundPosition             takes sound soundHandle, real x, real y, real z returns nothing
native SetSoundVelocity             takes sound soundHandle, real x, real y, real z returns nothing
native AttachSoundToUnit            takes sound soundHandle, unit whichUnit returns nothing
native StartSound                   takes sound soundHandle returns nothing
native StopSound                    takes sound soundHandle, boolean killWhenDone, boolean fadeOut returns nothing
native KillSoundWhenDone            takes sound soundHandle returns nothing
native SetMapMusic                  takes string musicName, boolean random, integer index returns nothing
native ClearMapMusic                takes nothing returns nothing
native PlayMusic                    takes string musicName returns nothing
native PlayMusicEx                  takes string musicName, integer frommsecs, integer fadeinmsecs returns nothing
native StopMusic                    takes boolean fadeOut returns nothing
native ResumeMusic                  takes nothing returns nothing
native PlayThematicMusic            takes string musicFileName returns nothing
native PlayThematicMusicEx          takes string musicFileName, integer frommsecs returns nothing
native EndThematicMusic             takes nothing returns nothing
native SetMusicVolume               takes integer volume returns nothing
native SetMusicPlayPosition         takes integer millisecs returns nothing
native SetThematicMusicPlayPosition takes integer millisecs returns nothing
native SetSoundDuration             takes sound soundHandle, integer duration returns nothing
native GetSoundDuration             takes sound soundHandle returns integer
native GetSoundFileDuration         takes string musicFileName returns integer
native VolumeGroupSetVolume         takes volumegroup vgroup, real scale returns nothing
native VolumeGroupReset             takes nothing returns nothing
native GetSoundIsPlaying            takes sound soundHandle returns boolean
native GetSoundIsLoading            takes sound soundHandle returns boolean
native RegisterStackedSound         takes sound soundHandle, boolean byPosition, real rectwidth, real rectheight returns nothing
native UnregisterStackedSound       takes sound soundHandle, boolean byPosition, real rectwidth, real rectheight returns nothing
native AddWeatherEffect             takes rect where, integer effectID returns weathereffect
native RemoveWeatherEffect          takes weathereffect whichEffect returns nothing
native EnableWeatherEffect          takes weathereffect whichEffect, boolean enable returns nothing
native TerrainDeformCrater          takes real x, real y, real radius, real depth, integer duration, boolean permanent returns terraindeformation
native TerrainDeformRipple          takes real x, real y, real radius, real depth, integer duration, integer count, real spaceWaves, real timeWaves, real radiusStartPct, boolean limitNeg returns terraindeformation
native TerrainDeformWave            takes real x, real y, real dirX, real dirY, real distance, real speed, real radius, real depth, integer trailTime, integer count returns terraindeformation
native TerrainDeformRandom          takes real x, real y, real radius, real minDelta, real maxDelta, integer duration, integer updateInterval returns terraindeformation
native TerrainDeformStop            takes terraindeformation deformation, integer duration returns nothing
native TerrainDeformStopAll         takes nothing returns nothing
native AddSpecialEffect             takes string modelName, real x, real y returns effect
native AddSpecialEffectLoc          takes string modelName, location where returns effect
native AddSpecialEffectTarget       takes string modelName, widget targetWidget, string attachPointName returns effect
native DestroyEffect                takes effect whichEffect returns nothing
native AddSpellEffect               takes string abilityString, effecttype t, real x, real y returns effect
native AddSpellEffectLoc            takes string abilityString, effecttype t,location where returns effect
native AddSpellEffectById           takes integer abilityId, effecttype t,real x, real y returns effect
native AddSpellEffectByIdLoc        takes integer abilityId, effecttype t,location where returns effect
native AddSpellEffectTarget         takes string modelName, effecttype t, widget targetWidget, string attachPoint returns effect
native AddSpellEffectTargetById     takes integer abilityId, effecttype t, widget targetWidget, string attachPoint returns effect
native AddLightning                 takes string codeName, boolean checkVisibility, real x1, real y1, real x2, real y2 returns lightning
native AddLightningEx               takes string codeName, boolean checkVisibility, real x1, real y1, real z1, real x2, real y2, real z2 returns lightning
native DestroyLightning             takes lightning whichBolt returns boolean
native MoveLightning                takes lightning whichBolt, boolean checkVisibility, real x1, real y1, real x2, real y2 returns boolean
native MoveLightningEx              takes lightning whichBolt, boolean checkVisibility, real x1, real y1, real z1, real x2, real y2, real z2 returns boolean
native GetLightningColorA           takes lightning whichBolt returns real
native GetLightningColorR           takes lightning whichBolt returns real
native GetLightningColorG           takes lightning whichBolt returns real
native GetLightningColorB           takes lightning whichBolt returns real
native SetLightningColor            takes lightning whichBolt, real r, real g, real b, real a returns boolean
native GetAbilityEffect             takes string abilityString, effecttype t, integer index returns string
native GetAbilityEffectById         takes integer abilityId, effecttype t, integer index returns string
native GetAbilitySound              takes string abilityString, soundtype t returns string
native GetAbilitySoundById          takes integer abilityId, soundtype t returns string
native GetTerrainCliffLevel         takes real x, real y returns integer
native SetWaterBaseColor            takes integer red, integer green, integer blue, integer alpha returns nothing
native SetWaterDeforms              takes boolean val returns nothing
native GetTerrainType               takes real x, real y returns integer
native GetTerrainVariance           takes real x, real y returns integer
native SetTerrainType               takes real x, real y, integer terrainType, integer variation, integer area, integer shape returns nothing
native IsTerrainPathable            takes real x, real y, pathingtype t returns boolean
native SetTerrainPathable           takes real x, real y, pathingtype t, boolean flag returns nothing
native CreateImage                  takes string file, real sizeX, real sizeY, real sizeZ, real posX, real posY, real posZ, real originX, real originY, real originZ, integer imageType returns image
native DestroyImage                 takes image whichImage returns nothing
native ShowImage                    takes image whichImage, boolean flag returns nothing
native SetImageConstantHeight       takes image whichImage, boolean flag, real height returns nothing
native SetImagePosition             takes image whichImage, real x, real y, real z returns nothing
native SetImageColor                takes image whichImage, integer red, integer green, integer blue, integer alpha returns nothing
native SetImageRender               takes image whichImage, boolean flag returns nothing
native SetImageRenderAlways         takes image whichImage, boolean flag returns nothing
native SetImageAboveWater           takes image whichImage, boolean flag, boolean useWaterAlpha returns nothing
native SetImageType                 takes image whichImage, integer imageType returns nothing
native CreateUbersplat              takes real x, real y, string name, integer red, integer green, integer blue, integer alpha, boolean forcePaused, boolean noBirthTime returns ubersplat
native DestroyUbersplat             takes ubersplat whichSplat returns nothing
native ResetUbersplat               takes ubersplat whichSplat returns nothing
native FinishUbersplat              takes ubersplat whichSplat returns nothing
native ShowUbersplat                takes ubersplat whichSplat, boolean flag returns nothing
native SetUbersplatRender           takes ubersplat whichSplat, boolean flag returns nothing
native SetUbersplatRenderAlways     takes ubersplat whichSplat, boolean flag returns nothing
native SetBlight                takes player whichPlayer, real x, real y, real radius, boolean addBlight returns nothing
native SetBlightRect            takes player whichPlayer, rect r, boolean addBlight returns nothing
native SetBlightPoint           takes player whichPlayer, real x, real y, boolean addBlight returns nothing
native SetBlightLoc             takes player whichPlayer, location whichLocation, real radius, boolean addBlight returns nothing
native CreateBlightedGoldmine   takes player id, real x, real y, real face returns unit
native IsPointBlighted          takes real x, real y returns boolean
native SetDoodadAnimation       takes real x, real y, real radius, integer doodadID, boolean nearestOnly, string animName, boolean animRandom returns nothing
native SetDoodadAnimationRect   takes rect r, integer doodadID, string animName, boolean animRandom returns nothing
native StartMeleeAI         takes player num, string script                 returns nothing
native StartCampaignAI      takes player num, string script                 returns nothing
native CommandAI            takes player num, integer command, integer data returns nothing
native PauseCompAI          takes player p,   boolean pause                 returns nothing
native GetAIDifficulty      takes player num                                returns aidifficulty
native RemoveGuardPosition  takes unit hUnit                                returns nothing
native RecycleGuardPosition takes unit hUnit                                returns nothing
native RemoveAllGuardPositions takes player num                             returns nothing
native Cheat            takes string cheatStr returns nothing
native IsNoVictoryCheat takes nothing returns boolean
native IsNoDefeatCheat  takes nothing returns boolean
native Preload          takes string filename returns nothing
native PreloadEnd       takes real timeout returns nothing
native PreloadStart     takes nothing returns nothing
native PreloadRefresh   takes nothing returns nothing
native PreloadEndEx     takes nothing returns nothing
native PreloadGenClear  takes nothing returns nothing
native PreloadGenStart  takes nothing returns nothing
native PreloadGenEnd    takes string filename returns nothing
native Preloader        takes string filename returns nothing
native AutomationSetTestType                    takes string testType returns nothing
native AutomationTestStart                      takes string testName returns nothing
native AutomationTestEnd                        takes nothing returns nothing
native AutomationTestingFinished                takes nothing returns nothing
native BlzGetTriggerPlayerMouseX                   takes nothing returns real
native BlzGetTriggerPlayerMouseY                   takes nothing returns real
native BlzGetTriggerPlayerMousePosition            takes nothing returns location
native BlzGetTriggerPlayerMouseButton              takes nothing returns mousebuttontype
native BlzSetAbilityTooltip                        takes integer abilCode, string tooltip, integer level returns nothing
native BlzSetAbilityActivatedTooltip               takes integer abilCode, string tooltip, integer level returns nothing
native BlzSetAbilityExtendedTooltip                takes integer abilCode, string extendedTooltip, integer level returns nothing
native BlzSetAbilityActivatedExtendedTooltip       takes integer abilCode, string extendedTooltip, integer level returns nothing
native BlzSetAbilityResearchTooltip                takes integer abilCode, string researchTooltip, integer level returns nothing
native BlzSetAbilityResearchExtendedTooltip        takes integer abilCode, string researchExtendedTooltip, integer level returns nothing
native BlzGetAbilityTooltip                        takes integer abilCode, integer level returns string
native BlzGetAbilityActivatedTooltip               takes integer abilCode, integer level returns string
native BlzGetAbilityExtendedTooltip                takes integer abilCode, integer level returns string
native BlzGetAbilityActivatedExtendedTooltip       takes integer abilCode, integer level returns string
native BlzGetAbilityResearchTooltip                takes integer abilCode, integer level returns string
native BlzGetAbilityResearchExtendedTooltip        takes integer abilCode, integer level returns string
native BlzSetAbilityIcon                           takes integer abilCode, string iconPath returns nothing
native BlzGetAbilityIcon                           takes integer abilCode returns string
native BlzSetAbilityActivatedIcon                  takes integer abilCode, string iconPath returns nothing
native BlzGetAbilityActivatedIcon                  takes integer abilCode returns string
native BlzGetAbilityPosX                           takes integer abilCode returns integer
native BlzGetAbilityPosY                           takes integer abilCode returns integer
native BlzSetAbilityPosX                           takes integer abilCode, integer x returns nothing
native BlzSetAbilityPosY                           takes integer abilCode, integer y returns nothing
native BlzGetAbilityActivatedPosX                  takes integer abilCode returns integer
native BlzGetAbilityActivatedPosY                  takes integer abilCode returns integer
native BlzSetAbilityActivatedPosX                  takes integer abilCode, integer x returns nothing
native BlzSetAbilityActivatedPosY                  takes integer abilCode, integer y returns nothing
native BlzGetUnitMaxHP                             takes unit whichUnit returns integer
native BlzSetUnitMaxHP                             takes unit whichUnit, integer hp returns nothing
native BlzGetUnitMaxMana                           takes unit whichUnit returns integer
native BlzSetUnitMaxMana                           takes unit whichUnit, integer mana returns nothing
native BlzSetItemName                              takes item whichItem, string name returns nothing
native BlzSetItemDescription                       takes item whichItem, string description returns nothing
native BlzGetItemDescription                       takes item whichItem returns string
native BlzSetItemTooltip                           takes item whichItem, string tooltip returns nothing
native BlzGetItemTooltip                           takes item whichItem returns string
native BlzSetItemExtendedTooltip                   takes item whichItem, string extendedTooltip returns nothing
native BlzGetItemExtendedTooltip                   takes item whichItem returns string
native BlzSetItemIconPath                          takes item whichItem, string iconPath returns nothing
native BlzGetItemIconPath                          takes item whichItem returns string
native BlzSetUnitName                              takes unit whichUnit, string name returns nothing
native BlzSetHeroProperName                        takes unit whichUnit, string heroProperName returns nothing
native BlzGetUnitBaseDamage                        takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitBaseDamage                        takes unit whichUnit, integer baseDamage, integer weaponIndex returns nothing
native BlzGetUnitDiceNumber                        takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitDiceNumber                        takes unit whichUnit, integer diceNumber, integer weaponIndex returns nothing
native BlzGetUnitDiceSides                         takes unit whichUnit, integer weaponIndex returns integer
native BlzSetUnitDiceSides                         takes unit whichUnit, integer diceSides, integer weaponIndex returns nothing
native BlzGetUnitAttackCooldown                    takes unit whichUnit, integer weaponIndex returns real
native BlzSetUnitAttackCooldown                    takes unit whichUnit, real cooldown, integer weaponIndex returns nothing
native BlzSetSpecialEffectColorByPlayer            takes effect whichEffect, player whichPlayer returns nothing
native BlzSetSpecialEffectColor                    takes effect whichEffect, integer r, integer g, integer b returns nothing
native BlzSetSpecialEffectAlpha                    takes effect whichEffect, integer alpha returns nothing
native BlzSetSpecialEffectScale                    takes effect whichEffect, real scale returns nothing
native BlzSetSpecialEffectPosition                 takes effect whichEffect, real x, real y, real z returns nothing
native BlzSetSpecialEffectHeight                   takes effect whichEffect, real height returns nothing
native BlzSetSpecialEffectTimeScale                takes effect whichEffect, real timeScale returns nothing
native BlzSetSpecialEffectTime                     takes effect whichEffect, real time returns nothing
native BlzSetSpecialEffectOrientation              takes effect whichEffect, real yaw, real pitch, real roll returns nothing
native BlzSetSpecialEffectYaw                      takes effect whichEffect, real yaw returns nothing
native BlzSetSpecialEffectPitch                    takes effect whichEffect, real pitch returns nothing
native BlzSetSpecialEffectRoll                     takes effect whichEffect, real roll returns nothing
native BlzSetSpecialEffectX                        takes effect whichEffect, real x returns nothing
native BlzSetSpecialEffectY                        takes effect whichEffect, real y returns nothing
native BlzSetSpecialEffectZ                        takes effect whichEffect, real z returns nothing
native BlzSetSpecialEffectPositionLoc              takes effect whichEffect, location loc returns nothing
native BlzGetLocalSpecialEffectX                   takes effect whichEffect returns real
native BlzGetLocalSpecialEffectY                   takes effect whichEffect returns real
native BlzGetLocalSpecialEffectZ                   takes effect whichEffect returns real
native BlzSpecialEffectClearSubAnimations          takes effect whichEffect returns nothing
native BlzSpecialEffectRemoveSubAnimation          takes effect whichEffect, subanimtype whichSubAnim returns nothing
native BlzSpecialEffectAddSubAnimation             takes effect whichEffect, subanimtype whichSubAnim returns nothing
native BlzPlaySpecialEffect                        takes effect whichEffect, animtype whichAnim returns nothing
native BlzPlaySpecialEffectWithTimeScale           takes effect whichEffect, animtype whichAnim, real timeScale returns nothing
native BlzGetAnimName                              takes animtype whichAnim returns string
native BlzGetUnitArmor                             takes unit whichUnit returns real
native BlzSetUnitArmor                             takes unit whichUnit, real armorAmount returns nothing
native BlzUnitHideAbility                          takes unit whichUnit, integer abilId, boolean flag returns nothing
native BlzUnitDisableAbility                       takes unit whichUnit, integer abilId, boolean flag, boolean hideUI returns nothing
native BlzUnitCancelTimedLife                      takes unit whichUnit returns nothing
native BlzIsUnitSelectable                         takes unit whichUnit returns boolean
native BlzIsUnitInvulnerable                       takes unit whichUnit returns boolean
native BlzUnitInterruptAttack                      takes unit whichUnit returns nothing
native BlzGetUnitCollisionSize                     takes unit whichUnit returns real
native BlzGetAbilityManaCost                       takes integer abilId, integer level returns integer
native BlzGetAbilityCooldown                       takes integer abilId, integer level returns real
native BlzSetUnitAbilityCooldown                   takes unit whichUnit, integer abilId, integer level, real cooldown returns nothing
native BlzGetUnitAbilityCooldown                   takes unit whichUnit, integer abilId, integer level returns real
native BlzGetUnitAbilityCooldownRemaining          takes unit whichUnit, integer abilId returns real
native BlzEndUnitAbilityCooldown                   takes unit whichUnit, integer abilCode returns nothing
native BlzGetUnitAbilityManaCost                   takes unit whichUnit, integer abilId, integer level returns integer
native BlzSetUnitAbilityManaCost                   takes unit whichUnit, integer abilId, integer level, integer manaCost returns nothing
native BlzGetLocalUnitZ                            takes unit whichUnit returns real    
native BlzDecPlayerTechResearched                  takes player whichPlayer, integer techid, integer levels returns nothing
native BlzSetEventDamage                           takes real damage returns nothing
native BlzGetEventDamageTarget 	                   takes nothing returns unit
native BlzGetEventAttackType  	                   takes nothing returns attacktype
native BlzGetEventDamageType                       takes nothing returns damagetype
native BlzGetEventWeaponType  	                   takes nothing returns weapontype
native BlzSetEventAttackType                       takes attacktype attackType returns boolean
native BlzSetEventDamageType                       takes damagetype damageType returns boolean
native BlzSetEventWeaponType                       takes weapontype weaponType returns boolean
native RequestExtraIntegerData                     takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns integer
native RequestExtraBooleanData                     takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns boolean
native RequestExtraStringData                      takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns string
native RequestExtraRealData                        takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns real
native BlzGetUnitZ                                 takes unit whichUnit returns real
native BlzEnableSelections                         takes boolean enableSelection, boolean enableSelectionCircle returns nothing
native BlzIsSelectionEnabled                       takes nothing returns boolean
native BlzIsSelectionCircleEnabled                 takes nothing returns boolean
native BlzCameraSetupApplyForceDurationSmooth      takes camerasetup whichSetup, boolean doPan, real forcedDuration, real easeInDuration, real easeOutDuration, real smoothFactor returns nothing
native BlzEnableTargetIndicator                    takes boolean enable returns nothing
native BlzIsTargetIndicatorEnabled                 takes nothing returns boolean
native BlzGetOriginFrame                           takes originframetype frameType, integer index returns framehandle
native BlzEnableUIAutoPosition                     takes boolean enable returns nothing
native BlzHideOriginFrames                         takes boolean enable returns nothing
native BlzConvertColor                             takes integer a, integer r, integer g, integer b returns integer
native BlzLoadTOCFile                              takes string TOCFile returns boolean
native BlzCreateFrame                              takes string name, framehandle owner, integer priority, integer createContext returns framehandle
native BlzCreateSimpleFrame                        takes string name, framehandle owner, integer createContext returns framehandle
native BlzCreateFrameByType                        takes string typeName, string name, framehandle owner, string inherits, integer createContext returns framehandle
native BlzDestroyFrame                             takes framehandle frame returns nothing
native BlzFrameSetPoint                            takes framehandle frame, framepointtype point, framehandle relative, framepointtype relativePoint, real x, real y returns nothing
native BlzFrameSetAbsPoint                         takes framehandle frame, framepointtype point, real x, real y returns nothing
native BlzFrameClearAllPoints                      takes framehandle frame returns nothing
native BlzFrameSetAllPoints                        takes framehandle frame, framehandle relative returns nothing
native BlzFrameSetVisible                          takes framehandle frame, boolean visible returns nothing
native BlzFrameIsVisible                           takes framehandle frame returns boolean
native BlzGetFrameByName                           takes string name, integer createContext returns framehandle
native BlzFrameGetName                             takes framehandle frame returns string
native BlzFrameClick                               takes framehandle frame returns nothing
native BlzFrameSetText                             takes framehandle frame, string text returns nothing
native BlzFrameGetText                             takes framehandle frame returns string
native BlzFrameSetTextSizeLimit                    takes framehandle frame, integer size returns nothing
native BlzFrameGetTextSizeLimit                    takes framehandle frame returns integer
native BlzFrameSetTextColor                        takes framehandle frame, integer color returns nothing
native BlzFrameSetFocus                            takes framehandle frame, boolean flag returns nothing
native BlzFrameSetModel                            takes framehandle frame, string modelFile, integer cameraIndex returns nothing
native BlzFrameSetEnable                           takes framehandle frame, boolean enabled returns nothing
native BlzFrameGetEnable                           takes framehandle frame returns boolean
native BlzFrameSetAlpha                            takes framehandle frame, integer alpha returns nothing
native BlzFrameGetAlpha                            takes framehandle frame returns integer
native BlzFrameSetSpriteAnimate                    takes framehandle frame, integer primaryProp, integer flags returns nothing
native BlzFrameSetTexture                          takes framehandle frame, string texFile, integer flag, boolean blend returns nothing
native BlzFrameSetScale                            takes framehandle frame, real scale returns nothing
native BlzFrameSetTooltip                          takes framehandle frame, framehandle tooltip returns nothing
native BlzFrameCageMouse                           takes framehandle frame, boolean enable returns nothing
native BlzFrameSetValue                            takes framehandle frame, real value returns nothing
native BlzFrameGetValue                            takes framehandle frame returns real
native BlzFrameSetMinMaxValue                      takes framehandle frame, real minValue, real maxValue returns nothing
native BlzFrameSetStepSize                         takes framehandle frame, real stepSize returns nothing
native BlzFrameSetSize                             takes framehandle frame, real width, real height returns nothing
native BlzFrameSetVertexColor                      takes framehandle frame, integer color returns nothing
native BlzFrameSetLevel                            takes framehandle frame, integer level returns nothing
native BlzFrameSetParent                           takes framehandle frame, framehandle parent returns nothing
native BlzFrameGetParent                           takes framehandle frame returns framehandle
native BlzFrameGetHeight                           takes framehandle frame returns real
native BlzFrameGetWidth                            takes framehandle frame returns real
native BlzFrameSetFont                             takes framehandle frame, string fileName, real height, integer flags returns nothing
native BlzFrameSetTextAlignment                    takes framehandle frame, textaligntype vert, textaligntype horz returns nothing
native BlzTriggerRegisterFrameEvent                takes trigger whichTrigger, framehandle frame, frameeventtype eventId returns event
native BlzGetTriggerFrame                          takes nothing returns framehandle
native BlzGetTriggerFrameEvent                     takes nothing returns frameeventtype
native BlzTriggerRegisterPlayerSyncEvent           takes trigger whichTrigger, player whichPlayer, string prefix, boolean fromServer returns event
native BlzSendSyncData                             takes string prefix, string data returns boolean
native BlzGetTriggerSyncPrefix                     takes nothing returns string
native BlzGetTriggerSyncData                       takes nothing returns string
native BlzTriggerRegisterPlayerKeyEvent            takes trigger whichTrigger, player whichPlayer, oskeytype key, integer metaKey, boolean keyDown returns event
native BlzGetTriggerPlayerKey                      takes nothing returns oskeytype
native BlzGetTriggerPlayerMetaKey                  takes nothing returns integer
native BlzGetTriggerPlayerIsKeyDown                takes nothing returns boolean
native BlzEnableCursor                             takes boolean enable returns nothing
native BlzSetMousePos                              takes integer x, integer y returns nothing
native BlzGetLocalClientWidth                      takes nothing returns integer
native BlzGetLocalClientHeight                     takes nothing returns integer
native BlzIsLocalClientActive                      takes nothing returns boolean
native BlzGetMouseFocusUnit                        takes nothing returns unit
native BlzChangeMinimapTerrainTex                  takes string texFile returns boolean
native BlzGetLocale                                takes nothing returns string
native BlzGetSpecialEffectScale                    takes effect whichEffect returns real
native BlzSetSpecialEffectMatrixScale              takes effect whichEffect, real x, real y, real z returns nothing
native BlzResetSpecialEffectMatrix                 takes effect whichEffect returns nothing
native BlzGetUnitAbility                           takes unit whichUnit, integer abilId returns ability
native BlzGetUnitAbilityByIndex                    takes unit whichUnit, integer index returns ability
native BlzDisplayChatMessage                       takes player whichPlayer, integer recipient, string message returns nothing
native BlzPauseUnitEx                              takes unit whichUnit, boolean flag returns nothing
native BlzBitOr                                    takes integer x, integer y returns integer
native BlzBitAnd                                   takes integer x, integer y returns integer
native BlzBitXor                                   takes integer x, integer y returns integer 
native BlzGetAbilityBooleanField                   takes ability whichAbility, abilitybooleanfield whichField returns boolean
native BlzGetAbilityIntegerField                   takes ability whichAbility, abilityintegerfield whichField returns integer
native BlzGetAbilityRealField                      takes ability whichAbility, abilityrealfield whichField returns real
native BlzGetAbilityStringField                    takes ability whichAbility, abilitystringfield whichField returns string
native BlzGetAbilityBooleanLevelField              takes ability whichAbility, abilitybooleanlevelfield whichField, integer level returns boolean
native BlzGetAbilityIntegerLevelField              takes ability whichAbility, abilityintegerlevelfield whichField, integer level returns integer
native BlzGetAbilityRealLevelField                 takes ability whichAbility, abilityreallevelfield whichField, integer level returns real
native BlzGetAbilityStringLevelField               takes ability whichAbility, abilitystringlevelfield whichField, integer level returns string
native BlzGetAbilityBooleanLevelArrayField         takes ability whichAbility, abilitybooleanlevelarrayfield whichField, integer level, integer index returns boolean
native BlzGetAbilityIntegerLevelArrayField         takes ability whichAbility, abilityintegerlevelarrayfield whichField, integer level, integer index returns integer
native BlzGetAbilityRealLevelArrayField            takes ability whichAbility, abilityreallevelarrayfield whichField, integer level, integer index returns real
native BlzGetAbilityStringLevelArrayField          takes ability whichAbility, abilitystringlevelarrayfield whichField, integer level, integer index returns string
native BlzSetAbilityBooleanField                   takes ability whichAbility, abilitybooleanfield whichField, boolean value returns boolean
native BlzSetAbilityIntegerField                   takes ability whichAbility, abilityintegerfield whichField, integer value returns boolean
native BlzSetAbilityRealField                      takes ability whichAbility, abilityrealfield whichField, real value returns boolean
native BlzSetAbilityStringField                    takes ability whichAbility, abilitystringfield whichField, string value returns boolean
native BlzSetAbilityBooleanLevelField              takes ability whichAbility, abilitybooleanlevelfield whichField, integer level, boolean value returns boolean
native BlzSetAbilityIntegerLevelField              takes ability whichAbility, abilityintegerlevelfield whichField, integer level, integer value returns boolean
native BlzSetAbilityRealLevelField                 takes ability whichAbility, abilityreallevelfield whichField, integer level, real value returns boolean
native BlzSetAbilityStringLevelField               takes ability whichAbility, abilitystringlevelfield whichField, integer level, string value returns boolean
native BlzSetAbilityBooleanLevelArrayField         takes ability whichAbility, abilitybooleanlevelarrayfield whichField, integer level, integer index, boolean value returns boolean
native BlzSetAbilityIntegerLevelArrayField         takes ability whichAbility, abilityintegerlevelarrayfield whichField, integer level, integer index, integer value returns boolean
native BlzSetAbilityRealLevelArrayField            takes ability whichAbility, abilityreallevelarrayfield whichField, integer level, integer index, real value returns boolean
native BlzSetAbilityStringLevelArrayField          takes ability whichAbility, abilitystringlevelarrayfield whichField, integer level, integer index, string value returns boolean
native BlzAddAbilityBooleanLevelArrayField         takes ability whichAbility, abilitybooleanlevelarrayfield whichField, integer level, boolean value returns boolean
native BlzAddAbilityIntegerLevelArrayField         takes ability whichAbility, abilityintegerlevelarrayfield whichField, integer level, integer value returns boolean
native BlzAddAbilityRealLevelArrayField            takes ability whichAbility, abilityreallevelarrayfield whichField, integer level, real value returns boolean
native BlzAddAbilityStringLevelArrayField          takes ability whichAbility, abilitystringlevelarrayfield whichField, integer level, string value returns boolean
native BlzRemoveAbilityBooleanLevelArrayField      takes ability whichAbility, abilitybooleanlevelarrayfield whichField, integer level, boolean value returns boolean
native BlzRemoveAbilityIntegerLevelArrayField      takes ability whichAbility, abilityintegerlevelarrayfield whichField, integer level, integer value returns boolean
native BlzRemoveAbilityRealLevelArrayField         takes ability whichAbility, abilityreallevelarrayfield whichField, integer level, real value returns boolean
native BlzRemoveAbilityStringLevelArrayField       takes ability whichAbility, abilitystringlevelarrayfield whichField, integer level, string value returns boolean
native BlzGetItemAbilityByIndex                    takes item whichItem, integer index returns ability
native BlzGetItemAbility                           takes item whichItem, integer abilCode returns ability
native BlzItemAddAbility                           takes item whichItem, integer abilCode returns boolean
native BlzGetItemBooleanField                      takes item whichItem, itembooleanfield whichField returns boolean
native BlzGetItemIntegerField                      takes item whichItem, itemintegerfield whichField returns integer
native BlzGetItemRealField                         takes item whichItem, itemrealfield whichField returns real
native BlzGetItemStringField                       takes item whichItem, itemstringfield whichField returns string
native BlzSetItemBooleanField                      takes item whichItem, itembooleanfield whichField, boolean value returns boolean
native BlzSetItemIntegerField                      takes item whichItem, itemintegerfield whichField, integer value returns boolean
native BlzSetItemRealField                         takes item whichItem, itemrealfield whichField, real value returns boolean
native BlzSetItemStringField                       takes item whichItem, itemstringfield whichField, string value returns boolean
native BlzItemRemoveAbility                        takes item whichItem, integer abilCode returns boolean
native BlzGetUnitBooleanField                      takes unit whichUnit, unitbooleanfield whichField returns boolean
native BlzGetUnitIntegerField                      takes unit whichUnit, unitintegerfield whichField returns integer
native BlzGetUnitRealField                         takes unit whichUnit, unitrealfield whichField returns real
native BlzGetUnitStringField                       takes unit whichUnit, unitstringfield whichField returns string
native BlzSetUnitBooleanField                      takes unit whichUnit, unitbooleanfield whichField, boolean value returns boolean
native BlzSetUnitIntegerField                      takes unit whichUnit, unitintegerfield whichField, integer value returns boolean
native BlzSetUnitRealField                         takes unit whichUnit, unitrealfield whichField, real value returns boolean
native BlzSetUnitStringField                       takes unit whichUnit, unitstringfield whichField, string value returns boolean
native BlzGetUnitWeaponBooleanField                takes unit whichUnit, unitweaponbooleanfield whichField, integer index returns boolean
native BlzGetUnitWeaponIntegerField                takes unit whichUnit, unitweaponintegerfield whichField, integer index returns integer
native BlzGetUnitWeaponRealField                   takes unit whichUnit, unitweaponrealfield whichField, integer index returns real
native BlzGetUnitWeaponStringField                 takes unit whichUnit, unitweaponstringfield whichField, integer index returns string
native BlzSetUnitWeaponBooleanField                takes unit whichUnit, unitweaponbooleanfield whichField, integer index, boolean value returns boolean
native BlzSetUnitWeaponIntegerField                takes unit whichUnit, unitweaponintegerfield whichField, integer index, integer value returns boolean
native BlzSetUnitWeaponRealField                   takes unit whichUnit, unitweaponrealfield whichField, integer index, real value returns boolean
native BlzSetUnitWeaponStringField                 takes unit whichUnit, unitweaponstringfield whichField, integer index, string value returns boolean
]]--