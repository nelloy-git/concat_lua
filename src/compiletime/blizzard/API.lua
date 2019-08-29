---@alias wc3_handle userdata
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
---@return integer
function GetBJMaxPlayers() end
---@return integer
function GetBJPlayerNeutralVictim() end
---@return integer
function GetBJPlayerNeutralExtra() end
---@return integer
function GetBJMaxPlayerSlots() end
---@return integer
function GetPlayerNeutralPassive() end
---@return integer
function GetPlayerNeutralAggressive() end
---@return wc3_placement
function GetGamePlacement() end
---@return wc3_gamespeed
function GetGameSpeed() end
---@return wc3_gamedifficulty
function GetGameDifficulty() end
---@return wc3_mapdensity
function GetResourceDensity() end
---@return wc3_mapdensity
function GetCreatureDensity() end
---@param whichStartLocation integer
---@return number
function GetStartLocationX(whichStartLocation) end
---@param whichStartLocation integer
---@return number
function GetStartLocationY(whichStartLocation) end
---@param whichStartLocation integer
---@return number
function GetStartLocationLoc(whichStartLocation) end
---@return wc3_unit
function GetFilterUnit() end
---@return wc3_unit
function GetEnumUnit() end
---@return wc3_destructable
function GetFilterDestructable() end
---@return wc3_destructable
function GetEnumDestructable() end
---@return wc3_item
function GetFilterItem() end
---@return wc3_item
function GetEnumItem() end
---@return wc3_player
function GetFilterPlayer() end
---@return wc3_player
function GetEnumPlayer() end
---@return wc3_trigger
function GetTriggeringTrigger() end
---@return wc3_eventid 
function GetTriggerEventId() end
---@param whichTrigger wc3_trigger
---@return integer
function GetTriggerEvalCount(whichTrigger) end
---@param whichTrigger wc3_trigger
---@return integer
function GetTriggerExecCount(whichTrigger) end
---@return wc3_gamestate
function GetEventGameState() end
---@return wc3_player
function GetWinningPlayer() end
---@return wc3_region
function GetTriggeringRegion() end
---@return wc3_unit
function GetEnteringUnit() end
---@return wc3_unit
function GetLeavingUnit() end
---@return wc3_trackable
function GetTriggeringTrackable() end
---@return wc3_button
function GetClickedButton() end
---@return wc3_dialog
function GetClickedDialog() end
---@return number
function GetTournamentFinishSoonTimeRemaining() end
---@return integer
function GetTournamentFinishNowRule() end
---@return wc3_player
function GetTournamentFinishNowPlayer() end
---@param whichPlayer wc3_player
---@return integer
function GetTournamentScore(whichPlayer) end
---@return string
function GetSaveBasicFilename() end
---@return wc3_player
function GetTriggerPlayer() end
---@return wc3_unit
function GetLevelingUnit() end
---@return wc3_unit
function GetLearningUnit() end
---@return integer
function GetLearnedSkill() end
---@return integer
function GetLearnedSkillLevel() end
---@return wc3_unit
function GetRevivableUnit() end
---@return wc3_unit
function GetRevivingUnit() end
---@return wc3_unit
function GetAttacker() end
---@return wc3_unit
function GetRescuer() end
---@return wc3_unit
function GetDyingUnit() end
---@return wc3_unit
function GetKillingUnit() end
---@return wc3_unit
function GetDecayingUnit() end
---@return wc3_unit
function GetConstructingStructure() end
---@return wc3_unit
function GetCancelledStructure() end
---@return wc3_unit
function GetConstructedStructure() end
---@return wc3_unit
function GetResearchingUnit() end
---@return integer
function GetResearched() end
---@return integer
function GetTrainedUnitType() end
---@return wc3_unit
function GetTrainedUnit() end
---@return wc3_unit
function GetDetectedUnit() end
---@return wc3_unit
function GetSummoningUnit() end
---@return wc3_unit
function GetSummonedUnit() end
---@return wc3_unit
function GetTransportUnit() end
---@return wc3_unit
function GetLoadedUnit() end
---@return wc3_unit
function GetSellingUnit() end
---@return wc3_unit
function GetSoldUnit() end
---@return wc3_unit
function GetBuyingUnit() end
---@return wc3_item
function GetSoldItem() end
---@return wc3_unit
function GetChangingUnit() end
---@return wc3_player
function GetChangingUnitPrevOwner() end
---@return wc3_unit
function GetManipulatingUnit() end
---@return wc3_item
function GetManipulatedItem() end
---@return wc3_unit
function GetOrderedUnit() end
---@return integer
function GetIssuedOrderId() end
---@return number
function GetOrderPointX() end
---@return number
function GetOrderPointY() end
---@return wc3_location
function GetOrderPointLoc() end
---@return wc3_widget
function GetOrderTarget() end
---@return wc3_destructable
function GetOrderTargetDestructable() end
---@return wc3_item
function GetOrderTargetItem() end
---@return wc3_unit
function GetOrderTargetUnit() end
---@return wc3_unit
function GetSpellAbilityUnit() end
---@return integer
function GetSpellAbilityId() end
---@return wc3_ability
function GetSpellAbility() end
---@return wc3_location
function GetSpellTargetLoc() end
---@return number
function GetSpellTargetX() end
---@return number
function GetSpellTargetY() end
---@return wc3_destructable
function GetSpellTargetDestructable() end
---@return wc3_item
function GetSpellTargetItem() end
---@return wc3_unit
function GetSpellTargetUnit() end
---@return wc3_playerstate
function GetEventPlayerState() end
---@return string
function GetEventPlayerChatString() end
---@return string
function GetEventPlayerChatStringMatched() end
---@return wc3_unit
function GetTriggerUnit() end
---@return wc3_unitstate
function GetEventUnitState() end
---@return number
function GetEventDamage() end
---@return wc3_unit
function GetEventDamageSource() end
---@return wc3_player
function GetEventDetectingPlayer() end
---@return wc3_unit
function GetEventTargetUnit() end
---@return wc3_widget
function GetTriggerWidget() end
---@return wc3_destructable
function GetTriggerDestructable() end
---@param whichItem wc3_item
---@return string
function GetItemName(whichItem) end
---@param whichHero wc3_unit
---@return integer
function GetHeroLevel(whichHero) end
---@param whichUnit wc3_unit
---@return integer
function GetUnitLevel(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitX(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitY(whichUnit) end
---@param whichUnit wc3_unit
---@return wc3_location
function GetUnitLoc(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitFacing(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitMoveSpeed(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitDefaultMoveSpeed(whichUnit) end
---@param whichUnit wc3_unit
---@return wc3_player
function GetOwningPlayer(whichUnit) end
---@param whichUnit wc3_unit
---@return integer
function GetUnitTypeId(whichUnit) end
---@param whichUnit wc3_unit
---@return wc3_race
function GetUnitRace(whichUnit) end
---@param whichUnit wc3_unit
---@return string
function GetUnitName(whichUnit) end
---@param whichUnit wc3_unit
---@return integer
function GetUnitFoodUsed(whichUnit) end
---@param whichUnit wc3_unit
---@return integer
function GetUnitFoodMade(whichUnit) end
---@param unitId integer
---@return integer
function GetFoodMade(unitId) end
---@param unitId integer
---@return integer
function GetFoodUsed(unitId) end
---@param whichUnit wc3_unit
---@return wc3_location
function GetUnitRallyPoint(whichUnit) end
---@param whichUnit wc3_unit
---@return wc3_unit
function GetUnitRallyUnit(whichUnit) end
---@param whichUnit wc3_unit
---@return wc3_destructable
function GetUnitRallyDestructable(whichUnit) end
---@param whichUnit wc3_unit
---@param whichUnitState wc3_unitstate
---@return number
function GetUnitState(whichUnit, whichUnitState) end
---@param whichUnit wc3_unit
---@param whichGroup wc3_group
---@return boolean
function IsUnitInGroup(whichUnit, whichGroup) end
---@param whichUnit wc3_unit
---@param whichForce wc3_force
---@return boolean
function IsUnitInForce(whichUnit, whichForce) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitOwnedByPlayer(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitAlly(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitEnemy(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitVisible(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitDetected(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitInvisible(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitFogged(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitMasked(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@return boolean
function IsUnitSelected(whichUnit, whichPlayer) end
---@param whichUnit wc3_unit
---@param whichRace wc3_race
---@return boolean
function IsUnitRace(whichUnit, whichRace) end
---@param whichUnit wc3_unit
---@param whichUnitType wc3_unittype
---@return boolean
function IsUnitType(whichUnit, whichUnitType) end
---@param whichUnit wc3_unit
---@param whichSpecifiedUnit wc3_unit
---@return boolean
function IsUnit(whichUnit, whichSpecifiedUnit) end
---@param whichUnit wc3_unit
---@param otherUnit wc3_unit
---@param distance number
---@return boolean
function IsUnitInRange(whichUnit, otherUnit, distance) end
---@param whichUnit wc3_unit
---@param x number
---@param y number
---@param distance number
function IsUnitInRangeXY(whichUnit, x, y, distance) end
---@param whichUnit wc3_unit
---@param whichLocation wc3_location
---@param distance number
function IsUnitInRangeLoc(whichUnit, whichLocation, distance) end
---@param whichUnit wc3_unit
---@return boolean
function IsUnitHidden(whichUnit) end
---@param whichUnit wc3_unit
---@return boolean
function IsUnitIllusion(whichUnit) end
---@param whichUnit wc3_unit
---@param whichTransport wc3_unit
---@return  boolean
function IsUnitInTransport(whichUnit, whichTransport) end
---@param whichUnit wc3_unit
---@return boolean
function IsUnitLoaded(whichUnit) end
---@param unitId integer
---@return boolean
function IsHeroUnitId(unitId) end
---@param unitId integer
---@param whichUnitType wc3_unittype
---@return boolean
function IsUnitIdType(unitId,whichUnitType) end
---@param num integer
---@return wc3_player
function Player(num) end
---@return wc3_player
function GetLocalPlayer() end
---@param whichPlayer wc3_player
---@param otherPlayer wc3_player
---@return boolean
function IsPlayerAlly(whichPlayer,otherPlayer) end
---@param whichPlayer wc3_player
---@param otherPlayer wc3_player
---@return boolean
function IsPlayerEnemy(whichPlayer,otherPlayer) end
---@param whichPlayer wc3_player
---@param whichForce wc3_force
---@return boolean
function IsPlayerInForce(whichPlayer,whichForce) end
---@param whichPlayer wc3_player
---@return boolean
function IsPlayerObserver(whichPlayer) end
---@param x number
---@param y number
---@param whichPlayer wc3_player
---@return boolean
function IsVisibleToPlayer(x,y,whichPlayer) end
---@param whichLocation wc3_location
---@param whichPlayer wc3_player
---@return boolean
function IsLocationVisibleToPlayer(whichLocation,whichPlayer) end
---@param x number
---@param y number
---@param whichPlayer wc3_player
---@return boolean
function IsFoggedToPlayer(x,y,whichPlayer) end
---@param whichLocation wc3_location
---@param whichPlayer wc3_player
---@return boolean
function IsLocationFoggedToPlayer(whichLocation,whichPlayer) end
---@param x number
---@param y number
---@param whichPlayer wc3_player
---@return boolean
function IsMaskedToPlayer(x,y,whichPlayer) end
---@param whichLocation wc3_location
---@param whichPlayer wc3_player
---@return boolean
function IsLocationMaskedToPlayer(whichLocation,whichPlayer) end
---@param whichPlayer wc3_player
---@return wc3_race
function GetPlayerRace(whichPlayer) end
---@param whichPlayer wc3_player
---@return integer
function GetPlayerId(whichPlayer) end
---@param whichPlayer wc3_player
---@param includeIncomplete boolean
---@return integer
function GetPlayerUnitCount(whichPlayer,includeIncomplete) end
---@param whichPlayer wc3_player
---@param unitName string
---@param includeIncomplete boolean
---@param includeUpgrades boolean
---@return integer
function GetPlayerTypedUnitCount(whichPlayer,unitName,includeIncomplete,includeUpgrades) end
---@param whichPlayer wc3_player
---@param includeIncomplete boolean
---@return integer
function GetPlayerStructureCount(whichPlayer,includeIncomplete) end
---@param whichPlayer wc3_player
---@param whichPlayerState wc3_playerstate
---@return integer
function GetPlayerState(whichPlayer,whichPlayerState) end
---@param whichPlayer wc3_player
---@param whichPlayerScore wc3_playerscore
---@return integer
function GetPlayerScore(whichPlayer,whichPlayerScore) end
---@param sourcePlayer wc3_player
---@param otherPlayer wc3_player
---@param whichAllianceSetting wc3_alliancetype
---@return boolean
function GetPlayerAlliance(sourcePlayer,otherPlayer,whichAllianceSetting) end
---@param whichPlayer wc3_player
---@return number
function GetPlayerHandicap(whichPlayer) end
---@param whichPlayer wc3_player
---@return number
function GetPlayerHandicapXP(whichPlayer) end
---@param whichPlayer wc3_player
---@param handicap number
function SetPlayerHandicap(whichPlayer,handicap) end
---@param whichPlayer wc3_player
---@param handicap number
function SetPlayerHandicapXP(whichPlayer,handicap) end
---@param whichPlayer wc3_player
---@param techid integer
---@param maximum integer
function SetPlayerTechMaxAllowed(whichPlayer,techid,maximum) end
---@param whichPlayer wc3_player
---@param techid integer
---@return integer
function GetPlayerTechMaxAllowed(whichPlayer,techid) end
---@param whichPlayer wc3_player
---@param techid integer
---@param levels integer
function AddPlayerTechResearched(whichPlayer,techid,levels) end
---@param whichPlayer wc3_player
---@param techid integer
---@param setToLevel integer
function SetPlayerTechResearched(whichPlayer,techid,setToLevel) end
---@param whichPlayer wc3_player
---@param techid integer
---@param specificonly boolean
---@return boolean
function GetPlayerTechResearched(whichPlayer,techid,specificonly) end
---@param whichPlayer wc3_player
---@param techid integer
---@param specificonly boolean
---@return integer
function GetPlayerTechCount(whichPlayer,techid,specificonly) end
---@param whichFloatGameState wc3_fgamestate
---@return number
function GetFloatGameState(whichFloatGameState) end
---@param whichIntegerGameState wc3_igamestate
---@return integer
function GetIntegerGameState(whichIntegerGameState) end
---@return number
function GetCameraBoundMinX() end
---@return number
function GetCameraBoundMinY() end
---@return number
function GetCameraBoundMaxX() end
---@return number
function GetCameraBoundMaxY() end
---@param whichField wc3_camerafield
---@return number
function GetCameraField(whichField) end
---@return number
function GetCameraTargetPositionX() end
---@return number
function GetCameraTargetPositionY() end
---@return number
function GetCameraTargetPositionZ() end
---@return wc3_location
function GetCameraTargetPositionLoc() end
---@return number
function GetCameraEyePositionX() end
---@return number
function GetCameraEyePositionY() end
---@return number
function GetCameraEyePositionZ() end
---@return wc3_location
function GetCameraEyePositionLoc() end
---@param whichStartLoc integer
---@param x number
---@param y number
function DefineStartLocation(whichStartLoc,x,y) end
---@param degrees number
---@return number
function Deg2Rad(degrees) end
---@param radians number
---@return number
function Rad2Deg(radians) end
---@param radians number
---@return number
function Sin(radians) end
---@param radians number
---@return number
function Cos(radians) end
---@param radians number
---@return number
function Tan(radians) end
---@param y number
---@return number
function Asin(y) end
---@param x number
---@return number
function Acos(x) end
---@param x number
---@return number
function Atan(x) end
---@param y number
---@param x number
---@return number
function Atan2(y,x) end
---@param x number
---@return number
function SquareRoot(x) end
---@param x number
---@param power number
---@return number
function Pow(x,power) end
---@param i integer
---@return number
function I2R(i) end
---@param r number
---@return integer
function R2I(r) end
---@param i integer
---@return string
function I2S(i) end
---@param r number
---@return string
function R2S(r) end
---@param r number
---@param width integer
---@param precision integer
---@return string
function R2SW(r,width,precision) end
---@param s string
---@return integer
function S2I(s) end
---@param s string
---@return number
function S2R(s) end
---@param h wc3_handle
---@return integer
function GetHandleId(h) end
---@param source string
---@param str_start integer
---@param str_end integer
---@return string
function SubString(source,str_start,str_end) end
---@param s string
---@return integer
function StringLength(s) end
---@param source string
---@param upper boolean
---@return string
function StringCase(source,upper) end
---@param s string
---@return integer
function StringHash(s) end
---@param source string
---@return string
function GetLocalizedString(source) end
---@param source string
---@return integer
function GetLocalizedHotkey(source) end
---@param name string
function SetMapName(name) end
---@param description string
function SetMapDescription(description) end
---@param teamcount integer
function SetTeams(teamcount) end
---@param playercount integer
function SetPlayers(playercount) end
---@param whichStartLoc integer
---@param whichLocation wc3_location
function DefineStartLocationLoc(whichStartLoc,whichLocation) end
---@param whichStartLoc integer
---@param prioSlotCount integer
function SetStartLocPrioCount(whichStartLoc,prioSlotCount) end
---@param whichStartLoc integer
---@param prioSlotIndex integer
---@param otherStartLocIndex integer
---@param priority wc3_startlocprio
function SetStartLocPrio(whichStartLoc,prioSlotIndex,otherStartLocIndex,priority) end
---@param whichStartLoc integer
---@param prioSlotIndex integer
---@return integer
function GetStartLocPrioSlot(whichStartLoc,prioSlotIndex) end
---@param whichStartLoc integer
---@param prioSlotIndex integer
---@return wc3_startlocprio
function GetStartLocPrio(whichStartLoc,prioSlotIndex) end
---@param whichGameType wc3_gametype
---@param value boolean
function SetGameTypeSupported(whichGameType,value) end
---@param whichMapFlag wc3_mapflag
---@param value boolean
function SetMapFlag(whichMapFlag,value) end
---@param whichPlacementType wc3_placement
function SetGamePlacement(whichPlacementType) end
---@param whichspeed wc3_gamespeed
function SetGameSpeed(whichspeed) end
---@param whichdifficulty wc3_gamedifficulty
function SetGameDifficulty(whichdifficulty) end
---@param whichdensity wc3_mapdensity
function SetResourceDensity(whichdensity) end
---@param whichdensity wc3_mapdensity
function SetCreatureDensity(whichdensity) end
---@return integer
function GetTeams() end
---@return integer
function GetPlayers() end
---@param whichGameType wc3_gametype
---@return boolean
function IsGameTypeSupported(whichGameType) end
---@return wc3_gametype
function GetGameTypeSelected() end
---@param whichMapFlag wc3_mapflag
---@return boolean
function IsMapFlagSet(whichMapFlag) end
---@param whichPlayer wc3_player
---@param whichTeam integer
function SetPlayerTeam(whichPlayer,whichTeam) end
---@param whichPlayer wc3_player
---@param startLocIndex integer
function SetPlayerStartLocation(whichPlayer,startLocIndex) end
---@param whichPlayer wc3_player
---@param startLocIndex integer
function ForcePlayerStartLocation(whichPlayer,startLocIndex) end
---@param whichPlayer wc3_player
---@param color wc3_playercolor
function SetPlayerColor(whichPlayer,color) end
---@param sourcePlayer wc3_player
---@param otherPlayer wc3_player
---@param whichAllianceSetting wc3_alliancetype
---@param value boolean
function SetPlayerAlliance(sourcePlayer,otherPlayer,whichAllianceSetting,value) end
---@param sourcePlayer wc3_player
---@param otherPlayer wc3_player
---@param whichResource wc3_playerstate
---@param rate integer
function SetPlayerTaxRate(sourcePlayer,otherPlayer,whichResource,rate) end
---@param whichPlayer wc3_player
---@param whichRacePreference wc3_racepreference
function SetPlayerRacePreference(whichPlayer,whichRacePreference) end
---@param whichPlayer wc3_player
---@param value boolean
function SetPlayerRaceSelectable(whichPlayer,value) end
---@param whichPlayer wc3_player
---@param controlType wc3_mapcontrol
function SetPlayerController(whichPlayer,controlType) end
---@param whichPlayer wc3_player
---@param name string
function SetPlayerName(whichPlayer,name) end
---@param whichPlayer wc3_player
---@param flag boolean
function SetPlayerOnScoreScreen(whichPlayer,flag) end
---@param whichPlayer wc3_player
---@return integer
function GetPlayerTeam(whichPlayer) end
---@param whichPlayer wc3_player
---@return integer
function GetPlayerStartLocation(whichPlayer) end
---@param whichPlayer wc3_player
---@return wc3_playercolor
function GetPlayerColor(whichPlayer) end
---@param whichPlayer wc3_player
---@return boolean
function GetPlayerSelectable(whichPlayer) end
---@param whichPlayer wc3_player
---@return wc3_mapcontrol
function GetPlayerController(whichPlayer) end
---@param whichPlayer wc3_player
---@return wc3_playerslotstate
function GetPlayerSlotState(whichPlayer) end
---@param sourcePlayer wc3_player
---@param otherPlayer wc3_player
---@param whichResource wc3_playerstate
---@return integer
function GetPlayerTaxRate(sourcePlayer,otherPlayer,whichResource) end
---@param whichPlayer wc3_player
---@param pref wc3_racepreference
---@return boolean
function IsPlayerRacePrefSet(whichPlayer,pref) end
---@param whichPlayer wc3_player
---@return string
function GetPlayerName(whichPlayer) end
---@return wc3_timer
function CreateTimer() end
---@param whichTimer wc3_timer
function DestroyTimer(whichTimer) end
---@param whichTimer wc3_timer
---@param timeout number
---@param periodic boolean
---@param handlerFunc function
function TimerStart(whichTimer,timeout,periodic,handlerFunc) end
---@param whichTimer wc3_timer
---@return number
function TimerGetElapsed(whichTimer) end
---@param whichTimer wc3_timer
---@return number
function TimerGetRemaining(whichTimer) end
---@param whichTimer wc3_timer
---@return number
function TimerGetTimeout(whichTimer) end
---@param whichTimer wc3_timer
function PauseTimer(whichTimer) end
---@param whichTimer wc3_timer
function ResumeTimer(whichTimer) end
---@return wc3_timer
function GetExpiredTimer() end
---@return wc3_group
function CreateGroup() end
---@param whichGroup wc3_group
function DestroyGroup(whichGroup) end
---@param whichGroup wc3_group
---@param whichUnit wc3_unit
---@return boolean
function GroupAddUnit(whichGroup,whichUnit) end
---@param whichGroup wc3_group
---@param whichUnit wc3_unit
---@return boolean
function GroupRemoveUnit(whichGroup,whichUnit) end
---@param whichGroup wc3_group
---@param addGroup wc3_group
---@return integer
function BlzGroupAddGroupFast(whichGroup,addGroup) end
---@param whichGroup wc3_group
---@param removeGroup wc3_group
---@return integer
function BlzGroupRemoveGroupFast(whichGroup,removeGroup) end
---@param whichGroup wc3_group
function GroupClear(whichGroup) end
---@param whichGroup wc3_group
---@return integer
function BlzGroupGetSize(whichGroup) end
---@param whichGroup wc3_group
---@param index integer
---@return wc3_unit
function BlzGroupUnitAt(whichGroup,index) end
---@param whichGroup wc3_group
---@param unitname string
---@param filter wc3_boolexpr
function GroupEnumUnitsOfType(whichGroup,unitname,filter) end
---@param whichGroup wc3_group
---@param whichPlayer wc3_player
---@param filter wc3_boolexpr
function GroupEnumUnitsOfPlayer(whichGroup,whichPlayer,filter) end
---@param whichGroup wc3_group
---@param unitname string
---@param filter wc3_boolexpr
---@param countLimit integer
function GroupEnumUnitsOfTypeCounted(whichGroup,unitname,filter,countLimit) end
---@param whichGroup wc3_group
---@param r wc3_rect
---@param filter wc3_boolexpr
function GroupEnumUnitsInRect(whichGroup,r,filter) end
---@param whichGroup wc3_group
---@param r wc3_rect
---@param filter wc3_boolexpr
---@param countLimit integer
function GroupEnumUnitsInRectCounted(whichGroup,r,filter,countLimit) end
---@param whichGroup wc3_group
---@param x number
---@param y number
---@param radius number
---@param filter wc3_boolexpr
function GroupEnumUnitsInRange(whichGroup,x,y,radius,filter) end
---@param whichGroup wc3_group
---@param whichLocation wc3_location
---@param radius number
---@param filter wc3_boolexpr
function GroupEnumUnitsInRangeOfLoc(whichGroup,whichLocation,radius,filter) end
---@param whichGroup wc3_group
---@param x number
---@param y number
---@param radius number
---@param filter wc3_boolexpr
---@param countLimit integer
function GroupEnumUnitsInRangeCounted(whichGroup,x,y,radius,filter,countLimit) end
---@param whichGroup wc3_group
---@param whichLocation wc3_location
---@param radius number
---@param filter wc3_boolexpr
---@param countLimit integer
function GroupEnumUnitsInRangeOfLocCounted(whichGroup,whichLocation,radius,filter,countLimit) end
---@param whichGroup wc3_group
---@param whichPlayer wc3_player
---@param filter wc3_boolexpr
function GroupEnumUnitsSelected(whichGroup,whichPlayer,filter) end
---@param whichGroup wc3_group
---@param order string
---@return boolean
function GroupImmediateOrder(whichGroup,order) end
---@param whichGroup wc3_group
---@param order integer
---@return boolean
function GroupImmediateOrderById(whichGroup,order) end
---@param whichGroup wc3_group
---@param order string
---@param x number
---@param y number
---@return boolean
function GroupPointOrder(whichGroup,order,x,y) end
---@param whichGroup wc3_group
---@param order string
---@param whichLocation wc3_location
---@return boolean
function GroupPointOrderLoc(whichGroup,order,whichLocation) end
---@param whichGroup wc3_group
---@param order integer
---@param x number
---@param y number
---@return boolean
function GroupPointOrderById(whichGroup,order,x,y) end
---@param whichGroup wc3_group
---@param order integer
---@param whichLocation wc3_location
---@return boolean
function GroupPointOrderByIdLoc(whichGroup,order,whichLocation) end
---@param whichGroup wc3_group
---@param order string
---@param targetWidget wc3_widget
---@return boolean
function GroupTargetOrder(whichGroup,order,targetWidget) end
---@param whichGroup wc3_group
---@param order integer
---@param targetWidget wc3_widget
---@return boolean
function GroupTargetOrderById(whichGroup,order,targetWidget) end
---@param whichGroup wc3_group
---@param callback function
function ForGroup(whichGroup,callback) end
---@param whichGroup wc3_group
---@return wc3_unit
function FirstOfGroup(whichGroup) end
---@return wc3_force
function CreateForce() end
---@param whichForce wc3_force
function DestroyForce(whichForce) end
---@param whichForce wc3_force
---@param whichPlayer wc3_player
function ForceAddPlayer(whichForce,whichPlayer) end
---@param whichForce wc3_force
---@param whichPlayer wc3_player
function ForceRemovePlayer(whichForce,whichPlayer) end
---@param whichForce wc3_force
---@param whichPlayer wc3_player
---@return boolean
function BlzForceHasPlayer(whichForce,whichPlayer) end
---@param whichForce wc3_force
function ForceClear(whichForce) end
---@param whichForce wc3_force
---@param filter wc3_boolexpr
function ForceEnumPlayers(whichForce,filter) end
---@param whichForce wc3_force
---@param filter wc3_boolexpr
---@param countLimit integer
function ForceEnumPlayersCounted(whichForce,filter,countLimit) end
---@param whichForce wc3_force
---@param whichPlayer wc3_player
---@param filter wc3_boolexpr
function ForceEnumAllies(whichForce,whichPlayer,filter) end
---@param whichForce wc3_force
---@param whichPlayer wc3_player
---@param filter wc3_boolexpr
function ForceEnumEnemies(whichForce,whichPlayer,filter) end
---@param whichForce wc3_force
---@param callback function
function ForForce(whichForce,callback) end
---@param minx number
---@param miny number
---@param maxx number
---@param maxy number
---@return wc3_rect
function Rect(minx,miny,maxx,maxy) end
---@param min wc3_location
---@param max wc3_location
---@return wc3_rect
function RectFromLoc(min,max) end
---@param whichRect wc3_rect
function RemoveRect(whichRect) end
---@param whichRect wc3_rect
---@param minx number
---@param miny number
---@param maxx number
---@param maxy number
function SetRect(whichRect,minx,miny,maxx,maxy) end
---@param whichRect wc3_rect
---@param min wc3_location
---@param max wc3_location
function SetRectFromLoc(whichRect,min,max) end
---@param whichRect wc3_rect
---@param newCenterX number
---@param newCenterY number
function MoveRectTo(whichRect,newCenterX,newCenterY) end
---@param whichRect wc3_rect
---@param newCenterLoc wc3_location
function MoveRectToLoc(whichRect,newCenterLoc) end
---@param whichRect wc3_rect
---@return number
function GetRectCenterX(whichRect) end
---@param whichRect wc3_rect
---@return number
function GetRectCenterY(whichRect) end
---@param whichRect wc3_rect
---@return number
function GetRectMinX(whichRect) end
---@param whichRect wc3_rect
---@return number
function GetRectMinY(whichRect) end
---@param whichRect wc3_rect
---@return number
function GetRectMaxX(whichRect) end
---@param whichRect wc3_rect
---@return number
function GetRectMaxY(whichRect) end
---@return wc3_region
function CreateRegion() end
---@param whichRegion wc3_region
function RemoveRegion(whichRegion) end
---@param whichRegion wc3_region
---@param r wc3_rect
function RegionAddRect(whichRegion,r) end
---@param whichRegion wc3_region
---@param r wc3_rect
function RegionClearRect(whichRegion,r) end
---@param whichRegion wc3_region
---@param x number
---@param y number
function RegionAddCell(whichRegion,x,y) end
---@param whichRegion wc3_region
---@param whichLocation wc3_location
function RegionAddCellAtLoc(whichRegion,whichLocation) end
---@param whichRegion wc3_region
---@param x number
---@param y number
function RegionClearCell(whichRegion,x,y) end
---@param whichRegion wc3_region
---@param whichLocation wc3_location
function RegionClearCellAtLoc(whichRegion,whichLocation) end
---@param x number
---@param y number
---@return wc3_location
function Location(x,y) end
---@param whichLocation wc3_location
function RemoveLocation(whichLocation) end
---@param whichLocation wc3_location
---@param newX number
---@param newY number
function MoveLocation(whichLocation,newX,newY) end
---@param whichLocation wc3_location
---@return number
function GetLocationX(whichLocation) end
---@param whichLocation wc3_location
---@return number
function GetLocationY(whichLocation) end
---@param whichLocation wc3_location
---@return number
function GetLocationZ(whichLocation) end
---@param whichRegion wc3_region
---@param whichUnit wc3_unit
---@return boolean
function IsUnitInRegion(whichRegion,whichUnit) end
---@param whichRegion wc3_region
---@param x number
---@param y number
---@return boolean
function IsPointInRegion(whichRegion,x,y) end
---@param whichRegion wc3_region
---@param whichLocation wc3_location
---@return boolean
function IsLocationInRegion(whichRegion,whichLocation) end
---@return wc3_rect
function GetWorldBounds() end
---@return wc3_trigger
function CreateTrigger() end
---@param whichTrigger wc3_trigger
function DestroyTrigger(whichTrigger) end
---@param whichTrigger wc3_trigger
function ResetTrigger(whichTrigger) end
---@param whichTrigger wc3_trigger
function EnableTrigger(whichTrigger) end
---@param whichTrigger wc3_trigger
function DisableTrigger(whichTrigger) end
---@param whichTrigger wc3_trigger
---@return boolean
function IsTriggerEnabled(whichTrigger) end
---@param whichTrigger wc3_trigger
---@param flag boolean
function TriggerWaitOnSleeps(whichTrigger,flag) end
---@param whichTrigger wc3_trigger
---@return boolean
function IsTriggerWaitOnSleeps(whichTrigger) end
---@param funcName string
function ExecuteFunc(funcName) end
---@param operandA wc3_boolexpr
---@param operandB wc3_boolexpr
---@return wc3_boolexpr
function And(operandA,operandB) end
---@param operandA wc3_boolexpr
---@param operandB wc3_boolexpr
---@return wc3_boolexpr
function Or(operandA,operandB) end
---@param operand wc3_boolexpr
---@return wc3_boolexpr
function Not(operand) end
---@param func function
---@return wc3_conditionfunc
function Condition(func) end
---@param c wc3_conditionfunc
function DestroyCondition(c) end
---@param func function
---@return wc3_filterfunc
function Filter(func) end
---@param f wc3_filterfunc
function DestroyFilter(f) end
---@param e wc3_boolexpr
function DestroyBoolExpr(e) end
---@param whichTrigger wc3_trigger
---@param varName string
---@param opcode wc3_limitop
---@param limitval number
---@return wc3_event
function TriggerRegisterVariableEvent(whichTrigger,varName,opcode,limitval) end
---@param whichTrigger wc3_trigger
---@param timeout number
---@param periodic boolean
---@return wc3_event
function TriggerRegisterTimerEvent(whichTrigger,timeout,periodic) end
---@param whichTrigger wc3_trigger
---@param t wc3_timer
---@return wc3_event
function TriggerRegisterTimerExpireEvent(whichTrigger,t) end
---@param whichTrigger wc3_trigger
---@param whichState wc3_gamestate
---@param opcode wc3_limitop
---@param limitval number
---@return wc3_event
function TriggerRegisterGameStateEvent(whichTrigger,whichState,opcode,limitval) end
---@param whichTrigger wc3_trigger
---@param whichDialog wc3_dialog
---@return wc3_event
function TriggerRegisterDialogEvent(whichTrigger,whichDialog) end
---@param whichTrigger wc3_trigger
---@param whichButton wc3_button
---@return wc3_event
function TriggerRegisterDialogButtonEvent(whichTrigger,whichButton) end
---@param whichTrigger wc3_trigger
---@param whichGameEvent wc3_gameevent
---@return wc3_event
function TriggerRegisterGameEvent(whichTrigger,whichGameEvent) end
---@param whichTrigger wc3_trigger
---@param whichRegion wc3_region
---@param filter wc3_boolexpr
---@return wc3_event
function TriggerRegisterEnterRegion(whichTrigger,whichRegion,filter) end
---@param whichTrigger wc3_trigger
---@param whichRegion wc3_region
---@param filter wc3_boolexpr
---@return wc3_event
function TriggerRegisterLeaveRegion(whichTrigger,whichRegion,filter) end
---@param whichTrigger wc3_trigger
---@param t wc3_trackable
---@return wc3_event
function TriggerRegisterTrackableHitEvent(whichTrigger,t) end
---@param whichTrigger wc3_trigger
---@param t wc3_trackable
---@return wc3_event
function TriggerRegisterTrackableTrackEvent(whichTrigger,t) end
---@param whichTrigger wc3_trigger
---@param whichPlayer wc3_player
---@param whichPlayerEvent wc3_playerevent
---@return wc3_event
function TriggerRegisterPlayerEvent(whichTrigger,whichPlayer,whichPlayerEvent) end
---@param whichTrigger wc3_trigger
---@param whichPlayer wc3_player
---@param whichPlayerUnitEvent wc3_playerunitevent
---@param filter wc3_boolexpr
---@return wc3_event
function TriggerRegisterPlayerUnitEvent(whichTrigger,whichPlayer,whichPlayerUnitEvent,filter) end
---@param whichTrigger wc3_trigger
---@param whichPlayer wc3_player
---@param whichAlliance wc3_alliancetype
---@return wc3_event
function TriggerRegisterPlayerAllianceChange(whichTrigger,whichPlayer,whichAlliance) end
---@param whichTrigger wc3_trigger
---@param whichPlayer wc3_player
---@param whichState wc3_playerstate
---@param opcode wc3_limitop
---@param limitval number
---@return wc3_event
function TriggerRegisterPlayerStateEvent(whichTrigger,whichPlayer,whichState,opcode,limitval) end
---@param whichTrigger wc3_trigger
---@param whichPlayer wc3_player
---@param chatMessageToDetect string
---@param exactMatchOnly boolean
---@return wc3_event
function TriggerRegisterPlayerChatEvent(whichTrigger,whichPlayer,chatMessageToDetect,exactMatchOnly) end
---@param whichTrigger wc3_trigger
---@param whichWidget wc3_widget
---@return wc3_event
function TriggerRegisterDeathEvent(whichTrigger,whichWidget) end
---@param whichTrigger wc3_trigger
---@param whichUnit wc3_unit
---@param whichState wc3_unitstate
---@param opcode wc3_limitop
---@param limitval number
---@return wc3_event
function TriggerRegisterUnitStateEvent(whichTrigger,whichUnit,whichState,opcode,limitval) end
---@param whichTrigger wc3_trigger
---@param whichUnit wc3_unit
---@param whichEvent wc3_unitevent
---@return wc3_event
function TriggerRegisterUnitEvent(whichTrigger,whichUnit,whichEvent) end
---@param whichTrigger wc3_trigger
---@param whichUnit wc3_unit
---@param whichEvent wc3_unitevent
---@param filter wc3_boolexpr
---@return wc3_event
function TriggerRegisterFilterUnitEvent(whichTrigger,whichUnit,whichEvent,filter) end
---@param whichTrigger wc3_trigger
---@param whichUnit wc3_unit
---@param range number
---@param filter wc3_boolexpr
---@return wc3_event
function TriggerRegisterUnitInRange(whichTrigger,whichUnit,range,filter) end
---@param whichTrigger wc3_trigger
---@param condition wc3_boolexpr
---@return wc3_triggercondition
function TriggerAddCondition(whichTrigger,condition) end
---@param whichTrigger wc3_trigger
---@param whichCondition wc3_triggercondition
function TriggerRemoveCondition(whichTrigger,whichCondition) end
---@param whichTrigger wc3_trigger
function TriggerClearConditions(whichTrigger) end
---@param whichTrigger wc3_trigger
---@param actionFunc function
---@return wc3_triggeraction
function TriggerAddAction(whichTrigger,actionFunc) end
---@param whichTrigger wc3_trigger
---@param whichAction wc3_triggeraction
function TriggerRemoveAction(whichTrigger,whichAction) end
---@param whichTrigger wc3_trigger
function TriggerClearActions(whichTrigger) end
---@param timeout number
function TriggerSleepAction(timeout) end
---@param s wc3_sound
---@param offset number
function TriggerWaitForSound(s,offset) end
---@param whichTrigger wc3_trigger
---@return boolean
function TriggerEvaluate(whichTrigger) end
---@param whichTrigger wc3_trigger
function TriggerExecute(whichTrigger) end
---@param whichTrigger wc3_trigger
function TriggerExecuteWait(whichTrigger) end
function TriggerSyncStart() end
function TriggerSyncReady() end
---@param whichWidget wc3_widget
---@return number
function GetWidgetLife(whichWidget) end
---@param whichWidget wc3_widget
---@param newLife number
function SetWidgetLife(whichWidget,newLife) end
---@param whichWidget wc3_widget
---@return number
function GetWidgetX(whichWidget) end
---@param whichWidget wc3_widget
---@return number
function GetWidgetY(whichWidget) end
---@param objectid integer
---@param x number
---@param y number
---@param face number
---@param scale number
---@param variation integer
---@return wc3_destructable
function CreateDestructable(objectid,x,y,face,scale,variation) end
---@param objectid integer
---@param x number
---@param y number
---@param z number
---@param face number
---@param scale number
---@param variation integer
---@return wc3_destructable
function CreateDestructableZ(objectid,x,y,z,face,scale,variation) end
---@param objectid integer
---@param x number
---@param y number
---@param face number
---@param scale number
---@param variation integer
---@return wc3_destructable
function CreateDeadDestructable(objectid,x,y,face,scale,variation) end
---@param objectid integer
---@param x number
---@param y number
---@param z number
---@param face number
---@param scale number
---@param variation integer
---@return wc3_destructable
function CreateDeadDestructableZ(objectid,x,y,z,face,scale,variation) end
---@param d wc3_destructable
function RemoveDestructable(d) end
---@param d wc3_destructable
function KillDestructable(d) end
---@param d wc3_destructable
---@param flag boolean
function SetDestructableInvulnerable(d,flag) end
---@param d wc3_destructable
---@return boolean
function IsDestructableInvulnerable(d) end
---@param r wc3_rect
---@param filter wc3_boolexpr
---@param actionFunc function
function EnumDestructablesInRect(r,filter,actionFunc) end
---@param d wc3_destructable
---@return integer
function GetDestructableTypeId(d) end
---@param d wc3_destructable
---@return number
function GetDestructableX(d) end
---@param d wc3_destructable
---@return number
function GetDestructableY(d) end
---@param d wc3_destructable
---@param life number
function SetDestructableLife(d,life) end
---@param d wc3_destructable
---@return number
function GetDestructableLife(d) end
---@param d wc3_destructable
---@param max number
function SetDestructableMaxLife(d,max) end
---@param d wc3_destructable
---@return number
function GetDestructableMaxLife(d) end
---@param d wc3_destructable
---@param life number
---@param birth boolean
function DestructableRestoreLife(d,life,birth) end
---@param d wc3_destructable
---@param whichAnimation string
function QueueDestructableAnimation(d,whichAnimation) end
---@param d wc3_destructable
---@param whichAnimation string
function SetDestructableAnimation(d,whichAnimation) end
---@param d wc3_destructable
---@param speedFactor number
function SetDestructableAnimationSpeed(d,speedFactor) end
---@param d wc3_destructable
---@param flag boolean
function ShowDestructable(d,flag) end
---@param d wc3_destructable
---@return number
function GetDestructableOccluderHeight(d) end
---@param d wc3_destructable
---@param height number
function SetDestructableOccluderHeight(d,height) end
---@param d wc3_destructable
---@return string
function GetDestructableName(d) end
---@param itemid integer
---@param x number
---@param y number
---@return wc3_item
function CreateItem(itemid,x,y) end
---@param whichItem wc3_item
function RemoveItem(whichItem) end
---@param whichItem wc3_item
---@return wc3_player
function GetItemPlayer(whichItem) end
---@param i wc3_item
---@return integer
function GetItemTypeId(i) end
---@param i wc3_item
---@return number
function GetItemX(i) end
---@param i wc3_item
---@return number
function GetItemY(i) end
---@param i wc3_item
---@param x number
---@param y number

function SetItemPosition(i,x,y) end
---@param whichItem wc3_item
---@param flag boolean

function SetItemDropOnDeath(whichItem,flag) end
---@param i wc3_item
---@param flag boolean

function SetItemDroppable(i,flag) end
---@param i wc3_item
---@param flag boolean

function SetItemPawnable(i,flag) end
---@param whichItem wc3_item
---@param whichPlayer wc3_player
---@param changeColor boolean

function SetItemPlayer(whichItem,whichPlayer,changeColor) end
---@param whichItem wc3_item
---@param flag boolean

function SetItemInvulnerable(whichItem,flag) end
---@param whichItem wc3_item
---@return boolean
function IsItemInvulnerable(whichItem) end
---@param whichItem wc3_item
---@param show boolean

function SetItemVisible(whichItem,show) end
---@param whichItem wc3_item
---@return boolean
function IsItemVisible(whichItem) end
---@param whichItem wc3_item
---@return boolean
function IsItemOwned(whichItem) end
---@param whichItem wc3_item
---@return boolean
function IsItemPowerup(whichItem) end
---@param whichItem wc3_item
---@return boolean
function IsItemSellable(whichItem) end
---@param whichItem wc3_item
---@return boolean
function IsItemPawnable(whichItem) end
---@param itemId integer
---@return boolean
function IsItemIdPowerup(itemId) end
---@param itemId integer
---@return boolean
function IsItemIdSellable(itemId) end
---@param itemId integer
---@return boolean
function IsItemIdPawnable(itemId) end
---@param r wc3_rect
---@param filter wc3_boolexpr
---@param actionFunc function

function EnumItemsInRect(r,filter,actionFunc) end
---@param whichItem wc3_item
---@return integer
function GetItemLevel(whichItem) end
---@param whichItem wc3_item
---@return wc3_itemtype
function GetItemType(whichItem) end
---@param whichItem wc3_item
---@param unitId integer

function SetItemDropID(whichItem,unitId) end
---@param whichItem wc3_item
---@return integer
function GetItemCharges(whichItem) end
---@param whichItem wc3_item
---@param charges integer

function SetItemCharges(whichItem,charges) end
---@param whichItem wc3_item
---@return integer
function GetItemUserData(whichItem) end
---@param whichItem wc3_item
---@param data integer

function SetItemUserData(whichItem,data) end
---@param id wc3_player
---@param unitid integer
---@param x number
---@param y number
---@param face number
---@return wc3_unit
function CreateUnit(id,unitid,x,y,face) end
---@param whichPlayer wc3_player
---@param unitname string
---@param x number
---@param y number
---@param face number
---@return wc3_unit
function CreateUnitByName(whichPlayer,unitname,x,y,face) end
---@param id wc3_player
---@param unitid integer
---@param whichLocation wc3_location
---@param face number
---@return wc3_unit
function CreateUnitAtLoc(id,unitid,whichLocation,face) end
---@param id wc3_player
---@param unitname string
---@param whichLocation wc3_location
---@param face number
---@return wc3_unit
function CreateUnitAtLocByName(id,unitname,whichLocation,face) end
---@param whichPlayer wc3_player
---@param unitid integer
---@param x number
---@param y number
---@param face number
---@return wc3_unit
function CreateCorpse(whichPlayer,unitid,x,y,face) end
---@param whichUnit wc3_unit

function KillUnit(whichUnit) end
---@param whichUnit wc3_unit

function RemoveUnit(whichUnit) end
---@param whichUnit wc3_unit
---@param show boolean

function ShowUnit(whichUnit,show) end
---@param whichUnit wc3_unit
---@param whichUnitState wc3_unitstate
---@param newVal number

function SetUnitState(whichUnit,whichUnitState,newVal) end
---@param whichUnit wc3_unit
---@param newX number

function SetUnitX(whichUnit,newX) end
---@param whichUnit wc3_unit
---@param newY number

function SetUnitY(whichUnit,newY) end
---@param whichUnit wc3_unit
---@param newX number
---@param newY number

function SetUnitPosition(whichUnit,newX,newY) end
---@param whichUnit wc3_unit
---@param whichLocation wc3_location

function SetUnitPositionLoc(whichUnit,whichLocation) end
---@param whichUnit wc3_unit
---@param facingAngle number

function SetUnitFacing(whichUnit,facingAngle) end
---@param whichUnit wc3_unit
---@param facingAngle number
---@param duration number

function SetUnitFacingTimed(whichUnit,facingAngle,duration) end
---@param whichUnit wc3_unit
---@param newSpeed number

function SetUnitMoveSpeed(whichUnit,newSpeed) end
---@param whichUnit wc3_unit
---@param newHeight number
---@param rate number

function SetUnitFlyHeight(whichUnit,newHeight,rate) end
---@param whichUnit wc3_unit
---@param newTurnSpeed number

function SetUnitTurnSpeed(whichUnit,newTurnSpeed) end
---@param whichUnit wc3_unit
---@param newPropWindowAngle number

function SetUnitPropWindow(whichUnit,newPropWindowAngle) end
---@param whichUnit wc3_unit
---@param newAcquireRange number

function SetUnitAcquireRange(whichUnit,newAcquireRange) end
---@param whichUnit wc3_unit
---@param creepGuard boolean

function SetUnitCreepGuard(whichUnit,creepGuard) end
---@param whichUnit wc3_unit
---@return number
function GetUnitAcquireRange(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitTurnSpeed(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitPropWindow(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitFlyHeight(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitDefaultAcquireRange(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitDefaultTurnSpeed(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitDefaultPropWindow(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function GetUnitDefaultFlyHeight(whichUnit) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@param changeColor boolean

function SetUnitOwner(whichUnit,whichPlayer,changeColor) end
---@param whichUnit wc3_unit
---@param whichColor wc3_playercolor

function SetUnitColor(whichUnit,whichColor) end
---@param whichUnit wc3_unit
---@param scaleX number
---@param scaleY number
---@param scaleZ number

function SetUnitScale(whichUnit,scaleX,scaleY,scaleZ) end
---@param whichUnit wc3_unit
---@param timeScale number

function SetUnitTimeScale(whichUnit,timeScale) end
---@param whichUnit wc3_unit
---@param blendTime number

function SetUnitBlendTime(whichUnit,blendTime) end
---@param whichUnit wc3_unit
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer

function SetUnitVertexColor(whichUnit,red,green,blue,alpha) end
---@param whichUnit wc3_unit
---@param whichAnimation string

function QueueUnitAnimation(whichUnit,whichAnimation) end
---@param whichUnit wc3_unit
---@param whichAnimation string

function SetUnitAnimation(whichUnit,whichAnimation) end
---@param whichUnit wc3_unit
---@param whichAnimation integer

function SetUnitAnimationByIndex(whichUnit,whichAnimation) end
---@param whichUnit wc3_unit
---@param whichAnimation string
---@param rarity wc3_raritycontrol

function SetUnitAnimationWithRarity(whichUnit,whichAnimation,rarity) end
---@param whichUnit wc3_unit
---@param animProperties string
---@param add boolean

function AddUnitAnimationProperties(whichUnit,animProperties,add) end
---@param whichUnit wc3_unit
---@param whichBone string
---@param lookAtTarget wc3_unit
---@param offsetX number
---@param offsetY number
---@param offsetZ number

function SetUnitLookAt(whichUnit,whichBone,lookAtTarget,offsetX,offsetY,offsetZ) end
---@param whichUnit wc3_unit

function ResetUnitLookAt(whichUnit) end
---@param whichUnit wc3_unit
---@param byWhichPlayer wc3_player
---@param flag boolean

function SetUnitRescuable(whichUnit,byWhichPlayer,flag) end
---@param whichUnit wc3_unit
---@param range number

function SetUnitRescueRange(whichUnit,range) end
---@param whichHero wc3_unit
---@param newStr integer
---@param permanent boolean

function SetHeroStr(whichHero,newStr,permanent) end
---@param whichHero wc3_unit
---@param newAgi integer
---@param permanent boolean

function SetHeroAgi(whichHero,newAgi,permanent) end
---@param whichHero wc3_unit
---@param newInt integer
---@param permanent boolean

function SetHeroInt(whichHero,newInt,permanent) end
---@param whichHero wc3_unit
---@param includeBonuses boolean
---@return integer
function GetHeroStr(whichHero,includeBonuses) end
---@param whichHero wc3_unit
---@param includeBonuses boolean
---@return integer
function GetHeroAgi(whichHero,includeBonuses) end
---@param whichHero wc3_unit
---@param includeBonuses boolean
---@return integer
function GetHeroInt(whichHero,includeBonuses) end
---@param whichHero wc3_unit
---@param howManyLevels integer
---@return boolean
function UnitStripHeroLevel(whichHero,howManyLevels) end
---@param whichHero wc3_unit
---@return integer
function GetHeroXP(whichHero) end
---@param whichHero wc3_unit
---@param newXpVal integer
---@param showEyeCandy boolean

function SetHeroXP(whichHero,newXpVal,showEyeCandy) end
---@param whichHero wc3_unit
---@return integer
function GetHeroSkillPoints(whichHero) end
---@param whichHero wc3_unit
---@param skillPointDelta integer
---@return boolean
function UnitModifySkillPoints(whichHero,skillPointDelta) end
---@param whichHero wc3_unit
---@param xpToAdd integer
---@param showEyeCandy boolean

function AddHeroXP(whichHero,xpToAdd,showEyeCandy) end
---@param whichHero wc3_unit
---@param level integer
---@param showEyeCandy boolean

function SetHeroLevel(whichHero,level,showEyeCandy) end
---@param whichHero wc3_unit
---@return string
function GetHeroProperName(whichHero) end
---@param whichHero wc3_unit
---@param flag boolean

function SuspendHeroXP(whichHero,flag) end
---@param whichHero wc3_unit
---@return boolean
function IsSuspendedXP(whichHero) end
---@param whichHero wc3_unit
---@param abilcode integer

function SelectHeroSkill(whichHero,abilcode) end
---@param whichUnit wc3_unit
---@param abilcode integer
---@return integer
function GetUnitAbilityLevel(whichUnit,abilcode) end
---@param whichUnit wc3_unit
---@param abilcode integer
---@return integer
function DecUnitAbilityLevel(whichUnit,abilcode) end
---@param whichUnit wc3_unit
---@param abilcode integer
---@return integer
function IncUnitAbilityLevel(whichUnit,abilcode) end
---@param whichUnit wc3_unit
---@param abilcode integer
---@param level integer
---@return integer
function SetUnitAbilityLevel(whichUnit,abilcode,level) end
---@param whichHero wc3_unit
---@param x number
---@param y number
---@param doEyecandy boolean
---@return boolean
function ReviveHero(whichHero,x,y,doEyecandy) end
---@param whichHero wc3_unit
---@param loc wc3_location
---@param doEyecandy boolean
---@return boolean
function ReviveHeroLoc(whichHero,loc,doEyecandy) end
---@param whichUnit wc3_unit
---@param exploded boolean

function SetUnitExploded(whichUnit,exploded) end
---@param whichUnit wc3_unit
---@param flag boolean

function SetUnitInvulnerable(whichUnit,flag) end
---@param whichUnit wc3_unit
---@param flag boolean

function PauseUnit(whichUnit,flag) end
---@param whichHero wc3_unit
---@return boolean
function IsUnitPaused(whichHero) end
---@param whichUnit wc3_unit
---@param flag boolean

function SetUnitPathing(whichUnit,flag) end
function ClearSelection() end
---@param whichUnit wc3_unit
---@param flag boolean

function SelectUnit(whichUnit,flag) end
---@param whichUnit wc3_unit
---@return integer
function GetUnitPointValue(whichUnit) end
---@param unitType integer
---@return integer
function GetUnitPointValueByType(unitType) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item
---@return boolean
function UnitAddItem(whichUnit,whichItem) end
---@param whichUnit wc3_unit
---@param itemId integer
---@return wc3_item
function UnitAddItemById(whichUnit,itemId) end
---@param whichUnit wc3_unit
---@param itemId integer
---@param itemSlot integer
---@return boolean
function UnitAddItemToSlotById(whichUnit,itemId,itemSlot) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item

function UnitRemoveItem(whichUnit,whichItem) end
---@param whichUnit wc3_unit
---@param itemSlot integer
---@return wc3_item
function UnitRemoveItemFromSlot(whichUnit,itemSlot) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item
---@return boolean
function UnitHasItem(whichUnit,whichItem) end
---@param whichUnit wc3_unit
---@param itemSlot integer
---@return wc3_item
function UnitItemInSlot(whichUnit,itemSlot) end
---@param whichUnit wc3_unit
---@return integer
function UnitInventorySize(whichUnit) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item
---@param x number
---@param y number
---@return boolean
function UnitDropItemPoint(whichUnit,whichItem,x,y) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item
---@param slot integer
---@return boolean
function UnitDropItemSlot(whichUnit,whichItem,slot) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item
---@param target wc3_widget
---@return boolean
function UnitDropItemTarget(whichUnit,whichItem,target) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item
---@return boolean
function UnitUseItem(whichUnit,whichItem) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item
---@param x number
---@param y number
---@return boolean
function UnitUseItemPoint(whichUnit,whichItem,x,y) end
---@param whichUnit wc3_unit
---@param whichItem wc3_item
---@param target wc3_widget
---@return boolean
function UnitUseItemTarget(whichUnit,whichItem,target) end
---@param whichUnit wc3_unit
---@param useFood boolean

function SetUnitUseFood(whichUnit,useFood) end
---@param whichUnit wc3_unit
---@param whichPlayer wc3_player
---@param share boolean

function UnitShareVision(whichUnit,whichPlayer,share) end
---@param whichUnit wc3_unit
---@param suspend boolean

function UnitSuspendDecay(whichUnit,suspend) end
---@param whichUnit wc3_unit
---@param whichUnitType wc3_unittype
---@return boolean
function UnitAddType(whichUnit,whichUnitType) end
---@param whichUnit wc3_unit
---@param whichUnitType wc3_unittype
---@return boolean
function UnitRemoveType(whichUnit,whichUnitType) end
---@param whichUnit wc3_unit
---@param abilityId integer
---@return boolean
function UnitAddAbility(whichUnit,abilityId) end
---@param whichUnit wc3_unit
---@param abilityId integer
---@return boolean
function UnitRemoveAbility(whichUnit,abilityId) end
---@param whichUnit wc3_unit
---@param permanent boolean
---@param abilityId integer
---@return boolean
function UnitMakeAbilityPermanent(whichUnit,permanent,abilityId) end
---@param whichUnit wc3_unit
---@param removePositive boolean
---@param removeNegative boolean

function UnitRemoveBuffs(whichUnit,removePositive,removeNegative) end
---@param whichUnit wc3_unit
---@param removePositive boolean
---@param removeNegative boolean
---@param magic boolean
---@param physical boolean
---@param timedLife boolean
---@param aura boolean
---@param autoDispel boolean

function UnitRemoveBuffsEx(whichUnit,removePositive,removeNegative,magic,physical,timedLife,aura,autoDispel) end
---@param whichUnit wc3_unit
---@param removePositive boolean
---@param removeNegative boolean
---@param magic boolean
---@param physical boolean
---@param timedLife boolean
---@param aura boolean
---@param autoDispel boolean
---@return boolean
function UnitHasBuffsEx(whichUnit,removePositive,removeNegative,magic,physical,timedLife,aura,autoDispel) end
---@param whichUnit wc3_unit
---@param removePositive boolean
---@param removeNegative boolean
---@param magic boolean
---@param physical boolean
---@param timedLife boolean
---@param aura boolean
---@param autoDispel boolean
---@return integer
function UnitCountBuffsEx(whichUnit,removePositive,removeNegative,magic,physical,timedLife,aura,autoDispel) end
---@param whichUnit wc3_unit
---@param add boolean

function UnitAddSleep(whichUnit,add) end
---@param whichUnit wc3_unit
---@return boolean
function UnitCanSleep(whichUnit) end
---@param whichUnit wc3_unit
---@param add boolean

function UnitAddSleepPerm(whichUnit,add) end
---@param whichUnit wc3_unit
---@return boolean
function UnitCanSleepPerm(whichUnit) end
---@param whichUnit wc3_unit
---@return boolean
function UnitIsSleeping(whichUnit) end
---@param whichUnit wc3_unit

function UnitWakeUp(whichUnit) end
---@param whichUnit wc3_unit
---@param buffId integer
---@param duration number

function UnitApplyTimedLife(whichUnit,buffId,duration) end
---@param whichUnit wc3_unit
---@param flag boolean
---@return boolean
function UnitIgnoreAlarm(whichUnit,flag) end
---@param whichUnit wc3_unit
---@return boolean
function UnitIgnoreAlarmToggled(whichUnit) end
---@param whichUnit wc3_unit

function UnitResetCooldown(whichUnit) end
---@param whichUnit wc3_unit
---@param constructionPercentage integer

function UnitSetConstructionProgress(whichUnit,constructionPercentage) end
---@param whichUnit wc3_unit
---@param upgradePercentage integer

function UnitSetUpgradeProgress(whichUnit,upgradePercentage) end
---@param whichUnit wc3_unit
---@param flag boolean

function UnitPauseTimedLife(whichUnit,flag) end
---@param whichUnit wc3_unit
---@param flag boolean

function UnitSetUsesAltIcon(whichUnit,flag) end
---@param whichUnit wc3_unit
---@param delay number
---@param radius number
---@param x number
---@param y number
---@param amount number
---@param attack boolean
---@param ranged boolean
---@param attackType wc3_attacktype
---@param damageType wc3_damagetype
---@param weaponType wc3_weapontype
---@return boolean
function UnitDamagePoint(whichUnit,delay,radius,x,y,amount,attack,ranged,attackType,damageType,weaponType) end
---@param whichUnit wc3_unit
---@param target wc3_widget
---@param amount number
---@param attack boolean
---@param ranged boolean
---@param attackType wc3_attacktype
---@param damageType wc3_damagetype
---@param weaponType wc3_weapontype
---@return boolean
function UnitDamageTarget(whichUnit,target,amount,attack,ranged,attackType,damageType,weaponType) end
---@param whichUnit wc3_unit
---@param order string
---@return boolean
function IssueImmediateOrder(whichUnit,order) end
---@param whichUnit wc3_unit
---@param order integer
---@return boolean
function IssueImmediateOrderById(whichUnit,order) end
---@param whichUnit wc3_unit
---@param order string
---@param x number
---@param y number
---@return boolean
function IssuePointOrder(whichUnit,order,x,y) end
---@param whichUnit wc3_unit
---@param order string
---@param whichLocation wc3_location
---@return boolean
function IssuePointOrderLoc(whichUnit,order,whichLocation) end
---@param whichUnit wc3_unit
---@param order integer
---@param x number
---@param y number
---@return boolean
function IssuePointOrderById(whichUnit,order,x,y) end
---@param whichUnit wc3_unit
---@param order integer
---@param whichLocation wc3_location
---@return boolean
function IssuePointOrderByIdLoc(whichUnit,order,whichLocation) end
---@param whichUnit wc3_unit
---@param order string
---@param targetWidget wc3_widget
---@return boolean
function IssueTargetOrder(whichUnit,order,targetWidget) end
---@param whichUnit wc3_unit
---@param order integer
---@param targetWidget wc3_widget
---@return boolean
function IssueTargetOrderById(whichUnit,order,targetWidget) end
---@param whichUnit wc3_unit
---@param order string
---@param x number
---@param y number
---@param instantTargetWidget wc3_widget
---@return boolean
function IssueInstantPointOrder(whichUnit,order,x,y,instantTargetWidget) end
---@param whichUnit wc3_unit
---@param order integer
---@param x number
---@param y number
---@param instantTargetWidget wc3_widget
---@return boolean
function IssueInstantPointOrderById(whichUnit,order,x,y,instantTargetWidget) end
---@param whichUnit wc3_unit
---@param order string
---@param targetWidget wc3_widget
---@param instantTargetWidget wc3_widget
---@return boolean
function IssueInstantTargetOrder(whichUnit,order,targetWidget,instantTargetWidget) end
---@param whichUnit wc3_unit
---@param order integer
---@param targetWidget wc3_widget
---@param instantTargetWidget wc3_widget
---@return boolean
function IssueInstantTargetOrderById(whichUnit,order,targetWidget,instantTargetWidget) end
---@param whichPeon wc3_unit
---@param unitToBuild string
---@param x number
---@param y number
---@return boolean
function IssueBuildOrder(whichPeon,unitToBuild,x,y) end
---@param whichPeon wc3_unit
---@param unitId integer
---@param x number
---@param y number
---@return boolean
function IssueBuildOrderById(whichPeon,unitId,x,y) end
---@param forWhichPlayer wc3_player
---@param neutralStructure wc3_unit
---@param unitToBuild string
---@return boolean
function IssueNeutralImmediateOrder(forWhichPlayer,neutralStructure,unitToBuild) end
---@param forWhichPlayer wc3_player
---@param neutralStructure wc3_unit
---@param unitId integer
---@return boolean
function IssueNeutralImmediateOrderById(forWhichPlayer,neutralStructure,unitId) end
---@param forWhichPlayer wc3_player
---@param neutralStructure wc3_unit
---@param unitToBuild string
---@param x number
---@param y number
---@return boolean
function IssueNeutralPointOrder(forWhichPlayer,neutralStructure,unitToBuild,x,y) end
---@param forWhichPlayer wc3_player
---@param neutralStructure wc3_unit
---@param unitId integer
---@param x number
---@param y number
---@return boolean
function IssueNeutralPointOrderById(forWhichPlayer,neutralStructure,unitId,x,y) end
---@param forWhichPlayer wc3_player
---@param neutralStructure wc3_unit
---@param unitToBuild string
---@param target wc3_widget
---@return boolean
function IssueNeutralTargetOrder(forWhichPlayer,neutralStructure,unitToBuild,target) end
---@param forWhichPlayer wc3_player
---@param neutralStructure wc3_unit
---@param unitId integer
---@param target wc3_widget
---@return boolean
function IssueNeutralTargetOrderById(forWhichPlayer,neutralStructure,unitId,target) end
---@param whichUnit wc3_unit
---@return integer
function GetUnitCurrentOrder(whichUnit) end
---@param whichUnit wc3_unit
---@param amount integer

function SetResourceAmount(whichUnit,amount) end
---@param whichUnit wc3_unit
---@param amount integer

function AddResourceAmount(whichUnit,amount) end
---@param whichUnit wc3_unit
---@return integer
function GetResourceAmount(whichUnit) end
---@param waygate wc3_unit
---@return number
function WaygateGetDestinationX(waygate) end
---@param waygate wc3_unit
---@return number
function WaygateGetDestinationY(waygate) end
---@param waygate wc3_unit
---@param x number
---@param y number

function WaygateSetDestination(waygate,x,y) end
---@param waygate wc3_unit
---@param activate boolean

function WaygateActivate(waygate,activate) end
---@param waygate wc3_unit
---@return boolean
function WaygateIsActive(waygate) end
---@param itemId integer
---@param currentStock integer
---@param stockMax integer

function AddItemToAllStock(itemId,currentStock,stockMax) end
---@param whichUnit wc3_unit
---@param itemId integer
---@param currentStock integer
---@param stockMax integer

function AddItemToStock(whichUnit,itemId,currentStock,stockMax) end
---@param unitId integer
---@param currentStock integer
---@param stockMax integer

function AddUnitToAllStock(unitId,currentStock,stockMax) end
---@param whichUnit wc3_unit
---@param unitId integer
---@param currentStock integer
---@param stockMax integer

function AddUnitToStock(whichUnit,unitId,currentStock,stockMax) end
---@param itemId integer

function RemoveItemFromAllStock(itemId) end
---@param whichUnit wc3_unit
---@param itemId integer

function RemoveItemFromStock(whichUnit,itemId) end
---@param unitId integer

function RemoveUnitFromAllStock(unitId) end
---@param whichUnit wc3_unit
---@param unitId integer

function RemoveUnitFromStock(whichUnit,unitId) end
---@param slots integer

function SetAllItemTypeSlots(slots) end
---@param slots integer

function SetAllUnitTypeSlots(slots) end
---@param whichUnit wc3_unit
---@param slots integer

function SetItemTypeSlots(whichUnit,slots) end
---@param whichUnit wc3_unit
---@param slots integer

function SetUnitTypeSlots(whichUnit,slots) end
---@param whichUnit wc3_unit
---@return integer
function GetUnitUserData(whichUnit) end
---@param whichUnit wc3_unit
---@param data integer

function SetUnitUserData(whichUnit,data) end
---@param whichPlayer wc3_player
---@param newOwner integer

function SetPlayerUnitsOwner(whichPlayer,newOwner) end
---@param whichPlayer wc3_player
---@param toWhichPlayers wc3_force
---@param flag boolean

function CripplePlayer(whichPlayer,toWhichPlayers,flag) end
---@param whichPlayer wc3_player
---@param abilid integer
---@param avail boolean

function SetPlayerAbilityAvailable(whichPlayer,abilid,avail) end
---@param whichPlayer wc3_player
---@param whichPlayerState wc3_playerstate
---@param value integer

function SetPlayerState(whichPlayer,whichPlayerState,value) end
---@param whichPlayer wc3_player
---@param gameResult wc3_playergameresult

function RemovePlayer(whichPlayer,gameResult) end
---@param whichPlayer wc3_player

function CachePlayerHeroData(whichPlayer) end
---@param forWhichPlayer wc3_player
---@param whichState wc3_fogstate
---@param where wc3_rect
---@param useSharedVision boolean
function SetFogStateRect(forWhichPlayer,whichState,where,useSharedVision) end
---@param forWhichPlayer wc3_player
---@param whichState wc3_fogstate
---@param centerx number
---@param centerY number
---@param radius number
---@param useSharedVision boolean
function SetFogStateRadius(forWhichPlayer,whichState,centerx,centerY,radius,useSharedVision) end
---@param forWhichPlayer wc3_player
---@param whichState wc3_fogstate
---@param center wc3_location
---@param radius number
---@param useSharedVision boolean
function SetFogStateRadiusLoc(forWhichPlayer,whichState,center,radius,useSharedVision) end
---@param enable boolean
function FogMaskEnable(enable) end
---@return boolean
function IsFogMaskEnabled() end
---@param enable boolean
function FogEnable(enable) end
---@return boolean
function IsFogEnabled() end
---@param forWhichPlayer wc3_player
---@param whichState wc3_fogstate
---@param where wc3_rect
---@param useSharedVision boolean
---@param afterUnits boolean
---@return wc3_fogmodifier
function CreateFogModifierRect(forWhichPlayer,whichState,where,useSharedVision,afterUnits) end
---@param forWhichPlayer wc3_player
---@param whichState wc3_fogstate
---@param centerx number
---@param centerY number
---@param radius number
---@param useSharedVision boolean
---@param afterUnits boolean
---@return wc3_fogmodifier
function CreateFogModifierRadius(forWhichPlayer,whichState,centerx,centerY,radius,useSharedVision,afterUnits) end
---@param forWhichPlayer wc3_player
---@param whichState wc3_fogstate
---@param center wc3_location
---@param radius number
---@param useSharedVision boolean
---@param afterUnits boolean
---@return wc3_fogmodifier
function CreateFogModifierRadiusLoc(forWhichPlayer,whichState,center,radius,useSharedVision,afterUnits) end
---@param whichFogModifier wc3_fogmodifier
function DestroyFogModifier(whichFogModifier) end
---@param whichFogModifier wc3_fogmodifier
function FogModifierStart(whichFogModifier) end
---@param whichFogModifier wc3_fogmodifier
function FogModifierStop(whichFogModifier) end
---@return wc3_version
function VersionGet() end
---@param whichVersion wc3_version
---@return boolean
function VersionCompatible(whichVersion) end
---@param whichVersion wc3_version
---@return boolean
function VersionSupported(whichVersion) end
---@param doScoreScreen boolean
function EndGame(doScoreScreen) end
---@param newLevel string
---@param doScoreScreen boolean
function ChangeLevel(newLevel,doScoreScreen) end
---@param doScoreScreen boolean
function RestartGame(doScoreScreen) end
function ReloadGame() end
---@param r wc3_race
function SetCampaignMenuRace(r) end
---@param campaignIndex integer
function SetCampaignMenuRaceEx(campaignIndex) end
function ForceCampaignSelectScreen() end
---@param saveFileName string
---@param doScoreScreen boolean
function LoadGame(saveFileName,doScoreScreen) end
---@param saveFileName string
function SaveGame(saveFileName) end
---@param sourceDirName string
---@param destDirName string
---@return boolean
function RenameSaveDirectory(sourceDirName,destDirName) end
---@param sourceDirName string
---@return boolean
function RemoveSaveDirectory(sourceDirName) end
---@param sourceSaveName string
---@param destSaveName string
---@return boolean
function CopySaveGame(sourceSaveName,destSaveName) end
---@param saveName string
---@return boolean
function SaveGameExists(saveName) end
function SyncSelections() end
---@param whichFloatGameState wc3_fgamestate
---@param value number
function SetFloatGameState(whichFloatGameState,value) end
---@param whichIntegerGameState wc3_igamestate
---@param value integer
function SetIntegerGameState(whichIntegerGameState,value) end
---@param cleared boolean
function SetTutorialCleared(cleared) end
---@param campaignNumber integer
---@param missionNumber integer
---@param available boolean
function SetMissionAvailable(campaignNumber,missionNumber,available) end
---@param campaignNumber integer
---@param available boolean
function SetCampaignAvailable(campaignNumber,available) end
---@param campaignNumber integer
---@param available boolean
function SetOpCinematicAvailable(campaignNumber,available) end
---@param campaignNumber integer
---@param available boolean
function SetEdCinematicAvailable(campaignNumber,available) end
---@return wc3_gamedifficulty
function GetDefaultDifficulty() end
---@param g wc3_gamedifficulty
function SetDefaultDifficulty(g) end
---@param whichButton integer
---@param visible boolean
function SetCustomCampaignButtonVisible(whichButton,visible) end
---@param whichButton integer
---@return boolean
function GetCustomCampaignButtonVisible(whichButton) end
function DoNotSaveReplay() end
---@return wc3_dialog
function DialogCreate() end
---@param whichDialog wc3_dialog
function DialogDestroy(whichDialog) end
---@param whichDialog wc3_dialog
function DialogClear(whichDialog) end
---@param whichDialog wc3_dialog
---@param messageText string
function DialogSetMessage(whichDialog,messageText) end
---@param whichDialog wc3_dialog
---@param buttonText string
---@param hotkey integer
---@return wc3_button
function DialogAddButton(whichDialog,buttonText,hotkey) end
---@param whichDialog wc3_dialog
---@param doScoreScreen boolean
---@param buttonText string
---@param hotkey integer
---@return wc3_button
function DialogAddQuitButton(whichDialog,doScoreScreen,buttonText,hotkey) end
---@param whichPlayer wc3_player
---@param whichDialog wc3_dialog
---@param flag boolean
function DialogDisplay(whichPlayer,whichDialog,flag) end
---@return boolean
function ReloadGameCachesFromDisk() end
---@param campaignFile string
---@return wc3_gamecache
function InitGameCache(campaignFile) end
---@param whichCache wc3_gamecache
---@return boolean
function SaveGameCache(whichCache) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@param value integer

function StoreInteger(cache,missionKey,key,value) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@param value number

function StoreReal(cache,missionKey,key,value) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@param value boolean

function StoreBoolean(cache,missionKey,key,value) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@param whichUnit wc3_unit
---@return boolean
function StoreUnit(cache,missionKey,key,whichUnit) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@param value string
---@return boolean
function StoreString(cache,missionKey,key,value) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function SyncStoredInteger(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function SyncStoredReal(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function SyncStoredBoolean(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function SyncStoredUnit(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function SyncStoredString(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return boolean
function HaveStoredInteger(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return boolean
function HaveStoredReal(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return boolean
function HaveStoredBoolean(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return boolean
function HaveStoredUnit(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return boolean
function HaveStoredString(cache,missionKey,key) end
---@param cache wc3_gamecache

function FlushGameCache(cache) end
---@param cache wc3_gamecache
---@param missionKey string

function FlushStoredMission(cache,missionKey) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function FlushStoredInteger(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function FlushStoredReal(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function FlushStoredBoolean(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function FlushStoredUnit(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string

function FlushStoredString(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return integer
function GetStoredInteger(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return number
function GetStoredReal(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return boolean
function GetStoredBoolean(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@return string
function GetStoredString(cache,missionKey,key) end
---@param cache wc3_gamecache
---@param missionKey string
---@param key string
---@param forWhichPlayer wc3_player
---@param x number
---@param y number
---@param facing number
---@return wc3_unit
function RestoreUnit(cache,missionKey,key,forWhichPlayer,x,y,facing) end
---@return wc3_hashtable
function InitHashtable() end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param value integer

function SaveInteger(table,parentKey,childKey,value) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param value number

function SaveReal(table,parentKey,childKey,value) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param value boolean

function SaveBoolean(table,parentKey,childKey,value) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param value string
---@return boolean
function SaveStr(table,parentKey,childKey,value) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichPlayer wc3_player
---@return boolean
function SavePlayerHandle(table,parentKey,childKey,whichPlayer) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichWidget wc3_widget
---@return boolean
function SaveWidgetHandle(table,parentKey,childKey,whichWidget) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichDestructable wc3_destructable
---@return boolean
function SaveDestructableHandle(table,parentKey,childKey,whichDestructable) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichItem wc3_item
---@return boolean
function SaveItemHandle(table,parentKey,childKey,whichItem) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichUnit wc3_unit
---@return boolean
function SaveUnitHandle(table,parentKey,childKey,whichUnit) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichAbility wc3_ability
---@return boolean
function SaveAbilityHandle(table,parentKey,childKey,whichAbility) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTimer wc3_timer
---@return boolean
function SaveTimerHandle(table,parentKey,childKey,whichTimer) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTrigger wc3_trigger
---@return boolean
function SaveTriggerHandle(table,parentKey,childKey,whichTrigger) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTriggercondition wc3_triggercondition
---@return boolean
function SaveTriggerConditionHandle(table,parentKey,childKey,whichTriggercondition) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTriggeraction wc3_triggeraction
---@return boolean
function SaveTriggerActionHandle(table,parentKey,childKey,whichTriggeraction) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichEvent wc3_event
---@return boolean
function SaveTriggerEventHandle(table,parentKey,childKey,whichEvent) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichForce wc3_force
---@return boolean
function SaveForceHandle(table,parentKey,childKey,whichForce) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichGroup wc3_group
---@return boolean
function SaveGroupHandle(table,parentKey,childKey,whichGroup) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichLocation wc3_location
---@return boolean
function SaveLocationHandle(table,parentKey,childKey,whichLocation) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichRect wc3_rect
---@return boolean
function SaveRectHandle(table,parentKey,childKey,whichRect) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichBoolexpr wc3_boolexpr
---@return boolean
function SaveBooleanExprHandle(table,parentKey,childKey,whichBoolexpr) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichSound wc3_sound
---@return boolean
function SaveSoundHandle(table,parentKey,childKey,whichSound) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichEffect wc3_effect
---@return boolean
function SaveEffectHandle(table,parentKey,childKey,whichEffect) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichUnitpool wc3_unitpool
---@return boolean
function SaveUnitPoolHandle(table,parentKey,childKey,whichUnitpool) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichItempool wc3_itempool
---@return boolean
function SaveItemPoolHandle(table,parentKey,childKey,whichItempool) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichQuest wc3_quest
---@return boolean
function SaveQuestHandle(table,parentKey,childKey,whichQuest) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichQuestitem wc3_questitem
---@return boolean
function SaveQuestItemHandle(table,parentKey,childKey,whichQuestitem) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichDefeatcondition wc3_defeatcondition
---@return boolean
function SaveDefeatConditionHandle(table,parentKey,childKey,whichDefeatcondition) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTimerdialog wc3_timerdialog
---@return boolean
function SaveTimerDialogHandle(table,parentKey,childKey,whichTimerdialog) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichLeaderboard wc3_leaderboard
---@return boolean
function SaveLeaderboardHandle(table,parentKey,childKey,whichLeaderboard) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichMultiboard wc3_multiboard
---@return boolean
function SaveMultiboardHandle(table,parentKey,childKey,whichMultiboard) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichMultiboarditem wc3_multiboarditem
---@return boolean
function SaveMultiboardItemHandle(table,parentKey,childKey,whichMultiboarditem) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTrackable wc3_trackable
---@return boolean
function SaveTrackableHandle(table,parentKey,childKey,whichTrackable) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichDialog wc3_dialog
---@return boolean
function SaveDialogHandle(table,parentKey,childKey,whichDialog) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichButton wc3_button
---@return boolean
function SaveButtonHandle(table,parentKey,childKey,whichButton) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichTexttag wc3_texttag
---@return boolean
function SaveTextTagHandle(table,parentKey,childKey,whichTexttag) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichLightning wc3_lightning
---@return boolean
function SaveLightningHandle(table,parentKey,childKey,whichLightning) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichImage wc3_image
---@return boolean
function SaveImageHandle(table,parentKey,childKey,whichImage) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichUbersplat wc3_ubersplat
---@return boolean
function SaveUbersplatHandle(table,parentKey,childKey,whichUbersplat) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichRegion wc3_region
---@return boolean
function SaveRegionHandle(table,parentKey,childKey,whichRegion) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichFogState wc3_fogstate
---@return boolean
function SaveFogStateHandle(table,parentKey,childKey,whichFogState) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichFogModifier wc3_fogmodifier
---@return boolean
function SaveFogModifierHandle(table,parentKey,childKey,whichFogModifier) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichAgent wc3_agent
---@return boolean
function SaveAgentHandle(table,parentKey,childKey,whichAgent) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichHashtable wc3_hashtable
---@return boolean
function SaveHashtableHandle(table,parentKey,childKey,whichHashtable) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@param whichFrameHandle wc3_framehandle
---@return boolean
function SaveFrameHandle(table,parentKey,childKey,whichFrameHandle) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return integer
function LoadInteger(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return number
function LoadReal(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return boolean
function LoadBoolean(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return string
function LoadStr(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_player
function LoadPlayerHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_widget
function LoadWidgetHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_destructable
function LoadDestructableHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_item
function LoadItemHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_unit
function LoadUnitHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_ability
function LoadAbilityHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_timer
function LoadTimerHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_trigger
function LoadTriggerHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_triggercondition
function LoadTriggerConditionHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_triggeraction
function LoadTriggerActionHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_event
function LoadTriggerEventHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_force
function LoadForceHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_group
function LoadGroupHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_location
function LoadLocationHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_rect
function LoadRectHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_boolexpr
function LoadBooleanExprHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_sound
function LoadSoundHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_effect
function LoadEffectHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_unitpool
function LoadUnitPoolHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_itempool
function LoadItemPoolHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_quest
function LoadQuestHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_questitem
function LoadQuestItemHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_defeatcondition
function LoadDefeatConditionHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_timerdialog
function LoadTimerDialogHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_leaderboard
function LoadLeaderboardHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_multiboard
function LoadMultiboardHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_multiboarditem
function LoadMultiboardItemHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_trackable
function LoadTrackableHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_dialog
function LoadDialogHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_button
function LoadButtonHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_texttag
function LoadTextTagHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_lightning
function LoadLightningHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_image
function LoadImageHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_ubersplat
function LoadUbersplatHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_region
function LoadRegionHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_fogstate
function LoadFogStateHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_fogmodifier
function LoadFogModifierHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_hashtable
function LoadHashtableHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return wc3_framehandle
function LoadFrameHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return boolean
function HaveSavedInteger(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return boolean
function HaveSavedReal(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return boolean
function HaveSavedBoolean(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return boolean
function HaveSavedString(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
---@return boolean
function HaveSavedHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer

function RemoveSavedInteger(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer

function RemoveSavedReal(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer

function RemoveSavedBoolean(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
function RemoveSavedString(table,parentKey,childKey) end
---@param table wc3_hashtable
---@param parentKey integer
---@param childKey integer
function RemoveSavedHandle(table,parentKey,childKey) end
---@param table wc3_hashtable
function FlushParentHashtable(table) end
---@param table wc3_hashtable
---@param parentKey integer
function FlushChildHashtable(table,parentKey) end
---@param lowBound integer
---@param highBound integer
---@return integer
function GetRandomInt(lowBound,highBound) end
---@param lowBound number
---@param highBound number
---@return number
function GetRandomReal(lowBound,highBound) end
---@return wc3_unitpool
function CreateUnitPool() end
---@param whichPool wc3_unitpool
function DestroyUnitPool(whichPool) end
---@param whichPool wc3_unitpool
---@param unitId integer
---@param weight number
function UnitPoolAddUnitType(whichPool,unitId,weight) end
---@param whichPool wc3_unitpool
---@param unitId integer
function UnitPoolRemoveUnitType(whichPool,unitId) end
---@param whichPool wc3_unitpool
---@param forWhichPlayer wc3_player
---@param x number
---@param y number
---@param facing number
---@return wc3_unit
function PlaceRandomUnit(whichPool,forWhichPlayer,x,y,facing) end
---@return wc3_itempool
function CreateItemPool() end
---@param whichItemPool wc3_itempool

function DestroyItemPool(whichItemPool) end
---@param whichItemPool wc3_itempool
---@param itemId integer
---@param weight number

function ItemPoolAddItemType(whichItemPool,itemId,weight) end
---@param whichItemPool wc3_itempool
---@param itemId integer

function ItemPoolRemoveItemType(whichItemPool,itemId) end
---@param whichItemPool wc3_itempool
---@param x number
---@param y number
---@return wc3_item
function PlaceRandomItem(whichItemPool,x,y) end
---@param level integer
---@return integer
function ChooseRandomCreep(level) end
---@return integer
function ChooseRandomNPBuilding() end
---@param level integer
---@return integer
function ChooseRandomItem(level) end
---@param whichType wc3_itemtype
---@param level integer
---@return integer
function ChooseRandomItemEx(whichType,level) end
---@param seed integer
function SetRandomSeed(seed) end
---@param a number
---@param b number
---@param c number
---@param d number
---@param e number
function SetTerrainFog(a,b,c,d,e) end
function ResetTerrainFog() end
---@param a number
---@param b number
---@param c number
---@param d number
---@param e number
function SetUnitFog(a,b,c,d,e) end
---@param style integer
---@param zstart number
---@param zend number
---@param density number
---@param red number
---@param green number
---@param blue number
function SetTerrainFogEx(style,zstart,zend,density,red,green,blue) end
---@param toPlayer wc3_player
---@param x number
---@param y number
---@param message string
function DisplayTextToPlayer(toPlayer,x,y,message) end
---@param toPlayer wc3_player
---@param x number
---@param y number
---@param duration number
---@param message string
function DisplayTimedTextToPlayer(toPlayer,x,y,duration,message) end
---@param toPlayer wc3_player
---@param x number
---@param y number
---@param duration number
---@param message string
function DisplayTimedTextFromPlayer(toPlayer,x,y,duration,message) end
function ClearTextMessages() end
---@param terrainDNCFile string
---@param unitDNCFile string
function SetDayNightModels(terrainDNCFile,unitDNCFile) end
---@param skyModelFile string
function SetSkyModel(skyModelFile) end
---@param b boolean
function EnableUserControl(b) end
---@param b boolean
function EnableUserUI(b) end
---@param b boolean
function SuspendTimeOfDay(b) end
---@param r number
function SetTimeOfDayScale(r) end
---@return number
function GetTimeOfDayScale() end
---@param flag boolean
---@param fadeDuration number
function ShowInterface(flag,fadeDuration) end
---@param flag boolean
function PauseGame(flag) end
---@param whichUnit wc3_unit
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function UnitAddIndicator(whichUnit,red,green,blue,alpha) end
---@param whichWidget wc3_widget
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function AddIndicator(whichWidget,red,green,blue,alpha) end
---@param x number
---@param y number
---@param duration number

function PingMinimap(x,y,duration) end
---@param x number
---@param y number
---@param duration number
---@param red integer
---@param green integer
---@param blue integer
---@param extraEffects boolean
function PingMinimapEx(x,y,duration,red,green,blue,extraEffects) end
---@param flag boolean
function EnableOcclusion(flag) end
---@param introText string
function SetIntroShotText(introText) end
---@param introModelPath string
function SetIntroShotModel(introModelPath) end
---@param b boolean
function EnableWorldFogBoundary(b) end
---@param modelName string
function PlayModelCinematic(modelName) end
---@param movieName string
function PlayCinematic(movieName) end
---@param key string
function ForceUIKey(key) end
function ForceUICancel() end
function DisplayLoadDialog() end
---@param iconPath string
function SetAltMinimapIcon(iconPath) end
---@param flag boolean
function DisableRestartMission(flag) end
---@return wc3_texttag
function CreateTextTag() end
---@param t wc3_texttag

function DestroyTextTag(t) end
---@param t wc3_texttag
---@param s string
---@param height number

function SetTextTagText(t,s,height) end
---@param t wc3_texttag
---@param x number
---@param y number
---@param heightOffset number

function SetTextTagPos(t,x,y,heightOffset) end
---@param t wc3_texttag
---@param whichUnit wc3_unit
---@param heightOffset number

function SetTextTagPosUnit(t,whichUnit,heightOffset) end
---@param t wc3_texttag
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer

function SetTextTagColor(t,red,green,blue,alpha) end
---@param t wc3_texttag
---@param xvel number
---@param yvel number

function SetTextTagVelocity(t,xvel,yvel) end
---@param t wc3_texttag
---@param flag boolean

function SetTextTagVisibility(t,flag) end
---@param t wc3_texttag
---@param flag boolean

function SetTextTagSuspended(t,flag) end
---@param t wc3_texttag
---@param flag boolean

function SetTextTagPermanent(t,flag) end
---@param t wc3_texttag
---@param age number

function SetTextTagAge(t,age) end
---@param t wc3_texttag
---@param lifespan number

function SetTextTagLifespan(t,lifespan) end
---@param t wc3_texttag
---@param fadepoint number

function SetTextTagFadepoint(t,fadepoint) end
---@param reserved integer

function SetReservedLocalHeroButtons(reserved) end
---@return integer
function GetAllyColorFilterState() end
---@param state integer

function SetAllyColorFilterState(state) end
---@return boolean
function GetCreepCampFilterState() end
---@param state boolean

function SetCreepCampFilterState(state) end
---@param enableAlly boolean
---@param enableCreep boolean

function EnableMinimapFilterButtons(enableAlly,enableCreep) end
---@param state boolean
---@param ui boolean

function EnableDragSelect(state,ui) end
---@param state boolean
---@param ui boolean

function EnablePreSelect(state,ui) end
---@param state boolean
---@param ui boolean

function EnableSelect(state,ui) end
---@param trackableModelPath string
---@param x number
---@param y number
---@param facing number
---@return wc3_trackable
function CreateTrackable(trackableModelPath,x,y,facing) end
---@return wc3_quest
function CreateQuest() end
---@param whichQuest wc3_quest

function DestroyQuest(whichQuest) end
---@param whichQuest wc3_quest
---@param title string

function QuestSetTitle(whichQuest,title) end
---@param whichQuest wc3_quest
---@param description string

function QuestSetDescription(whichQuest,description) end
---@param whichQuest wc3_quest
---@param iconPath string

function QuestSetIconPath(whichQuest,iconPath) end
---@param whichQuest wc3_quest
---@param required boolean

function QuestSetRequired(whichQuest,required) end
---@param whichQuest wc3_quest
---@param completed boolean

function QuestSetCompleted(whichQuest,completed) end
---@param whichQuest wc3_quest
---@param discovered boolean

function QuestSetDiscovered(whichQuest,discovered) end
---@param whichQuest wc3_quest
---@param failed boolean

function QuestSetFailed(whichQuest,failed) end
---@param whichQuest wc3_quest
---@param enabled boolean

function QuestSetEnabled(whichQuest,enabled) end
---@param whichQuest wc3_quest
---@return boolean
function IsQuestRequired(whichQuest) end
---@param whichQuest wc3_quest
---@return boolean
function IsQuestCompleted(whichQuest) end
---@param whichQuest wc3_quest
---@return boolean
function IsQuestDiscovered(whichQuest) end
---@param whichQuest wc3_quest
---@return boolean
function IsQuestFailed(whichQuest) end
---@param whichQuest wc3_quest
---@return boolean
function IsQuestEnabled(whichQuest) end
---@param whichQuest wc3_quest
---@return wc3_questitem
function QuestCreateItem(whichQuest) end
---@param whichQuestItem wc3_questitem
---@param description string
function QuestItemSetDescription(whichQuestItem,description) end
---@param whichQuestItem wc3_questitem
---@param completed boolean
function QuestItemSetCompleted(whichQuestItem,completed) end
---@param whichQuestItem wc3_questitem
---@return boolean
function IsQuestItemCompleted(whichQuestItem) end
---@return wc3_defeatcondition
function CreateDefeatCondition() end
---@param whichCondition wc3_defeatcondition
function DestroyDefeatCondition(whichCondition) end
---@param whichCondition wc3_defeatcondition
---@param description string
function DefeatConditionSetDescription(whichCondition,description) end
function FlashQuestDialogButton() end
function ForceQuestDialogUpdate() end
---@param t wc3_timer
---@return wc3_timerdialog
function CreateTimerDialog(t) end
---@param whichDialog wc3_timerdialog

function DestroyTimerDialog(whichDialog) end
---@param whichDialog wc3_timerdialog
---@param title string

function TimerDialogSetTitle(whichDialog,title) end
---@param whichDialog wc3_timerdialog
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer

function TimerDialogSetTitleColor(whichDialog,red,green,blue,alpha) end
---@param whichDialog wc3_timerdialog
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer

function TimerDialogSetTimeColor(whichDialog,red,green,blue,alpha) end
---@param whichDialog wc3_timerdialog
---@param speedMultFactor number

function TimerDialogSetSpeed(whichDialog,speedMultFactor) end
---@param whichDialog wc3_timerdialog
---@param display boolean

function TimerDialogDisplay(whichDialog,display) end
---@param whichDialog wc3_timerdialog
---@return boolean
function IsTimerDialogDisplayed(whichDialog) end
---@param whichDialog wc3_timerdialog
---@param timeRemaining number

function TimerDialogSetRealTimeRemaining(whichDialog,timeRemaining) end
---@return wc3_leaderboard
function CreateLeaderboard() end
---@param lb wc3_leaderboard

function DestroyLeaderboard(lb) end
---@param lb wc3_leaderboard
---@param show boolean

function LeaderboardDisplay(lb,show) end
---@param lb wc3_leaderboard
---@return boolean
function IsLeaderboardDisplayed(lb) end
---@param lb wc3_leaderboard
---@return integer
function LeaderboardGetItemCount(lb) end
---@param lb wc3_leaderboard
---@param count integer

function LeaderboardSetSizeByItemCount(lb,count) end
---@param lb wc3_leaderboard
---@param label string
---@param value integer
---@param p wc3_player
function LeaderboardAddItem(lb,label,value,p) end
---@param lb wc3_leaderboard
---@param index integer
function LeaderboardRemoveItem(lb,index) end
---@param lb wc3_leaderboard
---@param p wc3_player
function LeaderboardRemovePlayerItem(lb,p) end
---@param lb wc3_leaderboard
function LeaderboardClear(lb) end
---@param lb wc3_leaderboard
---@param ascending boolean
function LeaderboardSortItemsByValue(lb,ascending) end
---@param lb wc3_leaderboard
---@param ascending boolean
function LeaderboardSortItemsByPlayer(lb,ascending) end
---@param lb wc3_leaderboard
---@param ascending boolean
function LeaderboardSortItemsByLabel(lb,ascending) end
---@param lb wc3_leaderboard
---@param p wc3_player
---@return boolean
function LeaderboardHasPlayerItem(lb,p) end
---@param lb wc3_leaderboard
---@param p wc3_player
---@return integer
function LeaderboardGetPlayerIndex(lb,p) end
---@param lb wc3_leaderboard
---@param label string
function LeaderboardSetLabel(lb,label) end
---@param lb wc3_leaderboard
---@return string
function LeaderboardGetLabelText(lb) end
---@param toPlayer wc3_player
---@param lb wc3_leaderboard
function PlayerSetLeaderboard(toPlayer,lb) end
---@param toPlayer wc3_player
---@return wc3_leaderboard
function PlayerGetLeaderboard(toPlayer) end
---@param lb wc3_leaderboard
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function LeaderboardSetLabelColor(lb,red,green,blue,alpha) end
---@param lb wc3_leaderboard
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function LeaderboardSetValueColor(lb,red,green,blue,alpha) end
---@param lb wc3_leaderboard
---@param showLabel boolean
---@param showNames boolean
---@param showValues boolean
---@param showIcons boolean
function LeaderboardSetStyle(lb,showLabel,showNames,showValues,showIcons) end
---@param lb wc3_leaderboard
---@param whichItem integer
---@param val integer
function LeaderboardSetItemValue(lb,whichItem,val) end
---@param lb wc3_leaderboard
---@param whichItem integer
---@param val string
function LeaderboardSetItemLabel(lb,whichItem,val) end
---@param lb wc3_leaderboard
---@param whichItem integer
---@param showLabel boolean
---@param showValue boolean
---@param showIcon boolean
function LeaderboardSetItemStyle(lb,whichItem,showLabel,showValue,showIcon) end
---@param lb wc3_leaderboard
---@param whichItem integer
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function LeaderboardSetItemLabelColor(lb,whichItem,red,green,blue,alpha) end
---@param lb wc3_leaderboard
---@param whichItem integer
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function LeaderboardSetItemValueColor(lb,whichItem,red,green,blue,alpha) end
---@return wc3_multiboard
function CreateMultiboard() end
---@param lb wc3_multiboard
function DestroyMultiboard(lb) end
---@param lb wc3_multiboard
---@param show boolean
function MultiboardDisplay(lb,show) end
---@param lb wc3_multiboard
---@return boolean
function IsMultiboardDisplayed(lb) end
---@param lb wc3_multiboard
---@param minimize boolean
function MultiboardMinimize(lb,minimize) end
---@param lb wc3_multiboard
---@return boolean
function IsMultiboardMinimized(lb) end
---@param lb wc3_multiboard
function MultiboardClear(lb) end
---@param lb wc3_multiboard
---@param label string
function MultiboardSetTitleText(lb,label) end
---@param lb wc3_multiboard
---@return string
function MultiboardGetTitleText(lb) end
---@param lb wc3_multiboard
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function MultiboardSetTitleTextColor(lb,red,green,blue,alpha) end
---@param lb wc3_multiboard
---@return integer
function MultiboardGetRowCount(lb) end
---@param lb wc3_multiboard
---@return integer
function MultiboardGetColumnCount(lb) end
---@param lb wc3_multiboard
---@param count integer
function MultiboardSetColumnCount(lb,count) end
---@param lb wc3_multiboard
---@param count integer
function MultiboardSetRowCount(lb,count) end
---@param lb wc3_multiboard
---@param showValues boolean
---@param showIcons boolean
function MultiboardSetItemsStyle(lb,showValues,showIcons) end
---@param lb wc3_multiboard
---@param value string
function MultiboardSetItemsValue(lb,value) end
---@param lb wc3_multiboard
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function MultiboardSetItemsValueColor(lb,red,green,blue,alpha) end
---@param lb wc3_multiboard
---@param width number
function MultiboardSetItemsWidth(lb,width) end
---@param lb wc3_multiboard
---@param iconPath string
function MultiboardSetItemsIcon(lb,iconPath) end
---@param lb wc3_multiboard
---@param row integer
---@param column integer
---@return wc3_multiboarditem
function MultiboardGetItem(lb,row,column) end
---@param mbi wc3_multiboarditem
function MultiboardReleaseItem(mbi) end
---@param mbi wc3_multiboarditem
---@param showValue boolean
---@param showIcon boolean
function MultiboardSetItemStyle(mbi,showValue,showIcon) end
---@param mbi wc3_multiboarditem
---@param val string
function MultiboardSetItemValue(mbi,val) end
---@param mbi wc3_multiboarditem
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function MultiboardSetItemValueColor(mbi,red,green,blue,alpha) end
---@param mbi wc3_multiboarditem
---@param width number
function MultiboardSetItemWidth(mbi,width) end
---@param mbi wc3_multiboarditem
---@param iconFileName string
function MultiboardSetItemIcon(mbi,iconFileName) end
---@param flag boolean
function MultiboardSuppressDisplay(flag) end
---@param x number
---@param y number
function SetCameraPosition(x,y) end
---@param x number
---@param y number
function SetCameraQuickPosition(x,y) end
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param x3 number
---@param y3 number
---@param x4 number
---@param y4 number
function SetCameraBounds(x1,y1,x2,y2,x3,y3,x4,y4) end
function StopCamera() end
---@param duration number
function ResetToGameCamera(duration) end
---@param x number
---@param y number
function PanCameraTo(x,y) end
---@param x number
---@param y number
---@param duration number
function PanCameraToTimed(x,y,duration) end
---@param x number
---@param y number
---@param zOffsetDest number
function PanCameraToWithZ(x,y,zOffsetDest) end
---@param x number
---@param y number
---@param zOffsetDest number
---@param duration number
function PanCameraToTimedWithZ(x,y,zOffsetDest,duration) end
---@param cameraModelFile string
function SetCinematicCamera(cameraModelFile) end
---@param x number
---@param y number
---@param radiansToSweep number
---@param duration number
function SetCameraRotateMode(x,y,radiansToSweep,duration) end
---@param whichField wc3_camerafield
---@param value number
---@param duration number
function SetCameraField(whichField,value,duration) end
---@param whichField wc3_camerafield
---@param offset number
---@param duration number
function AdjustCameraField(whichField,offset,duration) end
---@param whichUnit wc3_unit
---@param xoffset number
---@param yoffset number
---@param inheritOrientation boolean
function SetCameraTargetController(whichUnit,xoffset,yoffset,inheritOrientation) end
---@param whichUnit wc3_unit
---@param xoffset number
---@param yoffset number
function SetCameraOrientController(whichUnit,xoffset,yoffset) end
---@return wc3_camerasetup
function CreateCameraSetup() end
---@param whichSetup wc3_camerasetup
---@param whichField wc3_camerafield
---@param value number
---@param duration number
function CameraSetupSetField(whichSetup,whichField,value,duration) end
---@param whichSetup wc3_camerasetup
---@param whichField wc3_camerafield
---@return number
function CameraSetupGetField(whichSetup,whichField) end
---@param whichSetup wc3_camerasetup
---@param x number
---@param y number
---@param duration number
function CameraSetupSetDestPosition(whichSetup,x,y,duration) end
---@param whichSetup wc3_camerasetup
---@return wc3_location
function CameraSetupGetDestPositionLoc(whichSetup) end
---@param whichSetup wc3_camerasetup
---@return number
function CameraSetupGetDestPositionX(whichSetup) end
---@param whichSetup wc3_camerasetup
---@return number
function CameraSetupGetDestPositionY(whichSetup) end
---@param whichSetup wc3_camerasetup
---@param doPan boolean
---@param panTimed boolean
function CameraSetupApply(whichSetup,doPan,panTimed) end
---@param whichSetup wc3_camerasetup
---@param zDestOffset number
function CameraSetupApplyWithZ(whichSetup,zDestOffset) end
---@param whichSetup wc3_camerasetup
---@param doPan boolean
---@param forceDuration number
function CameraSetupApplyForceDuration(whichSetup,doPan,forceDuration) end
---@param whichSetup wc3_camerasetup
---@param zDestOffset number
---@param forceDuration number
function CameraSetupApplyForceDurationWithZ(whichSetup,zDestOffset,forceDuration) end
---@param mag number
---@param velocity number
function CameraSetTargetNoise(mag,velocity) end
---@param mag number
---@param velocity number
function CameraSetSourceNoise(mag,velocity) end
---@param mag number
---@param velocity number
---@param vertOnly boolean
function CameraSetTargetNoiseEx(mag,velocity,vertOnly) end
---@param mag number
---@param velocity number
---@param vertOnly boolean
function CameraSetSourceNoiseEx(mag,velocity,vertOnly) end
---@param factor number
function CameraSetSmoothingFactor(factor) end
---@param filename string
function SetCineFilterTexture(filename) end
---@param whichMode wc3_blendmode
function SetCineFilterBlendMode(whichMode) end
---@param whichFlags wc3_texmapflags
function SetCineFilterTexMapFlags(whichFlags) end
---@param minu number
---@param minv number
---@param maxu number
---@param maxv number
function SetCineFilterStartUV(minu,minv,maxu,maxv) end
---@param minu number
---@param minv number
---@param maxu number
---@param maxv number
function SetCineFilterEndUV(minu,minv,maxu,maxv) end
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetCineFilterStartColor(red,green,blue,alpha) end
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetCineFilterEndColor(red,green,blue,alpha) end
---@param duration number
function SetCineFilterDuration(duration) end
---@param flag boolean
function DisplayCineFilter(flag) end
---@return boolean
function IsCineFilterDisplayed() end
---@param portraitUnitId integer
---@param color wc3_playercolor
---@param speakerTitle string
---@param text string
---@param sceneDuration number
---@param voiceoverDuration number
function SetCinematicScene(portraitUnitId,color,speakerTitle,text,sceneDuration,voiceoverDuration) end
function EndCinematicScene() end
---@param flag boolean
function ForceCinematicSubtitles(flag) end
---@param whichMargin integer
---@return number
function GetCameraMargin(whichMargin) end
---@param environmentName string
function NewSoundEnvironment(environmentName) end
---@param fileName string
---@param looping boolean
---@param is3D boolean
---@param stopwhenoutofrange boolean
---@param fadeInRate integer
---@param fadeOutRate integer
---@param eaxSetting string
---@return wc3_sound
function CreateSound(fileName,looping,is3D,stopwhenoutofrange,fadeInRate,fadeOutRate,eaxSetting) end
---@param fileName string
---@param looping boolean
---@param is3D boolean
---@param stopwhenoutofrange boolean
---@param fadeInRate integer
---@param fadeOutRate integer
---@param SLKEntryName string
---@return wc3_sound
function CreateSoundFilenameWithLabel(fileName,looping,is3D,stopwhenoutofrange,fadeInRate,fadeOutRate,SLKEntryName) end
---@param soundLabel string
---@param looping boolean
---@param is3D boolean
---@param stopwhenoutofrange boolean
---@param fadeInRate integer
---@param fadeOutRate integer
---@return wc3_sound
function CreateSoundFromLabel(soundLabel,looping,is3D,stopwhenoutofrange,fadeInRate,fadeOutRate) end
---@param soundLabel string
---@param fadeInRate integer
---@param fadeOutRate integer
---@return wc3_sound
function CreateMIDISound(soundLabel,fadeInRate,fadeOutRate) end
---@param soundHandle wc3_sound
---@param soundLabel string
function SetSoundParamsFromLabel(soundHandle,soundLabel) end
---@param soundHandle wc3_sound
---@param cutoff number
function SetSoundDistanceCutoff(soundHandle,cutoff) end
---@param soundHandle wc3_sound
---@param channel integer
function SetSoundChannel(soundHandle,channel) end
---@param soundHandle wc3_sound
---@param volume integer
function SetSoundVolume(soundHandle,volume) end
---@param soundHandle wc3_sound
---@param pitch number
function SetSoundPitch(soundHandle,pitch) end
---@param soundHandle wc3_sound
---@param millisecs integer
function SetSoundPlayPosition(soundHandle,millisecs) end
---@param soundHandle wc3_sound
---@param minDist number
---@param maxDist number
function SetSoundDistances(soundHandle,minDist,maxDist) end
---@param soundHandle wc3_sound
---@param inside number
---@param outside number
---@param outsideVolume integer
function SetSoundConeAngles(soundHandle,inside,outside,outsideVolume) end
---@param soundHandle wc3_sound
---@param x number
---@param y number
---@param z number
function SetSoundConeOrientation(soundHandle,x,y,z) end
---@param soundHandle wc3_sound
---@param x number
---@param y number
---@param z number
function SetSoundPosition(soundHandle,x,y,z) end
---@param soundHandle wc3_sound
---@param x number
---@param y number
---@param z number
function SetSoundVelocity(soundHandle,x,y,z) end
---@param soundHandle wc3_sound
---@param whichUnit wc3_unit
function AttachSoundToUnit(soundHandle,whichUnit) end
---@param soundHandle wc3_sound
function StartSound(soundHandle) end
---@param soundHandle wc3_sound
---@param killWhenDone boolean
---@param fadeOut boolean
function StopSound(soundHandle,killWhenDone,fadeOut) end
---@param soundHandle wc3_sound
function KillSoundWhenDone(soundHandle) end
---@param musicName string
---@param random boolean
---@param index integer
function SetMapMusic(musicName,random,index) end
function ClearMapMusic() end
---@param musicName string
function PlayMusic(musicName) end
---@param musicName string
---@param frommsecs integer
---@param fadeinmsecs integer
function PlayMusicEx(musicName,frommsecs,fadeinmsecs) end
---@param fadeOut boolean
function StopMusic(fadeOut) end
function ResumeMusic() end
---@param musicFileName string
function PlayThematicMusic(musicFileName) end
---@param musicFileName string
---@param frommsecs integer
function PlayThematicMusicEx(musicFileName,frommsecs) end
function EndThematicMusic() end
---@param volume integer
function SetMusicVolume(volume) end
---@param millisecs integer
function SetMusicPlayPosition(millisecs) end
---@param millisecs integer
function SetThematicMusicPlayPosition(millisecs) end
---@param soundHandle wc3_sound
---@param duration integer
function SetSoundDuration(soundHandle,duration) end
---@param soundHandle wc3_sound
---@return integer
function GetSoundDuration(soundHandle) end
---@param musicFileName string
---@return integer
function GetSoundFileDuration(musicFileName) end
---@param vgroup wc3_volumegroup
---@param scale number
function VolumeGroupSetVolume(vgroup,scale) end
function VolumeGroupReset() end
---@param soundHandle wc3_sound
---@return boolean
function GetSoundIsPlaying(soundHandle) end
---@param soundHandle wc3_sound
---@return boolean
function GetSoundIsLoading(soundHandle) end
---@param soundHandle wc3_sound
---@param byPosition boolean
---@param rectwidth number
---@param rectheight number
function RegisterStackedSound(soundHandle,byPosition,rectwidth,rectheight) end
---@param soundHandle wc3_sound
---@param byPosition boolean
---@param rectwidth number
---@param rectheight number
function UnregisterStackedSound(soundHandle,byPosition,rectwidth,rectheight) end
---@param where wc3_rect
---@param effectID integer
---@return wc3_weathereffect
function AddWeatherEffect(where,effectID) end
---@param whichEffect wc3_weathereffect
function RemoveWeatherEffect(whichEffect) end
---@param whichEffect wc3_weathereffect
---@param enable boolean
function EnableWeatherEffect(whichEffect,enable) end
---@param x number
---@param y number
---@param radius number
---@param depth number
---@param duration integer
---@param permanent boolean
---@return wc3_terraindeformation
function TerrainDeformCrater(x,y,radius,depth,duration,permanent) end
---@param x number
---@param y number
---@param radius number
---@param depth number
---@param duration integer
---@param count integer
---@param spaceWaves number
---@param timeWaves number
---@param radiusStartPct number
---@param limitNeg boolean
---@return wc3_terraindeformation
function TerrainDeformRipple(x,y,radius,depth,duration,count,spaceWaves,timeWaves,radiusStartPct,limitNeg) end
---@param x number
---@param y number
---@param dirX number
---@param dirY number
---@param distance number
---@param speed number
---@param radius number
---@param depth number
---@param trailTime integer
---@param count integer
---@return wc3_terraindeformation
function TerrainDeformWave(x,y,dirX,dirY,distance,speed,radius,depth,trailTime,count) end
---@param x number
---@param y number
---@param radius number
---@param minDelta number
---@param maxDelta number
---@param duration integer
---@param updateInterval integer
---@return wc3_terraindeformation
function TerrainDeformRandom(x,y,radius,minDelta,maxDelta,duration,updateInterval) end
---@param deformation wc3_terraindeformation
---@param duration integer
function TerrainDeformStop(deformation,duration) end
function TerrainDeformStopAll() end
---@param modelName string
---@param x number
---@param y number
---@return wc3_effect
function AddSpecialEffect(modelName,x,y) end
---@param modelName string
---@param where wc3_location
---@return wc3_effect
function AddSpecialEffectLoc(modelName,where) end
---@param modelName string
---@param targetWidget wc3_widget
---@param attachPointName string
---@return wc3_effect
function AddSpecialEffectTarget(modelName,targetWidget,attachPointName) end
---@param whichEffect wc3_effect
function DestroyEffect(whichEffect) end
---@param abilityString string
---@param t wc3_effecttype
---@param x number
---@param y number
---@return wc3_effect
function AddSpellEffect(abilityString,t,x,y) end
---@param abilityString string
---@param t wc3_effecttype
---@param where wc3_location
---@return wc3_effect
function AddSpellEffectLoc(abilityString,t,where) end
---@param abilityId integer
---@param t wc3_effecttype
---@param x number
---@param y number
---@return wc3_effect
function AddSpellEffectById(abilityId,t,x,y) end
---@param abilityId integer
---@param t wc3_effecttype
---@param where wc3_location
---@return wc3_effect
function AddSpellEffectByIdLoc(abilityId,t,where) end
---@param modelName string
---@param t wc3_effecttype
---@param targetWidget wc3_widget
---@param attachPoint string
---@return wc3_effect
function AddSpellEffectTarget(modelName,t,targetWidget,attachPoint) end
---@param abilityId integer
---@param t wc3_effecttype
---@param targetWidget wc3_widget
---@param attachPoint string
---@return wc3_effect
function AddSpellEffectTargetById(abilityId,t,targetWidget,attachPoint) end
---@param codeName string
---@param checkVisibility boolean
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return wc3_lightning
function AddLightning(codeName,checkVisibility,x1,y1,x2,y2) end
---@param codeName string
---@param checkVisibility boolean
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return wc3_lightning
function AddLightningEx(codeName,checkVisibility,x1,y1,z1,x2,y2,z2) end
---@param whichBolt wc3_lightning
---@return boolean
function DestroyLightning(whichBolt) end
---@param whichBolt wc3_lightning
---@param checkVisibility boolean
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return boolean
function MoveLightning(whichBolt,checkVisibility,x1,y1,x2,y2) end
---@param whichBolt wc3_lightning
---@param checkVisibility boolean
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return boolean
function MoveLightningEx(whichBolt,checkVisibility,x1,y1,z1,x2,y2,z2) end
---@param whichBolt wc3_lightning
---@return number
function GetLightningColorA(whichBolt) end
---@param whichBolt wc3_lightning
---@return number
function GetLightningColorR(whichBolt) end
---@param whichBolt wc3_lightning
---@return number
function GetLightningColorG(whichBolt) end
---@param whichBolt wc3_lightning
---@return number
function GetLightningColorB(whichBolt) end
---@param whichBolt wc3_lightning
---@param r number
---@param g number
---@param b number
---@param a number
---@return boolean
function SetLightningColor(whichBolt,r,g,b,a) end
---@param abilityString string
---@param t wc3_effecttype
---@param index integer
---@return string
function GetAbilityEffect(abilityString,t,index) end
---@param abilityId integer
---@param t wc3_effecttype
---@param index integer
---@return string
function GetAbilityEffectById(abilityId,t,index) end
---@param abilityString string
---@param t wc3_soundtype
---@return string
function GetAbilitySound(abilityString,t) end
---@param abilityId integer
---@param t wc3_soundtype
---@return string
function GetAbilitySoundById(abilityId,t) end
---@param x number
---@param y number
---@return integer
function GetTerrainCliffLevel(x,y) end
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetWaterBaseColor(red,green,blue,alpha) end
---@param val boolean
function SetWaterDeforms(val) end
---@param x number
---@param y number
---@return integer
function GetTerrainType(x,y) end
---@param x number
---@param y number
---@return integer
function GetTerrainVariance(x,y) end
---@param x number
---@param y number
---@param terrainType integer
---@param variation integer
---@param area integer
---@param shape integer
function SetTerrainType(x,y,terrainType,variation,area,shape) end
---@param x number
---@param y number
---@param t wc3_pathingtype
---@return boolean
function IsTerrainPathable(x,y,t) end
---@param x number
---@param y number
---@param t wc3_pathingtype
---@param flag boolean
function SetTerrainPathable(x,y,t,flag) end
---@param file string
---@param sizeX number
---@param sizeY number
---@param sizeZ number
---@param posX number
---@param posY number
---@param posZ number
---@param originX number
---@param originY number
---@param originZ number
---@param imageType integer
---@return wc3_image
function CreateImage(file,sizeX,sizeY,sizeZ,posX,posY,posZ,originX,originY,originZ,imageType) end
---@param whichImage wc3_image
function DestroyImage(whichImage) end
---@param whichImage wc3_image
---@param flag boolean
function ShowImage(whichImage,flag) end
---@param whichImage wc3_image
---@param flag boolean
---@param height number
function SetImageConstantHeight(whichImage,flag,height) end
---@param whichImage wc3_image
---@param x number
---@param y number
---@param z number
function SetImagePosition(whichImage,x,y,z) end
---@param whichImage wc3_image
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function SetImageColor(whichImage,red,green,blue,alpha) end
---@param whichImage wc3_image
---@param flag boolean
function SetImageRender(whichImage,flag) end
---@param whichImage wc3_image
---@param flag boolean
function SetImageRenderAlways(whichImage,flag) end
---@param whichImage wc3_image
---@param flag boolean
---@param useWaterAlpha boolean
function SetImageAboveWater(whichImage,flag,useWaterAlpha) end
---@param whichImage wc3_image
---@param imageType integer
function SetImageType(whichImage,imageType) end
---@param x number
---@param y number
---@param name string
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
---@param forcePaused boolean
---@param noBirthTime boolean
---@return wc3_ubersplat
function CreateUbersplat(x,y,name,red,green,blue,alpha,forcePaused,noBirthTime) end
---@param whichSplat wc3_ubersplat
function DestroyUbersplat(whichSplat) end
---@param whichSplat wc3_ubersplat
function ResetUbersplat(whichSplat) end
---@param whichSplat wc3_ubersplat
function FinishUbersplat(whichSplat) end
---@param whichSplat wc3_ubersplat
---@param flag boolean
function ShowUbersplat(whichSplat,flag) end
---@param whichSplat wc3_ubersplat
---@param flag boolean
function SetUbersplatRender(whichSplat,flag) end
---@param whichSplat wc3_ubersplat
---@param flag boolean
function SetUbersplatRenderAlways(whichSplat,flag) end
---@param whichPlayer wc3_player
---@param x number
---@param y number
---@param radius number
---@param addBlight boolean
function SetBlight(whichPlayer,x,y,radius,addBlight) end
---@param whichPlayer wc3_player
---@param r wc3_rect
---@param addBlight boolean
function SetBlightRect(whichPlayer,r,addBlight) end
---@param whichPlayer wc3_player
---@param x number
---@param y number
---@param addBlight boolean
function SetBlightPoint(whichPlayer,x,y,addBlight) end
---@param whichPlayer wc3_player
---@param whichLocation wc3_location
---@param radius number
---@param addBlight boolean
function SetBlightLoc(whichPlayer,whichLocation,radius,addBlight) end
---@param id wc3_player
---@param x number
---@param y number
---@param face number
---@return wc3_unit
function CreateBlightedGoldmine(id,x,y,face) end
---@param x number
---@param y number
---@return boolean
function IsPointBlighted(x,y) end
---@param x number
---@param y number
---@param radius number
---@param doodadID integer
---@param nearestOnly boolean
---@param animName string
---@param animRandom boolean
function SetDoodadAnimation(x,y,radius,doodadID,nearestOnly,animName,animRandom) end
---@param r wc3_rect
---@param doodadID integer
---@param animName string
---@param animRandom boolean
function SetDoodadAnimationRect(r,doodadID,animName,animRandom) end
---@param num wc3_player
---@param script string
function StartMeleeAI(num,script) end
---@param num wc3_player
---@param script string
function StartCampaignAI(num,script) end
---@param num wc3_player
---@param command integer
---@param data integer
function CommandAI(num,command,data) end
---@param p wc3_player
---@param pause boolean
function PauseCompAI(p,pause) end
---@param num wc3_player
---@return wc3_aidifficulty
function GetAIDifficulty(num) end
---@param hUnit wc3_unit
function RemoveGuardPosition(hUnit) end
---@param hUnit wc3_unit
function RecycleGuardPosition(hUnit) end
---@param num wc3_player
function RemoveAllGuardPositions(num) end
---@param cheatStr string
function Cheat(cheatStr) end
---@return boolean
function IsNoVictoryCheat() end
---@return boolean
function IsNoDefeatCheat() end
---@param filename string
function Preload(filename) end
---@param timeout number
function PreloadEnd(timeout) end
function PreloadStart() end
function PreloadRefresh() end
function PreloadEndEx() end
function PreloadGenClear() end
function PreloadGenStart() end
---@param filename string
function PreloadGenEnd(filename) end
---@param filename string
function Preloader(filename) end
---@param testType string
function AutomationSetTestType(testType) end
---@param testName string
function AutomationTestStart(testName) end
function AutomationTestEnd() end
function AutomationTestingFinished() end
---@return number
function BlzGetTriggerPlayerMouseX() end
---@return number
function BlzGetTriggerPlayerMouseY() end
---@return wc3_location
function BlzGetTriggerPlayerMousePosition() end
---@return wc3_mousebuttontype
function BlzGetTriggerPlayerMouseButton() end
---@param abilCode integer
---@param tooltip string
---@param level integer
function BlzSetAbilityTooltip(abilCode,tooltip,level) end
---@param abilCode integer
---@param tooltip string
---@param level integer
function BlzSetAbilityActivatedTooltip(abilCode,tooltip,level) end
---@param abilCode integer
---@param extendedTooltip string
---@param level integer
function BlzSetAbilityExtendedTooltip(abilCode,extendedTooltip,level) end
---@param abilCode integer
---@param extendedTooltip string
---@param level integer
function BlzSetAbilityActivatedExtendedTooltip(abilCode,extendedTooltip,level) end
---@param abilCode integer
---@param researchTooltip string
---@param level integer
function BlzSetAbilityResearchTooltip(abilCode,researchTooltip,level) end
---@param abilCode integer
---@param researchExtendedTooltip string
---@param level integer
function BlzSetAbilityResearchExtendedTooltip(abilCode,researchExtendedTooltip,level) end
---@param abilCode integer
---@param level integer
---@return string
function BlzGetAbilityTooltip(abilCode,level) end
---@param abilCode integer
---@param level integer
---@return string
function BlzGetAbilityActivatedTooltip(abilCode,level) end
---@param abilCode integer
---@param level integer
---@return string
function BlzGetAbilityExtendedTooltip(abilCode,level) end
---@param abilCode integer
---@param level integer
---@return string
function BlzGetAbilityActivatedExtendedTooltip(abilCode,level) end
---@param abilCode integer
---@param level integer
---@return string
function BlzGetAbilityResearchTooltip(abilCode,level) end
---@param abilCode integer
---@param level integer
---@return string
function BlzGetAbilityResearchExtendedTooltip(abilCode,level) end
---@param abilCode integer
---@param iconPath string
function BlzSetAbilityIcon(abilCode,iconPath) end
---@param abilCode integer
---@return string
function BlzGetAbilityIcon(abilCode) end
---@param abilCode integer
---@param iconPath string
function BlzSetAbilityActivatedIcon(abilCode,iconPath) end
---@param abilCode integer
---@return string
function BlzGetAbilityActivatedIcon(abilCode) end
---@param abilCode integer
---@return integer
function BlzGetAbilityPosX(abilCode) end
---@param abilCode integer
---@return integer
function BlzGetAbilityPosY(abilCode) end
---@param abilCode integer
---@param x integer
function BlzSetAbilityPosX(abilCode,x) end
---@param abilCode integer
---@param y integer
function BlzSetAbilityPosY(abilCode,y) end
---@param abilCode integer
---@return integer
function BlzGetAbilityActivatedPosX(abilCode) end
---@param abilCode integer
---@return integer
function BlzGetAbilityActivatedPosY(abilCode) end
---@param abilCode integer
---@param x integer
function BlzSetAbilityActivatedPosX(abilCode,x) end
---@param abilCode integer
---@param y integer
function BlzSetAbilityActivatedPosY(abilCode,y) end
---@param whichUnit wc3_unit
---@return integer
function BlzGetUnitMaxHP(whichUnit) end
---@param whichUnit wc3_unit
---@param hp integer
function BlzSetUnitMaxHP(whichUnit,hp) end
---@param whichUnit wc3_unit
---@return integer
function BlzGetUnitMaxMana(whichUnit) end
---@param whichUnit wc3_unit
---@param mana integer
function BlzSetUnitMaxMana(whichUnit,mana) end
---@param whichItem wc3_item
---@param name string
function BlzSetItemName(whichItem,name) end
---@param whichItem wc3_item
---@param description string
function BlzSetItemDescription(whichItem,description) end
---@param whichItem wc3_item
---@return string
function BlzGetItemDescription(whichItem) end
---@param whichItem wc3_item
---@param tooltip string
function BlzSetItemTooltip(whichItem,tooltip) end
---@param whichItem wc3_item
---@return string
function BlzGetItemTooltip(whichItem) end
---@param whichItem wc3_item
---@param extendedTooltip string
function BlzSetItemExtendedTooltip(whichItem,extendedTooltip) end
---@param whichItem wc3_item
---@return string
function BlzGetItemExtendedTooltip(whichItem) end
---@param whichItem wc3_item
---@param iconPath string
function BlzSetItemIconPath(whichItem,iconPath) end
---@param whichItem wc3_item
---@return string
function BlzGetItemIconPath(whichItem) end
---@param whichUnit wc3_unit
---@param name string
function BlzSetUnitName(whichUnit,name) end
---@param whichUnit wc3_unit
---@param heroProperName string
function BlzSetHeroProperName(whichUnit,heroProperName) end
---@param whichUnit wc3_unit
---@param weaponIndex integer
---@return integer
function BlzGetUnitBaseDamage(whichUnit,weaponIndex) end
---@param whichUnit wc3_unit
---@param baseDamage integer
---@param weaponIndex integer
function BlzSetUnitBaseDamage(whichUnit,baseDamage,weaponIndex) end
---@param whichUnit wc3_unit
---@param weaponIndex integer
---@return integer
function BlzGetUnitDiceNumber(whichUnit,weaponIndex) end
---@param whichUnit wc3_unit
---@param diceNumber integer
---@param weaponIndex integer
function BlzSetUnitDiceNumber(whichUnit,diceNumber,weaponIndex) end
---@param whichUnit wc3_unit
---@param weaponIndex integer
---@return integer
function BlzGetUnitDiceSides(whichUnit,weaponIndex) end
---@param whichUnit wc3_unit
---@param diceSides integer
---@param weaponIndex integer
function BlzSetUnitDiceSides(whichUnit,diceSides,weaponIndex) end
---@param whichUnit wc3_unit
---@param weaponIndex integer
---@return number
function BlzGetUnitAttackCooldown(whichUnit,weaponIndex) end
---@param whichUnit wc3_unit
---@param cooldown number
---@param weaponIndex integer
function BlzSetUnitAttackCooldown(whichUnit,cooldown,weaponIndex) end
---@param whichEffect wc3_effect
---@param whichPlayer wc3_player
function BlzSetSpecialEffectColorByPlayer(whichEffect,whichPlayer) end
---@param whichEffect wc3_effect
---@param r integer
---@param g integer
---@param b integer
function BlzSetSpecialEffectColor(whichEffect,r,g,b) end
---@param whichEffect wc3_effect
---@param alpha integer
function BlzSetSpecialEffectAlpha(whichEffect,alpha) end
---@param whichEffect wc3_effect
---@param scale number
function BlzSetSpecialEffectScale(whichEffect,scale) end
---@param whichEffect wc3_effect
---@param x number
---@param y number
---@param z number
function BlzSetSpecialEffectPosition(whichEffect,x,y,z) end
---@param whichEffect wc3_effect
---@param height number
function BlzSetSpecialEffectHeight(whichEffect,height) end
---@param whichEffect wc3_effect
---@param timeScale number
function BlzSetSpecialEffectTimeScale(whichEffect,timeScale) end
---@param whichEffect wc3_effect
---@param time number
function BlzSetSpecialEffectTime(whichEffect,time) end
---@param whichEffect wc3_effect
---@param yaw number
---@param pitch number
---@param roll number
function BlzSetSpecialEffectOrientation(whichEffect,yaw,pitch,roll) end
---@param whichEffect wc3_effect
---@param yaw number
function BlzSetSpecialEffectYaw(whichEffect,yaw) end
---@param whichEffect wc3_effect
---@param pitch number
function BlzSetSpecialEffectPitch(whichEffect,pitch) end
---@param whichEffect wc3_effect
---@param roll number
function BlzSetSpecialEffectRoll(whichEffect,roll) end
---@param whichEffect wc3_effect
---@param x number
function BlzSetSpecialEffectX(whichEffect,x) end
---@param whichEffect wc3_effect
---@param y number
function BlzSetSpecialEffectY(whichEffect,y) end
---@param whichEffect wc3_effect
---@param z number
function BlzSetSpecialEffectZ(whichEffect,z) end
---@param whichEffect wc3_effect
---@param loc wc3_location
function BlzSetSpecialEffectPositionLoc(whichEffect,loc) end
---@param whichEffect wc3_effect
---@return number
function BlzGetLocalSpecialEffectX(whichEffect) end
---@param whichEffect wc3_effect
---@return number
function BlzGetLocalSpecialEffectY(whichEffect) end
---@param whichEffect wc3_effect
---@return number
function BlzGetLocalSpecialEffectZ(whichEffect) end
---@param whichEffect wc3_effect
function BlzSpecialEffectClearSubAnimations(whichEffect) end
---@param whichEffect wc3_effect
---@param whichSubAnim wc3_subanimtype
function BlzSpecialEffectRemoveSubAnimation(whichEffect,whichSubAnim) end
---@param whichEffect wc3_effect
---@param whichSubAnim wc3_subanimtype
function BlzSpecialEffectAddSubAnimation(whichEffect,whichSubAnim) end
---@param whichEffect wc3_effect
---@param whichAnim wc3_animtype
function BlzPlaySpecialEffect(whichEffect,whichAnim) end
---@param whichEffect wc3_effect
---@param whichAnim wc3_animtype
---@param timeScale number
function BlzPlaySpecialEffectWithTimeScale(whichEffect,whichAnim,timeScale) end
---@param whichAnim wc3_animtype
---@return string
function BlzGetAnimName(whichAnim) end
---@param whichUnit wc3_unit
---@return number
function BlzGetUnitArmor(whichUnit) end
---@param whichUnit wc3_unit
---@param armorAmount number
function BlzSetUnitArmor(whichUnit,armorAmount) end
---@param whichUnit wc3_unit
---@param abilId integer
---@param flag boolean
function BlzUnitHideAbility(whichUnit,abilId,flag) end
---@param whichUnit wc3_unit
---@param abilId integer
---@param flag boolean
---@param hideUI boolean
function BlzUnitDisableAbility(whichUnit,abilId,flag,hideUI) end
---@param whichUnit wc3_unit
function BlzUnitCancelTimedLife(whichUnit) end
---@param whichUnit wc3_unit
---@return boolean
function BlzIsUnitSelectable(whichUnit) end
---@param whichUnit wc3_unit
---@return boolean
function BlzIsUnitInvulnerable(whichUnit) end
---@param whichUnit wc3_unit
function BlzUnitInterruptAttack(whichUnit) end
---@param whichUnit wc3_unit
---@return number
function BlzGetUnitCollisionSize(whichUnit) end
---@param abilId integer
---@param level integer
---@return integer
function BlzGetAbilityManaCost(abilId,level) end
---@param abilId integer
---@param level integer
---@return number
function BlzGetAbilityCooldown(abilId,level) end
---@param whichUnit wc3_unit
---@param abilId integer
---@param level integer
---@param cooldown number
function BlzSetUnitAbilityCooldown(whichUnit,abilId,level,cooldown) end
---@param whichUnit wc3_unit
---@param abilId integer
---@param level integer
---@return number
function BlzGetUnitAbilityCooldown(whichUnit,abilId,level) end
---@param whichUnit wc3_unit
---@param abilId integer
---@return number
function BlzGetUnitAbilityCooldownRemaining(whichUnit,abilId) end
---@param whichUnit wc3_unit
---@param abilCode integer
function BlzEndUnitAbilityCooldown(whichUnit,abilCode) end
---@param whichUnit wc3_unit
---@param abilId integer
---@param level integer
---@return integer
function BlzGetUnitAbilityManaCost(whichUnit,abilId,level) end
---@param whichUnit wc3_unit
---@param abilId integer
---@param level integer
---@param manaCost integer
function BlzSetUnitAbilityManaCost(whichUnit,abilId,level,manaCost) end
---@param whichUnit wc3_unit
---@return number
function BlzGetLocalUnitZ(whichUnit) end
---@param whichPlayer wc3_player
---@param techid integer
---@param levels integer
function BlzDecPlayerTechResearched(whichPlayer,techid,levels) end
---@param damage number
function BlzSetEventDamage(damage) end
---@return wc3_unit
function BlzGetEventDamageTarget() end
---@return wc3_attacktype
function BlzGetEventAttackType() end
---@return wc3_damagetype
function BlzGetEventDamageType() end
---@return wc3_weapontype
function BlzGetEventWeaponType() end
---@param attackType wc3_attacktype
---@return boolean
function BlzSetEventAttackType(attackType) end
---@param damageType wc3_damagetype
---@return boolean
function BlzSetEventDamageType(damageType) end
---@param weaponType wc3_weapontype
---@return boolean
function BlzSetEventWeaponType(weaponType) end
---@param dataType integer
---@param whichPlayer wc3_player
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 integer
---@param param5 integer
---@param param6 integer
---@return integer
function RequestExtraIntegerData(dataType,whichPlayer,param1,param2,param3,param4,param5,param6) end
---@param dataType integer
---@param whichPlayer wc3_player
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 integer
---@param param5 integer
---@param param6 integer
---@return boolean
function RequestExtraBooleanData(dataType,whichPlayer,param1,param2,param3,param4,param5,param6) end
---@param dataType integer
---@param whichPlayer wc3_player
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 integer
---@param param5 integer
---@param param6 integer
---@return string
function RequestExtraStringData(dataType,whichPlayer,param1,param2,param3,param4,param5,param6) end
---@param dataType integer
---@param whichPlayer wc3_player
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 integer
---@param param5 integer
---@param param6 integer
---@return number
function RequestExtraRealData(dataType,whichPlayer,param1,param2,param3,param4,param5,param6) end
---@param whichUnit wc3_unit
---@return number
function BlzGetUnitZ(whichUnit) end
---@param enableSelection boolean
---@param enableSelectionCircle boolean
function BlzEnableSelections(enableSelection,enableSelectionCircle) end
---@return boolean
function BlzIsSelectionEnabled() end
---@return boolean
function BlzIsSelectionCircleEnabled() end
---@param whichSetup wc3_camerasetup
---@param doPan boolean
---@param forcedDuration number
---@param easeInDuration number
---@param easeOutDuration number
---@param smoothFactor number
function BlzCameraSetupApplyForceDurationSmooth(whichSetup,doPan,forcedDuration,easeInDuration,easeOutDuration,smoothFactor) end
---@param enable boolean
function BlzEnableTargetIndicator(enable) end
---@return boolean
function BlzIsTargetIndicatorEnabled() end
---@param frameType wc3_originframetype
---@param index integer
---@return wc3_framehandle
function BlzGetOriginFrame(frameType,index) end
---@param enable boolean
function BlzEnableUIAutoPosition(enable) end
---@param enable boolean
function BlzHideOriginFrames(enable) end
---@param a integer
---@param r integer
---@param g integer
---@param b integer
---@return integer
function BlzConvertColor(a,r,g,b) end
---@param TOCFile string
---@return boolean
function BlzLoadTOCFile(TOCFile) end
---@param name string
---@param owner wc3_framehandle
---@param priority integer
---@param createContext integer
---@return wc3_framehandle
function BlzCreateFrame(name,owner,priority,createContext) end
---@param name string
---@param owner wc3_framehandle
---@param createContext integer
---@return wc3_framehandle
function BlzCreateSimpleFrame(name,owner,createContext) end
---@param typeName string
---@param name string
---@param owner wc3_framehandle
---@param inherits string
---@param createContext integer
---@return wc3_framehandle
function BlzCreateFrameByType(typeName,name,owner,inherits,createContext) end
---@param frame wc3_framehandle
function BlzDestroyFrame(frame) end
---@param frame wc3_framehandle
---@param point wc3_framepointtype
---@param relative wc3_framehandle
---@param relativePoint wc3_framepointtype
---@param x number
---@param y number
function BlzFrameSetPoint(frame,point,relative,relativePoint,x,y) end
---@param frame wc3_framehandle
---@param point wc3_framepointtype
---@param x number
---@param y number
function BlzFrameSetAbsPoint(frame,point,x,y) end
---@param frame wc3_framehandle
function BlzFrameClearAllPoints(frame) end
---@param frame wc3_framehandle
---@param relative wc3_framehandle
function BlzFrameSetAllPoints(frame,relative) end
---@param frame wc3_framehandle
---@param visible boolean
function BlzFrameSetVisible(frame,visible) end
---@param frame wc3_framehandle
---@return boolean
function BlzFrameIsVisible(frame) end
---@param name string
---@param createContext integer
---@return wc3_framehandle
function BlzGetFrameByName(name,createContext) end
---@param frame wc3_framehandle
---@return string
function BlzFrameGetName(frame) end
---@param frame wc3_framehandle
function BlzFrameClick(frame) end
---@param frame wc3_framehandle
---@param text string
function BlzFrameSetText(frame,text) end
---@param frame wc3_framehandle
---@return string
function BlzFrameGetText(frame) end
---@param frame wc3_framehandle
---@param size integer
function BlzFrameSetTextSizeLimit(frame,size) end
---@param frame wc3_framehandle
---@return integer
function BlzFrameGetTextSizeLimit(frame) end
---@param frame wc3_framehandle
---@param color integer
function BlzFrameSetTextColor(frame,color) end
---@param frame wc3_framehandle
---@param flag boolean
function BlzFrameSetFocus(frame,flag) end
---@param frame wc3_framehandle
---@param modelFile string
---@param cameraIndex integer
function BlzFrameSetModel(frame,modelFile,cameraIndex) end
---@param frame wc3_framehandle
---@param enabled boolean
function BlzFrameSetEnable(frame,enabled) end
---@param frame wc3_framehandle
---@return boolean
function BlzFrameGetEnable(frame) end
---@param frame wc3_framehandle
---@param alpha integer
function BlzFrameSetAlpha(frame,alpha) end
---@param frame wc3_framehandle
---@return integer
function BlzFrameGetAlpha(frame) end
---@param frame wc3_framehandle
---@param primaryProp integer
---@param flags integer
function BlzFrameSetSpriteAnimate(frame,primaryProp,flags) end
---@param frame wc3_framehandle
---@param texFile string
---@param flag integer
---@param blend boolean
function BlzFrameSetTexture(frame,texFile,flag,blend) end
---@param frame wc3_framehandle
---@param scale number
function BlzFrameSetScale(frame,scale) end
---@param frame wc3_framehandle
---@param tooltip wc3_framehandle
function BlzFrameSetTooltip(frame,tooltip) end
---@param frame wc3_framehandle
---@param enable boolean
function BlzFrameCageMouse(frame,enable) end
---@param frame wc3_framehandle
---@param value number
function BlzFrameSetValue(frame,value) end
---@param frame wc3_framehandle
---@return number
function BlzFrameGetValue(frame) end
---@param frame wc3_framehandle
---@param minValue number
---@param maxValue number
function BlzFrameSetMinMaxValue(frame,minValue,maxValue) end
---@param frame wc3_framehandle
---@param stepSize number
function BlzFrameSetStepSize(frame,stepSize) end
---@param frame wc3_framehandle
---@param width number
---@param height number
function BlzFrameSetSize(frame,width,height) end
---@param frame wc3_framehandle
---@param color integer
function BlzFrameSetVertexColor(frame,color) end
---@param frame wc3_framehandle
---@param level integer
function BlzFrameSetLevel(frame,level) end
---@param frame wc3_framehandle
---@param parent wc3_framehandle
function BlzFrameSetParent(frame,parent) end
---@param frame wc3_framehandle
---@return wc3_framehandle
function BlzFrameGetParent(frame) end
---@param frame wc3_framehandle
---@return number
function BlzFrameGetHeight(frame) end
---@param frame wc3_framehandle
---@return number
function BlzFrameGetWidth(frame) end
---@param frame wc3_framehandle
---@param fileName string
---@param height number
---@param flags integer
function BlzFrameSetFont(frame,fileName,height,flags) end
---@param frame wc3_framehandle
---@param vert wc3_textaligntype
---@param horz wc3_textaligntype
function BlzFrameSetTextAlignment(frame,vert,horz) end
---@param whichTrigger wc3_trigger
---@param frame wc3_framehandle
---@param eventId wc3_frameeventtype
---@return wc3_event
function BlzTriggerRegisterFrameEvent(whichTrigger,frame,eventId) end
---@return wc3_framehandle
function BlzGetTriggerFrame() end
---@return wc3_frameeventtype
function BlzGetTriggerFrameEvent() end
---@param whichTrigger wc3_trigger
---@param whichPlayer wc3_player
---@param prefix string
---@param fromServer boolean
---@return wc3_event
function BlzTriggerRegisterPlayerSyncEvent(whichTrigger,whichPlayer,prefix,fromServer) end
---@param prefix string
---@param data string
---@return boolean
function BlzSendSyncData(prefix,data) end
---@return string
function BlzGetTriggerSyncPrefix() end
---@return string
function BlzGetTriggerSyncData() end
---@param whichTrigger wc3_trigger
---@param whichPlayer wc3_player
---@param key wc3_oskeytype
---@param metaKey integer
---@param keyDown boolean
---@return wc3_event
function BlzTriggerRegisterPlayerKeyEvent(whichTrigger,whichPlayer,key,metaKey,keyDown) end
---@return wc3_oskeytype
function BlzGetTriggerPlayerKey() end
---@return integer
function BlzGetTriggerPlayerMetaKey() end
---@return boolean
function BlzGetTriggerPlayerIsKeyDown() end
---@param enable boolean
function BlzEnableCursor(enable) end
---@param x integer
---@param y integer
function BlzSetMousePos(x,y) end
---@return integer
function BlzGetLocalClientWidth() end
---@return integer
function BlzGetLocalClientHeight() end
---@return boolean
function BlzIsLocalClientActive() end
---@return wc3_unit
function BlzGetMouseFocusUnit() end
---@param texFile string
---@return boolean
function BlzChangeMinimapTerrainTex(texFile) end
---@return string
function BlzGetLocale() end
---@param whichEffect wc3_effect
---@return number
function BlzGetSpecialEffectScale(whichEffect) end
---@param whichEffect wc3_effect
---@param x number
---@param y number
---@param z number
function BlzSetSpecialEffectMatrixScale(whichEffect,x,y,z) end
---@param whichEffect wc3_effect
function BlzResetSpecialEffectMatrix(whichEffect) end
---@param whichUnit wc3_unit
---@param abilId integer
---@return wc3_ability
function BlzGetUnitAbility(whichUnit,abilId) end
---@param whichUnit wc3_unit
---@param index integer
---@return wc3_ability
function BlzGetUnitAbilityByIndex(whichUnit,index) end
---@param whichPlayer wc3_player
---@param recipient integer
---@param message string
function BlzDisplayChatMessage(whichPlayer,recipient,message) end
---@param whichUnit wc3_unit
---@param flag boolean
function BlzPauseUnitEx(whichUnit,flag) end
---@param x integer
---@param y integer
---@return integer
function BlzBitOr(x,y) end
---@param x integer
---@param y integer
---@return integer
function BlzBitAnd(x,y) end
---@param x integer
---@param y integer
---@return integer
function BlzBitXor(x,y) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitybooleanfield
---@return boolean
function BlzGetAbilityBooleanField(whichAbility,whichField) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityintegerfield
---@return integer
function BlzGetAbilityIntegerField(whichAbility,whichField) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityrealfield
---@return number
function BlzGetAbilityRealField(whichAbility,whichField) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitystringfield
---@return string
function BlzGetAbilityStringField(whichAbility,whichField) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitybooleanlevelfield
---@param level integer
---@return boolean
function BlzGetAbilityBooleanLevelField(whichAbility,whichField,level) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityintegerlevelfield
---@param level integer
---@return integer
function BlzGetAbilityIntegerLevelField(whichAbility,whichField,level) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityreallevelfield
---@param level integer
---@return number
function BlzGetAbilityRealLevelField(whichAbility,whichField,level) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitystringlevelfield
---@param level integer
---@return string
function BlzGetAbilityStringLevelField(whichAbility,whichField,level) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitybooleanlevelarrayfield
---@param level integer
---@param index integer
---@return boolean
function BlzGetAbilityBooleanLevelArrayField(whichAbility,whichField,level,index) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityintegerlevelarrayfield
---@param level integer
---@param index integer
---@return integer
function BlzGetAbilityIntegerLevelArrayField(whichAbility,whichField,level,index) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityreallevelarrayfield
---@param level integer
---@param index integer
---@return number
function BlzGetAbilityRealLevelArrayField(whichAbility,whichField,level,index) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitystringlevelarrayfield
---@param level integer
---@param index integer
---@return string
function BlzGetAbilityStringLevelArrayField(whichAbility,whichField,level,index) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitybooleanfield
---@param value boolean
---@return boolean
function BlzSetAbilityBooleanField(whichAbility,whichField,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityintegerfield
---@param value integer
---@return boolean
function BlzSetAbilityIntegerField(whichAbility,whichField,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityrealfield
---@param value number
---@return boolean
function BlzSetAbilityRealField(whichAbility,whichField,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitystringfield
---@param value string
---@return boolean
function BlzSetAbilityStringField(whichAbility,whichField,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitybooleanlevelfield
---@param level integer
---@param value boolean
---@return boolean
function BlzSetAbilityBooleanLevelField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityintegerlevelfield
---@param level integer
---@param value integer
---@return boolean
function BlzSetAbilityIntegerLevelField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityreallevelfield
---@param level integer
---@param value number
---@return boolean
function BlzSetAbilityRealLevelField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitystringlevelfield
---@param level integer
---@param value string
---@return boolean
function BlzSetAbilityStringLevelField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitybooleanlevelarrayfield
---@param level integer
---@param index integer
---@param value boolean
---@return boolean
function BlzSetAbilityBooleanLevelArrayField(whichAbility,whichField,level,index,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityintegerlevelarrayfield
---@param level integer
---@param index integer
---@param value integer
---@return boolean
function BlzSetAbilityIntegerLevelArrayField(whichAbility,whichField,level,index,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityreallevelarrayfield
---@param level integer
---@param index integer
---@param value number
---@return boolean
function BlzSetAbilityRealLevelArrayField(whichAbility,whichField,level,index,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitystringlevelarrayfield
---@param level integer
---@param index integer
---@param value string
---@return boolean
function BlzSetAbilityStringLevelArrayField(whichAbility,whichField,level,index,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitybooleanlevelarrayfield
---@param level integer
---@param value boolean
---@return boolean
function BlzAddAbilityBooleanLevelArrayField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityintegerlevelarrayfield
---@param level integer
---@param value integer
---@return boolean
function BlzAddAbilityIntegerLevelArrayField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityreallevelarrayfield
---@param level integer
---@param value number
---@return boolean
function BlzAddAbilityRealLevelArrayField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitystringlevelarrayfield
---@param level integer
---@param value string
---@return boolean
function BlzAddAbilityStringLevelArrayField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitybooleanlevelarrayfield
---@param level integer
---@param value boolean
---@return boolean
function BlzRemoveAbilityBooleanLevelArrayField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityintegerlevelarrayfield
---@param level integer
---@param value integer
---@return boolean
function BlzRemoveAbilityIntegerLevelArrayField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilityreallevelarrayfield
---@param level integer
---@param value number
---@return boolean
function BlzRemoveAbilityRealLevelArrayField(whichAbility,whichField,level,value) end
---@param whichAbility wc3_ability
---@param whichField wc3_abilitystringlevelarrayfield
---@param level integer
---@param value string
---@return boolean
function BlzRemoveAbilityStringLevelArrayField(whichAbility,whichField,level,value) end
---@param whichItem wc3_item
---@param index integer
---@return wc3_ability
function BlzGetItemAbilityByIndex(whichItem,index) end
---@param whichItem wc3_item
---@param abilCode integer
---@return wc3_ability
function BlzGetItemAbility(whichItem,abilCode) end
---@param whichItem wc3_item
---@param abilCode integer
---@return boolean
function BlzItemAddAbility(whichItem,abilCode) end
---@param whichItem wc3_item
---@param whichField wc3_itembooleanfield
---@return boolean
function BlzGetItemBooleanField(whichItem,whichField) end
---@param whichItem wc3_item
---@param whichField wc3_itemintegerfield
---@return integer
function BlzGetItemIntegerField(whichItem,whichField) end
---@param whichItem wc3_item
---@param whichField wc3_itemrealfield
---@return number
function BlzGetItemRealField(whichItem,whichField) end
---@param whichItem wc3_item
---@param whichField wc3_itemstringfield
---@return string
function BlzGetItemStringField(whichItem,whichField) end
---@param whichItem wc3_item
---@param whichField wc3_itembooleanfield
---@param value boolean
---@return boolean
function BlzSetItemBooleanField(whichItem,whichField,value) end
---@param whichItem wc3_item
---@param whichField wc3_itemintegerfield
---@param value integer
---@return boolean
function BlzSetItemIntegerField(whichItem,whichField,value) end
---@param whichItem wc3_item
---@param whichField wc3_itemrealfield
---@param value number
---@return boolean
function BlzSetItemRealField(whichItem,whichField,value) end
---@param whichItem wc3_item
---@param whichField wc3_itemstringfield
---@param value string
---@return boolean
function BlzSetItemStringField(whichItem,whichField,value) end
---@param whichItem wc3_item
---@param abilCode integer
---@return boolean
function BlzItemRemoveAbility(whichItem,abilCode) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitbooleanfield
---@return boolean
function BlzGetUnitBooleanField(whichUnit,whichField) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitintegerfield
---@return integer
function BlzGetUnitIntegerField(whichUnit,whichField) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitrealfield
---@return number
function BlzGetUnitRealField(whichUnit,whichField) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitstringfield
---@return string
function BlzGetUnitStringField(whichUnit,whichField) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitbooleanfield
---@param value boolean
---@return boolean
function BlzSetUnitBooleanField(whichUnit,whichField,value) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitintegerfield
---@param value integer
---@return boolean
function BlzSetUnitIntegerField(whichUnit,whichField,value) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitrealfield
---@param value number
---@return boolean
function BlzSetUnitRealField(whichUnit,whichField,value) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitstringfield
---@param value string
---@return boolean
function BlzSetUnitStringField(whichUnit,whichField,value) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitweaponbooleanfield
---@param index integer
---@return boolean
function BlzGetUnitWeaponBooleanField(whichUnit,whichField,index) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitweaponintegerfield
---@param index integer
---@return integer
function BlzGetUnitWeaponIntegerField(whichUnit,whichField,index) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitweaponrealfield
---@param index integer
---@return number
function BlzGetUnitWeaponRealField(whichUnit,whichField,index) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitweaponstringfield
---@param index integer
---@return string
function BlzGetUnitWeaponStringField(whichUnit,whichField,index) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitweaponbooleanfield
---@param index integer
---@param value boolean
---@return boolean
function BlzSetUnitWeaponBooleanField(whichUnit,whichField,index,value) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitweaponintegerfield
---@param index integer
---@param value integer
---@return boolean
function BlzSetUnitWeaponIntegerField(whichUnit,whichField,index,value) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitweaponrealfield
---@param index integer
---@param value number
---@return boolean
function BlzSetUnitWeaponRealField(whichUnit,whichField,index,value) end
---@param whichUnit wc3_unit
---@param whichField wc3_unitweaponstringfield
---@param index integer
---@param value string
---@return boolean
function BlzSetUnitWeaponStringField(whichUnit,whichField,index,value) end
