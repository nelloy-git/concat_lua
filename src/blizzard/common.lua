-- Native types. All native functions take extended handle types when
-- possible to help prevent passing bad values to native functions
--
function ConvertAllianceType(int_i) return alliancetype end
function ConvertRacePref(int_i) return racepreference end
function ConvertIGameState(int_i) return igamestate end
function ConvertFGameState(int_i) return fgamestate end
function ConvertPlayerState(int_i) return playerstate end
function ConvertPlayerScore(int_i) return playerscore end
function ConvertPlayerGameResult(int_i) return playergameresult end
function ConvertUnitState(int_i) return unitstate end
function ConvertAIDifficulty(int_i) return aidifficulty end
function ConvertGameEvent(int_i) return gameevent end
function ConvertPlayerEvent(int_i) return playerevent end
function ConvertPlayerUnitEvent(int_i) return playerunitevent end
function ConvertWidgetEvent(int_i) return widgetevent end
function ConvertDialogEvent(int_i) return dialogevent end
function ConvertUnitEvent(int_i) return unitevent end
function ConvertLimitOp(int_i) return limitop end
function ConvertUnitType(int_i) return unittype end
function ConvertGameSpeed(int_i) return gamespeed end
function ConvertPlacement(int_i) return placement end
function ConvertStartLocPrio(int_i) return startlocprio end
function ConvertGameDifficulty(int_i) return gamedifficulty end
function ConvertGameType(int_i) return gametype end
function ConvertMapFlag(int_i) return mapflag end
function ConvertMapVisibility(int_i) return mapvisibility end
function ConvertMapSetting(int_i) return mapsetting end
function ConvertMapDensity(int_i) return mapdensity end
function ConvertMapControl(int_i) return mapcontrol end
function ConvertPlayerColor(int_i) return playercolor end
function ConvertPlayerSlotState(int_i) return playerslotstate end
function ConvertVolumeGroup(int_i) return volumegroup end
function ConvertCameraField(int_i) return camerafield end
function ConvertBlendMode(int_i) return blendmode end
function ConvertRarityControl(int_i) return raritycontrol end
function ConvertTexMapFlags(int_i) return texmapflags end
function ConvertFogState(int_i) return fogstate end
function ConvertEffectType(int_i) return effecttype end
function ConvertVersion(int_i) return version end
function ConvertItemType(int_i) return itemtype end
function ConvertAttackType(int_i) return attacktype end
function ConvertDamageType(int_i) return damagetype end
function ConvertWeaponType(int_i) return weapontype end
function ConvertSoundType(int_i) return soundtype end
function ConvertPathingType(int_i) return pathingtype end
function ConvertMouseButtonType(int_i) return mousebuttontype end
function ConvertAnimType(int_i) return animtype end
function ConvertSubAnimType(int_i) return subanimtype end
function ConvertOriginFrameType(int_i) return originframetype end
function ConvertFramePointType(int_i) return framepointtype end
function ConvertTextAlignType(int_i) return textaligntype end
function ConvertFrameEventType(int_i) return frameeventtype end
function ConvertOsKeyType(int_i) return oskeytype end
function ConvertAbilityIntegerField(int_i) return abilityintegerfield end
function ConvertAbilityRealField(int_i) return abilityrealfield end
function ConvertAbilityBooleanField(int_i) return abilitybooleanfield end
function ConvertAbilityStringField(int_i) return abilitystringfield end
function ConvertAbilityIntegerLevelField(int_i) return abilityintegerlevelfield end
function ConvertAbilityRealLevelField(int_i) return abilityreallevelfield end
function ConvertAbilityBooleanLevelField(int_i) return abilitybooleanlevelfield end
function ConvertAbilityStringLevelField(int_i) return abilitystringlevelfield end
function ConvertAbilityIntegerLevelArrayField(int_i) return abilityintegerlevelarrayfield end
function ConvertAbilityRealLevelArrayField(int_i) return abilityreallevelarrayfield end
function ConvertAbilityBooleanLevelArrayField(int_i) return abilitybooleanlevelarrayfield end
function ConvertAbilityStringLevelArrayField(int_i) return abilitystringlevelarrayfield end
function ConvertUnitIntegerField(int_i) return unitintegerfield end
function ConvertUnitRealField(int_i) return unitrealfield end
function ConvertUnitBooleanField(int_i) return unitbooleanfield end
function ConvertUnitStringField(int_i) return unitstringfield end
function ConvertUnitWeaponIntegerField(int_i) return unitweaponintegerfield end
function ConvertUnitWeaponRealField(int_i) return unitweaponrealfield end
function ConvertUnitWeaponBooleanField(int_i) return unitweaponbooleanfield end
function ConvertUnitWeaponStringField(int_i) return unitweaponstringfield end
function ConvertItemIntegerField(int_i) return itemintegerfield end
function ConvertItemRealField(int_i) return itemrealfield end
function ConvertItemBooleanField(int_i) return itembooleanfield end
function ConvertItemStringField(int_i) return itemstringfield end
function ConvertMoveType(int_i) return movetype end
function ConvertTargetFlag(int_i) return targetflag end
function ConvertArmorType(int_i) return armortype end
function ConvertHeroAttribute(int_i) return heroattribute end
function ConvertDefenseType(int_i) return defensetype end
function ConvertRegenType(int_i) return regentype end
function ConvertUnitCategory(int_i) return unitcategory end
function ConvertPathingFlag(int_i) return pathingflag end
function OrderId2String(int_orderId) return string end
function UnitId(str_unitIdString) return integer end
function UnitId2String(int_unitId) return string end
function AbilityId(str_abilityIdString) return integer end
function AbilityId2String(int_abilityId) return string end
function GetObjectName(int_objectId) return string end
function GetBJPlayerNeutralVictim() return integer end
function GetBJPlayerNeutralExtra() return integer end
function GetBJMaxPlayerSlots() return integer end
function GetPlayerNeutralPassive() return integer end
function GetPlayerNeutralAggressive() return integer end
-- Game Constants
--===================================================
FALSE = false
TRUE = true
JASS_MAX_ARRAY_SIZE = 32768
PLAYER_NEUTRAL_AGGRESSIVE = GetPlayerNeutralAggressive()
PLAYER_COLOR_BLUE = ConvertPlayerColor(1)
PLAYER_COLOR_CYAN = ConvertPlayerColor(2)
PLAYER_COLOR_PURPLE = ConvertPlayerColor(3)
PLAYER_COLOR_YELLOW = ConvertPlayerColor(4)
PLAYER_COLOR_ORANGE = ConvertPlayerColor(5)
PLAYER_COLOR_GREEN = ConvertPlayerColor(6)
PLAYER_COLOR_PINK = ConvertPlayerColor(7)
PLAYER_COLOR_LIGHT_GRAY = ConvertPlayerColor(8)
PLAYER_COLOR_LIGHT_BLUE = ConvertPlayerColor(9)
PLAYER_COLOR_AQUA = ConvertPlayerColor(10)
PLAYER_COLOR_BROWN = ConvertPlayerColor(11)
PLAYER_COLOR_MAROON = ConvertPlayerColor(12)
PLAYER_COLOR_NAVY = ConvertPlayerColor(13)
PLAYER_COLOR_TURQUOISE = ConvertPlayerColor(14)
PLAYER_COLOR_VIOLET = ConvertPlayerColor(15)
PLAYER_COLOR_WHEAT = ConvertPlayerColor(16)
PLAYER_COLOR_PEACH = ConvertPlayerColor(17)
PLAYER_COLOR_MINT = ConvertPlayerColor(18)
PLAYER_COLOR_LAVENDER = ConvertPlayerColor(19)
PLAYER_COLOR_COAL = ConvertPlayerColor(20)
PLAYER_COLOR_SNOW = ConvertPlayerColor(21)
PLAYER_COLOR_EMERALD = ConvertPlayerColor(22)
PLAYER_COLOR_PEANUT = ConvertPlayerColor(23)
RACE_ORC = ConvertRace(2)
RACE_UNDEAD = ConvertRace(3)
RACE_NIGHTELF = ConvertRace(4)
RACE_DEMON = ConvertRace(5)
RACE_OTHER = ConvertRace(7)
PLAYER_GAME_RESULT_DEFEAT = ConvertPlayerGameResult(1)
PLAYER_GAME_RESULT_TIE = ConvertPlayerGameResult(2)
PLAYER_GAME_RESULT_NEUTRAL = ConvertPlayerGameResult(3)
ALLIANCE_HELP_REQUEST = ConvertAllianceType(1)
ALLIANCE_HELP_RESPONSE = ConvertAllianceType(2)
ALLIANCE_SHARED_XP = ConvertAllianceType(3)
ALLIANCE_SHARED_SPELLS = ConvertAllianceType(4)
ALLIANCE_SHARED_VISION = ConvertAllianceType(5)
ALLIANCE_SHARED_CONTROL = ConvertAllianceType(6)
ALLIANCE_SHARED_ADVANCED_CONTROL= ConvertAllianceType(7)
ALLIANCE_RESCUABLE = ConvertAllianceType(8)
ALLIANCE_SHARED_VISION_FORCED = ConvertAllianceType(9)
VERSION_FROZEN_THRONE = ConvertVersion(1)
ATTACK_TYPE_MELEE = ConvertAttackType(1)
ATTACK_TYPE_PIERCE = ConvertAttackType(2)
ATTACK_TYPE_SIEGE = ConvertAttackType(3)
ATTACK_TYPE_MAGIC = ConvertAttackType(4)
ATTACK_TYPE_CHAOS = ConvertAttackType(5)
ATTACK_TYPE_HERO = ConvertAttackType(6)
DAMAGE_TYPE_NORMAL = ConvertDamageType(4)
DAMAGE_TYPE_ENHANCED = ConvertDamageType(5)
DAMAGE_TYPE_FIRE = ConvertDamageType(8)
DAMAGE_TYPE_COLD = ConvertDamageType(9)
DAMAGE_TYPE_LIGHTNING = ConvertDamageType(10)
DAMAGE_TYPE_POISON = ConvertDamageType(11)
DAMAGE_TYPE_DISEASE = ConvertDamageType(12)
DAMAGE_TYPE_DIVINE = ConvertDamageType(13)
DAMAGE_TYPE_MAGIC = ConvertDamageType(14)
DAMAGE_TYPE_SONIC = ConvertDamageType(15)
DAMAGE_TYPE_ACID = ConvertDamageType(16)
DAMAGE_TYPE_FORCE = ConvertDamageType(17)
DAMAGE_TYPE_DEATH = ConvertDamageType(18)
DAMAGE_TYPE_MIND = ConvertDamageType(19)
DAMAGE_TYPE_PLANT = ConvertDamageType(20)
DAMAGE_TYPE_DEFENSIVE = ConvertDamageType(21)
DAMAGE_TYPE_DEMOLITION = ConvertDamageType(22)
DAMAGE_TYPE_SLOW_POISON = ConvertDamageType(23)
DAMAGE_TYPE_SPIRIT_LINK = ConvertDamageType(24)
DAMAGE_TYPE_SHADOW_STRIKE = ConvertDamageType(25)
DAMAGE_TYPE_UNIVERSAL = ConvertDamageType(26)
WEAPON_TYPE_METAL_LIGHT_CHOP = ConvertWeaponType(1)
WEAPON_TYPE_METAL_MEDIUM_CHOP = ConvertWeaponType(2)
WEAPON_TYPE_METAL_HEAVY_CHOP = ConvertWeaponType(3)
WEAPON_TYPE_METAL_LIGHT_SLICE = ConvertWeaponType(4)
WEAPON_TYPE_METAL_MEDIUM_SLICE = ConvertWeaponType(5)
WEAPON_TYPE_METAL_HEAVY_SLICE = ConvertWeaponType(6)
WEAPON_TYPE_METAL_MEDIUM_BASH = ConvertWeaponType(7)
WEAPON_TYPE_METAL_HEAVY_BASH = ConvertWeaponType(8)
WEAPON_TYPE_METAL_MEDIUM_STAB = ConvertWeaponType(9)
WEAPON_TYPE_METAL_HEAVY_STAB = ConvertWeaponType(10)
WEAPON_TYPE_WOOD_LIGHT_SLICE = ConvertWeaponType(11)
WEAPON_TYPE_WOOD_MEDIUM_SLICE = ConvertWeaponType(12)
WEAPON_TYPE_WOOD_HEAVY_SLICE = ConvertWeaponType(13)
WEAPON_TYPE_WOOD_LIGHT_BASH = ConvertWeaponType(14)
WEAPON_TYPE_WOOD_MEDIUM_BASH = ConvertWeaponType(15)
WEAPON_TYPE_WOOD_HEAVY_BASH = ConvertWeaponType(16)
WEAPON_TYPE_WOOD_LIGHT_STAB = ConvertWeaponType(17)
WEAPON_TYPE_WOOD_MEDIUM_STAB = ConvertWeaponType(18)
WEAPON_TYPE_CLAW_LIGHT_SLICE = ConvertWeaponType(19)
WEAPON_TYPE_CLAW_MEDIUM_SLICE = ConvertWeaponType(20)
WEAPON_TYPE_CLAW_HEAVY_SLICE = ConvertWeaponType(21)
WEAPON_TYPE_AXE_MEDIUM_CHOP = ConvertWeaponType(22)
WEAPON_TYPE_ROCK_HEAVY_BASH = ConvertWeaponType(23)
PATHING_TYPE_WALKABILITY = ConvertPathingType(1)
PATHING_TYPE_FLYABILITY = ConvertPathingType(2)
PATHING_TYPE_BUILDABILITY = ConvertPathingType(3)
PATHING_TYPE_PEONHARVESTPATHING = ConvertPathingType(4)
PATHING_TYPE_BLIGHTPATHING = ConvertPathingType(5)
PATHING_TYPE_FLOATABILITY = ConvertPathingType(6)
PATHING_TYPE_AMPHIBIOUSPATHING = ConvertPathingType(7)
MOUSE_BUTTON_TYPE_MIDDLE = ConvertMouseButtonType(2)
MOUSE_BUTTON_TYPE_RIGHT = ConvertMouseButtonType(3)
ANIM_TYPE_DEATH = ConvertAnimType(1)
ANIM_TYPE_DECAY = ConvertAnimType(2)
ANIM_TYPE_DISSIPATE = ConvertAnimType(3)
ANIM_TYPE_STAND = ConvertAnimType(4)
ANIM_TYPE_WALK = ConvertAnimType(5)
ANIM_TYPE_ATTACK = ConvertAnimType(6)
ANIM_TYPE_MORPH = ConvertAnimType(7)
ANIM_TYPE_SLEEP = ConvertAnimType(8)
ANIM_TYPE_SPELL = ConvertAnimType(9)
ANIM_TYPE_PORTRAIT = ConvertAnimType(10)
SUBANIM_TYPE_ALTERNATE_EX = ConvertSubAnimType(12)
SUBANIM_TYPE_LOOPING = ConvertSubAnimType(13)
SUBANIM_TYPE_SLAM = ConvertSubAnimType(14)
SUBANIM_TYPE_THROW = ConvertSubAnimType(15)
SUBANIM_TYPE_SPIKED = ConvertSubAnimType(16)
SUBANIM_TYPE_FAST = ConvertSubAnimType(17)
SUBANIM_TYPE_SPIN = ConvertSubAnimType(18)
SUBANIM_TYPE_READY = ConvertSubAnimType(19)
SUBANIM_TYPE_CHANNEL = ConvertSubAnimType(20)
SUBANIM_TYPE_DEFEND = ConvertSubAnimType(21)
SUBANIM_TYPE_VICTORY = ConvertSubAnimType(22)
SUBANIM_TYPE_TURN = ConvertSubAnimType(23)
SUBANIM_TYPE_LEFT = ConvertSubAnimType(24)
SUBANIM_TYPE_RIGHT = ConvertSubAnimType(25)
SUBANIM_TYPE_FIRE = ConvertSubAnimType(26)
SUBANIM_TYPE_FLESH = ConvertSubAnimType(27)
SUBANIM_TYPE_HIT = ConvertSubAnimType(28)
SUBANIM_TYPE_WOUNDED = ConvertSubAnimType(29)
SUBANIM_TYPE_LIGHT = ConvertSubAnimType(30)
SUBANIM_TYPE_MODERATE = ConvertSubAnimType(31)
SUBANIM_TYPE_SEVERE = ConvertSubAnimType(32)
SUBANIM_TYPE_CRITICAL = ConvertSubAnimType(33)
SUBANIM_TYPE_COMPLETE = ConvertSubAnimType(34)
SUBANIM_TYPE_GOLD = ConvertSubAnimType(35)
SUBANIM_TYPE_LUMBER = ConvertSubAnimType(36)
SUBANIM_TYPE_WORK = ConvertSubAnimType(37)
SUBANIM_TYPE_TALK = ConvertSubAnimType(38)
SUBANIM_TYPE_FIRST = ConvertSubAnimType(39)
SUBANIM_TYPE_SECOND = ConvertSubAnimType(40)
SUBANIM_TYPE_THIRD = ConvertSubAnimType(41)
SUBANIM_TYPE_FOURTH = ConvertSubAnimType(42)
SUBANIM_TYPE_FIFTH = ConvertSubAnimType(43)
SUBANIM_TYPE_ONE = ConvertSubAnimType(44)
SUBANIM_TYPE_TWO = ConvertSubAnimType(45)
SUBANIM_TYPE_THREE = ConvertSubAnimType(46)
SUBANIM_TYPE_FOUR = ConvertSubAnimType(47)
SUBANIM_TYPE_FIVE = ConvertSubAnimType(48)
SUBANIM_TYPE_SMALL = ConvertSubAnimType(49)
SUBANIM_TYPE_MEDIUM = ConvertSubAnimType(50)
SUBANIM_TYPE_LARGE = ConvertSubAnimType(51)
SUBANIM_TYPE_UPGRADE = ConvertSubAnimType(52)
SUBANIM_TYPE_DRAIN = ConvertSubAnimType(53)
SUBANIM_TYPE_FILL = ConvertSubAnimType(54)
SUBANIM_TYPE_CHAINLIGHTNING = ConvertSubAnimType(55)
SUBANIM_TYPE_EATTREE = ConvertSubAnimType(56)
SUBANIM_TYPE_PUKE = ConvertSubAnimType(57)
SUBANIM_TYPE_FLAIL = ConvertSubAnimType(58)
SUBANIM_TYPE_OFF = ConvertSubAnimType(59)
SUBANIM_TYPE_SWIM = ConvertSubAnimType(60)
SUBANIM_TYPE_ENTANGLE = ConvertSubAnimType(61)
SUBANIM_TYPE_BERSERK = ConvertSubAnimType(62)
-- Map Setup Constants
--===================================================
RACE_PREF_ORC = ConvertRacePref(2)
RACE_PREF_NIGHTELF = ConvertRacePref(4)
RACE_PREF_UNDEAD = ConvertRacePref(8)
RACE_PREF_DEMON = ConvertRacePref(16)
RACE_PREF_RANDOM = ConvertRacePref(32)
RACE_PREF_USER_SELECTABLE = ConvertRacePref(64)
MAP_CONTROL_COMPUTER = ConvertMapControl(1)
MAP_CONTROL_RESCUABLE = ConvertMapControl(2)
MAP_CONTROL_NEUTRAL = ConvertMapControl(3)
MAP_CONTROL_CREEP = ConvertMapControl(4)
MAP_CONTROL_NONE = ConvertMapControl(5)
GAME_TYPE_FFA = ConvertGameType(2)
GAME_TYPE_USE_MAP_SETTINGS = ConvertGameType(4)
GAME_TYPE_BLIZ = ConvertGameType(8)
GAME_TYPE_ONE_ON_ONE = ConvertGameType(16)
GAME_TYPE_TWO_TEAM_PLAY = ConvertGameType(32)
GAME_TYPE_THREE_TEAM_PLAY = ConvertGameType(64)
GAME_TYPE_FOUR_TEAM_PLAY = ConvertGameType(128)
MAP_FOG_MAP_EXPLORED = ConvertMapFlag(2)
MAP_FOG_ALWAYS_VISIBLE = ConvertMapFlag(4)
MAP_OBSERVERS = ConvertMapFlag(16)
MAP_OBSERVERS_ON_DEATH = ConvertMapFlag(32)
MAP_RESOURCE_TRADING_ALLIES_ONLY = ConvertMapFlag(512)
MAP_ALLIANCE_CHANGES_HIDDEN = ConvertMapFlag(2048)
MAP_CHEATS_HIDDEN = ConvertMapFlag(8192)
MAP_LOCK_RANDOM_SEED = ConvertMapFlag(8192*4)
MAP_SHARED_ADVANCED_CONTROL = ConvertMapFlag(8192*8)
MAP_RANDOM_HERO = ConvertMapFlag(8192*16)
MAP_RANDOM_RACES = ConvertMapFlag(8192*32)
MAP_RELOADED = ConvertMapFlag(8192*64)
MAP_PLACEMENT_FIXED = ConvertPlacement(1) -- player 0 in start loc 0...
MAP_PLACEMENT_USE_MAP_SETTINGS = ConvertPlacement(2) -- whatever was specified by the script
MAP_PLACEMENT_TEAMS_TOGETHER = ConvertPlacement(3) -- random with allies next to each other
MAP_LOC_PRIO_HIGH = ConvertStartLocPrio(1)
MAP_LOC_PRIO_NOT = ConvertStartLocPrio(2)
MAP_DENSITY_LIGHT = ConvertMapDensity(1)
MAP_DENSITY_MEDIUM = ConvertMapDensity(2)
MAP_DENSITY_HEAVY = ConvertMapDensity(3)
MAP_DIFFICULTY_NORMAL = ConvertGameDifficulty(1)
MAP_DIFFICULTY_HARD = ConvertGameDifficulty(2)
MAP_DIFFICULTY_INSANE = ConvertGameDifficulty(3)
MAP_SPEED_SLOW = ConvertGameSpeed(1)
MAP_SPEED_NORMAL = ConvertGameSpeed(2)
MAP_SPEED_FAST = ConvertGameSpeed(3)
MAP_SPEED_FASTEST = ConvertGameSpeed(4)
PLAYER_SLOT_STATE_PLAYING = ConvertPlayerSlotState(1)
PLAYER_SLOT_STATE_LEFT = ConvertPlayerSlotState(2)
-- Sound Constants
--===================================================
SOUND_VOLUMEGROUP_UNITMOVEMENT = ConvertVolumeGroup(0)
SOUND_VOLUMEGROUP_UNITSOUNDS = ConvertVolumeGroup(1)
SOUND_VOLUMEGROUP_COMBAT = ConvertVolumeGroup(2)
SOUND_VOLUMEGROUP_SPELLS = ConvertVolumeGroup(3)
SOUND_VOLUMEGROUP_UI = ConvertVolumeGroup(4)
SOUND_VOLUMEGROUP_MUSIC = ConvertVolumeGroup(5)
SOUND_VOLUMEGROUP_AMBIENTSOUNDS = ConvertVolumeGroup(6)
SOUND_VOLUMEGROUP_FIRE = ConvertVolumeGroup(7)
-- Game, Player, and Unit States
--
-- For use with TriggerRegister<X>StateEvent
--
--===================================================
GAME_STATE_DISCONNECTED = ConvertIGameState(1)
GAME_STATE_TIME_OF_DAY = ConvertFGameState(2)
--
PLAYER_STATE_RESOURCE_GOLD = ConvertPlayerState(1)
PLAYER_STATE_RESOURCE_LUMBER = ConvertPlayerState(2)
PLAYER_STATE_RESOURCE_HERO_TOKENS = ConvertPlayerState(3)
PLAYER_STATE_RESOURCE_FOOD_CAP = ConvertPlayerState(4)
PLAYER_STATE_RESOURCE_FOOD_USED = ConvertPlayerState(5)
PLAYER_STATE_FOOD_CAP_CEILING = ConvertPlayerState(6)
PLAYER_STATE_ALLIED_VICTORY = ConvertPlayerState(8)
PLAYER_STATE_PLACED = ConvertPlayerState(9)
PLAYER_STATE_OBSERVER_ON_DEATH = ConvertPlayerState(10)
PLAYER_STATE_OBSERVER = ConvertPlayerState(11)
PLAYER_STATE_UNFOLLOWABLE = ConvertPlayerState(12)
--
PLAYER_STATE_GOLD_UPKEEP_RATE = ConvertPlayerState(13)
PLAYER_STATE_LUMBER_UPKEEP_RATE = ConvertPlayerState(14)
--
PLAYER_STATE_GOLD_GATHERED = ConvertPlayerState(15)
PLAYER_STATE_LUMBER_GATHERED = ConvertPlayerState(16)
UNIT_STATE_MAX_LIFE = ConvertUnitState(1)
UNIT_STATE_MANA = ConvertUnitState(2)
UNIT_STATE_MAX_MANA = ConvertUnitState(3)
AI_DIFFICULTY_NORMAL = ConvertAIDifficulty(1)
AI_DIFFICULTY_INSANE = ConvertAIDifficulty(2)
PLAYER_SCORE_UNITS_TRAINED = ConvertPlayerScore(0)
PLAYER_SCORE_UNITS_KILLED = ConvertPlayerScore(1)
PLAYER_SCORE_STRUCT_BUILT = ConvertPlayerScore(2)
PLAYER_SCORE_STRUCT_RAZED = ConvertPlayerScore(3)
PLAYER_SCORE_TECH_PERCENT = ConvertPlayerScore(4)
PLAYER_SCORE_FOOD_MAXPROD = ConvertPlayerScore(5)
PLAYER_SCORE_FOOD_MAXUSED = ConvertPlayerScore(6)
PLAYER_SCORE_HEROES_KILLED = ConvertPlayerScore(7)
PLAYER_SCORE_ITEMS_GAINED = ConvertPlayerScore(8)
PLAYER_SCORE_MERCS_HIRED = ConvertPlayerScore(9)
PLAYER_SCORE_GOLD_MINED_TOTAL = ConvertPlayerScore(10)
PLAYER_SCORE_GOLD_MINED_UPKEEP = ConvertPlayerScore(11)
PLAYER_SCORE_GOLD_LOST_UPKEEP = ConvertPlayerScore(12)
PLAYER_SCORE_GOLD_LOST_TAX = ConvertPlayerScore(13)
PLAYER_SCORE_GOLD_GIVEN = ConvertPlayerScore(14)
PLAYER_SCORE_GOLD_RECEIVED = ConvertPlayerScore(15)
PLAYER_SCORE_LUMBER_TOTAL = ConvertPlayerScore(16)
PLAYER_SCORE_LUMBER_LOST_UPKEEP = ConvertPlayerScore(17)
PLAYER_SCORE_LUMBER_LOST_TAX = ConvertPlayerScore(18)
PLAYER_SCORE_LUMBER_GIVEN = ConvertPlayerScore(19)
PLAYER_SCORE_LUMBER_RECEIVED = ConvertPlayerScore(20)
PLAYER_SCORE_UNIT_TOTAL = ConvertPlayerScore(21)
PLAYER_SCORE_HERO_TOTAL = ConvertPlayerScore(22)
PLAYER_SCORE_RESOURCE_TOTAL = ConvertPlayerScore(23)
PLAYER_SCORE_TOTAL = ConvertPlayerScore(24)
-- Game, Player and Unit Events
--
-- When an event causes a trigger to fire these
-- values allow the action code to determine which
-- event was dispatched and therefore which set of
-- native functions should be used to get information
-- about the event.
--
-- Do NOT change the order or value of these constants
-- without insuring that the JASS_GAME_EVENTS_WAR3 enum
-- is changed to match.
--
--===================================================
-- For use with TriggerRegisterGameEvent
--===================================================
EVENT_GAME_END_LEVEL = ConvertGameEvent(1)
EVENT_GAME_STATE_LIMIT = ConvertGameEvent(3)
EVENT_GAME_LEAVE_REGION = ConvertGameEvent(6)
EVENT_GAME_TRACKABLE_TRACK = ConvertGameEvent(8)
EVENT_GAME_BUILD_SUBMENU = ConvertGameEvent(10)
-- For use with TriggerRegisterPlayerEvent
--===================================================
EVENT_PLAYER_STATE_LIMIT = ConvertPlayerEvent(11)
EVENT_PLAYER_ALLIANCE_CHANGED = ConvertPlayerEvent(12)
EVENT_PLAYER_VICTORY = ConvertPlayerEvent(14)
EVENT_PLAYER_LEAVE = ConvertPlayerEvent(15)
EVENT_PLAYER_CHAT = ConvertPlayerEvent(16)
EVENT_PLAYER_END_CINEMATIC = ConvertPlayerEvent(17)
-- For use with TriggerRegisterPlayerUnitEvent
--===================================================
EVENT_PLAYER_UNIT_RESCUED = ConvertPlayerUnitEvent(19)
EVENT_PLAYER_UNIT_DECAY = ConvertPlayerUnitEvent(21)
EVENT_PLAYER_UNIT_HIDDEN = ConvertPlayerUnitEvent(23)
EVENT_PLAYER_UNIT_DESELECTED = ConvertPlayerUnitEvent(25)
EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL = ConvertPlayerUnitEvent(27)
EVENT_PLAYER_UNIT_CONSTRUCT_FINISH = ConvertPlayerUnitEvent(28)
EVENT_PLAYER_UNIT_UPGRADE_CANCEL = ConvertPlayerUnitEvent(30)
EVENT_PLAYER_UNIT_UPGRADE_FINISH = ConvertPlayerUnitEvent(31)
EVENT_PLAYER_UNIT_TRAIN_CANCEL = ConvertPlayerUnitEvent(33)
EVENT_PLAYER_UNIT_TRAIN_FINISH = ConvertPlayerUnitEvent(34)
EVENT_PLAYER_UNIT_RESEARCH_CANCEL = ConvertPlayerUnitEvent(36)
EVENT_PLAYER_UNIT_RESEARCH_FINISH = ConvertPlayerUnitEvent(37)
EVENT_PLAYER_UNIT_ISSUED_ORDER = ConvertPlayerUnitEvent(38)
EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER = ConvertPlayerUnitEvent(39)
EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER = ConvertPlayerUnitEvent(40)
EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER = ConvertPlayerUnitEvent(40) -- for compat
EVENT_PLAYER_HERO_SKILL = ConvertPlayerUnitEvent(42)
EVENT_PLAYER_HERO_REVIVE_CANCEL = ConvertPlayerUnitEvent(45)
EVENT_PLAYER_HERO_REVIVE_FINISH = ConvertPlayerUnitEvent(46)
EVENT_PLAYER_UNIT_SUMMON = ConvertPlayerUnitEvent(47)
EVENT_PLAYER_UNIT_DROP_ITEM = ConvertPlayerUnitEvent(48)
EVENT_PLAYER_UNIT_PICKUP_ITEM = ConvertPlayerUnitEvent(49)
EVENT_PLAYER_UNIT_USE_ITEM = ConvertPlayerUnitEvent(50)
EVENT_PLAYER_UNIT_DAMAGED = ConvertPlayerUnitEvent(308)
EVENT_PLAYER_UNIT_DAMAGING = ConvertPlayerUnitEvent(315)
-- For use with TriggerRegisterUnitEvent
--===================================================
EVENT_UNIT_DAMAGING = ConvertUnitEvent(314)
EVENT_UNIT_DEATH = ConvertUnitEvent(53)
EVENT_UNIT_DECAY = ConvertUnitEvent(54)
EVENT_UNIT_DETECTED = ConvertUnitEvent(55)
EVENT_UNIT_HIDDEN = ConvertUnitEvent(56)
EVENT_UNIT_SELECTED = ConvertUnitEvent(57)
EVENT_UNIT_DESELECTED = ConvertUnitEvent(58)
--
EVENT_UNIT_ACQUIRED_TARGET = ConvertUnitEvent(60)
EVENT_UNIT_TARGET_IN_RANGE = ConvertUnitEvent(61)
EVENT_UNIT_ATTACKED = ConvertUnitEvent(62)
EVENT_UNIT_RESCUED = ConvertUnitEvent(63)
EVENT_UNIT_CONSTRUCT_FINISH = ConvertUnitEvent(65)
EVENT_UNIT_UPGRADE_CANCEL = ConvertUnitEvent(67)
EVENT_UNIT_UPGRADE_FINISH = ConvertUnitEvent(68)
-- training of other units
--
EVENT_UNIT_TRAIN_START = ConvertUnitEvent(69)
EVENT_UNIT_TRAIN_CANCEL = ConvertUnitEvent(70)
EVENT_UNIT_TRAIN_FINISH = ConvertUnitEvent(71)
EVENT_UNIT_RESEARCH_CANCEL = ConvertUnitEvent(73)
EVENT_UNIT_RESEARCH_FINISH = ConvertUnitEvent(74)
EVENT_UNIT_ISSUED_POINT_ORDER = ConvertUnitEvent(76)
EVENT_UNIT_ISSUED_TARGET_ORDER = ConvertUnitEvent(77)
EVENT_UNIT_HERO_SKILL = ConvertUnitEvent(79)
EVENT_UNIT_HERO_REVIVE_START = ConvertUnitEvent(81)
EVENT_UNIT_HERO_REVIVE_CANCEL = ConvertUnitEvent(82)
EVENT_UNIT_HERO_REVIVE_FINISH = ConvertUnitEvent(83)
EVENT_UNIT_PICKUP_ITEM = ConvertUnitEvent(86)
EVENT_UNIT_USE_ITEM = ConvertUnitEvent(87)
EVENT_DIALOG_CLICK = ConvertDialogEvent(91)
-- Frozen Throne Expansion Events
-- Need to be added here to preserve compat
--===================================================
EVENT_GAME_TOURNAMENT_FINISH_SOON = ConvertGameEvent(257)
EVENT_GAME_TOURNAMENT_FINISH_NOW = ConvertGameEvent(258)
EVENT_GAME_SAVE = ConvertGameEvent(259)
EVENT_GAME_CUSTOM_UI_FRAME = ConvertGameEvent(310)
-- For use with TriggerRegisterPlayerEvent
--===================================================
EVENT_PLAYER_ARROW_LEFT_UP = ConvertPlayerEvent(262)
EVENT_PLAYER_ARROW_RIGHT_DOWN = ConvertPlayerEvent(263)
EVENT_PLAYER_ARROW_RIGHT_UP = ConvertPlayerEvent(264)
EVENT_PLAYER_ARROW_DOWN_DOWN = ConvertPlayerEvent(265)
EVENT_PLAYER_ARROW_DOWN_UP = ConvertPlayerEvent(266)
EVENT_PLAYER_ARROW_UP_DOWN = ConvertPlayerEvent(267)
EVENT_PLAYER_ARROW_UP_UP = ConvertPlayerEvent(268)
EVENT_PLAYER_MOUSE_DOWN = ConvertPlayerEvent(305)
EVENT_PLAYER_MOUSE_UP = ConvertPlayerEvent(306)
EVENT_PLAYER_MOUSE_MOVE = ConvertPlayerEvent(307)
EVENT_PLAYER_SYNC_DATA = ConvertPlayerEvent(309)
EVENT_PLAYER_KEY = ConvertPlayerEvent(311)
EVENT_PLAYER_KEY_DOWN = ConvertPlayerEvent(312)
EVENT_PLAYER_KEY_UP = ConvertPlayerEvent(313)
-- For use with TriggerRegisterPlayerUnitEvent
--===================================================
EVENT_PLAYER_UNIT_CHANGE_OWNER = ConvertPlayerUnitEvent(270)
EVENT_PLAYER_UNIT_SELL_ITEM = ConvertPlayerUnitEvent(271)
EVENT_PLAYER_UNIT_SPELL_CHANNEL = ConvertPlayerUnitEvent(272)
EVENT_PLAYER_UNIT_SPELL_CAST = ConvertPlayerUnitEvent(273)
EVENT_PLAYER_UNIT_SPELL_EFFECT = ConvertPlayerUnitEvent(274)
EVENT_PLAYER_UNIT_SPELL_FINISH = ConvertPlayerUnitEvent(275)
EVENT_PLAYER_UNIT_SPELL_ENDCAST = ConvertPlayerUnitEvent(276)
EVENT_PLAYER_UNIT_PAWN_ITEM = ConvertPlayerUnitEvent(277)
-- For use with TriggerRegisterUnitEvent
--===================================================
EVENT_UNIT_CHANGE_OWNER = ConvertUnitEvent(287)
EVENT_UNIT_SELL_ITEM = ConvertUnitEvent(288)
EVENT_UNIT_SPELL_CHANNEL = ConvertUnitEvent(289)
EVENT_UNIT_SPELL_CAST = ConvertUnitEvent(290)
EVENT_UNIT_SPELL_EFFECT = ConvertUnitEvent(291)
EVENT_UNIT_SPELL_FINISH = ConvertUnitEvent(292)
EVENT_UNIT_SPELL_ENDCAST = ConvertUnitEvent(293)
EVENT_UNIT_PAWN_ITEM = ConvertUnitEvent(294)
-- Limit Event API constants
-- variable, player state, game state, and unit state events
-- ( do NOT change the order of these... )
--===================================================
LESS_THAN = ConvertLimitOp(0)
LESS_THAN_OR_EQUAL = ConvertLimitOp(1)
EQUAL = ConvertLimitOp(2)
GREATER_THAN_OR_EQUAL = ConvertLimitOp(3)
GREATER_THAN = ConvertLimitOp(4)
NOT_EQUAL = ConvertLimitOp(5)
-- Unit Type Constants for use with IsUnitType()
--===================================================
UNIT_TYPE_DEAD = ConvertUnitType(1)
UNIT_TYPE_STRUCTURE = ConvertUnitType(2)
UNIT_TYPE_GROUND = ConvertUnitType(4)
UNIT_TYPE_ATTACKS_GROUND = ConvertUnitType(6)
UNIT_TYPE_RANGED_ATTACKER = ConvertUnitType(8)
UNIT_TYPE_SUMMONED = ConvertUnitType(10)
UNIT_TYPE_STUNNED = ConvertUnitType(11)
UNIT_TYPE_PLAGUED = ConvertUnitType(12)
UNIT_TYPE_SNARED = ConvertUnitType(13)
UNIT_TYPE_MECHANICAL = ConvertUnitType(15)
UNIT_TYPE_PEON = ConvertUnitType(16)
UNIT_TYPE_SAPPER = ConvertUnitType(17)
UNIT_TYPE_TOWNHALL = ConvertUnitType(18)
UNIT_TYPE_ANCIENT = ConvertUnitType(19)
UNIT_TYPE_POISONED = ConvertUnitType(21)
UNIT_TYPE_POLYMORPHED = ConvertUnitType(22)
UNIT_TYPE_SLEEPING = ConvertUnitType(23)
UNIT_TYPE_RESISTANT = ConvertUnitType(24)
UNIT_TYPE_ETHEREAL = ConvertUnitType(25)
UNIT_TYPE_MAGIC_IMMUNE = ConvertUnitType(26)
-- Unit Type Constants for use with ChooseRandomItemEx()
--===================================================
ITEM_TYPE_CHARGED = ConvertItemType(1)
ITEM_TYPE_POWERUP = ConvertItemType(2)
ITEM_TYPE_ARTIFACT = ConvertItemType(3)
ITEM_TYPE_PURCHASABLE = ConvertItemType(4)
ITEM_TYPE_CAMPAIGN = ConvertItemType(5)
ITEM_TYPE_MISCELLANEOUS = ConvertItemType(6)
ITEM_TYPE_UNKNOWN = ConvertItemType(7)
ITEM_TYPE_ANY = ConvertItemType(8)
ITEM_TYPE_TOME = ConvertItemType(2)
-- Animatable Camera Fields
--===================================================
CAMERA_FIELD_FARZ = ConvertCameraField(1)
CAMERA_FIELD_ANGLE_OF_ATTACK = ConvertCameraField(2)
CAMERA_FIELD_FIELD_OF_VIEW = ConvertCameraField(3)
CAMERA_FIELD_ROLL = ConvertCameraField(4)
CAMERA_FIELD_ROTATION = ConvertCameraField(5)
CAMERA_FIELD_ZOFFSET = ConvertCameraField(6)
CAMERA_FIELD_NEARZ = ConvertCameraField(7)
CAMERA_FIELD_LOCAL_PITCH = ConvertCameraField(8)
CAMERA_FIELD_LOCAL_YAW = ConvertCameraField(9)
CAMERA_FIELD_LOCAL_ROLL = ConvertCameraField(10)
BLEND_MODE_DONT_CARE = ConvertBlendMode(0)
BLEND_MODE_KEYALPHA = ConvertBlendMode(1)
BLEND_MODE_BLEND = ConvertBlendMode(2)
BLEND_MODE_ADDITIVE = ConvertBlendMode(3)
BLEND_MODE_MODULATE = ConvertBlendMode(4)
BLEND_MODE_MODULATE_2X = ConvertBlendMode(5)
RARITY_RARE = ConvertRarityControl(1)
TEXMAP_FLAG_WRAP_U = ConvertTexMapFlags(1)
TEXMAP_FLAG_WRAP_V = ConvertTexMapFlags(2)
TEXMAP_FLAG_WRAP_UV = ConvertTexMapFlags(3)
FOG_OF_WAR_FOGGED = ConvertFogState(2)
FOG_OF_WAR_VISIBLE = ConvertFogState(4)
-- Camera Margin constants for use with GetCameraMargin
--===================================================
CAMERA_MARGIN_RIGHT = 1
CAMERA_MARGIN_TOP = 2
CAMERA_MARGIN_BOTTOM = 3
-- Effect API constants
--===================================================
EFFECT_TYPE_TARGET = ConvertEffectType(1)
EFFECT_TYPE_CASTER = ConvertEffectType(2)
EFFECT_TYPE_SPECIAL = ConvertEffectType(3)
EFFECT_TYPE_AREA_EFFECT = ConvertEffectType(4)
EFFECT_TYPE_MISSILE = ConvertEffectType(5)
EFFECT_TYPE_LIGHTNING = ConvertEffectType(6)
SOUND_TYPE_EFFECT_LOOPED = ConvertSoundType(1)
-- Custom UI API constants
--===================================================
ORIGIN_FRAME_COMMAND_BUTTON = ConvertOriginFrameType(1)
ORIGIN_FRAME_HERO_BAR = ConvertOriginFrameType(2)
ORIGIN_FRAME_HERO_BUTTON = ConvertOriginFrameType(3)
ORIGIN_FRAME_HERO_HP_BAR = ConvertOriginFrameType(4)
ORIGIN_FRAME_HERO_MANA_BAR = ConvertOriginFrameType(5)
ORIGIN_FRAME_HERO_BUTTON_INDICATOR = ConvertOriginFrameType(6)
ORIGIN_FRAME_ITEM_BUTTON = ConvertOriginFrameType(7)
ORIGIN_FRAME_MINIMAP = ConvertOriginFrameType(8)
ORIGIN_FRAME_MINIMAP_BUTTON = ConvertOriginFrameType(9)
ORIGIN_FRAME_SYSTEM_BUTTON = ConvertOriginFrameType(10)
ORIGIN_FRAME_TOOLTIP = ConvertOriginFrameType(11)
ORIGIN_FRAME_UBERTOOLTIP = ConvertOriginFrameType(12)
ORIGIN_FRAME_CHAT_MSG = ConvertOriginFrameType(13)
ORIGIN_FRAME_UNIT_MSG = ConvertOriginFrameType(14)
ORIGIN_FRAME_TOP_MSG = ConvertOriginFrameType(15)
ORIGIN_FRAME_PORTRAIT = ConvertOriginFrameType(16)
ORIGIN_FRAME_WORLD_FRAME = ConvertOriginFrameType(17)
FRAMEPOINT_TOP = ConvertFramePointType(1)
FRAMEPOINT_TOPRIGHT = ConvertFramePointType(2)
FRAMEPOINT_LEFT = ConvertFramePointType(3)
FRAMEPOINT_CENTER = ConvertFramePointType(4)
FRAMEPOINT_RIGHT = ConvertFramePointType(5)
FRAMEPOINT_BOTTOMLEFT = ConvertFramePointType(6)
FRAMEPOINT_BOTTOM = ConvertFramePointType(7)
FRAMEPOINT_BOTTOMRIGHT = ConvertFramePointType(8)
TEXT_JUSTIFY_MIDDLE = ConvertTextAlignType(1)
TEXT_JUSTIFY_BOTTOM = ConvertTextAlignType(2)
TEXT_JUSTIFY_LEFT = ConvertTextAlignType(3)
TEXT_JUSTIFY_CENTER = ConvertTextAlignType(4)
TEXT_JUSTIFY_RIGHT = ConvertTextAlignType(5)
FRAMEEVENT_MOUSE_ENTER = ConvertFrameEventType(2)
FRAMEEVENT_MOUSE_LEAVE = ConvertFrameEventType(3)
FRAMEEVENT_MOUSE_UP = ConvertFrameEventType(4)
FRAMEEVENT_MOUSE_DOWN = ConvertFrameEventType(5)
FRAMEEVENT_MOUSE_WHEEL = ConvertFrameEventType(6)
FRAMEEVENT_CHECKBOX_CHECKED = ConvertFrameEventType(7)
FRAMEEVENT_CHECKBOX_UNCHECKED = ConvertFrameEventType(8)
FRAMEEVENT_EDITBOX_TEXT_CHANGED = ConvertFrameEventType(9)
FRAMEEVENT_POPUPMENU_ITEM_CHANGED = ConvertFrameEventType(10)
FRAMEEVENT_MOUSE_DOUBLECLICK = ConvertFrameEventType(11)
FRAMEEVENT_SPRITE_ANIM_UPDATE = ConvertFrameEventType(12)
FRAMEEVENT_SLIDER_VALUE_CHANGED = ConvertFrameEventType(13)
FRAMEEVENT_DIALOG_CANCEL = ConvertFrameEventType(14)
FRAMEEVENT_DIALOG_ACCEPT = ConvertFrameEventType(15)
FRAMEEVENT_EDITBOX_ENTER = ConvertFrameEventType(16)
-- OS Key constants
--===================================================
OSKEY_TAB = ConvertOsKeyType(0x09)
OSKEY_CLEAR = ConvertOsKeyType(0x0C)
OSKEY_RETURN = ConvertOsKeyType(0x0D)
OSKEY_SHIFT = ConvertOsKeyType(0x10)
OSKEY_CONTROL = ConvertOsKeyType(0x11)
OSKEY_ALT = ConvertOsKeyType(0x12)
OSKEY_PAUSE = ConvertOsKeyType(0x13)
OSKEY_CAPSLOCK = ConvertOsKeyType(0x14)
OSKEY_KANA = ConvertOsKeyType(0x15)
OSKEY_HANGUL = ConvertOsKeyType(0x15)
OSKEY_JUNJA = ConvertOsKeyType(0x17)
OSKEY_FINAL = ConvertOsKeyType(0x18)
OSKEY_HANJA = ConvertOsKeyType(0x19)
OSKEY_KANJI = ConvertOsKeyType(0x19)
OSKEY_ESCAPE = ConvertOsKeyType(0x1B)
OSKEY_CONVERT = ConvertOsKeyType(0x1C)
OSKEY_NONCONVERT = ConvertOsKeyType(0x1D)
OSKEY_ACCEPT = ConvertOsKeyType(0x1E)
OSKEY_MODECHANGE = ConvertOsKeyType(0x1F)
OSKEY_SPACE = ConvertOsKeyType(0x20)
OSKEY_PAGEUP = ConvertOsKeyType(0x21)
OSKEY_PAGEDOWN = ConvertOsKeyType(0x22)
OSKEY_END = ConvertOsKeyType(0x23)
OSKEY_HOME = ConvertOsKeyType(0x24)
OSKEY_LEFT = ConvertOsKeyType(0x25)
OSKEY_UP = ConvertOsKeyType(0x26)
OSKEY_RIGHT = ConvertOsKeyType(0x27)
OSKEY_DOWN = ConvertOsKeyType(0x28)
OSKEY_SELECT = ConvertOsKeyType(0x29)
OSKEY_PRINT = ConvertOsKeyType(0x2A)
OSKEY_EXECUTE = ConvertOsKeyType(0x2B)
OSKEY_PRINTSCREEN = ConvertOsKeyType(0x2C)
OSKEY_INSERT = ConvertOsKeyType(0x2D)
OSKEY_DELETE = ConvertOsKeyType(0x2E)
OSKEY_HELP = ConvertOsKeyType(0x2F)
OSKEY_0 = ConvertOsKeyType(0x30)
OSKEY_1 = ConvertOsKeyType(0x31)
OSKEY_2 = ConvertOsKeyType(0x32)
OSKEY_3 = ConvertOsKeyType(0x33)
OSKEY_4 = ConvertOsKeyType(0x34)
OSKEY_5 = ConvertOsKeyType(0x35)
OSKEY_6 = ConvertOsKeyType(0x36)
OSKEY_7 = ConvertOsKeyType(0x37)
OSKEY_8 = ConvertOsKeyType(0x38)
OSKEY_9 = ConvertOsKeyType(0x39)
OSKEY_A = ConvertOsKeyType(0x41)
OSKEY_B = ConvertOsKeyType(0x42)
OSKEY_C = ConvertOsKeyType(0x43)
OSKEY_D = ConvertOsKeyType(0x44)
OSKEY_E = ConvertOsKeyType(0x45)
OSKEY_F = ConvertOsKeyType(0x46)
OSKEY_G = ConvertOsKeyType(0x47)
OSKEY_H = ConvertOsKeyType(0x48)
OSKEY_I = ConvertOsKeyType(0x49)
OSKEY_J = ConvertOsKeyType(0x4A)
OSKEY_K = ConvertOsKeyType(0x4B)
OSKEY_L = ConvertOsKeyType(0x4C)
OSKEY_M = ConvertOsKeyType(0x4D)
OSKEY_N = ConvertOsKeyType(0x4E)
OSKEY_O = ConvertOsKeyType(0x4F)
OSKEY_P = ConvertOsKeyType(0x50)
OSKEY_Q = ConvertOsKeyType(0x51)
OSKEY_R = ConvertOsKeyType(0x52)
OSKEY_S = ConvertOsKeyType(0x53)
OSKEY_T = ConvertOsKeyType(0x54)
OSKEY_U = ConvertOsKeyType(0x55)
OSKEY_V = ConvertOsKeyType(0x56)
OSKEY_W = ConvertOsKeyType(0x57)
OSKEY_X = ConvertOsKeyType(0x58)
OSKEY_Y = ConvertOsKeyType(0x59)
OSKEY_Z = ConvertOsKeyType(0x5A)
OSKEY_LMETA = ConvertOsKeyType(0x5B)
OSKEY_RMETA = ConvertOsKeyType(0x5C)
OSKEY_APPS = ConvertOsKeyType(0x5D)
OSKEY_SLEEP = ConvertOsKeyType(0x5F)
OSKEY_NUMPAD0 = ConvertOsKeyType(0x60)
OSKEY_NUMPAD1 = ConvertOsKeyType(0x61)
OSKEY_NUMPAD2 = ConvertOsKeyType(0x62)
OSKEY_NUMPAD3 = ConvertOsKeyType(0x63)
OSKEY_NUMPAD4 = ConvertOsKeyType(0x64)
OSKEY_NUMPAD5 = ConvertOsKeyType(0x65)
OSKEY_NUMPAD6 = ConvertOsKeyType(0x66)
OSKEY_NUMPAD7 = ConvertOsKeyType(0x67)
OSKEY_NUMPAD8 = ConvertOsKeyType(0x68)
OSKEY_NUMPAD9 = ConvertOsKeyType(0x69)
OSKEY_MULTIPLY = ConvertOsKeyType(0x6A)
OSKEY_ADD = ConvertOsKeyType(0x6B)
OSKEY_SEPARATOR = ConvertOsKeyType(0x6C)
OSKEY_SUBTRACT = ConvertOsKeyType(0x6D)
OSKEY_DECIMAL = ConvertOsKeyType(0x6E)
OSKEY_DIVIDE = ConvertOsKeyType(0x6F)
OSKEY_F1 = ConvertOsKeyType(0x70)
OSKEY_F2 = ConvertOsKeyType(0x71)
OSKEY_F3 = ConvertOsKeyType(0x72)
OSKEY_F4 = ConvertOsKeyType(0x73)
OSKEY_F5 = ConvertOsKeyType(0x74)
OSKEY_F6 = ConvertOsKeyType(0x75)
OSKEY_F7 = ConvertOsKeyType(0x76)
OSKEY_F8 = ConvertOsKeyType(0x77)
OSKEY_F9 = ConvertOsKeyType(0x78)
OSKEY_F10 = ConvertOsKeyType(0x79)
OSKEY_F11 = ConvertOsKeyType(0x7A)
OSKEY_F12 = ConvertOsKeyType(0x7B)
OSKEY_F13 = ConvertOsKeyType(0x7C)
OSKEY_F14 = ConvertOsKeyType(0x7D)
OSKEY_F15 = ConvertOsKeyType(0x7E)
OSKEY_F16 = ConvertOsKeyType(0x7F)
OSKEY_F17 = ConvertOsKeyType(0x80)
OSKEY_F18 = ConvertOsKeyType(0x81)
OSKEY_F19 = ConvertOsKeyType(0x82)
OSKEY_F20 = ConvertOsKeyType(0x83)
OSKEY_F21 = ConvertOsKeyType(0x84)
OSKEY_F22 = ConvertOsKeyType(0x85)
OSKEY_F23 = ConvertOsKeyType(0x86)
OSKEY_F24 = ConvertOsKeyType(0x87)
OSKEY_NUMLOCK = ConvertOsKeyType(0x90)
OSKEY_SCROLLLOCK = ConvertOsKeyType(0x91)
OSKEY_OEM_NEC_EQUAL = ConvertOsKeyType(0x92)
OSKEY_OEM_FJ_JISHO = ConvertOsKeyType(0x92)
OSKEY_OEM_FJ_MASSHOU = ConvertOsKeyType(0x93)
OSKEY_OEM_FJ_TOUROKU = ConvertOsKeyType(0x94)
OSKEY_OEM_FJ_LOYA = ConvertOsKeyType(0x95)
OSKEY_OEM_FJ_ROYA = ConvertOsKeyType(0x96)
OSKEY_LSHIFT = ConvertOsKeyType(0xA0)
OSKEY_RSHIFT = ConvertOsKeyType(0xA1)
OSKEY_LCONTROL = ConvertOsKeyType(0xA2)
OSKEY_RCONTROL = ConvertOsKeyType(0xA3)
OSKEY_LALT = ConvertOsKeyType(0xA4)
OSKEY_RALT = ConvertOsKeyType(0xA5)
OSKEY_BROWSER_BACK = ConvertOsKeyType(0xA6)
OSKEY_BROWSER_FORWARD = ConvertOsKeyType(0xA7)
OSKEY_BROWSER_REFRESH = ConvertOsKeyType(0xA8)
OSKEY_BROWSER_STOP = ConvertOsKeyType(0xA9)
OSKEY_BROWSER_SEARCH = ConvertOsKeyType(0xAA)
OSKEY_BROWSER_FAVORITES = ConvertOsKeyType(0xAB)
OSKEY_BROWSER_HOME = ConvertOsKeyType(0xAC)
OSKEY_VOLUME_MUTE = ConvertOsKeyType(0xAD)
OSKEY_VOLUME_DOWN = ConvertOsKeyType(0xAE)
OSKEY_VOLUME_UP = ConvertOsKeyType(0xAF)
OSKEY_MEDIA_NEXT_TRACK = ConvertOsKeyType(0xB0)
OSKEY_MEDIA_PREV_TRACK = ConvertOsKeyType(0xB1)
OSKEY_MEDIA_STOP = ConvertOsKeyType(0xB2)
OSKEY_MEDIA_PLAY_PAUSE = ConvertOsKeyType(0xB3)
OSKEY_LAUNCH_MAIL = ConvertOsKeyType(0xB4)
OSKEY_LAUNCH_MEDIA_SELECT = ConvertOsKeyType(0xB5)
OSKEY_LAUNCH_APP1 = ConvertOsKeyType(0xB6)
OSKEY_LAUNCH_APP2 = ConvertOsKeyType(0xB7)
OSKEY_OEM_1 = ConvertOsKeyType(0xBA)
OSKEY_OEM_PLUS = ConvertOsKeyType(0xBB)
OSKEY_OEM_COMMA = ConvertOsKeyType(0xBC)
OSKEY_OEM_MINUS = ConvertOsKeyType(0xBD)
OSKEY_OEM_PERIOD = ConvertOsKeyType(0xBE)
OSKEY_OEM_2 = ConvertOsKeyType(0xBF)
OSKEY_OEM_3 = ConvertOsKeyType(0xC0)
OSKEY_OEM_4 = ConvertOsKeyType(0xDB)
OSKEY_OEM_5 = ConvertOsKeyType(0xDC)
OSKEY_OEM_6 = ConvertOsKeyType(0xDD)
OSKEY_OEM_7 = ConvertOsKeyType(0xDE)
OSKEY_OEM_8 = ConvertOsKeyType(0xDF)
OSKEY_OEM_AX = ConvertOsKeyType(0xE1)
OSKEY_OEM_102 = ConvertOsKeyType(0xE2)
OSKEY_ICO_HELP = ConvertOsKeyType(0xE3)
OSKEY_ICO_00 = ConvertOsKeyType(0xE4)
OSKEY_PROCESSKEY = ConvertOsKeyType(0xE5)
OSKEY_ICO_CLEAR = ConvertOsKeyType(0xE6)
OSKEY_PACKET = ConvertOsKeyType(0xE7)
OSKEY_OEM_RESET = ConvertOsKeyType(0xE9)
OSKEY_OEM_JUMP = ConvertOsKeyType(0xEA)
OSKEY_OEM_PA1 = ConvertOsKeyType(0xEB)
OSKEY_OEM_PA2 = ConvertOsKeyType(0xEC)
OSKEY_OEM_PA3 = ConvertOsKeyType(0xED)
OSKEY_OEM_WSCTRL = ConvertOsKeyType(0xEE)
OSKEY_OEM_CUSEL = ConvertOsKeyType(0xEF)
OSKEY_OEM_ATTN = ConvertOsKeyType(0xF0)
OSKEY_OEM_FINISH = ConvertOsKeyType(0xF1)
OSKEY_OEM_COPY = ConvertOsKeyType(0xF2)
OSKEY_OEM_AUTO = ConvertOsKeyType(0xF3)
OSKEY_OEM_ENLW = ConvertOsKeyType(0xF4)
OSKEY_OEM_BACKTAB = ConvertOsKeyType(0xF5)
OSKEY_ATTN = ConvertOsKeyType(0xF6)
OSKEY_CRSEL = ConvertOsKeyType(0xF7)
OSKEY_EXSEL = ConvertOsKeyType(0xF8)
OSKEY_EREOF = ConvertOsKeyType(0xF9)
OSKEY_PLAY = ConvertOsKeyType(0xFA)
OSKEY_ZOOM = ConvertOsKeyType(0xFB)
OSKEY_NONAME = ConvertOsKeyType(0xFC)
OSKEY_PA1 = ConvertOsKeyType(0xFD)
OSKEY_OEM_CLEAR = ConvertOsKeyType(0xFE)
-- Instanced Object Operation API constants
--===================================================
ABILITY_IF_BUTTON_POSITION_NORMAL_X = ConvertAbilityIntegerField('abpx')
ABILITY_IF_BUTTON_POSITION_NORMAL_Y = ConvertAbilityIntegerField('abpy')
ABILITY_IF_BUTTON_POSITION_ACTIVATED_X = ConvertAbilityIntegerField('aubx')
ABILITY_IF_BUTTON_POSITION_ACTIVATED_Y = ConvertAbilityIntegerField('auby')
ABILITY_IF_BUTTON_POSITION_RESEARCH_X = ConvertAbilityIntegerField('arpx')
ABILITY_IF_BUTTON_POSITION_RESEARCH_Y = ConvertAbilityIntegerField('arpy')
ABILITY_IF_MISSILE_SPEED = ConvertAbilityIntegerField('amsp')
ABILITY_IF_TARGET_ATTACHMENTS = ConvertAbilityIntegerField('atac')
ABILITY_IF_CASTER_ATTACHMENTS = ConvertAbilityIntegerField('acac')
ABILITY_IF_PRIORITY = ConvertAbilityIntegerField('apri')
ABILITY_IF_LEVELS = ConvertAbilityIntegerField('alev')
ABILITY_IF_REQUIRED_LEVEL = ConvertAbilityIntegerField('arlv')
ABILITY_IF_LEVEL_SKIP_REQUIREMENT = ConvertAbilityIntegerField('alsk')
ABILITY_BF_ITEM_ABILITY = ConvertAbilityBooleanField('aite')
ABILITY_BF_CHECK_DEPENDENCIES = ConvertAbilityBooleanField('achd')
ABILITY_SF_ICON_ACTIVATED = ConvertAbilityStringField('auar')
ABILITY_SF_ICON_RESEARCH = ConvertAbilityStringField('arar')
ABILITY_SF_EFFECT_SOUND = ConvertAbilityStringField('aefs')
ABILITY_SF_EFFECT_SOUND_LOOPING = ConvertAbilityStringField('aefl')
ABILITY_ILF_NUMBER_OF_WAVES = ConvertAbilityIntegerLevelField('Hbz1')
ABILITY_ILF_NUMBER_OF_SHARDS = ConvertAbilityIntegerLevelField('Hbz3')
ABILITY_ILF_NUMBER_OF_UNITS_TELEPORTED = ConvertAbilityIntegerLevelField('Hmt1')
ABILITY_ILF_SUMMONED_UNIT_COUNT_HWE2 = ConvertAbilityIntegerLevelField('Hwe2')
ABILITY_ILF_NUMBER_OF_IMAGES = ConvertAbilityIntegerLevelField('Omi1')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1 = ConvertAbilityIntegerLevelField('Uan1')
ABILITY_ILF_MORPHING_FLAGS = ConvertAbilityIntegerLevelField('Eme2')
ABILITY_ILF_STRENGTH_BONUS_NRG5 = ConvertAbilityIntegerLevelField('Nrg5')
ABILITY_ILF_DEFENSE_BONUS_NRG6 = ConvertAbilityIntegerLevelField('Nrg6')
ABILITY_ILF_NUMBER_OF_TARGETS_HIT = ConvertAbilityIntegerLevelField('Ocl2')
ABILITY_ILF_DETECTION_TYPE_OFS1 = ConvertAbilityIntegerLevelField('Ofs1')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_OSF2 = ConvertAbilityIntegerLevelField('Osf2')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_EFN1 = ConvertAbilityIntegerLevelField('Efn1')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_HRE1 = ConvertAbilityIntegerLevelField('Hre1')
ABILITY_ILF_STACK_FLAGS = ConvertAbilityIntegerLevelField('Hca4')
ABILITY_ILF_MINIMUM_NUMBER_OF_UNITS = ConvertAbilityIntegerLevelField('Ndp2')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_NDP3 = ConvertAbilityIntegerLevelField('Ndp3')
ABILITY_ILF_NUMBER_OF_UNITS_CREATED_NRC2 = ConvertAbilityIntegerLevelField('Nrc2')
ABILITY_ILF_SHIELD_LIFE = ConvertAbilityIntegerLevelField('Ams3')
ABILITY_ILF_MANA_LOSS_AMS4 = ConvertAbilityIntegerLevelField('Ams4')
ABILITY_ILF_GOLD_PER_INTERVAL_BGM1 = ConvertAbilityIntegerLevelField('Bgm1')
ABILITY_ILF_MAX_NUMBER_OF_MINERS = ConvertAbilityIntegerLevelField('Bgm3')
ABILITY_ILF_CARGO_CAPACITY = ConvertAbilityIntegerLevelField('Car1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3 = ConvertAbilityIntegerLevelField('Dev3')
ABILITY_ILF_MAX_CREEP_LEVEL_DEV1 = ConvertAbilityIntegerLevelField('Dev1')
ABILITY_ILF_GOLD_PER_INTERVAL_EGM1 = ConvertAbilityIntegerLevelField('Egm1')
ABILITY_ILF_DEFENSE_REDUCTION = ConvertAbilityIntegerLevelField('Fae1')
ABILITY_ILF_DETECTION_TYPE_FLA1 = ConvertAbilityIntegerLevelField('Fla1')
ABILITY_ILF_FLARE_COUNT = ConvertAbilityIntegerLevelField('Fla3')
ABILITY_ILF_MAX_GOLD = ConvertAbilityIntegerLevelField('Gld1')
ABILITY_ILF_MINING_CAPACITY = ConvertAbilityIntegerLevelField('Gld3')
ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_GYD1 = ConvertAbilityIntegerLevelField('Gyd1')
ABILITY_ILF_DAMAGE_TO_TREE = ConvertAbilityIntegerLevelField('Har1')
ABILITY_ILF_LUMBER_CAPACITY = ConvertAbilityIntegerLevelField('Har2')
ABILITY_ILF_GOLD_CAPACITY = ConvertAbilityIntegerLevelField('Har3')
ABILITY_ILF_DEFENSE_INCREASE_INF2 = ConvertAbilityIntegerLevelField('Inf2')
ABILITY_ILF_INTERACTION_TYPE = ConvertAbilityIntegerLevelField('Neu2')
ABILITY_ILF_GOLD_COST_NDT1 = ConvertAbilityIntegerLevelField('Ndt1')
ABILITY_ILF_LUMBER_COST_NDT2 = ConvertAbilityIntegerLevelField('Ndt2')
ABILITY_ILF_DETECTION_TYPE_NDT3 = ConvertAbilityIntegerLevelField('Ndt3')
ABILITY_ILF_STACKING_TYPE_POI4 = ConvertAbilityIntegerLevelField('Poi4')
ABILITY_ILF_STACKING_TYPE_POA5 = ConvertAbilityIntegerLevelField('Poa5')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_PLY1 = ConvertAbilityIntegerLevelField('Ply1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_POS1 = ConvertAbilityIntegerLevelField('Pos1')
ABILITY_ILF_MOVEMENT_UPDATE_FREQUENCY_PRG1 = ConvertAbilityIntegerLevelField('Prg1')
ABILITY_ILF_ATTACK_UPDATE_FREQUENCY_PRG2 = ConvertAbilityIntegerLevelField('Prg2')
ABILITY_ILF_MANA_LOSS_PRG6 = ConvertAbilityIntegerLevelField('Prg6')
ABILITY_ILF_UNITS_SUMMONED_TYPE_ONE = ConvertAbilityIntegerLevelField('Rai1')
ABILITY_ILF_UNITS_SUMMONED_TYPE_TWO = ConvertAbilityIntegerLevelField('Rai2')
ABILITY_ILF_MAX_UNITS_SUMMONED = ConvertAbilityIntegerLevelField('Ucb5')
ABILITY_ILF_ALLOW_WHEN_FULL_REJ3 = ConvertAbilityIntegerLevelField('Rej3')
ABILITY_ILF_MAXIMUM_UNITS_CHARGED_TO_CASTER = ConvertAbilityIntegerLevelField('Rpb5')
ABILITY_ILF_MAXIMUM_UNITS_AFFECTED = ConvertAbilityIntegerLevelField('Rpb6')
ABILITY_ILF_DEFENSE_INCREASE_ROA2 = ConvertAbilityIntegerLevelField('Roa2')
ABILITY_ILF_MAX_UNITS_ROA7 = ConvertAbilityIntegerLevelField('Roa7')
ABILITY_ILF_ROOTED_WEAPONS = ConvertAbilityIntegerLevelField('Roo1')
ABILITY_ILF_UPROOTED_WEAPONS = ConvertAbilityIntegerLevelField('Roo2')
ABILITY_ILF_UPROOTED_DEFENSE_TYPE = ConvertAbilityIntegerLevelField('Roo4')
ABILITY_ILF_ACCUMULATION_STEP = ConvertAbilityIntegerLevelField('Sal2')
ABILITY_ILF_NUMBER_OF_OWLS = ConvertAbilityIntegerLevelField('Esn4')
ABILITY_ILF_STACKING_TYPE_SPO4 = ConvertAbilityIntegerLevelField('Spo4')
ABILITY_ILF_NUMBER_OF_UNITS = ConvertAbilityIntegerLevelField('Sod1')
ABILITY_ILF_SPIDER_CAPACITY = ConvertAbilityIntegerLevelField('Spa1')
ABILITY_ILF_INTERVALS_BEFORE_CHANGING_TREES = ConvertAbilityIntegerLevelField('Wha2')
ABILITY_ILF_AGILITY_BONUS = ConvertAbilityIntegerLevelField('Iagi')
ABILITY_ILF_INTELLIGENCE_BONUS = ConvertAbilityIntegerLevelField('Iint')
ABILITY_ILF_STRENGTH_BONUS_ISTR = ConvertAbilityIntegerLevelField('Istr')
ABILITY_ILF_ATTACK_BONUS = ConvertAbilityIntegerLevelField('Iatt')
ABILITY_ILF_DEFENSE_BONUS_IDEF = ConvertAbilityIntegerLevelField('Idef')
ABILITY_ILF_SUMMON_1_AMOUNT = ConvertAbilityIntegerLevelField('Isn1')
ABILITY_ILF_SUMMON_2_AMOUNT = ConvertAbilityIntegerLevelField('Isn2')
ABILITY_ILF_EXPERIENCE_GAINED = ConvertAbilityIntegerLevelField('Ixpg')
ABILITY_ILF_HIT_POINTS_GAINED_IHPG = ConvertAbilityIntegerLevelField('Ihpg')
ABILITY_ILF_MANA_POINTS_GAINED_IMPG = ConvertAbilityIntegerLevelField('Impg')
ABILITY_ILF_HIT_POINTS_GAINED_IHP2 = ConvertAbilityIntegerLevelField('Ihp2')
ABILITY_ILF_MANA_POINTS_GAINED_IMP2 = ConvertAbilityIntegerLevelField('Imp2')
ABILITY_ILF_DAMAGE_BONUS_DICE = ConvertAbilityIntegerLevelField('Idic')
ABILITY_ILF_ARMOR_PENALTY_IARP = ConvertAbilityIntegerLevelField('Iarp')
ABILITY_ILF_ENABLED_ATTACK_INDEX_IOB5 = ConvertAbilityIntegerLevelField('Iob5')
ABILITY_ILF_LEVELS_GAINED = ConvertAbilityIntegerLevelField('Ilev')
ABILITY_ILF_MAX_LIFE_GAINED = ConvertAbilityIntegerLevelField('Ilif')
ABILITY_ILF_MAX_MANA_GAINED = ConvertAbilityIntegerLevelField('Iman')
ABILITY_ILF_GOLD_GIVEN = ConvertAbilityIntegerLevelField('Igol')
ABILITY_ILF_LUMBER_GIVEN = ConvertAbilityIntegerLevelField('Ilum')
ABILITY_ILF_DETECTION_TYPE_IFA1 = ConvertAbilityIntegerLevelField('Ifa1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_ICRE = ConvertAbilityIntegerLevelField('Icre')
ABILITY_ILF_MOVEMENT_SPEED_BONUS = ConvertAbilityIntegerLevelField('Imvb')
ABILITY_ILF_HIT_POINTS_REGENERATED_PER_SECOND = ConvertAbilityIntegerLevelField('Ihpr')
ABILITY_ILF_SIGHT_RANGE_BONUS = ConvertAbilityIntegerLevelField('Isib')
ABILITY_ILF_DAMAGE_PER_DURATION = ConvertAbilityIntegerLevelField('Icfd')
ABILITY_ILF_MANA_USED_PER_SECOND = ConvertAbilityIntegerLevelField('Icfm')
ABILITY_ILF_EXTRA_MANA_REQUIRED = ConvertAbilityIntegerLevelField('Icfx')
ABILITY_ILF_DETECTION_RADIUS_IDET = ConvertAbilityIntegerLevelField('Idet')
ABILITY_ILF_MANA_LOSS_PER_UNIT_IDIM = ConvertAbilityIntegerLevelField('Idim')
ABILITY_ILF_DAMAGE_TO_SUMMONED_UNITS_IDID = ConvertAbilityIntegerLevelField('Idid')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_IREC = ConvertAbilityIntegerLevelField('Irec')
ABILITY_ILF_DELAY_AFTER_DEATH_SECONDS = ConvertAbilityIntegerLevelField('Ircd')
ABILITY_ILF_RESTORED_LIFE = ConvertAbilityIntegerLevelField('irc2')
ABILITY_ILF_RESTORED_MANA__1_FOR_CURRENT = ConvertAbilityIntegerLevelField('irc3')
ABILITY_ILF_HIT_POINTS_RESTORED = ConvertAbilityIntegerLevelField('Ihps')
ABILITY_ILF_MANA_POINTS_RESTORED = ConvertAbilityIntegerLevelField('Imps')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_ITPM = ConvertAbilityIntegerLevelField('Itpm')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_CAD1 = ConvertAbilityIntegerLevelField('Cad1')
ABILITY_ILF_TERRAIN_DEFORMATION_DURATION_MS = ConvertAbilityIntegerLevelField('Wrs3')
ABILITY_ILF_MAXIMUM_UNITS = ConvertAbilityIntegerLevelField('Uds1')
ABILITY_ILF_DETECTION_TYPE_DET1 = ConvertAbilityIntegerLevelField('Det1')
ABILITY_ILF_GOLD_COST_PER_STRUCTURE = ConvertAbilityIntegerLevelField('Nsp1')
ABILITY_ILF_LUMBER_COST_PER_USE = ConvertAbilityIntegerLevelField('Nsp2')
ABILITY_ILF_DETECTION_TYPE_NSP3 = ConvertAbilityIntegerLevelField('Nsp3')
ABILITY_ILF_NUMBER_OF_SWARM_UNITS = ConvertAbilityIntegerLevelField('Uls1')
ABILITY_ILF_MAX_SWARM_UNITS_PER_TARGET = ConvertAbilityIntegerLevelField('Uls3')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NBA2 = ConvertAbilityIntegerLevelField('Nba2')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1 = ConvertAbilityIntegerLevelField('Nch1')
ABILITY_ILF_ATTACKS_PREVENTED = ConvertAbilityIntegerLevelField('Nsi1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_EFK3 = ConvertAbilityIntegerLevelField('Efk3')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_ESV1 = ConvertAbilityIntegerLevelField('Esv1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_EXH1 = ConvertAbilityIntegerLevelField('exh1')
ABILITY_ILF_ITEM_CAPACITY = ConvertAbilityIntegerLevelField('inv1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_SPL2 = ConvertAbilityIntegerLevelField('spl2')
ABILITY_ILF_ALLOW_WHEN_FULL_IRL3 = ConvertAbilityIntegerLevelField('irl3')
ABILITY_ILF_MAXIMUM_DISPELLED_UNITS = ConvertAbilityIntegerLevelField('idc3')
ABILITY_ILF_NUMBER_OF_LURES = ConvertAbilityIntegerLevelField('imo1')
ABILITY_ILF_NEW_TIME_OF_DAY_HOUR = ConvertAbilityIntegerLevelField('ict1')
ABILITY_ILF_NEW_TIME_OF_DAY_MINUTE = ConvertAbilityIntegerLevelField('ict2')
ABILITY_ILF_NUMBER_OF_UNITS_CREATED_MEC1 = ConvertAbilityIntegerLevelField('mec1')
ABILITY_ILF_MINIMUM_SPELLS = ConvertAbilityIntegerLevelField('spb3')
ABILITY_ILF_MAXIMUM_SPELLS = ConvertAbilityIntegerLevelField('spb4')
ABILITY_ILF_DISABLED_ATTACK_INDEX = ConvertAbilityIntegerLevelField('gra3')
ABILITY_ILF_ENABLED_ATTACK_INDEX_GRA4 = ConvertAbilityIntegerLevelField('gra4')
ABILITY_ILF_MAXIMUM_ATTACKS = ConvertAbilityIntegerLevelField('gra5')
ABILITY_ILF_BUILDING_TYPES_ALLOWED_NPR1 = ConvertAbilityIntegerLevelField('Npr1')
ABILITY_ILF_BUILDING_TYPES_ALLOWED_NSA1 = ConvertAbilityIntegerLevelField('Nsa1')
ABILITY_ILF_ATTACK_MODIFICATION = ConvertAbilityIntegerLevelField('Iaa1')
ABILITY_ILF_SUMMONED_UNIT_COUNT_NPA5 = ConvertAbilityIntegerLevelField('Npa5')
ABILITY_ILF_UPGRADE_LEVELS = ConvertAbilityIntegerLevelField('Igl1')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NDO2 = ConvertAbilityIntegerLevelField('Ndo2')
ABILITY_ILF_BEASTS_PER_SECOND = ConvertAbilityIntegerLevelField('Nst1')
ABILITY_ILF_TARGET_TYPE = ConvertAbilityIntegerLevelField('Ncl2')
ABILITY_ILF_OPTIONS = ConvertAbilityIntegerLevelField('Ncl3')
ABILITY_ILF_ARMOR_PENALTY_NAB3 = ConvertAbilityIntegerLevelField('Nab3')
ABILITY_ILF_WAVE_COUNT_NHS6 = ConvertAbilityIntegerLevelField('Nhs6')
ABILITY_ILF_MAX_CREEP_LEVEL_NTM3 = ConvertAbilityIntegerLevelField('Ntm3')
ABILITY_ILF_MISSILE_COUNT = ConvertAbilityIntegerLevelField('Ncs3')
ABILITY_ILF_SPLIT_ATTACK_COUNT = ConvertAbilityIntegerLevelField('Nlm3')
ABILITY_ILF_GENERATION_COUNT = ConvertAbilityIntegerLevelField('Nlm6')
ABILITY_ILF_ROCK_RING_COUNT = ConvertAbilityIntegerLevelField('Nvc1')
ABILITY_ILF_WAVE_COUNT_NVC2 = ConvertAbilityIntegerLevelField('Nvc2')
ABILITY_ILF_PREFER_HOSTILES_TAU1 = ConvertAbilityIntegerLevelField('Tau1')
ABILITY_ILF_PREFER_FRIENDLIES_TAU2 = ConvertAbilityIntegerLevelField('Tau2')
ABILITY_ILF_MAX_UNITS_TAU3 = ConvertAbilityIntegerLevelField('Tau3')
ABILITY_ILF_NUMBER_OF_PULSES = ConvertAbilityIntegerLevelField('Tau4')
ABILITY_ILF_SUMMONED_UNIT_TYPE_HWE1 = ConvertAbilityIntegerLevelField('Hwe1')
ABILITY_ILF_SUMMONED_UNIT_UIN4 = ConvertAbilityIntegerLevelField('Uin4')
ABILITY_ILF_SUMMONED_UNIT_OSF1 = ConvertAbilityIntegerLevelField('Osf1')
ABILITY_ILF_SUMMONED_UNIT_TYPE_EFNU = ConvertAbilityIntegerLevelField('Efnu')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NBAU = ConvertAbilityIntegerLevelField('Nbau')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NTOU = ConvertAbilityIntegerLevelField('Ntou')
ABILITY_ILF_SUMMONED_UNIT_TYPE_ESVU = ConvertAbilityIntegerLevelField('Esvu')
ABILITY_ILF_SUMMONED_UNIT_TYPES = ConvertAbilityIntegerLevelField('Nef1')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NDOU = ConvertAbilityIntegerLevelField('Ndou')
ABILITY_ILF_ALTERNATE_FORM_UNIT_EMEU = ConvertAbilityIntegerLevelField('Emeu')
ABILITY_ILF_PLAGUE_WARD_UNIT_TYPE = ConvertAbilityIntegerLevelField('Aplu')
ABILITY_ILF_ALLOWED_UNIT_TYPE_BTL1 = ConvertAbilityIntegerLevelField('Btl1')
ABILITY_ILF_NEW_UNIT_TYPE = ConvertAbilityIntegerLevelField('Cha1')
ABILITY_ILF_RESULTING_UNIT_TYPE_ENT1 = ConvertAbilityIntegerLevelField('ent1')
ABILITY_ILF_CORPSE_UNIT_TYPE = ConvertAbilityIntegerLevelField('Gydu')
ABILITY_ILF_ALLOWED_UNIT_TYPE_LOA1 = ConvertAbilityIntegerLevelField('Loa1')
ABILITY_ILF_UNIT_TYPE_FOR_LIMIT_CHECK = ConvertAbilityIntegerLevelField('Raiu')
ABILITY_ILF_WARD_UNIT_TYPE_STAU = ConvertAbilityIntegerLevelField('Stau')
ABILITY_ILF_EFFECT_ABILITY = ConvertAbilityIntegerLevelField('Iobu')
ABILITY_ILF_CONVERSION_UNIT = ConvertAbilityIntegerLevelField('Ndc2')
ABILITY_ILF_UNIT_TO_PRESERVE = ConvertAbilityIntegerLevelField('Nsl1')
ABILITY_ILF_UNIT_TYPE_ALLOWED = ConvertAbilityIntegerLevelField('Chl1')
ABILITY_ILF_SWARM_UNIT_TYPE = ConvertAbilityIntegerLevelField('Ulsu')
ABILITY_ILF_RESULTING_UNIT_TYPE_COAU = ConvertAbilityIntegerLevelField('coau')
ABILITY_ILF_UNIT_TYPE_EXHU = ConvertAbilityIntegerLevelField('exhu')
ABILITY_ILF_WARD_UNIT_TYPE_HWDU = ConvertAbilityIntegerLevelField('hwdu')
ABILITY_ILF_LURE_UNIT_TYPE = ConvertAbilityIntegerLevelField('imou')
ABILITY_ILF_UNIT_TYPE_IPMU = ConvertAbilityIntegerLevelField('ipmu')
ABILITY_ILF_FACTORY_UNIT_ID = ConvertAbilityIntegerLevelField('Nsyu')
ABILITY_ILF_SPAWN_UNIT_ID_NFYU = ConvertAbilityIntegerLevelField('Nfyu')
ABILITY_ILF_DESTRUCTIBLE_ID = ConvertAbilityIntegerLevelField('Nvcu')
ABILITY_ILF_UPGRADE_TYPE = ConvertAbilityIntegerLevelField('Iglu')
ABILITY_RLF_DURATION_NORMAL = ConvertAbilityRealLevelField('adur')
ABILITY_RLF_DURATION_HERO = ConvertAbilityRealLevelField('ahdu')
ABILITY_RLF_COOLDOWN = ConvertAbilityRealLevelField('acdn')
ABILITY_RLF_AREA_OF_EFFECT = ConvertAbilityRealLevelField('aare')
ABILITY_RLF_CAST_RANGE = ConvertAbilityRealLevelField('aran')
ABILITY_RLF_DAMAGE_HBZ2 = ConvertAbilityRealLevelField('Hbz2')
ABILITY_RLF_BUILDING_REDUCTION_HBZ4 = ConvertAbilityRealLevelField('Hbz4')
ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5 = ConvertAbilityRealLevelField('Hbz5')
ABILITY_RLF_MAXIMUM_DAMAGE_PER_WAVE = ConvertAbilityRealLevelField('Hbz6')
ABILITY_RLF_MANA_REGENERATION_INCREASE = ConvertAbilityRealLevelField('Hab1')
ABILITY_RLF_CASTING_DELAY = ConvertAbilityRealLevelField('Hmt2')
ABILITY_RLF_DAMAGE_PER_SECOND_OWW1 = ConvertAbilityRealLevelField('Oww1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_OWW2 = ConvertAbilityRealLevelField('Oww2')
ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE = ConvertAbilityRealLevelField('Ocr1')
ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2 = ConvertAbilityRealLevelField('Ocr2')
ABILITY_RLF_DAMAGE_BONUS_OCR3 = ConvertAbilityRealLevelField('Ocr3')
ABILITY_RLF_CHANCE_TO_EVADE_OCR4 = ConvertAbilityRealLevelField('Ocr4')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_OMI2 = ConvertAbilityRealLevelField('Omi2')
ABILITY_RLF_DAMAGE_TAKEN_PERCENT_OMI3 = ConvertAbilityRealLevelField('Omi3')
ABILITY_RLF_ANIMATION_DELAY = ConvertAbilityRealLevelField('Omi4')
ABILITY_RLF_TRANSITION_TIME = ConvertAbilityRealLevelField('Owk1')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OWK2 = ConvertAbilityRealLevelField('Owk2')
ABILITY_RLF_BACKSTAB_DAMAGE = ConvertAbilityRealLevelField('Owk3')
ABILITY_RLF_AMOUNT_HEALED_DAMAGED_UDC1 = ConvertAbilityRealLevelField('Udc1')
ABILITY_RLF_LIFE_CONVERTED_TO_MANA = ConvertAbilityRealLevelField('Udp1')
ABILITY_RLF_LIFE_CONVERTED_TO_LIFE = ConvertAbilityRealLevelField('Udp2')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_UAU1 = ConvertAbilityRealLevelField('Uau1')
ABILITY_RLF_LIFE_REGENERATION_INCREASE_PERCENT = ConvertAbilityRealLevelField('Uau2')
ABILITY_RLF_CHANCE_TO_EVADE_EEV1 = ConvertAbilityRealLevelField('Eev1')
ABILITY_RLF_DAMAGE_PER_INTERVAL = ConvertAbilityRealLevelField('Eim1')
ABILITY_RLF_MANA_DRAINED_PER_SECOND_EIM2 = ConvertAbilityRealLevelField('Eim2')
ABILITY_RLF_BUFFER_MANA_REQUIRED = ConvertAbilityRealLevelField('Eim3')
ABILITY_RLF_MAX_MANA_DRAINED = ConvertAbilityRealLevelField('Emb1')
ABILITY_RLF_BOLT_DELAY = ConvertAbilityRealLevelField('Emb2')
ABILITY_RLF_BOLT_LIFETIME = ConvertAbilityRealLevelField('Emb3')
ABILITY_RLF_ALTITUDE_ADJUSTMENT_DURATION = ConvertAbilityRealLevelField('Eme3')
ABILITY_RLF_LANDING_DELAY_TIME = ConvertAbilityRealLevelField('Eme4')
ABILITY_RLF_ALTERNATE_FORM_HIT_POINT_BONUS = ConvertAbilityRealLevelField('Eme5')
ABILITY_RLF_MOVE_SPEED_BONUS_INFO_PANEL_ONLY = ConvertAbilityRealLevelField('Ncr5')
ABILITY_RLF_ATTACK_SPEED_BONUS_INFO_PANEL_ONLY = ConvertAbilityRealLevelField('Ncr6')
ABILITY_RLF_LIFE_REGENERATION_RATE_PER_SECOND = ConvertAbilityRealLevelField('ave5')
ABILITY_RLF_STUN_DURATION_USL1 = ConvertAbilityRealLevelField('Usl1')
ABILITY_RLF_ATTACK_DAMAGE_STOLEN_PERCENT = ConvertAbilityRealLevelField('Uav1')
ABILITY_RLF_DAMAGE_UCS1 = ConvertAbilityRealLevelField('Ucs1')
ABILITY_RLF_MAX_DAMAGE_UCS2 = ConvertAbilityRealLevelField('Ucs2')
ABILITY_RLF_DISTANCE_UCS3 = ConvertAbilityRealLevelField('Ucs3')
ABILITY_RLF_FINAL_AREA_UCS4 = ConvertAbilityRealLevelField('Ucs4')
ABILITY_RLF_DAMAGE_UIN1 = ConvertAbilityRealLevelField('Uin1')
ABILITY_RLF_DURATION = ConvertAbilityRealLevelField('Uin2')
ABILITY_RLF_IMPACT_DELAY = ConvertAbilityRealLevelField('Uin3')
ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 = ConvertAbilityRealLevelField('Ocl1')
ABILITY_RLF_DAMAGE_REDUCTION_PER_TARGET = ConvertAbilityRealLevelField('Ocl3')
ABILITY_RLF_EFFECT_DELAY_OEQ1 = ConvertAbilityRealLevelField('Oeq1')
ABILITY_RLF_DAMAGE_PER_SECOND_TO_BUILDINGS = ConvertAbilityRealLevelField('Oeq2')
ABILITY_RLF_UNITS_SLOWED_PERCENT = ConvertAbilityRealLevelField('Oeq3')
ABILITY_RLF_FINAL_AREA_OEQ4 = ConvertAbilityRealLevelField('Oeq4')
ABILITY_RLF_DAMAGE_PER_SECOND_EER1 = ConvertAbilityRealLevelField('Eer1')
ABILITY_RLF_DAMAGE_DEALT_TO_ATTACKERS = ConvertAbilityRealLevelField('Eah1')
ABILITY_RLF_LIFE_HEALED = ConvertAbilityRealLevelField('Etq1')
ABILITY_RLF_HEAL_INTERVAL = ConvertAbilityRealLevelField('Etq2')
ABILITY_RLF_BUILDING_REDUCTION_ETQ3 = ConvertAbilityRealLevelField('Etq3')
ABILITY_RLF_INITIAL_IMMUNITY_DURATION = ConvertAbilityRealLevelField('Etq4')
ABILITY_RLF_MAX_LIFE_DRAINED_PER_SECOND_PERCENT = ConvertAbilityRealLevelField('Udd1')
ABILITY_RLF_BUILDING_REDUCTION_UDD2 = ConvertAbilityRealLevelField('Udd2')
ABILITY_RLF_ARMOR_DURATION = ConvertAbilityRealLevelField('Ufa1')
ABILITY_RLF_ARMOR_BONUS_UFA2 = ConvertAbilityRealLevelField('Ufa2')
ABILITY_RLF_AREA_OF_EFFECT_DAMAGE = ConvertAbilityRealLevelField('Ufn1')
ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2 = ConvertAbilityRealLevelField('Ufn2')
ABILITY_RLF_DAMAGE_BONUS_HFA1 = ConvertAbilityRealLevelField('Hfa1')
ABILITY_RLF_DAMAGE_DEALT_ESF1 = ConvertAbilityRealLevelField('Esf1')
ABILITY_RLF_DAMAGE_INTERVAL_ESF2 = ConvertAbilityRealLevelField('Esf2')
ABILITY_RLF_BUILDING_REDUCTION_ESF3 = ConvertAbilityRealLevelField('Esf3')
ABILITY_RLF_DAMAGE_BONUS_PERCENT = ConvertAbilityRealLevelField('Ear1')
ABILITY_RLF_DEFENSE_BONUS_HAV1 = ConvertAbilityRealLevelField('Hav1')
ABILITY_RLF_HIT_POINT_BONUS = ConvertAbilityRealLevelField('Hav2')
ABILITY_RLF_DAMAGE_BONUS_HAV3 = ConvertAbilityRealLevelField('Hav3')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_HAV4 = ConvertAbilityRealLevelField('Hav4')
ABILITY_RLF_CHANCE_TO_BASH = ConvertAbilityRealLevelField('Hbh1')
ABILITY_RLF_DAMAGE_MULTIPLIER_HBH2 = ConvertAbilityRealLevelField('Hbh2')
ABILITY_RLF_DAMAGE_BONUS_HBH3 = ConvertAbilityRealLevelField('Hbh3')
ABILITY_RLF_CHANCE_TO_MISS_HBH4 = ConvertAbilityRealLevelField('Hbh4')
ABILITY_RLF_DAMAGE_HTB1 = ConvertAbilityRealLevelField('Htb1')
ABILITY_RLF_AOE_DAMAGE = ConvertAbilityRealLevelField('Htc1')
ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2 = ConvertAbilityRealLevelField('Htc2')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HTC3 = ConvertAbilityRealLevelField('Htc3')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HTC4 = ConvertAbilityRealLevelField('Htc4')
ABILITY_RLF_ARMOR_BONUS_HAD1 = ConvertAbilityRealLevelField('Had1')
ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1 = ConvertAbilityRealLevelField('Hhb1')
ABILITY_RLF_EXTRA_DAMAGE_HCA1 = ConvertAbilityRealLevelField('Hca1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_HCA2 = ConvertAbilityRealLevelField('Hca2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_HCA3 = ConvertAbilityRealLevelField('Hca3')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1 = ConvertAbilityRealLevelField('Oae1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2 = ConvertAbilityRealLevelField('Oae2')
ABILITY_RLF_REINCARNATION_DELAY = ConvertAbilityRealLevelField('Ore1')
ABILITY_RLF_DAMAGE_OSH1 = ConvertAbilityRealLevelField('Osh1')
ABILITY_RLF_MAXIMUM_DAMAGE_OSH2 = ConvertAbilityRealLevelField('Osh2')
ABILITY_RLF_DISTANCE_OSH3 = ConvertAbilityRealLevelField('Osh3')
ABILITY_RLF_FINAL_AREA_OSH4 = ConvertAbilityRealLevelField('Osh4')
ABILITY_RLF_GRAPHIC_DELAY_NFD1 = ConvertAbilityRealLevelField('Nfd1')
ABILITY_RLF_GRAPHIC_DURATION_NFD2 = ConvertAbilityRealLevelField('Nfd2')
ABILITY_RLF_DAMAGE_NFD3 = ConvertAbilityRealLevelField('Nfd3')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_AMS1 = ConvertAbilityRealLevelField('Ams1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_AMS2 = ConvertAbilityRealLevelField('Ams2')
ABILITY_RLF_AURA_DURATION = ConvertAbilityRealLevelField('Apl1')
ABILITY_RLF_DAMAGE_PER_SECOND_APL2 = ConvertAbilityRealLevelField('Apl2')
ABILITY_RLF_DURATION_OF_PLAGUE_WARD = ConvertAbilityRealLevelField('Apl3')
ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED = ConvertAbilityRealLevelField('Oar1')
ABILITY_RLF_ATTACK_DAMAGE_INCREASE_AKB1 = ConvertAbilityRealLevelField('Akb1')
ABILITY_RLF_MANA_LOSS_ADM1 = ConvertAbilityRealLevelField('Adm1')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_ADM2 = ConvertAbilityRealLevelField('Adm2')
ABILITY_RLF_EXPANSION_AMOUNT = ConvertAbilityRealLevelField('Bli1')
ABILITY_RLF_INTERVAL_DURATION_BGM2 = ConvertAbilityRealLevelField('Bgm2')
ABILITY_RLF_RADIUS_OF_MINING_RING = ConvertAbilityRealLevelField('Bgm4')
ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_BLO1 = ConvertAbilityRealLevelField('Blo1')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_BLO2 = ConvertAbilityRealLevelField('Blo2')
ABILITY_RLF_SCALING_FACTOR = ConvertAbilityRealLevelField('Blo3')
ABILITY_RLF_HIT_POINTS_PER_SECOND_CAN1 = ConvertAbilityRealLevelField('Can1')
ABILITY_RLF_MAX_HIT_POINTS = ConvertAbilityRealLevelField('Can2')
ABILITY_RLF_DAMAGE_PER_SECOND_DEV2 = ConvertAbilityRealLevelField('Dev2')
ABILITY_RLF_MOVEMENT_UPDATE_FREQUENCY_CHD1 = ConvertAbilityRealLevelField('Chd1')
ABILITY_RLF_ATTACK_UPDATE_FREQUENCY_CHD2 = ConvertAbilityRealLevelField('Chd2')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_CHD3 = ConvertAbilityRealLevelField('Chd3')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_CRI1 = ConvertAbilityRealLevelField('Cri1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_CRI2 = ConvertAbilityRealLevelField('Cri2')
ABILITY_RLF_DAMAGE_REDUCTION_CRI3 = ConvertAbilityRealLevelField('Cri3')
ABILITY_RLF_CHANCE_TO_MISS_CRS = ConvertAbilityRealLevelField('Crs1')
ABILITY_RLF_FULL_DAMAGE_RADIUS_DDA1 = ConvertAbilityRealLevelField('Dda1')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_DDA2 = ConvertAbilityRealLevelField('Dda2')
ABILITY_RLF_PARTIAL_DAMAGE_RADIUS = ConvertAbilityRealLevelField('Dda3')
ABILITY_RLF_PARTIAL_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('Dda4')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_SDS1 = ConvertAbilityRealLevelField('Sds1')
ABILITY_RLF_MAX_DAMAGE_UCO5 = ConvertAbilityRealLevelField('Uco5')
ABILITY_RLF_MOVE_SPEED_BONUS_UCO6 = ConvertAbilityRealLevelField('Uco6')
ABILITY_RLF_DAMAGE_TAKEN_PERCENT_DEF1 = ConvertAbilityRealLevelField('Def1')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_DEF2 = ConvertAbilityRealLevelField('Def2')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_DEF3 = ConvertAbilityRealLevelField('Def3')
ABILITY_RLF_ATTACK_SPEED_FACTOR_DEF4 = ConvertAbilityRealLevelField('Def4')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_DEF5 = ConvertAbilityRealLevelField('Def5')
ABILITY_RLF_CHANCE_TO_DEFLECT = ConvertAbilityRealLevelField('Def6')
ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_PIERCING = ConvertAbilityRealLevelField('Def7')
ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_SPELLS = ConvertAbilityRealLevelField('Def8')
ABILITY_RLF_RIP_DELAY = ConvertAbilityRealLevelField('Eat1')
ABILITY_RLF_EAT_DELAY = ConvertAbilityRealLevelField('Eat2')
ABILITY_RLF_HIT_POINTS_GAINED_EAT3 = ConvertAbilityRealLevelField('Eat3')
ABILITY_RLF_AIR_UNIT_LOWER_DURATION = ConvertAbilityRealLevelField('Ens1')
ABILITY_RLF_AIR_UNIT_HEIGHT = ConvertAbilityRealLevelField('Ens2')
ABILITY_RLF_MELEE_ATTACK_RANGE = ConvertAbilityRealLevelField('Ens3')
ABILITY_RLF_INTERVAL_DURATION_EGM2 = ConvertAbilityRealLevelField('Egm2')
ABILITY_RLF_EFFECT_DELAY_FLA2 = ConvertAbilityRealLevelField('Fla2')
ABILITY_RLF_MINING_DURATION = ConvertAbilityRealLevelField('Gld2')
ABILITY_RLF_RADIUS_OF_GRAVESTONES = ConvertAbilityRealLevelField('Gyd2')
ABILITY_RLF_RADIUS_OF_CORPSES = ConvertAbilityRealLevelField('Gyd3')
ABILITY_RLF_HIT_POINTS_GAINED_HEA1 = ConvertAbilityRealLevelField('Hea1')
ABILITY_RLF_DAMAGE_INCREASE_PERCENT_INF1 = ConvertAbilityRealLevelField('Inf1')
ABILITY_RLF_AUTOCAST_RANGE = ConvertAbilityRealLevelField('Inf3')
ABILITY_RLF_LIFE_REGEN_RATE = ConvertAbilityRealLevelField('Inf4')
ABILITY_RLF_GRAPHIC_DELAY_LIT1 = ConvertAbilityRealLevelField('Lit1')
ABILITY_RLF_GRAPHIC_DURATION_LIT2 = ConvertAbilityRealLevelField('Lit2')
ABILITY_RLF_DAMAGE_PER_SECOND_LSH1 = ConvertAbilityRealLevelField('Lsh1')
ABILITY_RLF_MANA_GAINED = ConvertAbilityRealLevelField('Mbt1')
ABILITY_RLF_HIT_POINTS_GAINED_MBT2 = ConvertAbilityRealLevelField('Mbt2')
ABILITY_RLF_AUTOCAST_REQUIREMENT = ConvertAbilityRealLevelField('Mbt3')
ABILITY_RLF_WATER_HEIGHT = ConvertAbilityRealLevelField('Mbt4')
ABILITY_RLF_ACTIVATION_DELAY_MIN1 = ConvertAbilityRealLevelField('Min1')
ABILITY_RLF_INVISIBILITY_TRANSITION_TIME = ConvertAbilityRealLevelField('Min2')
ABILITY_RLF_ACTIVATION_RADIUS = ConvertAbilityRealLevelField('Neu1')
ABILITY_RLF_AMOUNT_REGENERATED = ConvertAbilityRealLevelField('Arm1')
ABILITY_RLF_DAMAGE_PER_SECOND_POI1 = ConvertAbilityRealLevelField('Poi1')
ABILITY_RLF_ATTACK_SPEED_FACTOR_POI2 = ConvertAbilityRealLevelField('Poi2')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POI3 = ConvertAbilityRealLevelField('Poi3')
ABILITY_RLF_EXTRA_DAMAGE_POA1 = ConvertAbilityRealLevelField('Poa1')
ABILITY_RLF_DAMAGE_PER_SECOND_POA2 = ConvertAbilityRealLevelField('Poa2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_POA3 = ConvertAbilityRealLevelField('Poa3')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POA4 = ConvertAbilityRealLevelField('Poa4')
ABILITY_RLF_DAMAGE_AMPLIFICATION = ConvertAbilityRealLevelField('Pos2')
ABILITY_RLF_CHANCE_TO_STOMP_PERCENT = ConvertAbilityRealLevelField('War1')
ABILITY_RLF_DAMAGE_DEALT_WAR2 = ConvertAbilityRealLevelField('War2')
ABILITY_RLF_FULL_DAMAGE_RADIUS_WAR3 = ConvertAbilityRealLevelField('War3')
ABILITY_RLF_HALF_DAMAGE_RADIUS_WAR4 = ConvertAbilityRealLevelField('War4')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_PRG3 = ConvertAbilityRealLevelField('Prg3')
ABILITY_RLF_UNIT_PAUSE_DURATION = ConvertAbilityRealLevelField('Prg4')
ABILITY_RLF_HERO_PAUSE_DURATION = ConvertAbilityRealLevelField('Prg5')
ABILITY_RLF_HIT_POINTS_GAINED_REJ1 = ConvertAbilityRealLevelField('Rej1')
ABILITY_RLF_MANA_POINTS_GAINED_REJ2 = ConvertAbilityRealLevelField('Rej2')
ABILITY_RLF_MINIMUM_LIFE_REQUIRED = ConvertAbilityRealLevelField('Rpb3')
ABILITY_RLF_MINIMUM_MANA_REQUIRED = ConvertAbilityRealLevelField('Rpb4')
ABILITY_RLF_REPAIR_COST_RATIO = ConvertAbilityRealLevelField('Rep1')
ABILITY_RLF_REPAIR_TIME_RATIO = ConvertAbilityRealLevelField('Rep2')
ABILITY_RLF_POWERBUILD_COST = ConvertAbilityRealLevelField('Rep3')
ABILITY_RLF_POWERBUILD_RATE = ConvertAbilityRealLevelField('Rep4')
ABILITY_RLF_NAVAL_RANGE_BONUS = ConvertAbilityRealLevelField('Rep5')
ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1 = ConvertAbilityRealLevelField('Roa1')
ABILITY_RLF_LIFE_REGENERATION_RATE = ConvertAbilityRealLevelField('Roa3')
ABILITY_RLF_MANA_REGEN = ConvertAbilityRealLevelField('Roa4')
ABILITY_RLF_DAMAGE_INCREASE = ConvertAbilityRealLevelField('Nbr1')
ABILITY_RLF_SALVAGE_COST_RATIO = ConvertAbilityRealLevelField('Sal1')
ABILITY_RLF_IN_FLIGHT_SIGHT_RADIUS = ConvertAbilityRealLevelField('Esn1')
ABILITY_RLF_HOVERING_SIGHT_RADIUS = ConvertAbilityRealLevelField('Esn2')
ABILITY_RLF_HOVERING_HEIGHT = ConvertAbilityRealLevelField('Esn3')
ABILITY_RLF_DURATION_OF_OWLS = ConvertAbilityRealLevelField('Esn5')
ABILITY_RLF_FADE_DURATION = ConvertAbilityRealLevelField('Shm1')
ABILITY_RLF_DAY_NIGHT_DURATION = ConvertAbilityRealLevelField('Shm2')
ABILITY_RLF_ACTION_DURATION = ConvertAbilityRealLevelField('Shm3')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SLO1 = ConvertAbilityRealLevelField('Slo1')
ABILITY_RLF_ATTACK_SPEED_FACTOR_SLO2 = ConvertAbilityRealLevelField('Slo2')
ABILITY_RLF_DAMAGE_PER_SECOND_SPO1 = ConvertAbilityRealLevelField('Spo1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SPO2 = ConvertAbilityRealLevelField('Spo2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_SPO3 = ConvertAbilityRealLevelField('Spo3')
ABILITY_RLF_ACTIVATION_DELAY_STA1 = ConvertAbilityRealLevelField('Sta1')
ABILITY_RLF_DETECTION_RADIUS_STA2 = ConvertAbilityRealLevelField('Sta2')
ABILITY_RLF_DETONATION_RADIUS = ConvertAbilityRealLevelField('Sta3')
ABILITY_RLF_STUN_DURATION_STA4 = ConvertAbilityRealLevelField('Sta4')
ABILITY_RLF_ATTACK_SPEED_BONUS_PERCENT = ConvertAbilityRealLevelField('Uhf1')
ABILITY_RLF_DAMAGE_PER_SECOND_UHF2 = ConvertAbilityRealLevelField('Uhf2')
ABILITY_RLF_LUMBER_PER_INTERVAL = ConvertAbilityRealLevelField('Wha1')
ABILITY_RLF_ART_ATTACHMENT_HEIGHT = ConvertAbilityRealLevelField('Wha3')
ABILITY_RLF_TELEPORT_AREA_WIDTH = ConvertAbilityRealLevelField('Wrp1')
ABILITY_RLF_TELEPORT_AREA_HEIGHT = ConvertAbilityRealLevelField('Wrp2')
ABILITY_RLF_LIFE_STOLEN_PER_ATTACK = ConvertAbilityRealLevelField('Ivam')
ABILITY_RLF_DAMAGE_BONUS_IDAM = ConvertAbilityRealLevelField('Idam')
ABILITY_RLF_CHANCE_TO_HIT_UNITS_PERCENT = ConvertAbilityRealLevelField('Iob2')
ABILITY_RLF_CHANCE_TO_HIT_HEROS_PERCENT = ConvertAbilityRealLevelField('Iob3')
ABILITY_RLF_CHANCE_TO_HIT_SUMMONS_PERCENT = ConvertAbilityRealLevelField('Iob4')
ABILITY_RLF_DELAY_FOR_TARGET_EFFECT = ConvertAbilityRealLevelField('Idel')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_OF_NORMAL = ConvertAbilityRealLevelField('Iild')
ABILITY_RLF_DAMAGE_RECEIVED_MULTIPLIER = ConvertAbilityRealLevelField('Iilw')
ABILITY_RLF_MANA_REGENERATION_BONUS_AS_FRACTION_OF_NORMAL = ConvertAbilityRealLevelField('Imrp')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_ISPI = ConvertAbilityRealLevelField('Ispi')
ABILITY_RLF_DAMAGE_PER_SECOND_IDPS = ConvertAbilityRealLevelField('Idps')
ABILITY_RLF_ATTACK_DAMAGE_INCREASE_CAC1 = ConvertAbilityRealLevelField('Cac1')
ABILITY_RLF_DAMAGE_PER_SECOND_COR1 = ConvertAbilityRealLevelField('Cor1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1 = ConvertAbilityRealLevelField('Isx1')
ABILITY_RLF_DAMAGE_WRS1 = ConvertAbilityRealLevelField('Wrs1')
ABILITY_RLF_TERRAIN_DEFORMATION_AMPLITUDE = ConvertAbilityRealLevelField('Wrs2')
ABILITY_RLF_DAMAGE_CTC1 = ConvertAbilityRealLevelField('Ctc1')
ABILITY_RLF_EXTRA_DAMAGE_TO_TARGET = ConvertAbilityRealLevelField('Ctc2')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_CTC3 = ConvertAbilityRealLevelField('Ctc3')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_CTC4 = ConvertAbilityRealLevelField('Ctc4')
ABILITY_RLF_DAMAGE_CTB1 = ConvertAbilityRealLevelField('Ctb1')
ABILITY_RLF_CASTING_DELAY_SECONDS = ConvertAbilityRealLevelField('Uds2')
ABILITY_RLF_MANA_LOSS_PER_UNIT_DTN1 = ConvertAbilityRealLevelField('Dtn1')
ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_DTN2 = ConvertAbilityRealLevelField('Dtn2')
ABILITY_RLF_TRANSITION_TIME_SECONDS = ConvertAbilityRealLevelField('Ivs1')
ABILITY_RLF_MANA_DRAINED_PER_SECOND_NMR1 = ConvertAbilityRealLevelField('Nmr1')
ABILITY_RLF_CHANCE_TO_REDUCE_DAMAGE_PERCENT = ConvertAbilityRealLevelField('Ssk1')
ABILITY_RLF_MINIMUM_DAMAGE = ConvertAbilityRealLevelField('Ssk2')
ABILITY_RLF_IGNORED_DAMAGE = ConvertAbilityRealLevelField('Ssk3')
ABILITY_RLF_FULL_DAMAGE_DEALT = ConvertAbilityRealLevelField('Hfs1')
ABILITY_RLF_FULL_DAMAGE_INTERVAL = ConvertAbilityRealLevelField('Hfs2')
ABILITY_RLF_HALF_DAMAGE_DEALT = ConvertAbilityRealLevelField('Hfs3')
ABILITY_RLF_HALF_DAMAGE_INTERVAL = ConvertAbilityRealLevelField('Hfs4')
ABILITY_RLF_BUILDING_REDUCTION_HFS5 = ConvertAbilityRealLevelField('Hfs5')
ABILITY_RLF_MAXIMUM_DAMAGE_HFS6 = ConvertAbilityRealLevelField('Hfs6')
ABILITY_RLF_MANA_PER_HIT_POINT = ConvertAbilityRealLevelField('Nms1')
ABILITY_RLF_DAMAGE_ABSORBED_PERCENT = ConvertAbilityRealLevelField('Nms2')
ABILITY_RLF_WAVE_DISTANCE = ConvertAbilityRealLevelField('Uim1')
ABILITY_RLF_WAVE_TIME_SECONDS = ConvertAbilityRealLevelField('Uim2')
ABILITY_RLF_DAMAGE_DEALT_UIM3 = ConvertAbilityRealLevelField('Uim3')
ABILITY_RLF_AIR_TIME_SECONDS_UIM4 = ConvertAbilityRealLevelField('Uim4')
ABILITY_RLF_UNIT_RELEASE_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Uls2')
ABILITY_RLF_DAMAGE_RETURN_FACTOR = ConvertAbilityRealLevelField('Uls4')
ABILITY_RLF_DAMAGE_RETURN_THRESHOLD = ConvertAbilityRealLevelField('Uls5')
ABILITY_RLF_RETURNED_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Uts1')
ABILITY_RLF_RECEIVED_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Uts2')
ABILITY_RLF_DEFENSE_BONUS_UTS3 = ConvertAbilityRealLevelField('Uts3')
ABILITY_RLF_DAMAGE_BONUS_NBA1 = ConvertAbilityRealLevelField('Nba1')
ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NBA3 = ConvertAbilityRealLevelField('Nba3')
ABILITY_RLF_MANA_PER_SUMMONED_HITPOINT = ConvertAbilityRealLevelField('Cmg2')
ABILITY_RLF_CHARGE_FOR_CURRENT_LIFE = ConvertAbilityRealLevelField('Cmg3')
ABILITY_RLF_HIT_POINTS_DRAINED = ConvertAbilityRealLevelField('Ndr1')
ABILITY_RLF_MANA_POINTS_DRAINED = ConvertAbilityRealLevelField('Ndr2')
ABILITY_RLF_DRAIN_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Ndr3')
ABILITY_RLF_LIFE_TRANSFERRED_PER_SECOND = ConvertAbilityRealLevelField('Ndr4')
ABILITY_RLF_MANA_TRANSFERRED_PER_SECOND = ConvertAbilityRealLevelField('Ndr5')
ABILITY_RLF_BONUS_LIFE_FACTOR = ConvertAbilityRealLevelField('Ndr6')
ABILITY_RLF_BONUS_LIFE_DECAY = ConvertAbilityRealLevelField('Ndr7')
ABILITY_RLF_BONUS_MANA_FACTOR = ConvertAbilityRealLevelField('Ndr8')
ABILITY_RLF_BONUS_MANA_DECAY = ConvertAbilityRealLevelField('Ndr9')
ABILITY_RLF_CHANCE_TO_MISS_PERCENT = ConvertAbilityRealLevelField('Nsi2')
ABILITY_RLF_MOVEMENT_SPEED_MODIFIER = ConvertAbilityRealLevelField('Nsi3')
ABILITY_RLF_ATTACK_SPEED_MODIFIER = ConvertAbilityRealLevelField('Nsi4')
ABILITY_RLF_DAMAGE_PER_SECOND_TDG1 = ConvertAbilityRealLevelField('Tdg1')
ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_TDG2 = ConvertAbilityRealLevelField('Tdg2')
ABILITY_RLF_MEDIUM_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('Tdg3')
ABILITY_RLF_SMALL_DAMAGE_RADIUS_TDG4 = ConvertAbilityRealLevelField('Tdg4')
ABILITY_RLF_SMALL_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('Tdg5')
ABILITY_RLF_AIR_TIME_SECONDS_TSP1 = ConvertAbilityRealLevelField('Tsp1')
ABILITY_RLF_MINIMUM_HIT_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Tsp2')
ABILITY_RLF_DAMAGE_PER_SECOND_NBF5 = ConvertAbilityRealLevelField('Nbf5')
ABILITY_RLF_MAXIMUM_RANGE = ConvertAbilityRealLevelField('Ebl1')
ABILITY_RLF_MINIMUM_RANGE = ConvertAbilityRealLevelField('Ebl2')
ABILITY_RLF_DAMAGE_PER_TARGET_EFK1 = ConvertAbilityRealLevelField('Efk1')
ABILITY_RLF_MAXIMUM_TOTAL_DAMAGE = ConvertAbilityRealLevelField('Efk2')
ABILITY_RLF_MAXIMUM_SPEED_ADJUSTMENT = ConvertAbilityRealLevelField('Efk4')
ABILITY_RLF_DECAYING_DAMAGE = ConvertAbilityRealLevelField('Esh1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_ESH2 = ConvertAbilityRealLevelField('Esh2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_ESH3 = ConvertAbilityRealLevelField('Esh3')
ABILITY_RLF_DECAY_POWER = ConvertAbilityRealLevelField('Esh4')
ABILITY_RLF_INITIAL_DAMAGE_ESH5 = ConvertAbilityRealLevelField('Esh5')
ABILITY_RLF_MAXIMUM_LIFE_ABSORBED = ConvertAbilityRealLevelField('abs1')
ABILITY_RLF_MAXIMUM_MANA_ABSORBED = ConvertAbilityRealLevelField('abs2')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_BSK1 = ConvertAbilityRealLevelField('bsk1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_BSK2 = ConvertAbilityRealLevelField('bsk2')
ABILITY_RLF_DAMAGE_TAKEN_INCREASE = ConvertAbilityRealLevelField('bsk3')
ABILITY_RLF_LIFE_PER_UNIT = ConvertAbilityRealLevelField('dvm1')
ABILITY_RLF_MANA_PER_UNIT = ConvertAbilityRealLevelField('dvm2')
ABILITY_RLF_LIFE_PER_BUFF = ConvertAbilityRealLevelField('dvm3')
ABILITY_RLF_MANA_PER_BUFF = ConvertAbilityRealLevelField('dvm4')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_DVM5 = ConvertAbilityRealLevelField('dvm5')
ABILITY_RLF_DAMAGE_BONUS_FAK1 = ConvertAbilityRealLevelField('fak1')
ABILITY_RLF_MEDIUM_DAMAGE_FACTOR_FAK2 = ConvertAbilityRealLevelField('fak2')
ABILITY_RLF_SMALL_DAMAGE_FACTOR_FAK3 = ConvertAbilityRealLevelField('fak3')
ABILITY_RLF_FULL_DAMAGE_RADIUS_FAK4 = ConvertAbilityRealLevelField('fak4')
ABILITY_RLF_HALF_DAMAGE_RADIUS_FAK5 = ConvertAbilityRealLevelField('fak5')
ABILITY_RLF_EXTRA_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('liq1')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_LIQ2 = ConvertAbilityRealLevelField('liq2')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_LIQ3 = ConvertAbilityRealLevelField('liq3')
ABILITY_RLF_MAGIC_DAMAGE_FACTOR = ConvertAbilityRealLevelField('mim1')
ABILITY_RLF_UNIT_DAMAGE_PER_MANA_POINT = ConvertAbilityRealLevelField('mfl1')
ABILITY_RLF_HERO_DAMAGE_PER_MANA_POINT = ConvertAbilityRealLevelField('mfl2')
ABILITY_RLF_UNIT_MAXIMUM_DAMAGE = ConvertAbilityRealLevelField('mfl3')
ABILITY_RLF_HERO_MAXIMUM_DAMAGE = ConvertAbilityRealLevelField('mfl4')
ABILITY_RLF_DAMAGE_COOLDOWN = ConvertAbilityRealLevelField('mfl5')
ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_SPL1 = ConvertAbilityRealLevelField('spl1')
ABILITY_RLF_LIFE_REGENERATED = ConvertAbilityRealLevelField('irl1')
ABILITY_RLF_MANA_REGENERATED = ConvertAbilityRealLevelField('irl2')
ABILITY_RLF_MANA_LOSS_PER_UNIT_IDC1 = ConvertAbilityRealLevelField('idc1')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_IDC2 = ConvertAbilityRealLevelField('idc2')
ABILITY_RLF_ACTIVATION_DELAY_IMO2 = ConvertAbilityRealLevelField('imo2')
ABILITY_RLF_LURE_INTERVAL_SECONDS = ConvertAbilityRealLevelField('imo3')
ABILITY_RLF_DAMAGE_BONUS_ISR1 = ConvertAbilityRealLevelField('isr1')
ABILITY_RLF_DAMAGE_REDUCTION_ISR2 = ConvertAbilityRealLevelField('isr2')
ABILITY_RLF_DAMAGE_BONUS_IPV1 = ConvertAbilityRealLevelField('ipv1')
ABILITY_RLF_LIFE_STEAL_AMOUNT = ConvertAbilityRealLevelField('ipv2')
ABILITY_RLF_LIFE_RESTORED_FACTOR = ConvertAbilityRealLevelField('ast1')
ABILITY_RLF_MANA_RESTORED_FACTOR = ConvertAbilityRealLevelField('ast2')
ABILITY_RLF_ATTACH_DELAY = ConvertAbilityRealLevelField('gra1')
ABILITY_RLF_REMOVE_DELAY = ConvertAbilityRealLevelField('gra2')
ABILITY_RLF_HERO_REGENERATION_DELAY = ConvertAbilityRealLevelField('Nsa2')
ABILITY_RLF_UNIT_REGENERATION_DELAY = ConvertAbilityRealLevelField('Nsa3')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_NSA4 = ConvertAbilityRealLevelField('Nsa4')
ABILITY_RLF_HIT_POINTS_PER_SECOND_NSA5 = ConvertAbilityRealLevelField('Nsa5')
ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_IXS1 = ConvertAbilityRealLevelField('Ixs1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_IXS2 = ConvertAbilityRealLevelField('Ixs2')
ABILITY_RLF_SUMMONED_UNIT_DURATION = ConvertAbilityRealLevelField('Npa6')
ABILITY_RLF_SHIELD_COOLDOWN_TIME = ConvertAbilityRealLevelField('Nse1')
ABILITY_RLF_DAMAGE_PER_SECOND_NDO1 = ConvertAbilityRealLevelField('Ndo1')
ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NDO3 = ConvertAbilityRealLevelField('Ndo3')
ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_FLK1 = ConvertAbilityRealLevelField('flk1')
ABILITY_RLF_SMALL_DAMAGE_RADIUS_FLK2 = ConvertAbilityRealLevelField('flk2')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_FLK3 = ConvertAbilityRealLevelField('flk3')
ABILITY_RLF_MEDIUM_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('flk4')
ABILITY_RLF_SMALL_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('flk5')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HBN1 = ConvertAbilityRealLevelField('Hbn1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HBN2 = ConvertAbilityRealLevelField('Hbn2')
ABILITY_RLF_MAX_MANA_DRAINED_UNITS = ConvertAbilityRealLevelField('fbk1')
ABILITY_RLF_DAMAGE_RATIO_UNITS_PERCENT = ConvertAbilityRealLevelField('fbk2')
ABILITY_RLF_MAX_MANA_DRAINED_HEROS = ConvertAbilityRealLevelField('fbk3')
ABILITY_RLF_DAMAGE_RATIO_HEROS_PERCENT = ConvertAbilityRealLevelField('fbk4')
ABILITY_RLF_SUMMONED_DAMAGE = ConvertAbilityRealLevelField('fbk5')
ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_NCA1 = ConvertAbilityRealLevelField('nca1')
ABILITY_RLF_INITIAL_DAMAGE_PXF1 = ConvertAbilityRealLevelField('pxf1')
ABILITY_RLF_DAMAGE_PER_SECOND_PXF2 = ConvertAbilityRealLevelField('pxf2')
ABILITY_RLF_DAMAGE_PER_SECOND_MLS1 = ConvertAbilityRealLevelField('mls1')
ABILITY_RLF_BEAST_COLLISION_RADIUS = ConvertAbilityRealLevelField('Nst2')
ABILITY_RLF_DAMAGE_AMOUNT_NST3 = ConvertAbilityRealLevelField('Nst3')
ABILITY_RLF_DAMAGE_RADIUS = ConvertAbilityRealLevelField('Nst4')
ABILITY_RLF_DAMAGE_DELAY = ConvertAbilityRealLevelField('Nst5')
ABILITY_RLF_FOLLOW_THROUGH_TIME = ConvertAbilityRealLevelField('Ncl1')
ABILITY_RLF_ART_DURATION = ConvertAbilityRealLevelField('Ncl4')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NAB1 = ConvertAbilityRealLevelField('Nab1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NAB2 = ConvertAbilityRealLevelField('Nab2')
ABILITY_RLF_PRIMARY_DAMAGE = ConvertAbilityRealLevelField('Nab4')
ABILITY_RLF_SECONDARY_DAMAGE = ConvertAbilityRealLevelField('Nab5')
ABILITY_RLF_DAMAGE_INTERVAL_NAB6 = ConvertAbilityRealLevelField('Nab6')
ABILITY_RLF_GOLD_COST_FACTOR = ConvertAbilityRealLevelField('Ntm1')
ABILITY_RLF_LUMBER_COST_FACTOR = ConvertAbilityRealLevelField('Ntm2')
ABILITY_RLF_MOVE_SPEED_BONUS_NEG1 = ConvertAbilityRealLevelField('Neg1')
ABILITY_RLF_DAMAGE_BONUS_NEG2 = ConvertAbilityRealLevelField('Neg2')
ABILITY_RLF_DAMAGE_AMOUNT_NCS1 = ConvertAbilityRealLevelField('Ncs1')
ABILITY_RLF_DAMAGE_INTERVAL_NCS2 = ConvertAbilityRealLevelField('Ncs2')
ABILITY_RLF_MAX_DAMAGE_NCS4 = ConvertAbilityRealLevelField('Ncs4')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NCS5 = ConvertAbilityRealLevelField('Ncs5')
ABILITY_RLF_EFFECT_DURATION = ConvertAbilityRealLevelField('Ncs6')
ABILITY_RLF_SPAWN_INTERVAL_NSY1 = ConvertAbilityRealLevelField('Nsy1')
ABILITY_RLF_SPAWN_UNIT_DURATION = ConvertAbilityRealLevelField('Nsy3')
ABILITY_RLF_SPAWN_UNIT_OFFSET = ConvertAbilityRealLevelField('Nsy4')
ABILITY_RLF_LEASH_RANGE_NSY5 = ConvertAbilityRealLevelField('Nsy5')
ABILITY_RLF_SPAWN_INTERVAL_NFY1 = ConvertAbilityRealLevelField('Nfy1')
ABILITY_RLF_LEASH_RANGE_NFY2 = ConvertAbilityRealLevelField('Nfy2')
ABILITY_RLF_CHANCE_TO_DEMOLISH = ConvertAbilityRealLevelField('Nde1')
ABILITY_RLF_DAMAGE_MULTIPLIER_BUILDINGS = ConvertAbilityRealLevelField('Nde2')
ABILITY_RLF_DAMAGE_MULTIPLIER_UNITS = ConvertAbilityRealLevelField('Nde3')
ABILITY_RLF_DAMAGE_MULTIPLIER_HEROES = ConvertAbilityRealLevelField('Nde4')
ABILITY_RLF_BONUS_DAMAGE_MULTIPLIER = ConvertAbilityRealLevelField('Nic1')
ABILITY_RLF_DEATH_DAMAGE_FULL_AMOUNT = ConvertAbilityRealLevelField('Nic2')
ABILITY_RLF_DEATH_DAMAGE_FULL_AREA = ConvertAbilityRealLevelField('Nic3')
ABILITY_RLF_DEATH_DAMAGE_HALF_AMOUNT = ConvertAbilityRealLevelField('Nic4')
ABILITY_RLF_DEATH_DAMAGE_HALF_AREA = ConvertAbilityRealLevelField('Nic5')
ABILITY_RLF_DEATH_DAMAGE_DELAY = ConvertAbilityRealLevelField('Nic6')
ABILITY_RLF_DAMAGE_AMOUNT_NSO1 = ConvertAbilityRealLevelField('Nso1')
ABILITY_RLF_DAMAGE_PERIOD = ConvertAbilityRealLevelField('Nso2')
ABILITY_RLF_DAMAGE_PENALTY = ConvertAbilityRealLevelField('Nso3')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NSO4 = ConvertAbilityRealLevelField('Nso4')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NSO5 = ConvertAbilityRealLevelField('Nso5')
ABILITY_RLF_SPLIT_DELAY = ConvertAbilityRealLevelField('Nlm2')
ABILITY_RLF_MAX_HITPOINT_FACTOR = ConvertAbilityRealLevelField('Nlm4')
ABILITY_RLF_LIFE_DURATION_SPLIT_BONUS = ConvertAbilityRealLevelField('Nlm5')
ABILITY_RLF_WAVE_INTERVAL = ConvertAbilityRealLevelField('Nvc3')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NVC4 = ConvertAbilityRealLevelField('Nvc4')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_NVC5 = ConvertAbilityRealLevelField('Nvc5')
ABILITY_RLF_HALF_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Nvc6')
ABILITY_RLF_INTERVAL_BETWEEN_PULSES = ConvertAbilityRealLevelField('Tau5')
ABILITY_BLF_USE_TELEPORT_CLUSTERING_HMT3 = ConvertAbilityBooleanLevelField('Hmt3')
ABILITY_BLF_NEVER_MISS_OCR5 = ConvertAbilityBooleanLevelField('Ocr5')
ABILITY_BLF_EXCLUDE_ITEM_DAMAGE = ConvertAbilityBooleanLevelField('Ocr6')
ABILITY_BLF_BACKSTAB_DAMAGE = ConvertAbilityBooleanLevelField('Owk4')
ABILITY_BLF_INHERIT_UPGRADES_UAN3 = ConvertAbilityBooleanLevelField('Uan3')
ABILITY_BLF_MANA_CONVERSION_AS_PERCENT = ConvertAbilityBooleanLevelField('Udp3')
ABILITY_BLF_LIFE_CONVERSION_AS_PERCENT = ConvertAbilityBooleanLevelField('Udp4')
ABILITY_BLF_LEAVE_TARGET_ALIVE = ConvertAbilityBooleanLevelField('Udp5')
ABILITY_BLF_PERCENT_BONUS_UAU3 = ConvertAbilityBooleanLevelField('Uau3')
ABILITY_BLF_DAMAGE_IS_PERCENT_RECEIVED = ConvertAbilityBooleanLevelField('Eah2')
ABILITY_BLF_MELEE_BONUS = ConvertAbilityBooleanLevelField('Ear2')
ABILITY_BLF_RANGED_BONUS = ConvertAbilityBooleanLevelField('Ear3')
ABILITY_BLF_FLAT_BONUS = ConvertAbilityBooleanLevelField('Ear4')
ABILITY_BLF_NEVER_MISS_HBH5 = ConvertAbilityBooleanLevelField('Hbh5')
ABILITY_BLF_PERCENT_BONUS_HAD2 = ConvertAbilityBooleanLevelField('Had2')
ABILITY_BLF_CAN_DEACTIVATE = ConvertAbilityBooleanLevelField('Hds1')
ABILITY_BLF_RAISED_UNITS_ARE_INVULNERABLE = ConvertAbilityBooleanLevelField('Hre2')
ABILITY_BLF_PERCENTAGE_OAR2 = ConvertAbilityBooleanLevelField('Oar2')
ABILITY_BLF_SUMMON_BUSY_UNITS = ConvertAbilityBooleanLevelField('Btl2')
ABILITY_BLF_CREATES_BLIGHT = ConvertAbilityBooleanLevelField('Bli2')
ABILITY_BLF_EXPLODES_ON_DEATH = ConvertAbilityBooleanLevelField('Sds6')
ABILITY_BLF_ALWAYS_AUTOCAST_FAE2 = ConvertAbilityBooleanLevelField('Fae2')
ABILITY_BLF_REGENERATE_ONLY_AT_NIGHT = ConvertAbilityBooleanLevelField('Mbt5')
ABILITY_BLF_SHOW_SELECT_UNIT_BUTTON = ConvertAbilityBooleanLevelField('Neu3')
ABILITY_BLF_SHOW_UNIT_INDICATOR = ConvertAbilityBooleanLevelField('Neu4')
ABILITY_BLF_CHARGE_OWNING_PLAYER = ConvertAbilityBooleanLevelField('Ans6')
ABILITY_BLF_PERCENTAGE_ARM2 = ConvertAbilityBooleanLevelField('Arm2')
ABILITY_BLF_TARGET_IS_INVULNERABLE = ConvertAbilityBooleanLevelField('Pos3')
ABILITY_BLF_TARGET_IS_MAGIC_IMMUNE = ConvertAbilityBooleanLevelField('Pos4')
ABILITY_BLF_KILL_ON_CASTER_DEATH = ConvertAbilityBooleanLevelField('Ucb6')
ABILITY_BLF_NO_TARGET_REQUIRED_REJ4 = ConvertAbilityBooleanLevelField('Rej4')
ABILITY_BLF_ACCEPTS_GOLD = ConvertAbilityBooleanLevelField('Rtn1')
ABILITY_BLF_ACCEPTS_LUMBER = ConvertAbilityBooleanLevelField('Rtn2')
ABILITY_BLF_PREFER_HOSTILES_ROA5 = ConvertAbilityBooleanLevelField('Roa5')
ABILITY_BLF_PREFER_FRIENDLIES_ROA6 = ConvertAbilityBooleanLevelField('Roa6')
ABILITY_BLF_ROOTED_TURNING = ConvertAbilityBooleanLevelField('Roo3')
ABILITY_BLF_ALWAYS_AUTOCAST_SLO3 = ConvertAbilityBooleanLevelField('Slo3')
ABILITY_BLF_HIDE_BUTTON = ConvertAbilityBooleanLevelField('Ihid')
ABILITY_BLF_USE_TELEPORT_CLUSTERING_ITP2 = ConvertAbilityBooleanLevelField('Itp2')
ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS = ConvertAbilityBooleanLevelField('Eth1')
ABILITY_BLF_DOES_NOT_BLOCK_BUILDINGS = ConvertAbilityBooleanLevelField('Eth2')
ABILITY_BLF_AUTO_ACQUIRE_ATTACK_TARGETS = ConvertAbilityBooleanLevelField('Gho1')
ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS_GHO2 = ConvertAbilityBooleanLevelField('Gho2')
ABILITY_BLF_DO_NOT_BLOCK_BUILDINGS = ConvertAbilityBooleanLevelField('Gho3')
ABILITY_BLF_INCLUDE_RANGED_DAMAGE = ConvertAbilityBooleanLevelField('Ssk4')
ABILITY_BLF_INCLUDE_MELEE_DAMAGE = ConvertAbilityBooleanLevelField('Ssk5')
ABILITY_BLF_MOVE_TO_PARTNER = ConvertAbilityBooleanLevelField('coa2')
ABILITY_BLF_CAN_BE_DISPELLED = ConvertAbilityBooleanLevelField('cyc1')
ABILITY_BLF_IGNORE_FRIENDLY_BUFFS = ConvertAbilityBooleanLevelField('dvm6')
ABILITY_BLF_DROP_ITEMS_ON_DEATH = ConvertAbilityBooleanLevelField('inv2')
ABILITY_BLF_CAN_USE_ITEMS = ConvertAbilityBooleanLevelField('inv3')
ABILITY_BLF_CAN_GET_ITEMS = ConvertAbilityBooleanLevelField('inv4')
ABILITY_BLF_CAN_DROP_ITEMS = ConvertAbilityBooleanLevelField('inv5')
ABILITY_BLF_REPAIRS_ALLOWED = ConvertAbilityBooleanLevelField('liq4')
ABILITY_BLF_CASTER_ONLY_SPLASH = ConvertAbilityBooleanLevelField('mfl6')
ABILITY_BLF_NO_TARGET_REQUIRED_IRL4 = ConvertAbilityBooleanLevelField('irl4')
ABILITY_BLF_DISPEL_ON_ATTACK = ConvertAbilityBooleanLevelField('irl5')
ABILITY_BLF_AMOUNT_IS_RAW_VALUE = ConvertAbilityBooleanLevelField('ipv3')
ABILITY_BLF_SHARED_SPELL_COOLDOWN = ConvertAbilityBooleanLevelField('spb2')
ABILITY_BLF_SLEEP_ONCE = ConvertAbilityBooleanLevelField('sla1')
ABILITY_BLF_ALLOW_ON_ANY_PLAYER_SLOT = ConvertAbilityBooleanLevelField('sla2')
ABILITY_BLF_DISABLE_OTHER_ABILITIES = ConvertAbilityBooleanLevelField('Ncl5')
ABILITY_BLF_ALLOW_BOUNTY = ConvertAbilityBooleanLevelField('Ntm4')
ABILITY_SLF_CASTER = ConvertAbilityStringLevelField('acat')
ABILITY_SLF_TARGET = ConvertAbilityStringLevelField('atat')
ABILITY_SLF_SPECIAL = ConvertAbilityStringLevelField('asat')
ABILITY_SLF_EFFECT = ConvertAbilityStringLevelField('aeat')
ABILITY_SLF_AREA_EFFECT = ConvertAbilityStringLevelField('aaea')
ABILITY_SLF_LIGHTNING_EFFECTS = ConvertAbilityStringLevelField('alig')
ABILITY_SLF_MISSILE_ART = ConvertAbilityStringLevelField('amat')
ABILITY_SLF_TOOLTIP_LEARN = ConvertAbilityStringLevelField('aret')
ABILITY_SLF_TOOLTIP_LEARN_EXTENDED = ConvertAbilityStringLevelField('arut')
ABILITY_SLF_TOOLTIP_NORMAL = ConvertAbilityStringLevelField('atp1')
ABILITY_SLF_TOOLTIP_TURN_OFF = ConvertAbilityStringLevelField('aut1')
ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED = ConvertAbilityStringLevelField('aub1')
ABILITY_SLF_TOOLTIP_TURN_OFF_EXTENDED = ConvertAbilityStringLevelField('auu1')
ABILITY_SLF_NORMAL_FORM_UNIT_EME1 = ConvertAbilityStringLevelField('Eme1')
ABILITY_SLF_SPAWNED_UNITS = ConvertAbilityStringLevelField('Ndp1')
ABILITY_SLF_ABILITY_FOR_UNIT_CREATION = ConvertAbilityStringLevelField('Nrc1')
ABILITY_SLF_NORMAL_FORM_UNIT_MIL1 = ConvertAbilityStringLevelField('Mil1')
ABILITY_SLF_ALTERNATE_FORM_UNIT_MIL2 = ConvertAbilityStringLevelField('Mil2')
ABILITY_SLF_BASE_ORDER_ID_ANS5 = ConvertAbilityStringLevelField('Ans5')
ABILITY_SLF_MORPH_UNITS_GROUND = ConvertAbilityStringLevelField('Ply2')
ABILITY_SLF_MORPH_UNITS_AIR = ConvertAbilityStringLevelField('Ply3')
ABILITY_SLF_MORPH_UNITS_AMPHIBIOUS = ConvertAbilityStringLevelField('Ply4')
ABILITY_SLF_MORPH_UNITS_WATER = ConvertAbilityStringLevelField('Ply5')
ABILITY_SLF_UNIT_TYPE_ONE = ConvertAbilityStringLevelField('Rai3')
ABILITY_SLF_UNIT_TYPE_TWO = ConvertAbilityStringLevelField('Rai4')
ABILITY_SLF_UNIT_TYPE_SOD2 = ConvertAbilityStringLevelField('Sod2')
ABILITY_SLF_SUMMON_1_UNIT_TYPE = ConvertAbilityStringLevelField('Ist1')
ABILITY_SLF_SUMMON_2_UNIT_TYPE = ConvertAbilityStringLevelField('Ist2')
ABILITY_SLF_RACE_TO_CONVERT = ConvertAbilityStringLevelField('Ndc1')
ABILITY_SLF_PARTNER_UNIT_TYPE = ConvertAbilityStringLevelField('coa1')
ABILITY_SLF_PARTNER_UNIT_TYPE_ONE = ConvertAbilityStringLevelField('dcp1')
ABILITY_SLF_PARTNER_UNIT_TYPE_TWO = ConvertAbilityStringLevelField('dcp2')
ABILITY_SLF_REQUIRED_UNIT_TYPE = ConvertAbilityStringLevelField('tpi1')
ABILITY_SLF_CONVERTED_UNIT_TYPE = ConvertAbilityStringLevelField('tpi2')
ABILITY_SLF_SPELL_LIST = ConvertAbilityStringLevelField('spb1')
ABILITY_SLF_BASE_ORDER_ID_SPB5 = ConvertAbilityStringLevelField('spb5')
ABILITY_SLF_BASE_ORDER_ID_NCL6 = ConvertAbilityStringLevelField('Ncl6')
ABILITY_SLF_ABILITY_UPGRADE_1 = ConvertAbilityStringLevelField('Neg3')
ABILITY_SLF_ABILITY_UPGRADE_2 = ConvertAbilityStringLevelField('Neg4')
ABILITY_SLF_ABILITY_UPGRADE_3 = ConvertAbilityStringLevelField('Neg5')
ABILITY_SLF_ABILITY_UPGRADE_4 = ConvertAbilityStringLevelField('Neg6')
ABILITY_SLF_SPAWN_UNIT_ID_NSY2 = ConvertAbilityStringLevelField('Nsy2')
ITEM_IF_LEVEL = ConvertItemIntegerField('ilev')
ITEM_IF_NUMBER_OF_CHARGES = ConvertItemIntegerField('iuse')
ITEM_IF_COOLDOWN_GROUP = ConvertItemIntegerField('icid')
ITEM_IF_MAX_HIT_POINTS = ConvertItemIntegerField('ihtp')
ITEM_IF_HIT_POINTS = ConvertItemIntegerField('ihpc')
ITEM_IF_PRIORITY = ConvertItemIntegerField('ipri')
ITEM_IF_ARMOR_TYPE = ConvertItemIntegerField('iarm')
ITEM_IF_TINTING_COLOR_RED = ConvertItemIntegerField('iclr')
ITEM_IF_TINTING_COLOR_GREEN = ConvertItemIntegerField('iclg')
ITEM_IF_TINTING_COLOR_BLUE = ConvertItemIntegerField('iclb')
ITEM_IF_TINTING_COLOR_ALPHA = ConvertItemIntegerField('ical')
ITEM_BF_CAN_BE_DROPPED = ConvertItemBooleanField('idro')
ITEM_BF_PERISHABLE = ConvertItemBooleanField('iper')
ITEM_BF_INCLUDE_AS_RANDOM_CHOICE = ConvertItemBooleanField('iprn')
ITEM_BF_USE_AUTOMATICALLY_WHEN_ACQUIRED = ConvertItemBooleanField('ipow')
ITEM_BF_CAN_BE_SOLD_TO_MERCHANTS = ConvertItemBooleanField('ipaw')
ITEM_BF_ACTIVELY_USED = ConvertItemBooleanField('iusa')
UNIT_IF_DEFENSE_TYPE = ConvertUnitIntegerField('udty')
UNIT_IF_ARMOR_TYPE = ConvertUnitIntegerField('uarm')
UNIT_IF_LOOPING_FADE_IN_RATE = ConvertUnitIntegerField('ulfi')
UNIT_IF_LOOPING_FADE_OUT_RATE = ConvertUnitIntegerField('ulfo')
UNIT_IF_AGILITY = ConvertUnitIntegerField('uagc')
UNIT_IF_INTELLIGENCE = ConvertUnitIntegerField('uinc')
UNIT_IF_STRENGTH = ConvertUnitIntegerField('ustc')
UNIT_IF_AGILITY_PERMANENT = ConvertUnitIntegerField('uagm')
UNIT_IF_INTELLIGENCE_PERMANENT = ConvertUnitIntegerField('uinm')
UNIT_IF_STRENGTH_PERMANENT = ConvertUnitIntegerField('ustm')
UNIT_IF_AGILITY_WITH_BONUS = ConvertUnitIntegerField('uagb')
UNIT_IF_INTELLIGENCE_WITH_BONUS = ConvertUnitIntegerField('uinb')
UNIT_IF_STRENGTH_WITH_BONUS = ConvertUnitIntegerField('ustb')
UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE = ConvertUnitIntegerField('ubdi')
UNIT_IF_GOLD_BOUNTY_AWARDED_BASE = ConvertUnitIntegerField('ubba')
UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE = ConvertUnitIntegerField('ubsi')
UNIT_IF_LUMBER_BOUNTY_AWARDED_NUMBER_OF_DICE = ConvertUnitIntegerField('ulbd')
UNIT_IF_LUMBER_BOUNTY_AWARDED_BASE = ConvertUnitIntegerField('ulba')
UNIT_IF_LUMBER_BOUNTY_AWARDED_SIDES_PER_DIE = ConvertUnitIntegerField('ulbs')
UNIT_IF_LEVEL = ConvertUnitIntegerField('ulev')
UNIT_IF_FORMATION_RANK = ConvertUnitIntegerField('ufor')
UNIT_IF_ORIENTATION_INTERPOLATION = ConvertUnitIntegerField('uori')
UNIT_IF_ELEVATION_SAMPLE_POINTS = ConvertUnitIntegerField('uept')
UNIT_IF_TINTING_COLOR_RED = ConvertUnitIntegerField('uclr')
UNIT_IF_TINTING_COLOR_GREEN = ConvertUnitIntegerField('uclg')
UNIT_IF_TINTING_COLOR_BLUE = ConvertUnitIntegerField('uclb')
UNIT_IF_TINTING_COLOR_ALPHA = ConvertUnitIntegerField('ucal')
UNIT_IF_MOVE_TYPE = ConvertUnitIntegerField('umvt')
UNIT_IF_TARGETED_AS = ConvertUnitIntegerField('utar')
UNIT_IF_UNIT_CLASSIFICATION = ConvertUnitIntegerField('utyp')
UNIT_IF_HIT_POINTS_REGENERATION_TYPE = ConvertUnitIntegerField('uhrt')
UNIT_IF_PLACEMENT_PREVENTED_BY = ConvertUnitIntegerField('upar')
UNIT_IF_PRIMARY_ATTRIBUTE = ConvertUnitIntegerField('upra')
UNIT_RF_AGILITY_PER_LEVEL = ConvertUnitRealField('uagp')
UNIT_RF_INTELLIGENCE_PER_LEVEL = ConvertUnitRealField('uinp')
UNIT_RF_HIT_POINTS_REGENERATION_RATE = ConvertUnitRealField('uhpr')
UNIT_RF_MANA_REGENERATION = ConvertUnitRealField('umpr')
UNIT_RF_DEATH_TIME = ConvertUnitRealField('udtm')
UNIT_RF_FLY_HEIGHT = ConvertUnitRealField('ufyh')
UNIT_RF_TURN_RATE = ConvertUnitRealField('umvr')
UNIT_RF_ELEVATION_SAMPLE_RADIUS = ConvertUnitRealField('uerd')
UNIT_RF_FOG_OF_WAR_SAMPLE_RADIUS = ConvertUnitRealField('ufrd')
UNIT_RF_MAXIMUM_PITCH_ANGLE_DEGREES = ConvertUnitRealField('umxp')
UNIT_RF_MAXIMUM_ROLL_ANGLE_DEGREES = ConvertUnitRealField('umxr')
UNIT_RF_SCALING_VALUE = ConvertUnitRealField('usca')
UNIT_RF_ANIMATION_RUN_SPEED = ConvertUnitRealField('urun')
UNIT_RF_SELECTION_SCALE = ConvertUnitRealField('ussc')
UNIT_RF_SELECTION_CIRCLE_HEIGHT = ConvertUnitRealField('uslz')
UNIT_RF_SHADOW_IMAGE_HEIGHT = ConvertUnitRealField('ushh')
UNIT_RF_SHADOW_IMAGE_WIDTH = ConvertUnitRealField('ushw')
UNIT_RF_SHADOW_IMAGE_CENTER_X = ConvertUnitRealField('ushx')
UNIT_RF_SHADOW_IMAGE_CENTER_Y = ConvertUnitRealField('ushy')
UNIT_RF_ANIMATION_WALK_SPEED = ConvertUnitRealField('uwal')
UNIT_RF_DEFENSE = ConvertUnitRealField('udfc')
UNIT_RF_SIGHT_RADIUS = ConvertUnitRealField('usir')
UNIT_RF_PRIORITY = ConvertUnitRealField('upri')
UNIT_RF_SPEED = ConvertUnitRealField('umvc')
UNIT_RF_OCCLUDER_HEIGHT = ConvertUnitRealField('uocc')
UNIT_RF_HP = ConvertUnitRealField('uhpc')
UNIT_RF_MANA = ConvertUnitRealField('umpc')
UNIT_RF_ACQUISITION_RANGE = ConvertUnitRealField('uacq')
UNIT_RF_CAST_BACK_SWING = ConvertUnitRealField('ucbs')
UNIT_RF_CAST_POINT = ConvertUnitRealField('ucpt')
UNIT_RF_MINIMUM_ATTACK_RANGE = ConvertUnitRealField('uamn')
UNIT_BF_DECAYABLE = ConvertUnitBooleanField('udec')
UNIT_BF_IS_A_BUILDING = ConvertUnitBooleanField('ubdg')
UNIT_BF_USE_EXTENDED_LINE_OF_SIGHT = ConvertUnitBooleanField('ulos')
UNIT_BF_NEUTRAL_BUILDING_SHOWS_MINIMAP_ICON = ConvertUnitBooleanField('unbm')
UNIT_BF_HERO_HIDE_HERO_INTERFACE_ICON = ConvertUnitBooleanField('uhhb')
UNIT_BF_HERO_HIDE_HERO_MINIMAP_DISPLAY = ConvertUnitBooleanField('uhhm')
UNIT_BF_HERO_HIDE_HERO_DEATH_MESSAGE = ConvertUnitBooleanField('uhhd')
UNIT_BF_HIDE_MINIMAP_DISPLAY = ConvertUnitBooleanField('uhom')
UNIT_BF_SCALE_PROJECTILES = ConvertUnitBooleanField('uscb')
UNIT_BF_SELECTION_CIRCLE_ON_WATER = ConvertUnitBooleanField('usew')
UNIT_BF_HAS_WATER_SHADOW = ConvertUnitBooleanField('ushr')
UNIT_SF_PROPER_NAMES = ConvertUnitStringField('upro')
UNIT_SF_GROUND_TEXTURE = ConvertUnitStringField('uubs')
UNIT_SF_SHADOW_IMAGE_UNIT = ConvertUnitStringField('ushu')
UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE = ConvertUnitWeaponIntegerField('ua1d')
UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE = ConvertUnitWeaponIntegerField('ua1b')
UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE = ConvertUnitWeaponIntegerField('ua1s')
UNIT_WEAPON_IF_ATTACK_MAXIMUM_NUMBER_OF_TARGETS = ConvertUnitWeaponIntegerField('utc1')
UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE = ConvertUnitWeaponIntegerField('ua1t')
UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND = ConvertUnitWeaponIntegerField('ucs1')
UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS = ConvertUnitWeaponIntegerField('ua1p')
UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED = ConvertUnitWeaponIntegerField('ua1g')
UNIT_WEAPON_RF_ATTACK_DAMAGE_POINT = ConvertUnitWeaponRealField('udp1')
UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN = ConvertUnitWeaponRealField('ua1c')
UNIT_WEAPON_RF_ATTACK_DAMAGE_LOSS_FACTOR = ConvertUnitWeaponRealField('udl1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM = ConvertUnitWeaponRealField('uhd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL = ConvertUnitWeaponRealField('uqd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_DISTANCE = ConvertUnitWeaponRealField('usd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_RADIUS = ConvertUnitWeaponRealField('usr1')
UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED = ConvertUnitWeaponRealField('ua1z')
UNIT_WEAPON_RF_ATTACK_PROJECTILE_ARC = ConvertUnitWeaponRealField('uma1')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_FULL_DAMAGE = ConvertUnitWeaponRealField('ua1f')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_MEDIUM_DAMAGE = ConvertUnitWeaponRealField('ua1h')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_SMALL_DAMAGE = ConvertUnitWeaponRealField('ua1q')
UNIT_WEAPON_RF_ATTACK_RANGE = ConvertUnitWeaponRealField('ua1r')
UNIT_WEAPON_BF_ATTACKS_ENABLED = ConvertUnitWeaponBooleanField('uaen')
UNIT_WEAPON_BF_ATTACK_PROJECTILE_HOMING_ENABLED = ConvertUnitWeaponBooleanField('umh1')
MOVE_TYPE_UNKNOWN = ConvertMoveType(0)
MOVE_TYPE_FOOT = ConvertMoveType(1)
MOVE_TYPE_FLY = ConvertMoveType(2)
MOVE_TYPE_HORSE = ConvertMoveType(4)
MOVE_TYPE_HOVER = ConvertMoveType(8)
MOVE_TYPE_FLOAT = ConvertMoveType(16)
MOVE_TYPE_AMPHIBIOUS = ConvertMoveType(32)
MOVE_TYPE_UNBUILDABLE = ConvertMoveType(64)
TARGET_FLAG_NONE = ConvertTargetFlag(1)
TARGET_FLAG_GROUND = ConvertTargetFlag(2)
TARGET_FLAG_AIR = ConvertTargetFlag(4)
TARGET_FLAG_STRUCTURE = ConvertTargetFlag(8)
TARGET_FLAG_WARD = ConvertTargetFlag(16)
TARGET_FLAG_ITEM = ConvertTargetFlag(32)
TARGET_FLAG_TREE = ConvertTargetFlag(64)
TARGET_FLAG_WALL = ConvertTargetFlag(128)
TARGET_FLAG_DEBRIS = ConvertTargetFlag(256)
TARGET_FLAG_DECORATION = ConvertTargetFlag(512)
TARGET_FLAG_BRIDGE = ConvertTargetFlag(1024)
DEFENSE_TYPE_LIGHT = ConvertDefenseType(0)
DEFENSE_TYPE_MEDIUM = ConvertDefenseType(1)
DEFENSE_TYPE_LARGE = ConvertDefenseType(2)
DEFENSE_TYPE_FORT = ConvertDefenseType(3)
DEFENSE_TYPE_NORMAL = ConvertDefenseType(4)
DEFENSE_TYPE_HERO = ConvertDefenseType(5)
DEFENSE_TYPE_DIVINE = ConvertDefenseType(6)
DEFENSE_TYPE_NONE = ConvertDefenseType(7)
HERO_ATTRIBUTE_STR = ConvertHeroAttribute(1)
HERO_ATTRIBUTE_INT = ConvertHeroAttribute(2)
HERO_ATTRIBUTE_AGI = ConvertHeroAttribute(3)
ARMOR_TYPE_WHOKNOWS = ConvertArmorType(0)
ARMOR_TYPE_FLESH = ConvertArmorType(1)
ARMOR_TYPE_METAL = ConvertArmorType(2)
ARMOR_TYPE_WOOD = ConvertArmorType(3)
ARMOR_TYPE_ETHREAL = ConvertArmorType(4)
ARMOR_TYPE_STONE = ConvertArmorType(5)
REGENERATION_TYPE_NONE = ConvertRegenType(0)
REGENERATION_TYPE_ALWAYS = ConvertRegenType(1)
REGENERATION_TYPE_BLIGHT = ConvertRegenType(2)
REGENERATION_TYPE_DAY = ConvertRegenType(3)
REGENERATION_TYPE_NIGHT = ConvertRegenType(4)
UNIT_CATEGORY_GIANT = ConvertUnitCategory(1)
UNIT_CATEGORY_UNDEAD = ConvertUnitCategory(2)
UNIT_CATEGORY_SUMMONED = ConvertUnitCategory(4)
UNIT_CATEGORY_MECHANICAL = ConvertUnitCategory(8)
UNIT_CATEGORY_PEON = ConvertUnitCategory(16)
UNIT_CATEGORY_SAPPER = ConvertUnitCategory(32)
UNIT_CATEGORY_TOWNHALL = ConvertUnitCategory(64)
UNIT_CATEGORY_ANCIENT = ConvertUnitCategory(128)
UNIT_CATEGORY_NEUTRAL = ConvertUnitCategory(256)
UNIT_CATEGORY_WARD = ConvertUnitCategory(512)
UNIT_CATEGORY_STANDON = ConvertUnitCategory(1024)
UNIT_CATEGORY_TAUREN = ConvertUnitCategory(2048)
PATHING_FLAG_UNWALKABLE = ConvertPathingFlag(2)
PATHING_FLAG_UNFLYABLE = ConvertPathingFlag(4)
PATHING_FLAG_UNBUILDABLE = ConvertPathingFlag(8)
PATHING_FLAG_UNPEONHARVEST = ConvertPathingFlag(16)
PATHING_FLAG_BLIGHTED = ConvertPathingFlag(32)
PATHING_FLAG_UNFLOATABLE = ConvertPathingFlag(64)
PATHING_FLAG_UNAMPHIBIOUS = ConvertPathingFlag(128)
PATHING_FLAG_UNITEMPLACABLE = ConvertPathingFlag(256)
-- MathAPI
function Deg2Rad(r_degrees) return real end
function Rad2Deg(r_radians) return real end
function Cos(r_radians) return real end
function Tan(r_radians) return real end
function Asin(r_y) return real end
function Acos(r_x) return real end
function Atan2(r_y, r_x) return real end
function SquareRoot(r_x) return real end
-- y == 0.0 => 1
-- x ==0.0 and y < 0 => 0
--
function Pow(r_x, r_power) return real end
-- String Utility API
function I2R(int_i) return real end
function R2I(r_r) return integer end
function I2S(int_i) return string end
function R2S(r_r) return string end
function R2SW(r_r, int_width, int_precision) return string end
function S2I(str_s) return integer end
function S2R(str_s) return real end
function GetHandleId(handle_h) return integer end
function SubString(str_source, int_start, int_end) return string end
function StringLength(str_s) return integer end
function StringCase(str_source, b_upper) return string end
function StringHash(str_s) return integer end
function GetLocalizedHotkey(str_source) return integer end
-- Map Setup API
--
-- These are native functions for describing the map configuration
-- these funcs should only be used in the "config" function of
-- a map script. The functions should also be called in this order
-- ( i.e. call SetPlayers before SetPlayerColor...
--
function SetMapDescription(str_description) end
function SetPlayers(int_playercount) end
function DefineStartLocationLoc(int_whichStartLoc, location_whichLocation) end
function SetStartLocPrioCount(int_whichStartLoc, int_prioSlotCount) end
function SetStartLocPrio(int_whichStartLoc, int_prioSlotIndex, int_otherStartLocIndex, startlocprio_priority) end
function GetStartLocPrioSlot(int_whichStartLoc, int_prioSlotIndex) return integer end
function GetStartLocPrio(int_whichStartLoc, int_prioSlotIndex) return startlocprio end
function SetMapFlag(mapflag_whichMapFlag, b_value) end
function SetGamePlacement(placement_whichPlacementType) end
function SetGameSpeed(gamespeed_whichspeed) end
function SetGameDifficulty(gamedifficulty_whichdifficulty) end
function SetResourceDensity(mapdensity_whichdensity) end
function SetCreatureDensity(mapdensity_whichdensity) end
function GetPlayers() return integer end
function GetGameTypeSelected() return gametype end
function IsMapFlagSet(mapflag_whichMapFlag) return boolean end
function GetGameSpeed() return gamespeed end
function GetGameDifficulty() return gamedifficulty end
function GetResourceDensity() return mapdensity end
function GetCreatureDensity() return mapdensity end
function GetStartLocationX(int_whichStartLocation) return real end
function GetStartLocationY(int_whichStartLocation) return real end
function GetStartLocationLoc(int_whichStartLocation) return location end
function SetPlayerStartLocation(player_whichPlayer, int_startLocIndex) end
-- forces player to have the specified start loc and marks the start loc as occupied
-- which removes it from consideration for subsequently placed players
-- ( i.e. you can use this to put people in a fixed loc and then
-- use random placement for any unplaced players etc )
function ForcePlayerStartLocation(player_whichPlayer, int_startLocIndex) end
function SetPlayerColor(player_whichPlayer, playercolor_color) end
function SetPlayerAlliance(player_sourcePlayer, player_otherPlayer, alliancetype_whichAllianceSetting, b_value) end
function SetPlayerTaxRate(player_sourcePlayer, player_otherPlayer, playerstate_whichResource, int_rate) end
function SetPlayerRacePreference(player_whichPlayer, racepreference_whichRacePreference) end
function SetPlayerRaceSelectable(player_whichPlayer, b_value) end
function SetPlayerController(player_whichPlayer, mapcontrol_controlType) end
function SetPlayerName(player_whichPlayer, str_name) end
function GetPlayerStartLocation(player_whichPlayer) return integer end
function GetPlayerColor(player_whichPlayer) return playercolor end
function GetPlayerSelectable(player_whichPlayer) return boolean end
function GetPlayerController(player_whichPlayer) return mapcontrol end
function GetPlayerSlotState(player_whichPlayer) return playerslotstate end
function GetPlayerTaxRate(player_sourcePlayer, player_otherPlayer, playerstate_whichResource) return integer end
function IsPlayerRacePrefSet(player_whichPlayer, racepreference_pref) return boolean end
function GetPlayerName(player_whichPlayer) return string end
-- Timer API
--
function CreateTimer() return timer end
function DestroyTimer(timer_whichTimer) end
function TimerStart(timer_whichTimer, r_timeout, b_periodic, code_handlerFunc) end
function TimerGetElapsed(timer_whichTimer) return real end
function TimerGetRemaining(timer_whichTimer) return real end
function TimerGetTimeout(timer_whichTimer) return real end
function PauseTimer(timer_whichTimer) end
function ResumeTimer(timer_whichTimer) end
function GetExpiredTimer() return timer end
-- Group API
--
function CreateGroup() return group end
function DestroyGroup(group_whichGroup) end
function GroupAddUnit(group_whichGroup, unit_whichUnit) return boolean end
function GroupRemoveUnit(group_whichGroup, unit_whichUnit) return boolean end
function BlzGroupAddGroupFast(group_whichGroup, group_addGroup) return integer end
function BlzGroupRemoveGroupFast(group_whichGroup, group_removeGroup) return integer end
function GroupClear(group_whichGroup) end
function BlzGroupGetSize(group_whichGroup) return integer end
function BlzGroupUnitAt(group_whichGroup, int_index) return unit end
function GroupEnumUnitsOfType(group_whichGroup, str_unitname, boolexpr_filter) end
function GroupEnumUnitsOfPlayer(group_whichGroup, player_whichPlayer, boolexpr_filter) end
function GroupEnumUnitsOfTypeCounted(group_whichGroup, str_unitname, boolexpr_filter, int_countLimit) end
function GroupEnumUnitsInRect(group_whichGroup, rect_r, boolexpr_filter) end
function GroupEnumUnitsInRectCounted(group_whichGroup, rect_r, boolexpr_filter, int_countLimit) end
function GroupEnumUnitsInRange(group_whichGroup, r_x, r_y, r_radius, boolexpr_filter) end
function GroupEnumUnitsInRangeOfLoc(group_whichGroup, location_whichLocation, r_radius, boolexpr_filter) end
function GroupEnumUnitsInRangeCounted(group_whichGroup, r_x, r_y, r_radius, boolexpr_filter, int_countLimit) end
function GroupEnumUnitsInRangeOfLocCounted(group_whichGroup, location_whichLocation, r_radius, boolexpr_filter, int_countLimit) end
function GroupEnumUnitsSelected(group_whichGroup, player_whichPlayer, boolexpr_filter) end
function GroupImmediateOrderById(group_whichGroup, int_order) return boolean end
function GroupPointOrder(group_whichGroup, str_order, r_x, r_y) return boolean end
function GroupPointOrderLoc(group_whichGroup, str_order, location_whichLocation) return boolean end
function GroupPointOrderById(group_whichGroup, int_order, r_x, r_y) return boolean end
function GroupPointOrderByIdLoc(group_whichGroup, int_order, location_whichLocation) return boolean end
function GroupTargetOrder(group_whichGroup, str_order, widget_targetWidget) return boolean end
function GroupTargetOrderById(group_whichGroup, int_order, widget_targetWidget) return boolean end
-- as it would involve enumerating all the cells that are covered by a particularregion
-- a better implementation would be a trigger that adds relevant units as they enter
-- and removes them if they leave...
function ForGroup(group_whichGroup, code_callback) end
function FirstOfGroup(group_whichGroup) return unit end
-- Force API
--
function CreateForce() return force end
function DestroyForce(force_whichForce) end
function ForceAddPlayer(force_whichForce, player_whichPlayer) end
function ForceRemovePlayer(force_whichForce, player_whichPlayer) end
function BlzForceHasPlayer(force_whichForce, player_whichPlayer) return boolean end
function ForceClear(force_whichForce) end
function ForceEnumPlayers(force_whichForce, boolexpr_filter) end
function ForceEnumPlayersCounted(force_whichForce, boolexpr_filter, int_countLimit) end
function ForceEnumAllies(force_whichForce, player_whichPlayer, boolexpr_filter) end
function ForceEnumEnemies(force_whichForce, player_whichPlayer, boolexpr_filter) end
function ForForce(force_whichForce, code_callback) end
-- Region and Location API
--
function Rect(r_minx, r_miny, r_maxx, r_maxy) return rect end
function RectFromLoc(location_min, location_max) return rect end
function RemoveRect(rect_whichRect) end
function SetRect(rect_whichRect, r_minx, r_miny, r_maxx, r_maxy) end
function SetRectFromLoc(rect_whichRect, location_min, location_max) end
function MoveRectTo(rect_whichRect, r_newCenterX, r_newCenterY) end
function MoveRectToLoc(rect_whichRect, location_newCenterLoc) end
function GetRectCenterY(rect_whichRect) return real end
function GetRectMinX(rect_whichRect) return real end
function GetRectMinY(rect_whichRect) return real end
function GetRectMaxX(rect_whichRect) return real end
function GetRectMaxY(rect_whichRect) return real end
function RemoveRegion(region_whichRegion) end
function RegionClearRect(region_whichRegion, rect_r) end
function RegionAddCellAtLoc(region_whichRegion, location_whichLocation) end
function RegionClearCell(region_whichRegion, r_x, r_y) end
function RegionClearCellAtLoc(region_whichRegion, location_whichLocation) end
function RemoveLocation(location_whichLocation) end
function MoveLocation(location_whichLocation, r_newX, r_newY) end
function GetLocationX(location_whichLocation) return real end
function GetLocationY(location_whichLocation) return real end
-- If you attempt to use it in a synchronous manner, it may cause a desync.
function GetLocationZ(location_whichLocation) return real end
function IsPointInRegion(region_whichRegion, r_x, r_y) return boolean end
function IsLocationInRegion(region_whichRegion, location_whichLocation) return boolean end
function GetWorldBounds() return rect end
-- Native trigger interface
--
function CreateTrigger() return trigger end
function DestroyTrigger(trigger_whichTrigger) end
function ResetTrigger(trigger_whichTrigger) end
function EnableTrigger(trigger_whichTrigger) end
function DisableTrigger(trigger_whichTrigger) end
function IsTriggerEnabled(trigger_whichTrigger) return boolean end
function IsTriggerWaitOnSleeps(trigger_whichTrigger) return boolean end
function GetEnumUnit() return unit end
function GetEnumDestructable() return destructable end
function GetEnumItem() return item end
function GetEnumPlayer() return player end
function GetTriggerEventId() return eventid end
function GetTriggerEvalCount(trigger_whichTrigger) return integer end
function GetTriggerExecCount(trigger_whichTrigger) return integer end
-- Boolean Expr API ( for compositing trigger conditions and unit filter funcs...)
--============================================================================
function And(boolexpr_operandA, boolexpr_operandB) return boolexpr end
function Or(boolexpr_operandA, boolexpr_operandB) return boolexpr end
function Not(boolexpr_operand) return boolexpr end
function Condition(code_func) return conditionfunc end
function DestroyCondition(conditionfunc_c) end
function Filter(code_func) return filterfunc end
function DestroyFilter(filterfunc_f) end
function DestroyBoolExpr(boolexpr_e) end
-- Trigger Game Event API
--============================================================================
--constant native string GetTriggeringVariableName takes  returns string
function TriggerRegisterTimerEvent(trigger_whichTrigger, r_timeout, b_periodic) return event end
function TriggerRegisterTimerExpireEvent(trigger_whichTrigger, timer_t) return event end
function TriggerRegisterDialogButtonEvent(trigger_whichTrigger, button_whichButton) return event end
function GetEventGameState() return gamestate end
function GetWinningPlayer() return player end
function GetTriggeringRegion() return region end
function GetEnteringUnit() return unit end
function GetLeavingUnit() return unit end
function TriggerRegisterTrackableTrackEvent(trigger_whichTrigger, trackable_t) return event end
-- EVENT_GAME_TRACKABLE_TRACK
function GetTriggeringTrackable() return trackable end
function GetClickedButton() return button end
function GetClickedDialog() return dialog end
function GetTournamentFinishSoonTimeRemaining() return real end
function GetTournamentFinishNowRule() return integer end
function GetTournamentFinishNowPlayer() return player end
function GetTournamentScore(player_whichPlayer) return integer end
function GetSaveBasicFilename() return string end
-- Trigger Player Based Event API
--============================================================================
-- EVENT_PLAYER_VICTORY
function GetTriggerPlayer() return player end
-- EVENT_UNIT_HERO_LEVEL
function GetLevelingUnit() return unit end
-- EVENT_UNIT_HERO_SKILL
function GetLearningUnit() return unit end
function GetLearnedSkill() return integer end
function GetLearnedSkillLevel() return integer end
function GetRevivableUnit() return unit end
-- EVENT_PLAYER_HERO_REVIVE_CANCEL
-- EVENT_PLAYER_HERO_REVIVE_FINISH
-- EVENT_UNIT_HERO_REVIVE_START
-- EVENT_UNIT_HERO_REVIVE_CANCEL
-- EVENT_UNIT_HERO_REVIVE_FINISH
function GetRevivingUnit() return unit end
function GetAttacker() return unit end
function GetRescuer() return unit end
function GetDyingUnit() return unit end
function GetKillingUnit() return unit end
function GetDecayingUnit() return unit end
--constant native GetSelectedUnit takes  returns unit
function GetConstructingStructure() return unit end
-- EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL
function GetCancelledStructure() return unit end
function GetConstructedStructure() return unit end
-- EVENT_PLAYER_UNIT_RESEARCH_CANCEL
-- EVENT_PLAYER_UNIT_RESEARCH_FINISH
function GetResearchingUnit() return unit end
function GetResearched() return integer end
-- EVENT_PLAYER_UNIT_TRAIN_CANCEL
function GetTrainedUnitType() return integer end
function GetTrainedUnit() return unit end
function GetDetectedUnit() return unit end
function GetSummoningUnit() return unit end
function GetSummonedUnit() return unit end
function GetTransportUnit() return unit end
function GetLoadedUnit() return unit end
function GetSellingUnit() return unit end
function GetSoldUnit() return unit end
function GetBuyingUnit() return unit end
function GetSoldItem() return item end
function GetChangingUnit() return unit end
function GetChangingUnitPrevOwner() return player end
-- EVENT_PLAYER_UNIT_PICKUP_ITEM
-- EVENT_PLAYER_UNIT_USE_ITEM
function GetManipulatingUnit() return unit end
function GetManipulatedItem() return item end
function GetOrderedUnit() return unit end
function GetIssuedOrderId() return integer end
function GetOrderPointX() return real end
function GetOrderPointY() return real end
function GetOrderPointLoc() return location end
function GetOrderTarget() return widget end
function GetOrderTargetDestructable() return destructable end
function GetOrderTargetItem() return item end
function GetOrderTargetUnit() return unit end
-- EVENT_UNIT_SPELL_CAST
-- EVENT_UNIT_SPELL_EFFECT
-- EVENT_UNIT_SPELL_FINISH
-- EVENT_UNIT_SPELL_ENDCAST
-- EVENT_PLAYER_UNIT_SPELL_CHANNEL
-- EVENT_PLAYER_UNIT_SPELL_CAST
-- EVENT_PLAYER_UNIT_SPELL_EFFECT
-- EVENT_PLAYER_UNIT_SPELL_FINISH
-- EVENT_PLAYER_UNIT_SPELL_ENDCAST
function GetSpellAbilityUnit() return unit end
function GetSpellAbilityId() return integer end
function GetSpellAbility() return ability end
function GetSpellTargetLoc() return location end
function GetSpellTargetX() return real end
function GetSpellTargetY() return real end
function GetSpellTargetDestructable() return destructable end
function GetSpellTargetItem() return item end
function GetSpellTargetUnit() return unit end
function TriggerRegisterPlayerStateEvent(trigger_whichTrigger, player_whichPlayer, playerstate_whichState, limitop_opcode, r_limitval) return event end
function GetEventPlayerState() return playerstate end
-- if you required exact match )
function GetEventPlayerChatString() return string end
function GetEventPlayerChatStringMatched() return string end
-- Trigger Unit Based Event API
--============================================================================
-- within a trigger action function...returns null handle when used incorrectly
function GetEventUnitState() return unitstate end
function GetEventDamage() return real end
function GetEventDamageSource() return unit end
-- EVENT_UNIT_DECAY
-- Use the GetDyingUnit and GetDecayingUnit funcs above
function GetEventDetectingPlayer() return player end
-- EVENT_UNIT_TARGET_IN_RANGE
function GetEventTargetUnit() return unit end
-- Use GetAttacker from the Player Unit Event API Below...
-- Use GetRescuer from the Player Unit Event API Below...
-- EVENT_UNIT_CONSTRUCT_FINISH
-- EVENT_UNIT_TRAIN_CANCELLED
-- EVENT_UNIT_TRAIN_FINISH
-- EVENT_UNIT_PICKUP_ITEM
-- EVENT_UNIT_USE_ITEM
-- See the Player Unit/Item manipulation Event API above for event info funcs
-- EVENT_UNIT_ISSUED_POINT_ORDER
-- EVENT_UNIT_ISSUED_TARGET_ORDER
function TriggerRemoveCondition(trigger_whichTrigger, triggercondition_whichCondition) end
function TriggerClearConditions(trigger_whichTrigger) end
function TriggerRemoveAction(trigger_whichTrigger, triggeraction_whichAction) end
function TriggerClearActions(trigger_whichTrigger) end
function TriggerSleepAction(r_timeout) end
function TriggerWaitForSound(sound_s, r_offset) end
function TriggerEvaluate(trigger_whichTrigger) return boolean end
function TriggerExecute(trigger_whichTrigger) end
function TriggerExecuteWait(trigger_whichTrigger) end
function TriggerSyncStart() end
function TriggerSyncReady() end
-- Widget API
function GetWidgetLife(widget_whichWidget) return real end
function SetWidgetLife(widget_whichWidget, r_newLife) end
function GetWidgetX(widget_whichWidget) return real end
function GetWidgetY(widget_whichWidget) return real end
function GetTriggerWidget() return widget end
-- Destructable Object API
-- Facing arguments are specified in degrees
function CreateDestructable(int_objectid, r_x, r_y, r_face, r_scale, int_variation) return destructable end
function CreateDestructableZ(int_objectid, r_x, r_y, r_z, r_face, r_scale, int_variation) return destructable end
function CreateDeadDestructable(int_objectid, r_x, r_y, r_face, r_scale, int_variation) return destructable end
function CreateDeadDestructableZ(int_objectid, r_x, r_y, r_z, r_face, r_scale, int_variation) return destructable end
function RemoveDestructable(destructable_d) end
function KillDestructable(destructable_d) end
function SetDestructableInvulnerable(destructable_d, b_flag) end
function IsDestructableInvulnerable(destructable_d) return boolean end
function EnumDestructablesInRect(rect_r, boolexpr_filter, code_actionFunc) end
function GetDestructableTypeId(destructable_d) return integer end
function GetDestructableX(destructable_d) return real end
function GetDestructableY(destructable_d) return real end
function SetDestructableLife(destructable_d, r_life) end
function GetDestructableLife(destructable_d) return real end
function SetDestructableMaxLife(destructable_d, r_max) end
function GetDestructableMaxLife(destructable_d) return real end
function DestructableRestoreLife(destructable_d, r_life, b_birth) end
function QueueDestructableAnimation(destructable_d, str_whichAnimation) end
function SetDestructableAnimation(destructable_d, str_whichAnimation) end
function SetDestructableAnimationSpeed(destructable_d, r_speedFactor) end
function ShowDestructable(destructable_d, b_flag) end
function GetDestructableOccluderHeight(destructable_d) return real end
function SetDestructableOccluderHeight(destructable_d, r_height) end
function GetDestructableName(destructable_d) return string end
function GetTriggerDestructable() return destructable end
-- Item API
function CreateItem(int_itemid, r_x, r_y) return item end
function RemoveItem(item_whichItem) end
function GetItemPlayer(item_whichItem) return player end
function GetItemTypeId(item_i) return integer end
function GetItemX(item_i) return real end
function GetItemY(item_i) return real end
function SetItemPosition(item_i, r_x, r_y) end
function SetItemDropOnDeath(item_whichItem, b_flag) end
function SetItemDroppable(item_i, b_flag) end
function SetItemPawnable(item_i, b_flag) end
function SetItemPlayer(item_whichItem, player_whichPlayer, b_changeColor) end
function SetItemInvulnerable(item_whichItem, b_flag) end
function IsItemInvulnerable(item_whichItem) return boolean end
function SetItemVisible(item_whichItem, b_show) end
function IsItemVisible(item_whichItem) return boolean end
function IsItemOwned(item_whichItem) return boolean end
function IsItemPowerup(item_whichItem) return boolean end
function IsItemSellable(item_whichItem) return boolean end
function IsItemPawnable(item_whichItem) return boolean end
function IsItemIdPowerup(int_itemId) return boolean end
function IsItemIdSellable(int_itemId) return boolean end
function IsItemIdPawnable(int_itemId) return boolean end
function EnumItemsInRect(rect_r, boolexpr_filter, code_actionFunc) end
function GetItemLevel(item_whichItem) return integer end
function GetItemType(item_whichItem) return itemtype end
function SetItemDropID(item_whichItem, int_unitId) end
function GetItemName(item_whichItem) return string end
function GetItemCharges(item_whichItem) return integer end
function SetItemCharges(item_whichItem, int_charges) end
function GetItemUserData(item_whichItem) return integer end
function SetItemUserData(item_whichItem, int_data) end
-- Unit API
-- Facing arguments are specified in degrees
function CreateUnit(player_id, int_unitid, r_x, r_y, r_face) return unit end
function CreateUnitByName(player_whichPlayer, str_unitname, r_x, r_y, r_face) return unit end
function CreateUnitAtLoc(player_id, int_unitid, location_whichLocation, r_face) return unit end
function CreateUnitAtLocByName(player_id, str_unitname, location_whichLocation, r_face) return unit end
function CreateCorpse(player_whichPlayer, int_unitid, r_x, r_y, r_face) return unit end
function RemoveUnit(unit_whichUnit) end
function ShowUnit(unit_whichUnit, b_show) end
function SetUnitX(unit_whichUnit, r_newX) end
function SetUnitY(unit_whichUnit, r_newY) end
function SetUnitPosition(unit_whichUnit, r_newX, r_newY) end
function SetUnitPositionLoc(unit_whichUnit, location_whichLocation) end
function SetUnitFacing(unit_whichUnit, r_facingAngle) end
function SetUnitFacingTimed(unit_whichUnit, r_facingAngle, r_duration) end
function SetUnitMoveSpeed(unit_whichUnit, r_newSpeed) end
function SetUnitFlyHeight(unit_whichUnit, r_newHeight, r_rate) end
function SetUnitTurnSpeed(unit_whichUnit, r_newTurnSpeed) end
function SetUnitPropWindow(unit_whichUnit, r_newPropWindowAngle) end
function SetUnitAcquireRange(unit_whichUnit, r_newAcquireRange) end
function SetUnitCreepGuard(unit_whichUnit, b_creepGuard) end
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
-- Player API
function Player(int_number) return player end
function GetLocalPlayer() return player end
function IsPlayerAlly(player_whichPlayer, player_otherPlayer) return boolean end
function IsPlayerEnemy(player_whichPlayer, player_otherPlayer) return boolean end
function IsPlayerInForce(player_whichPlayer, force_whichForce) return boolean end
function IsPlayerObserver(player_whichPlayer) return boolean end
function IsVisibleToPlayer(r_x, r_y, player_whichPlayer) return boolean end
function IsLocationVisibleToPlayer(location_whichLocation, player_whichPlayer) return boolean end
function IsFoggedToPlayer(r_x, r_y, player_whichPlayer) return boolean end
function IsLocationFoggedToPlayer(location_whichLocation, player_whichPlayer) return boolean end
function IsMaskedToPlayer(r_x, r_y, player_whichPlayer) return boolean end
function IsLocationMaskedToPlayer(location_whichLocation, player_whichPlayer) return boolean end
function GetPlayerId(player_whichPlayer) return integer end
function GetPlayerUnitCount(player_whichPlayer, b_includeIncomplete) return integer end
function GetPlayerTypedUnitCount(player_whichPlayer, str_unitName, b_includeIncomplete, b_includeUpgrades) return integer end
function GetPlayerStructureCount(player_whichPlayer, b_includeIncomplete) return integer end
function GetPlayerState(player_whichPlayer, playerstate_whichPlayerState) return integer end
function GetPlayerScore(player_whichPlayer, playerscore_whichPlayerScore) return integer end
function GetPlayerAlliance(player_sourcePlayer, player_otherPlayer, alliancetype_whichAllianceSetting) return boolean end
function GetPlayerHandicapXP(player_whichPlayer) return real end
function SetPlayerHandicap(player_whichPlayer, r_handicap) end
function SetPlayerHandicapXP(player_whichPlayer, r_handicap) end
function GetPlayerTechMaxAllowed(player_whichPlayer, int_techid) return integer end
function AddPlayerTechResearched(player_whichPlayer, int_techid, int_levels) end
function SetPlayerTechResearched(player_whichPlayer, int_techid, int_setToLevel) end
function GetPlayerTechResearched(player_whichPlayer, int_techid, b_specificonly) return boolean end
function GetPlayerTechCount(player_whichPlayer, int_techid, b_specificonly) return integer end
function CripplePlayer(player_whichPlayer, force_toWhichPlayers, b_flag) end
function RemovePlayer(player_whichPlayer, playergameresult_gameResult) end
-- before units are moved to neutral passive in melee games
--
function CachePlayerHeroData(player_whichPlayer) end
-- Fog of War API
function SetFogStateRect(player_forWhichPlayer, fogstate_whichState, rect_where, b_useSharedVision) end
function SetFogStateRadius(player_forWhichPlayer, fogstate_whichState, r_centerx, r_centerY, r_radius, b_useSharedVision) end
function SetFogStateRadiusLoc(player_forWhichPlayer, fogstate_whichState, location_center, r_radius, b_useSharedVision) end
function FogMaskEnable(b_enable) end
function IsFogMaskEnabled() return boolean end
function FogEnable(b_enable) end
function IsFogEnabled() return boolean end
function CreateFogModifierRadius(player_forWhichPlayer, fogstate_whichState, r_centerx, r_centerY, r_radius, b_useSharedVision, b_afterUnits) return fogmodifier end
function CreateFogModifierRadiusLoc(player_forWhichPlayer, fogstate_whichState, location_center, r_radius, b_useSharedVision, b_afterUnits) return fogmodifier end
function DestroyFogModifier(fogmodifier_whichFogModifier) end
function FogModifierStart(fogmodifier_whichFogModifier) end
function FogModifierStop(fogmodifier_whichFogModifier) end
-- Game API
function VersionGet() return version end
function VersionCompatible(version_whichVersion) return boolean end
function VersionSupported(version_whichVersion) return boolean end
function ChangeLevel(str_newLevel, b_doScoreScreen) end
function RestartGame(b_doScoreScreen) end
function ReloadGame() end
-- %%% SetCampaignMenuRace is deprecated. It must remain to support
-- old maps which use it, but all new maps should use SetCampaignMenuRaceEx
function SetCampaignMenuRace(race_r) end
function SetCampaignMenuRaceEx(int_campaignIndex) end
function ForceCampaignSelectScreen() end
function SaveGame(str_saveFileName) end
function RenameSaveDirectory(str_sourceDirName, str_destDirName) return boolean end
function RemoveSaveDirectory(str_sourceDirName) return boolean end
function CopySaveGame(str_sourceSaveName, str_destSaveName) return boolean end
function SaveGameExists(str_saveName) return boolean end
function SyncSelections() end
function SetFloatGameState(fgamestate_whichFloatGameState, r_value) end
function GetFloatGameState(fgamestate_whichFloatGameState) return real end
function SetIntegerGameState(igamestate_whichIntegerGameState, int_value) end
function GetIntegerGameState(igamestate_whichIntegerGameState) return integer end
-- Campaign API
function SetTutorialCleared(b_cleared) end
function SetMissionAvailable(int_campaignNumber, int_missionNumber, b_available) end
function SetCampaignAvailable(int_campaignNumber, b_available) end
function SetOpCinematicAvailable(int_campaignNumber, b_available) end
function SetEdCinematicAvailable(int_campaignNumber, b_available) end
function GetDefaultDifficulty() return gamedifficulty end
function SetDefaultDifficulty(gamedifficulty_g) end
function SetCustomCampaignButtonVisible(int_whichButton, b_visible) end
function GetCustomCampaignButtonVisible(int_whichButton) return boolean end
function DoNotSaveReplay() end
-- Dialog API
function DialogCreate() return dialog end
function DialogDestroy(dialog_whichDialog) end
function DialogClear(dialog_whichDialog) end
function DialogSetMessage(dialog_whichDialog, str_messageText) end
function DialogAddButton(dialog_whichDialog, str_buttonText, int_hotkey) return button end
function DialogAddQuitButton(dialog_whichDialog, b_doScoreScreen, str_buttonText, int_hotkey) return button end
function DialogDisplay(player_whichPlayer, dialog_whichDialog, b_flag) end
-- in the current campaign profile dir
--
function ReloadGameCachesFromDisk() return boolean end
function SaveGameCache(gamecache_whichCache) return boolean end
function StoreReal(gamecache_cache, str_missionKey, str_key, r_value) end
function StoreBoolean(gamecache_cache, str_missionKey, str_key, b_value) end
function StoreUnit(gamecache_cache, str_missionKey, str_key, unit_whichUnit) return boolean end
function StoreString(gamecache_cache, str_missionKey, str_key, str_value) return boolean end
function SyncStoredReal(gamecache_cache, str_missionKey, str_key) end
function SyncStoredBoolean(gamecache_cache, str_missionKey, str_key) end
function SyncStoredUnit(gamecache_cache, str_missionKey, str_key) end
function SyncStoredString(gamecache_cache, str_missionKey, str_key) end
function HaveStoredReal(gamecache_cache, str_missionKey, str_key) return boolean end
function HaveStoredBoolean(gamecache_cache, str_missionKey, str_key) return boolean end
function HaveStoredUnit(gamecache_cache, str_missionKey, str_key) return boolean end
function HaveStoredString(gamecache_cache, str_missionKey, str_key) return boolean end
function FlushStoredMission(gamecache_cache, str_missionKey) end
function FlushStoredInteger(gamecache_cache, str_missionKey, str_key) end
function FlushStoredReal(gamecache_cache, str_missionKey, str_key) end
function FlushStoredBoolean(gamecache_cache, str_missionKey, str_key) end
function FlushStoredUnit(gamecache_cache, str_missionKey, str_key) end
function FlushStoredString(gamecache_cache, str_missionKey, str_key) end
function GetStoredInteger(gamecache_cache, str_missionKey, str_key) return integer end
function GetStoredReal(gamecache_cache, str_missionKey, str_key) return real end
function GetStoredBoolean(gamecache_cache, str_missionKey, str_key) return boolean end
function GetStoredString(gamecache_cache, str_missionKey, str_key) return string end
function RestoreUnit(gamecache_cache, str_missionKey, str_key, player_forWhichPlayer, r_x, r_y, r_facing) return unit end
function SaveReal(hashtable_table, int_parentKey, int_childKey, r_value) end
function SaveBoolean(hashtable_table, int_parentKey, int_childKey, b_value) end
function SaveStr(hashtable_table, int_parentKey, int_childKey, str_value) return boolean end
function SavePlayerHandle(hashtable_table, int_parentKey, int_childKey, player_whichPlayer) return boolean end
function SaveWidgetHandle(hashtable_table, int_parentKey, int_childKey, widget_whichWidget) return boolean end
function SaveDestructableHandle(hashtable_table, int_parentKey, int_childKey, destructable_whichDestructable) return boolean end
function SaveItemHandle(hashtable_table, int_parentKey, int_childKey, item_whichItem) return boolean end
function SaveUnitHandle(hashtable_table, int_parentKey, int_childKey, unit_whichUnit) return boolean end
function SaveAbilityHandle(hashtable_table, int_parentKey, int_childKey, ability_whichAbility) return boolean end
function SaveTimerHandle(hashtable_table, int_parentKey, int_childKey, timer_whichTimer) return boolean end
function SaveTriggerHandle(hashtable_table, int_parentKey, int_childKey, trigger_whichTrigger) return boolean end
function SaveTriggerConditionHandle(hashtable_table, int_parentKey, int_childKey, triggercondition_whichTriggercondition) return boolean end
function SaveTriggerActionHandle(hashtable_table, int_parentKey, int_childKey, triggeraction_whichTriggeraction) return boolean end
function SaveTriggerEventHandle(hashtable_table, int_parentKey, int_childKey, event_whichEvent) return boolean end
function SaveForceHandle(hashtable_table, int_parentKey, int_childKey, force_whichForce) return boolean end
function SaveGroupHandle(hashtable_table, int_parentKey, int_childKey, group_whichGroup) return boolean end
function SaveLocationHandle(hashtable_table, int_parentKey, int_childKey, location_whichLocation) return boolean end
function SaveRectHandle(hashtable_table, int_parentKey, int_childKey, rect_whichRect) return boolean end
function SaveBooleanExprHandle(hashtable_table, int_parentKey, int_childKey, boolexpr_whichBoolexpr) return boolean end
function SaveSoundHandle(hashtable_table, int_parentKey, int_childKey, sound_whichSound) return boolean end
function SaveEffectHandle(hashtable_table, int_parentKey, int_childKey, effect_whichEffect) return boolean end
function SaveUnitPoolHandle(hashtable_table, int_parentKey, int_childKey, unitpool_whichUnitpool) return boolean end
function SaveItemPoolHandle(hashtable_table, int_parentKey, int_childKey, itempool_whichItempool) return boolean end
function SaveQuestHandle(hashtable_table, int_parentKey, int_childKey, quest_whichQuest) return boolean end
function SaveQuestItemHandle(hashtable_table, int_parentKey, int_childKey, questitem_whichQuestitem) return boolean end
function SaveDefeatConditionHandle(hashtable_table, int_parentKey, int_childKey, defeatcondition_whichDefeatcondition) return boolean end
function SaveTimerDialogHandle(hashtable_table, int_parentKey, int_childKey, timerdialog_whichTimerdialog) return boolean end
function SaveLeaderboardHandle(hashtable_table, int_parentKey, int_childKey, leaderboard_whichLeaderboard) return boolean end
function SaveMultiboardHandle(hashtable_table, int_parentKey, int_childKey, multiboard_whichMultiboard) return boolean end
function SaveMultiboardItemHandle(hashtable_table, int_parentKey, int_childKey, multiboarditem_whichMultiboarditem) return boolean end
function SaveTrackableHandle(hashtable_table, int_parentKey, int_childKey, trackable_whichTrackable) return boolean end
function SaveDialogHandle(hashtable_table, int_parentKey, int_childKey, dialog_whichDialog) return boolean end
function SaveButtonHandle(hashtable_table, int_parentKey, int_childKey, button_whichButton) return boolean end
function SaveTextTagHandle(hashtable_table, int_parentKey, int_childKey, texttag_whichTexttag) return boolean end
function SaveLightningHandle(hashtable_table, int_parentKey, int_childKey, lightning_whichLightning) return boolean end
function SaveImageHandle(hashtable_table, int_parentKey, int_childKey, image_whichImage) return boolean end
function SaveUbersplatHandle(hashtable_table, int_parentKey, int_childKey, ubersplat_whichUbersplat) return boolean end
function SaveRegionHandle(hashtable_table, int_parentKey, int_childKey, region_whichRegion) return boolean end
function SaveFogStateHandle(hashtable_table, int_parentKey, int_childKey, fogstate_whichFogState) return boolean end
function SaveFogModifierHandle(hashtable_table, int_parentKey, int_childKey, fogmodifier_whichFogModifier) return boolean end
function SaveAgentHandle(hashtable_table, int_parentKey, int_childKey, agent_whichAgent) return boolean end
function SaveHashtableHandle(hashtable_table, int_parentKey, int_childKey, hashtable_whichHashtable) return boolean end
function SaveFrameHandle(hashtable_table, int_parentKey, int_childKey, framehandle_whichFrameHandle) return boolean end
function LoadReal(hashtable_table, int_parentKey, int_childKey) return real end
function LoadBoolean(hashtable_table, int_parentKey, int_childKey) return boolean end
function LoadStr(hashtable_table, int_parentKey, int_childKey) return string end
function LoadPlayerHandle(hashtable_table, int_parentKey, int_childKey) return player end
function LoadWidgetHandle(hashtable_table, int_parentKey, int_childKey) return widget end
function LoadDestructableHandle(hashtable_table, int_parentKey, int_childKey) return destructable end
function LoadItemHandle(hashtable_table, int_parentKey, int_childKey) return item end
function LoadUnitHandle(hashtable_table, int_parentKey, int_childKey) return unit end
function LoadAbilityHandle(hashtable_table, int_parentKey, int_childKey) return ability end
function LoadTimerHandle(hashtable_table, int_parentKey, int_childKey) return timer end
function LoadTriggerHandle(hashtable_table, int_parentKey, int_childKey) return trigger end
function LoadTriggerConditionHandle(hashtable_table, int_parentKey, int_childKey) return triggercondition end
function LoadTriggerActionHandle(hashtable_table, int_parentKey, int_childKey) return triggeraction end
function LoadTriggerEventHandle(hashtable_table, int_parentKey, int_childKey) return event end
function LoadForceHandle(hashtable_table, int_parentKey, int_childKey) return force end
function LoadGroupHandle(hashtable_table, int_parentKey, int_childKey) return group end
function LoadLocationHandle(hashtable_table, int_parentKey, int_childKey) return location end
function LoadRectHandle(hashtable_table, int_parentKey, int_childKey) return rect end
function LoadBooleanExprHandle(hashtable_table, int_parentKey, int_childKey) return boolexpr end
function LoadSoundHandle(hashtable_table, int_parentKey, int_childKey) return sound end
function LoadEffectHandle(hashtable_table, int_parentKey, int_childKey) return effect end
function LoadUnitPoolHandle(hashtable_table, int_parentKey, int_childKey) return unitpool end
function LoadItemPoolHandle(hashtable_table, int_parentKey, int_childKey) return itempool end
function LoadQuestHandle(hashtable_table, int_parentKey, int_childKey) return quest end
function LoadQuestItemHandle(hashtable_table, int_parentKey, int_childKey) return questitem end
function LoadDefeatConditionHandle(hashtable_table, int_parentKey, int_childKey) return defeatcondition end
function LoadTimerDialogHandle(hashtable_table, int_parentKey, int_childKey) return timerdialog end
function LoadLeaderboardHandle(hashtable_table, int_parentKey, int_childKey) return leaderboard end
function LoadMultiboardHandle(hashtable_table, int_parentKey, int_childKey) return multiboard end
function LoadMultiboardItemHandle(hashtable_table, int_parentKey, int_childKey) return multiboarditem end
function LoadTrackableHandle(hashtable_table, int_parentKey, int_childKey) return trackable end
function LoadDialogHandle(hashtable_table, int_parentKey, int_childKey) return dialog end
function LoadButtonHandle(hashtable_table, int_parentKey, int_childKey) return button end
function LoadTextTagHandle(hashtable_table, int_parentKey, int_childKey) return texttag end
function LoadLightningHandle(hashtable_table, int_parentKey, int_childKey) return lightning end
function LoadImageHandle(hashtable_table, int_parentKey, int_childKey) return image end
function LoadUbersplatHandle(hashtable_table, int_parentKey, int_childKey) return ubersplat end
function LoadRegionHandle(hashtable_table, int_parentKey, int_childKey) return region end
function LoadFogStateHandle(hashtable_table, int_parentKey, int_childKey) return fogstate end
function LoadFogModifierHandle(hashtable_table, int_parentKey, int_childKey) return fogmodifier end
function LoadHashtableHandle(hashtable_table, int_parentKey, int_childKey) return hashtable end
function LoadFrameHandle(hashtable_table, int_parentKey, int_childKey) return framehandle end
function HaveSavedReal(hashtable_table, int_parentKey, int_childKey) return boolean end
function HaveSavedBoolean(hashtable_table, int_parentKey, int_childKey) return boolean end
function HaveSavedString(hashtable_table, int_parentKey, int_childKey) return boolean end
function HaveSavedHandle(hashtable_table, int_parentKey, int_childKey) return boolean end
function RemoveSavedReal(hashtable_table, int_parentKey, int_childKey) end
function RemoveSavedBoolean(hashtable_table, int_parentKey, int_childKey) end
function RemoveSavedString(hashtable_table, int_parentKey, int_childKey) end
function RemoveSavedHandle(hashtable_table, int_parentKey, int_childKey) end
function FlushChildHashtable(hashtable_table, int_parentKey) end
-- Randomization API
function GetRandomInt(int_lowBound, int_highBound) return integer end
function GetRandomReal(r_lowBound, r_highBound) return real end
function DestroyUnitPool(unitpool_whichPool) end
function UnitPoolAddUnitType(unitpool_whichPool, int_unitId, r_weight) end
function UnitPoolRemoveUnitType(unitpool_whichPool, int_unitId) end
function PlaceRandomUnit(unitpool_whichPool, player_forWhichPlayer, r_x, r_y, r_facing) return unit end
function DestroyItemPool(itempool_whichItemPool) end
function ItemPoolAddItemType(itempool_whichItemPool, int_itemId, r_weight) end
function ItemPoolRemoveItemType(itempool_whichItemPool, int_itemId) end
function PlaceRandomItem(itempool_whichItemPool, r_x, r_y) return item end
function ChooseRandomCreep(int_level) return integer end
function ChooseRandomNPBuilding() return integer end
function ChooseRandomItem(int_level) return integer end
function ChooseRandomItemEx(itemtype_whichType, int_level) return integer end
function SetRandomSeed(int_seed) end
-- Visual API
function SetTerrainFog(r_a, r_b, r_c, r_d, r_e) end
function ResetTerrainFog() end
function SetTerrainFogEx(int_style, r_zstart, r_zend, r_density, r_red, r_green, r_blue) end
function DisplayTextToPlayer(player_toPlayer, r_x, r_y, str_message) end
function DisplayTimedTextToPlayer(player_toPlayer, r_x, r_y, r_duration, str_message) end
function DisplayTimedTextFromPlayer(player_toPlayer, r_x, r_y, r_duration, str_message) end
function ClearTextMessages() end
function SetDayNightModels(str_terrainDNCFile, str_unitDNCFile) end
function SetSkyModel(str_skyModelFile) end
function EnableUserControl(b_b) end
function EnableUserUI(b_b) end
function SuspendTimeOfDay(b_b) end
function SetTimeOfDayScale(r_r) end
function GetTimeOfDayScale() return real end
function ShowInterface(b_flag, r_fadeDuration) end
function PauseGame(b_flag) end
function UnitAddIndicator(unit_whichUnit, int_red, int_green, int_blue, int_alpha) end
function AddIndicator(widget_whichWidget, int_red, int_green, int_blue, int_alpha) end
function PingMinimap(r_x, r_y, r_duration) end
function PingMinimapEx(r_x, r_y, r_duration, int_red, int_green, int_blue, b_extraEffects) end
function EnableOcclusion(b_flag) end
function SetIntroShotText(str_introText) end
function SetIntroShotModel(str_introModelPath) end
function EnableWorldFogBoundary(b_b) end
function PlayModelCinematic(str_modelName) end
function PlayCinematic(str_movieName) end
function ForceUIKey(str_key) end
function ForceUICancel() end
function DisplayLoadDialog() end
function SetAltMinimapIcon(str_iconPath) end
function DisableRestartMission(b_flag) end
function DestroyTextTag(texttag_t) end
function SetTextTagText(texttag_t, str_s, r_height) end
function SetTextTagPos(texttag_t, r_x, r_y, r_heightOffset) end
function SetTextTagPosUnit(texttag_t, unit_whichUnit, r_heightOffset) end
function SetTextTagColor(texttag_t, int_red, int_green, int_blue, int_alpha) end
function SetTextTagVelocity(texttag_t, r_xvel, r_yvel) end
function SetTextTagVisibility(texttag_t, b_flag) end
function SetTextTagSuspended(texttag_t, b_flag) end
function SetTextTagPermanent(texttag_t, b_flag) end
function SetTextTagAge(texttag_t, r_age) end
function SetTextTagLifespan(texttag_t, r_lifespan) end
function SetTextTagFadepoint(texttag_t, r_fadepoint) end
function GetAllyColorFilterState() return integer end
function SetAllyColorFilterState(int_state) end
function GetCreepCampFilterState() return boolean end
function SetCreepCampFilterState(b_state) end
function EnableMinimapFilterButtons(b_enableAlly, b_enableCreep) end
function EnableDragSelect(b_state, b_ui) end
function EnablePreSelect(b_state, b_ui) end
function EnableSelect(b_state, b_ui) end
-- Trackable API
function CreateTrackable(str_trackableModelPath, r_x, r_y, r_facing) return trackable end
-- Quest API
function CreateQuest() return quest end
function DestroyQuest(quest_whichQuest) end
function QuestSetTitle(quest_whichQuest, str_title) end
function QuestSetDescription(quest_whichQuest, str_description) end
function QuestSetIconPath(quest_whichQuest, str_iconPath) end
function QuestSetCompleted(quest_whichQuest, b_completed) end
function QuestSetDiscovered(quest_whichQuest, b_discovered) end
function QuestSetFailed(quest_whichQuest, b_failed) end
function QuestSetEnabled(quest_whichQuest, b_enabled) end
function IsQuestCompleted(quest_whichQuest) return boolean end
function IsQuestDiscovered(quest_whichQuest) return boolean end
function IsQuestFailed(quest_whichQuest) return boolean end
function IsQuestEnabled(quest_whichQuest) return boolean end
function QuestItemSetDescription(questitem_whichQuestItem, str_description) end
function QuestItemSetCompleted(questitem_whichQuestItem, b_completed) end
function DestroyDefeatCondition(defeatcondition_whichCondition) end
function DefeatConditionSetDescription(defeatcondition_whichCondition, str_description) end
function ForceQuestDialogUpdate() end
-- Timer Dialog API
function CreateTimerDialog(timer_t) return timerdialog end
function DestroyTimerDialog(timerdialog_whichDialog) end
function TimerDialogSetTitle(timerdialog_whichDialog, str_title) end
function TimerDialogSetTitleColor(timerdialog_whichDialog, int_red, int_green, int_blue, int_alpha) end
function TimerDialogSetTimeColor(timerdialog_whichDialog, int_red, int_green, int_blue, int_alpha) end
function TimerDialogSetSpeed(timerdialog_whichDialog, r_speedMultFactor) end
function TimerDialogDisplay(timerdialog_whichDialog, b_display) end
function IsTimerDialogDisplayed(timerdialog_whichDialog) return boolean end
function TimerDialogSetRealTimeRemaining(timerdialog_whichDialog, r_timeRemaining) end
-- Leaderboard API
function CreateLeaderboard() return leaderboard end
function DestroyLeaderboard(leaderboard_lb) end
function IsLeaderboardDisplayed(leaderboard_lb) return boolean end
function LeaderboardAddItem(leaderboard_lb, str_label, int_value, player_p) end
function LeaderboardRemoveItem(leaderboard_lb, int_index) end
function LeaderboardRemovePlayerItem(leaderboard_lb, player_p) end
function LeaderboardClear(leaderboard_lb) end
function LeaderboardSortItemsByPlayer(leaderboard_lb, b_ascending) end
function LeaderboardSortItemsByLabel(leaderboard_lb, b_ascending) end
function LeaderboardGetPlayerIndex(leaderboard_lb, player_p) return integer end
function LeaderboardSetLabel(leaderboard_lb, str_label) end
function LeaderboardGetLabelText(leaderboard_lb) return string end
function PlayerGetLeaderboard(player_toPlayer) return leaderboard end
function LeaderboardSetValueColor(leaderboard_lb, int_red, int_green, int_blue, int_alpha) end
function LeaderboardSetStyle(leaderboard_lb, b_showLabel, b_showNames, b_showValues, b_showIcons) end
function LeaderboardSetItemLabel(leaderboard_lb, int_whichItem, str_val) end
function LeaderboardSetItemStyle(leaderboard_lb, int_whichItem, b_showLabel, b_showValue, b_showIcon) end
function LeaderboardSetItemLabelColor(leaderboard_lb, int_whichItem, int_red, int_green, int_blue, int_alpha) end
function LeaderboardSetItemValueColor(leaderboard_lb, int_whichItem, int_red, int_green, int_blue, int_alpha) end
-- Multiboard API
--============================================================================
function CreateMultiboard() return multiboard end
function DestroyMultiboard(multiboard_lb) end
function IsMultiboardDisplayed(multiboard_lb) return boolean end
function IsMultiboardMinimized(multiboard_lb) return boolean end
function MultiboardClear(multiboard_lb) end
function MultiboardGetTitleText(multiboard_lb) return string end
function MultiboardSetTitleTextColor(multiboard_lb, int_red, int_green, int_blue, int_alpha) end
function MultiboardGetColumnCount(multiboard_lb) return integer end
function MultiboardSetRowCount(multiboard_lb, int_count) end
function MultiboardSetItemsStyle(multiboard_lb, b_showValues, b_showIcons) end
function MultiboardSetItemsValue(multiboard_lb, str_value) end
function MultiboardSetItemsValueColor(multiboard_lb, int_red, int_green, int_blue, int_alpha) end
function MultiboardSetItemsWidth(multiboard_lb, r_width) end
function MultiboardSetItemsIcon(multiboard_lb, str_iconPath) end
function MultiboardGetItem(multiboard_lb, int_row, int_column) return multiboarditem end
function MultiboardReleaseItem(multiboarditem_mbi) end
function MultiboardSetItemValue(multiboarditem_mbi, str_val) end
function MultiboardSetItemValueColor(multiboarditem_mbi, int_red, int_green, int_blue, int_alpha) end
function MultiboardSetItemWidth(multiboarditem_mbi, r_width) end
function MultiboardSetItemIcon(multiboarditem_mbi, str_iconFileName) end
-- subsequently displayed multiboards
--
function MultiboardSuppressDisplay(b_flag) end
-- Camera API
function SetCameraPosition(r_x, r_y) end
function SetCameraQuickPosition(r_x, r_y) end
function SetCameraBounds(r_x1, r_y1, r_x2, r_y2, r_x3, r_y3, r_x4, r_y4) end
function StopCamera() end
function ResetToGameCamera(r_duration) end
function PanCameraTo(r_x, r_y) end
function PanCameraToTimed(r_x, r_y, r_duration) end
function PanCameraToWithZ(r_x, r_y, r_zOffsetDest) end
function PanCameraToTimedWithZ(r_x, r_y, r_zOffsetDest, r_duration) end
function SetCinematicCamera(str_cameraModelFile) end
function SetCameraRotateMode(r_x, r_y, r_radiansToSweep, r_duration) end
function SetCameraField(camerafield_whichField, r_value, r_duration) end
function AdjustCameraField(camerafield_whichField, r_offset, r_duration) end
function SetCameraTargetController(unit_whichUnit, r_xoffset, r_yoffset, b_inheritOrientation) end
function SetCameraOrientController(unit_whichUnit, r_xoffset, r_yoffset) end
function CameraSetupSetField(camerasetup_whichSetup, camerafield_whichField, r_value, r_duration) end
function CameraSetupGetField(camerasetup_whichSetup, camerafield_whichField) return real end
function CameraSetupSetDestPosition(camerasetup_whichSetup, r_x, r_y, r_duration) end
function CameraSetupGetDestPositionLoc(camerasetup_whichSetup) return location end
function CameraSetupGetDestPositionX(camerasetup_whichSetup) return real end
function CameraSetupGetDestPositionY(camerasetup_whichSetup) return real end
function CameraSetupApply(camerasetup_whichSetup, b_doPan, b_panTimed) end
function CameraSetupApplyWithZ(camerasetup_whichSetup, r_zDestOffset) end
function CameraSetupApplyForceDuration(camerasetup_whichSetup, b_doPan, r_forceDuration) end
function CameraSetupApplyForceDurationWithZ(camerasetup_whichSetup, r_zDestOffset, r_forceDuration) end
function CameraSetSourceNoise(r_mag, r_velocity) end
function CameraSetSourceNoiseEx(r_mag, r_velocity, b_vertOnly) end
function SetCineFilterBlendMode(blendmode_whichMode) end
function SetCineFilterTexMapFlags(texmapflags_whichFlags) end
function SetCineFilterStartUV(r_minu, r_minv, r_maxu, r_maxv) end
function SetCineFilterEndUV(r_minu, r_minv, r_maxu, r_maxv) end
function SetCineFilterStartColor(int_red, int_green, int_blue, int_alpha) end
function SetCineFilterEndColor(int_red, int_green, int_blue, int_alpha) end
function SetCineFilterDuration(r_duration) end
function DisplayCineFilter(b_flag) end
function IsCineFilterDisplayed() return boolean end
function EndCinematicScene() end
function ForceCinematicSubtitles(b_flag) end
function GetCameraBoundMinX() return real end
function GetCameraBoundMinY() return real end
function GetCameraBoundMaxX() return real end
function GetCameraBoundMaxY() return real end
function GetCameraField(camerafield_whichField) return real end
function GetCameraTargetPositionX() return real end
function GetCameraTargetPositionY() return real end
function GetCameraTargetPositionZ() return real end
function GetCameraTargetPositionLoc() return location end
function GetCameraEyePositionX() return real end
function GetCameraEyePositionY() return real end
function GetCameraEyePositionZ() return real end
function GetCameraEyePositionLoc() return location end
-- Sound API
--
function NewSoundEnvironment(str_environmentName) end
function CreateSoundFilenameWithLabel(str_fileName, b_looping, b_is3D, b_stopwhenoutofrange, int_fadeInRate, int_fadeOutRate, str_SLKEntryName) return sound end
function CreateSoundFromLabel(str_soundLabel, b_looping, b_is3D, b_stopwhenoutofrange, int_fadeInRate, int_fadeOutRate) return sound end
function CreateMIDISound(str_soundLabel, int_fadeInRate, int_fadeOutRate) return sound end
function SetSoundDistanceCutoff(sound_soundHandle, r_cutoff) end
function SetSoundChannel(sound_soundHandle, int_channel) end
function SetSoundVolume(sound_soundHandle, int_volume) end
function SetSoundPitch(sound_soundHandle, r_pitch) end
function SetSoundPlayPosition(sound_soundHandle, int_millisecs) end
function SetSoundDistances(sound_soundHandle, r_minDist, r_maxDist) end
function SetSoundConeAngles(sound_soundHandle, r_inside, r_outside, int_outsideVolume) end
function SetSoundConeOrientation(sound_soundHandle, r_x, r_y, r_z) end
function SetSoundPosition(sound_soundHandle, r_x, r_y, r_z) end
function SetSoundVelocity(sound_soundHandle, r_x, r_y, r_z) end
function AttachSoundToUnit(sound_soundHandle, unit_whichUnit) end
function StopSound(sound_soundHandle, b_killWhenDone, b_fadeOut) end
function KillSoundWhenDone(sound_soundHandle) end
function SetMapMusic(str_musicName, b_random, int_index) end
function ClearMapMusic() end
function PlayMusicEx(str_musicName, int_frommsecs, int_fadeinmsecs) end
function StopMusic(b_fadeOut) end
function ResumeMusic() end
function PlayThematicMusicEx(str_musicFileName, int_frommsecs) end
function EndThematicMusic() end
function SetMusicPlayPosition(int_millisecs) end
function SetThematicMusicPlayPosition(int_millisecs) end
function SetSoundDuration(sound_soundHandle, int_duration) end
function GetSoundDuration(sound_soundHandle) return integer end
function GetSoundFileDuration(str_musicFileName) return integer end
function VolumeGroupReset() end
function GetSoundIsLoading(sound_soundHandle) return boolean end
function UnregisterStackedSound(sound_soundHandle, b_byPosition, r_rectwidth, r_rectheight) end
-- Effects API
--
function AddWeatherEffect(rect_where, int_effectID) return weathereffect end
function RemoveWeatherEffect(weathereffect_whichEffect) end
function EnableWeatherEffect(weathereffect_whichEffect, b_enable) end
function TerrainDeformRipple(r_x, r_y, r_radius, r_depth, int_duration, int_count, r_spaceWaves, r_timeWaves, r_radiusStartPct, b_limitNeg) return terraindeformation end
function TerrainDeformWave(r_x, r_y, r_dirX, r_dirY, r_distance, r_speed, r_radius, r_depth, int_trailTime, int_count) return terraindeformation end
function TerrainDeformRandom(r_x, r_y, r_radius, r_minDelta, r_maxDelta, int_duration, int_updateInterval) return terraindeformation end
function TerrainDeformStop(terraindeformation_deformation, int_duration) end
function TerrainDeformStopAll() end
function AddSpecialEffectLoc(str_modelName, location_where) return effect end
function AddSpecialEffectTarget(str_modelName, widget_targetWidget, str_attachPointName) return effect end
function DestroyEffect(effect_whichEffect) end
function AddSpellEffectLoc(str_abilityString, effecttype_t, location_where) return effect end
function AddSpellEffectById(int_abilityId, effecttype_t, r_x, r_y) return effect end
function AddSpellEffectByIdLoc(int_abilityId, effecttype_t, location_where) return effect end
function AddSpellEffectTarget(str_modelName, effecttype_t, widget_targetWidget, str_attachPoint) return effect end
function AddSpellEffectTargetById(int_abilityId, effecttype_t, widget_targetWidget, str_attachPoint) return effect end
function AddLightningEx(str_codeName, b_checkVisibility, r_x1, r_y1, r_z1, r_x2, r_y2, r_z2) return lightning end
function DestroyLightning(lightning_whichBolt) return boolean end
function MoveLightning(lightning_whichBolt, b_checkVisibility, r_x1, r_y1, r_x2, r_y2) return boolean end
function MoveLightningEx(lightning_whichBolt, b_checkVisibility, r_x1, r_y1, r_z1, r_x2, r_y2, r_z2) return boolean end
function GetLightningColorA(lightning_whichBolt) return real end
function GetLightningColorR(lightning_whichBolt) return real end
function GetLightningColorG(lightning_whichBolt) return real end
function GetLightningColorB(lightning_whichBolt) return real end
function SetLightningColor(lightning_whichBolt, r_r, r_g, r_b, r_a) return boolean end
function GetAbilityEffectById(int_abilityId, effecttype_t, int_index) return string end
function GetAbilitySound(str_abilityString, soundtype_t) return string end
function GetAbilitySoundById(int_abilityId, soundtype_t) return string end
-- Terrain API
--
function GetTerrainCliffLevel(r_x, r_y) return integer end
function SetWaterBaseColor(int_red, int_green, int_blue, int_alpha) end
function SetWaterDeforms(b_val) end
function GetTerrainType(r_x, r_y) return integer end
function GetTerrainVariance(r_x, r_y) return integer end
function SetTerrainType(r_x, r_y, int_terrainType, int_variation, int_area, int_shape) end
function IsTerrainPathable(r_x, r_y, pathingtype_t) return boolean end
function SetTerrainPathable(r_x, r_y, pathingtype_t, b_flag) end
-- Image API
--
function CreateImage(str_file, r_sizeX, r_sizeY, r_sizeZ, r_posX, r_posY, r_posZ, r_originX, r_originY, r_originZ, int_imageType) return image end
function DestroyImage(image_whichImage) end
function ShowImage(image_whichImage, b_flag) end
function SetImageConstantHeight(image_whichImage, b_flag, r_height) end
function SetImagePosition(image_whichImage, r_x, r_y, r_z) end
function SetImageColor(image_whichImage, int_red, int_green, int_blue, int_alpha) end
function SetImageRender(image_whichImage, b_flag) end
function SetImageRenderAlways(image_whichImage, b_flag) end
function SetImageAboveWater(image_whichImage, b_flag, b_useWaterAlpha) end
function SetImageType(image_whichImage, int_imageType) end
-- Ubersplat API
--
function CreateUbersplat(r_x, r_y, str_name, int_red, int_green, int_blue, int_alpha, b_forcePaused, b_noBirthTime) return ubersplat end
function DestroyUbersplat(ubersplat_whichSplat) end
function ResetUbersplat(ubersplat_whichSplat) end
function FinishUbersplat(ubersplat_whichSplat) end
function ShowUbersplat(ubersplat_whichSplat, b_flag) end
function SetUbersplatRender(ubersplat_whichSplat, b_flag) end
function SetUbersplatRenderAlways(ubersplat_whichSplat, b_flag) end
-- Blight API
--
function SetBlight(player_whichPlayer, r_x, r_y, r_radius, b_addBlight) end
function SetBlightRect(player_whichPlayer, rect_r, b_addBlight) end
function SetBlightPoint(player_whichPlayer, r_x, r_y, b_addBlight) end
function SetBlightLoc(player_whichPlayer, location_whichLocation, r_radius, b_addBlight) end
function CreateBlightedGoldmine(player_id, r_x, r_y, r_face) return unit end
function IsPointBlighted(r_x, r_y) return boolean end
-- Doodad API
--
function SetDoodadAnimation(r_x, r_y, r_radius, int_doodadID, b_nearestOnly, str_animName, b_animRandom) end
function SetDoodadAnimationRect(rect_r, int_doodadID, str_animName, b_animRandom) end
-- Computer AI interface
--
function StartMeleeAI(player_num, str_script) end
function StartCampaignAI(player_num, str_script) end
function CommandAI(player_num, int_command, int_data) end
function PauseCompAI(player_p, b_pause) end
function GetAIDifficulty(player_num) return aidifficulty end
function RecycleGuardPosition(unit_hUnit) end
function RemoveAllGuardPositions(player_num) end
function Cheat(str_cheatStr) end
function IsNoVictoryCheat() return boolean end
function IsNoDefeatCheat() return boolean end
function PreloadEnd(r_timeout) end
function PreloadRefresh() end
function PreloadEndEx() end
function PreloadGenStart() end
function PreloadGenEnd(str_filename) end
function Preloader(str_filename) end
function AutomationSetTestType(str_testType) end
function AutomationTestStart(str_testName) end
function AutomationTestEnd() end
function AutomationTestingFinished() end
function BlzGetTriggerPlayerMouseX() return real end
function BlzGetTriggerPlayerMouseY() return real end
function BlzGetTriggerPlayerMousePosition() return location end
function BlzGetTriggerPlayerMouseButton() return mousebuttontype end
function BlzSetAbilityTooltip(int_abilCode, str_tooltip, int_level) end
function BlzSetAbilityActivatedTooltip(int_abilCode, str_tooltip, int_level) end
function BlzSetAbilityExtendedTooltip(int_abilCode, str_extendedTooltip, int_level) end
function BlzSetAbilityActivatedExtendedTooltip(int_abilCode, str_extendedTooltip, int_level) end
function BlzSetAbilityResearchTooltip(int_abilCode, str_researchTooltip, int_level) end
function BlzSetAbilityResearchExtendedTooltip(int_abilCode, str_researchExtendedTooltip, int_level) end
function BlzGetAbilityTooltip(int_abilCode, int_level) return string end
function BlzGetAbilityActivatedTooltip(int_abilCode, int_level) return string end
function BlzGetAbilityExtendedTooltip(int_abilCode, int_level) return string end
function BlzGetAbilityActivatedExtendedTooltip(int_abilCode, int_level) return string end
function BlzGetAbilityResearchTooltip(int_abilCode, int_level) return string end
function BlzGetAbilityResearchExtendedTooltip(int_abilCode, int_level) return string end
function BlzSetAbilityIcon(int_abilCode, str_iconPath) end
function BlzGetAbilityIcon(int_abilCode) return string end
function BlzSetAbilityActivatedIcon(int_abilCode, str_iconPath) end
function BlzGetAbilityActivatedIcon(int_abilCode) return string end
function BlzGetAbilityPosX(int_abilCode) return integer end
function BlzGetAbilityPosY(int_abilCode) return integer end
function BlzSetAbilityPosX(int_abilCode, int_x) end
function BlzSetAbilityPosY(int_abilCode, int_y) end
function BlzGetAbilityActivatedPosX(int_abilCode) return integer end
function BlzGetAbilityActivatedPosY(int_abilCode) return integer end
function BlzSetAbilityActivatedPosX(int_abilCode, int_x) end
function BlzSetAbilityActivatedPosY(int_abilCode, int_y) end
function BlzGetUnitMaxHP(unit_whichUnit) return integer end
function BlzSetUnitMaxHP(unit_whichUnit, int_hp) end
function BlzGetUnitMaxMana(unit_whichUnit) return integer end
function BlzSetUnitMaxMana(unit_whichUnit, int_mana) end
function BlzSetItemName(item_whichItem, str_name) end
function BlzSetItemDescription(item_whichItem, str_description) end
function BlzGetItemDescription(item_whichItem) return string end
function BlzSetItemTooltip(item_whichItem, str_tooltip) end
function BlzGetItemTooltip(item_whichItem) return string end
function BlzSetItemExtendedTooltip(item_whichItem, str_extendedTooltip) end
function BlzGetItemExtendedTooltip(item_whichItem) return string end
function BlzSetItemIconPath(item_whichItem, str_iconPath) end
function BlzGetItemIconPath(item_whichItem) return string end
function BlzSetUnitName(unit_whichUnit, str_name) end
function BlzSetHeroProperName(unit_whichUnit, str_heroProperName) end
function BlzGetUnitBaseDamage(unit_whichUnit, int_weaponIndex) return integer end
function BlzSetUnitBaseDamage(unit_whichUnit, int_baseDamage, int_weaponIndex) end
function BlzGetUnitDiceNumber(unit_whichUnit, int_weaponIndex) return integer end
function BlzSetUnitDiceNumber(unit_whichUnit, int_diceNumber, int_weaponIndex) end
function BlzGetUnitDiceSides(unit_whichUnit, int_weaponIndex) return integer end
function BlzSetUnitDiceSides(unit_whichUnit, int_diceSides, int_weaponIndex) end
function BlzGetUnitAttackCooldown(unit_whichUnit, int_weaponIndex) return real end
function BlzSetUnitAttackCooldown(unit_whichUnit, r_cooldown, int_weaponIndex) end
function BlzSetSpecialEffectColorByPlayer(effect_whichEffect, player_whichPlayer) end
function BlzSetSpecialEffectColor(effect_whichEffect, int_r, int_g, int_b) end
function BlzSetSpecialEffectAlpha(effect_whichEffect, int_alpha) end
function BlzSetSpecialEffectScale(effect_whichEffect, r_scale) end
function BlzSetSpecialEffectPosition(effect_whichEffect, r_x, r_y, r_z) end
function BlzSetSpecialEffectHeight(effect_whichEffect, r_height) end
function BlzSetSpecialEffectTimeScale(effect_whichEffect, r_timeScale) end
function BlzSetSpecialEffectTime(effect_whichEffect, r_time) end
function BlzSetSpecialEffectOrientation(effect_whichEffect, r_yaw, r_pitch, r_roll) end
function BlzSetSpecialEffectYaw(effect_whichEffect, r_yaw) end
function BlzSetSpecialEffectPitch(effect_whichEffect, r_pitch) end
function BlzSetSpecialEffectRoll(effect_whichEffect, r_roll) end
function BlzSetSpecialEffectX(effect_whichEffect, r_x) end
function BlzSetSpecialEffectY(effect_whichEffect, r_y) end
function BlzSetSpecialEffectZ(effect_whichEffect, r_z) end
function BlzSetSpecialEffectPositionLoc(effect_whichEffect, location_loc) end
function BlzGetLocalSpecialEffectX(effect_whichEffect) return real end
function BlzGetLocalSpecialEffectY(effect_whichEffect) return real end
function BlzGetLocalSpecialEffectZ(effect_whichEffect) return real end
function BlzSpecialEffectClearSubAnimations(effect_whichEffect) end
function BlzSpecialEffectRemoveSubAnimation(effect_whichEffect, subanimtype_whichSubAnim) end
function BlzSpecialEffectAddSubAnimation(effect_whichEffect, subanimtype_whichSubAnim) end
function BlzPlaySpecialEffect(effect_whichEffect, animtype_whichAnim) end
function BlzPlaySpecialEffectWithTimeScale(effect_whichEffect, animtype_whichAnim, r_timeScale) end
function BlzGetAnimName(animtype_whichAnim) return string end
function BlzGetUnitArmor(unit_whichUnit) return real end
function BlzSetUnitArmor(unit_whichUnit, r_armorAmount) end
function BlzUnitHideAbility(unit_whichUnit, int_abilId, b_flag) end
function BlzUnitDisableAbility(unit_whichUnit, int_abilId, b_flag, b_hideUI) end
function BlzUnitCancelTimedLife(unit_whichUnit) end
function BlzIsUnitSelectable(unit_whichUnit) return boolean end
function BlzIsUnitInvulnerable(unit_whichUnit) return boolean end
function BlzUnitInterruptAttack(unit_whichUnit) end
function BlzGetUnitCollisionSize(unit_whichUnit) return real end
function BlzGetAbilityManaCost(int_abilId, int_level) return integer end
function BlzGetAbilityCooldown(int_abilId, int_level) return real end
function BlzSetUnitAbilityCooldown(unit_whichUnit, int_abilId, int_level, r_cooldown) end
function BlzGetUnitAbilityCooldown(unit_whichUnit, int_abilId, int_level) return real end
function BlzGetUnitAbilityCooldownRemaining(unit_whichUnit, int_abilId) return real end
function BlzEndUnitAbilityCooldown(unit_whichUnit, int_abilCode) end
function BlzGetUnitAbilityManaCost(unit_whichUnit, int_abilId, int_level) return integer end
function BlzSetUnitAbilityManaCost(unit_whichUnit, int_abilId, int_level, int_manaCost) end
function BlzGetLocalUnitZ(unit_whichUnit) return real end
function BlzDecPlayerTechResearched(player_whichPlayer, int_techid, int_levels) end
function BlzSetEventDamage(r_damage) end
function BlzGetEventDamageTarget() return unit end
function BlzGetEventAttackType() return attacktype end
function BlzGetEventDamageType() return damagetype end
function BlzGetEventWeaponType() return weapontype end
function BlzSetEventAttackType(attacktype_attackType) return boolean end
function BlzSetEventDamageType(damagetype_damageType) return boolean end
function BlzSetEventWeaponType(weapontype_weaponType) return boolean end
function RequestExtraIntegerData(int_dataType, player_whichPlayer, str_param1, str_param2, b_param3, int_param4, int_param5, int_param6) return integer end
function RequestExtraBooleanData(int_dataType, player_whichPlayer, str_param1, str_param2, b_param3, int_param4, int_param5, int_param6) return boolean end
function RequestExtraStringData(int_dataType, player_whichPlayer, str_param1, str_param2, b_param3, int_param4, int_param5, int_param6) return string end
function RequestExtraRealData(int_dataType, player_whichPlayer, str_param1, str_param2, b_param3, int_param4, int_param5, int_param6) return real end
-- Add this function to follow the style of GetUnitX and GetUnitY, it has the same result as BlzGetLocalUnitZ
function BlzGetUnitZ(unit_whichUnit) return real end
function BlzEnableSelections(b_enableSelection, b_enableSelectionCircle) end
function BlzIsSelectionEnabled() return boolean end
function BlzIsSelectionCircleEnabled() return boolean end
function BlzCameraSetupApplyForceDurationSmooth(camerasetup_whichSetup, b_doPan, r_forcedDuration, r_easeInDuration, r_easeOutDuration, r_smoothFactor) end
function BlzEnableTargetIndicator(b_enable) end
function BlzIsTargetIndicatorEnabled() return boolean end
function BlzEnableUIAutoPosition(b_enable) end
function BlzHideOriginFrames(b_enable) end
function BlzConvertColor(int_a, int_r, int_g, int_b) return integer end
function BlzLoadTOCFile(str_TOCFile) return boolean end
function BlzCreateFrame(str_name, framehandle_owner, int_priority, int_createContext) return framehandle end
function BlzCreateSimpleFrame(str_name, framehandle_owner, int_createContext) return framehandle end
function BlzCreateFrameByType(str_typeName, str_name, framehandle_owner, str_inherits, int_createContext) return framehandle end
function BlzDestroyFrame(framehandle_frame) end
function BlzFrameSetPoint(framehandle_frame, framepointtype_point, framehandle_relative, framepointtype_relativePoint, r_x, r_y) end
function BlzFrameSetAbsPoint(framehandle_frame, framepointtype_point, r_x, r_y) end
function BlzFrameClearAllPoints(framehandle_frame) end
function BlzFrameSetAllPoints(framehandle_frame, framehandle_relative) end
function BlzFrameSetVisible(framehandle_frame, b_visible) end
function BlzFrameIsVisible(framehandle_frame) return boolean end
function BlzGetFrameByName(str_name, int_createContext) return framehandle end
function BlzFrameGetName(framehandle_frame) return string end
function BlzFrameClick(framehandle_frame) end
function BlzFrameSetText(framehandle_frame, str_text) end
function BlzFrameGetText(framehandle_frame) return string end
function BlzFrameSetTextSizeLimit(framehandle_frame, int_size) end
function BlzFrameGetTextSizeLimit(framehandle_frame) return integer end
function BlzFrameSetTextColor(framehandle_frame, int_color) end
function BlzFrameSetFocus(framehandle_frame, b_flag) end
function BlzFrameSetModel(framehandle_frame, str_modelFile, int_cameraIndex) end
function BlzFrameSetEnable(framehandle_frame, b_enabled) end
function BlzFrameGetEnable(framehandle_frame) return boolean end
function BlzFrameSetAlpha(framehandle_frame, int_alpha) end
function BlzFrameGetAlpha(framehandle_frame) return integer end
function BlzFrameSetSpriteAnimate(framehandle_frame, int_primaryProp, int_flags) end
function BlzFrameSetTexture(framehandle_frame, str_texFile, int_flag, b_blend) end
function BlzFrameSetScale(framehandle_frame, r_scale) end
function BlzFrameSetTooltip(framehandle_frame, framehandle_tooltip) end
function BlzFrameCageMouse(framehandle_frame, b_enable) end
function BlzFrameSetValue(framehandle_frame, r_value) end
function BlzFrameGetValue(framehandle_frame) return real end
function BlzFrameSetMinMaxValue(framehandle_frame, r_minValue, r_maxValue) end
function BlzFrameSetStepSize(framehandle_frame, r_stepSize) end
function BlzFrameSetSize(framehandle_frame, r_width, r_height) end
function BlzFrameSetVertexColor(framehandle_frame, int_color) end
function BlzFrameSetLevel(framehandle_frame, int_level) end
function BlzFrameSetParent(framehandle_frame, framehandle_parent) end
function BlzFrameGetParent(framehandle_frame) return framehandle end
function BlzFrameGetHeight(framehandle_frame) return real end
function BlzFrameGetWidth(framehandle_frame) return real end
function BlzFrameSetFont(framehandle_frame, str_fileName, r_height, int_flags) end
function BlzFrameSetTextAlignment(framehandle_frame, textaligntype_vert, textaligntype_horz) end
function BlzTriggerRegisterFrameEvent(trigger_whichTrigger, framehandle_frame, frameeventtype_eventId) return event end
function BlzGetTriggerFrame() return framehandle end
function BlzGetTriggerFrameEvent() return frameeventtype end
function BlzTriggerRegisterPlayerSyncEvent(trigger_whichTrigger, player_whichPlayer, str_prefix, b_fromServer) return event end
function BlzSendSyncData(str_prefix, str_data) return boolean end
function BlzGetTriggerSyncPrefix() return string end
function BlzGetTriggerSyncData() return string end
function BlzTriggerRegisterPlayerKeyEvent(trigger_whichTrigger, player_whichPlayer, oskeytype_key, int_metaKey, b_keyDown) return event end
function BlzGetTriggerPlayerKey() return oskeytype end
function BlzGetTriggerPlayerMetaKey() return integer end
function BlzGetTriggerPlayerIsKeyDown() return boolean end
function BlzEnableCursor(b_enable) end
function BlzSetMousePos(int_x, int_y) end
function BlzGetLocalClientWidth() return integer end
function BlzGetLocalClientHeight() return integer end
function BlzIsLocalClientActive() return boolean end
function BlzGetMouseFocusUnit() return unit end
function BlzChangeMinimapTerrainTex(str_texFile) return boolean end
function BlzGetLocale() return string end
function BlzGetSpecialEffectScale(effect_whichEffect) return real end
function BlzSetSpecialEffectMatrixScale(effect_whichEffect, r_x, r_y, r_z) end
function BlzResetSpecialEffectMatrix(effect_whichEffect) end
function BlzGetUnitAbility(unit_whichUnit, int_abilId) return ability end
function BlzGetUnitAbilityByIndex(unit_whichUnit, int_index) return ability end
function BlzDisplayChatMessage(player_whichPlayer, int_recipient, str_message) end
function BlzPauseUnitEx(unit_whichUnit, b_flag) end
function BlzBitOr(int_x, int_y) return integer end
function BlzBitAnd(int_x, int_y) return integer end
function BlzBitXor(int_x, int_y) return integer end
-- Ability
function BlzGetAbilityBooleanField(ability_whichAbility, abilitybooleanfield_whichField) return boolean end
function BlzGetAbilityIntegerField(ability_whichAbility, abilityintegerfield_whichField) return integer end
function BlzGetAbilityRealField(ability_whichAbility, abilityrealfield_whichField) return real end
function BlzGetAbilityStringField(ability_whichAbility, abilitystringfield_whichField) return string end
function BlzGetAbilityBooleanLevelField(ability_whichAbility, abilitybooleanlevelfield_whichField, int_level) return boolean end
function BlzGetAbilityIntegerLevelField(ability_whichAbility, abilityintegerlevelfield_whichField, int_level) return integer end
function BlzGetAbilityRealLevelField(ability_whichAbility, abilityreallevelfield_whichField, int_level) return real end
function BlzGetAbilityStringLevelField(ability_whichAbility, abilitystringlevelfield_whichField, int_level) return string end
function BlzGetAbilityBooleanLevelArrayField(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, int_level, int_index) return boolean end
function BlzGetAbilityIntegerLevelArrayField(ability_whichAbility, abilityintegerlevelarrayfield_whichField, int_level, int_index) return integer end
function BlzGetAbilityRealLevelArrayField(ability_whichAbility, abilityreallevelarrayfield_whichField, int_level, int_index) return real end
function BlzGetAbilityStringLevelArrayField(ability_whichAbility, abilitystringlevelarrayfield_whichField, int_level, int_index) return string end
function BlzSetAbilityBooleanField(ability_whichAbility, abilitybooleanfield_whichField, b_value) return boolean end
function BlzSetAbilityIntegerField(ability_whichAbility, abilityintegerfield_whichField, int_value) return boolean end
function BlzSetAbilityRealField(ability_whichAbility, abilityrealfield_whichField, r_value) return boolean end
function BlzSetAbilityStringField(ability_whichAbility, abilitystringfield_whichField, str_value) return boolean end
function BlzSetAbilityBooleanLevelField(ability_whichAbility, abilitybooleanlevelfield_whichField, int_level, b_value) return boolean end
function BlzSetAbilityIntegerLevelField(ability_whichAbility, abilityintegerlevelfield_whichField, int_level, int_value) return boolean end
function BlzSetAbilityRealLevelField(ability_whichAbility, abilityreallevelfield_whichField, int_level, r_value) return boolean end
function BlzSetAbilityStringLevelField(ability_whichAbility, abilitystringlevelfield_whichField, int_level, str_value) return boolean end
function BlzSetAbilityBooleanLevelArrayField(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, int_level, int_index, b_value) return boolean end
function BlzSetAbilityIntegerLevelArrayField(ability_whichAbility, abilityintegerlevelarrayfield_whichField, int_level, int_index, int_value) return boolean end
function BlzSetAbilityRealLevelArrayField(ability_whichAbility, abilityreallevelarrayfield_whichField, int_level, int_index, r_value) return boolean end
function BlzSetAbilityStringLevelArrayField(ability_whichAbility, abilitystringlevelarrayfield_whichField, int_level, int_index, str_value) return boolean end
function BlzAddAbilityBooleanLevelArrayField(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, int_level, b_value) return boolean end
function BlzAddAbilityIntegerLevelArrayField(ability_whichAbility, abilityintegerlevelarrayfield_whichField, int_level, int_value) return boolean end
function BlzAddAbilityRealLevelArrayField(ability_whichAbility, abilityreallevelarrayfield_whichField, int_level, r_value) return boolean end
function BlzAddAbilityStringLevelArrayField(ability_whichAbility, abilitystringlevelarrayfield_whichField, int_level, str_value) return boolean end
function BlzRemoveAbilityBooleanLevelArrayField(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, int_level, b_value) return boolean end
function BlzRemoveAbilityIntegerLevelArrayField(ability_whichAbility, abilityintegerlevelarrayfield_whichField, int_level, int_value) return boolean end
function BlzRemoveAbilityRealLevelArrayField(ability_whichAbility, abilityreallevelarrayfield_whichField, int_level, r_value) return boolean end
function BlzRemoveAbilityStringLevelArrayField(ability_whichAbility, abilitystringlevelarrayfield_whichField, int_level, str_value) return boolean end
function BlzGetItemAbilityByIndex(item_whichItem, int_index) return ability end
function BlzGetItemAbility(item_whichItem, int_abilCode) return ability end
function BlzItemAddAbility(item_whichItem, int_abilCode) return boolean end
function BlzGetItemBooleanField(item_whichItem, itembooleanfield_whichField) return boolean end
function BlzGetItemIntegerField(item_whichItem, itemintegerfield_whichField) return integer end
function BlzGetItemRealField(item_whichItem, itemrealfield_whichField) return real end
function BlzGetItemStringField(item_whichItem, itemstringfield_whichField) return string end
function BlzSetItemBooleanField(item_whichItem, itembooleanfield_whichField, b_value) return boolean end
function BlzSetItemIntegerField(item_whichItem, itemintegerfield_whichField, int_value) return boolean end
function BlzSetItemRealField(item_whichItem, itemrealfield_whichField, r_value) return boolean end
function BlzSetItemStringField(item_whichItem, itemstringfield_whichField, str_value) return boolean end
function BlzItemRemoveAbility(item_whichItem, int_abilCode) return boolean end
function BlzGetUnitBooleanField(unit_whichUnit, unitbooleanfield_whichField) return boolean end
function BlzGetUnitIntegerField(unit_whichUnit, unitintegerfield_whichField) return integer end
function BlzGetUnitRealField(unit_whichUnit, unitrealfield_whichField) return real end
function BlzGetUnitStringField(unit_whichUnit, unitstringfield_whichField) return string end
function BlzSetUnitBooleanField(unit_whichUnit, unitbooleanfield_whichField, b_value) return boolean end
function BlzSetUnitIntegerField(unit_whichUnit, unitintegerfield_whichField, int_value) return boolean end
function BlzSetUnitRealField(unit_whichUnit, unitrealfield_whichField, r_value) return boolean end
function BlzSetUnitStringField(unit_whichUnit, unitstringfield_whichField, str_value) return boolean end
function BlzGetUnitWeaponBooleanField(unit_whichUnit, unitweaponbooleanfield_whichField, int_index) return boolean end
function BlzGetUnitWeaponIntegerField(unit_whichUnit, unitweaponintegerfield_whichField, int_index) return integer end
function BlzGetUnitWeaponRealField(unit_whichUnit, unitweaponrealfield_whichField, int_index) return real end
function BlzGetUnitWeaponStringField(unit_whichUnit, unitweaponstringfield_whichField, int_index) return string end
function BlzSetUnitWeaponBooleanField(unit_whichUnit, unitweaponbooleanfield_whichField, int_index, b_value) return boolean end
function BlzSetUnitWeaponIntegerField(unit_whichUnit, unitweaponintegerfield_whichField, int_index, int_value) return boolean end
function BlzSetUnitWeaponRealField(unit_whichUnit, unitweaponrealfield_whichField, int_index, r_value) return boolean end
function BlzSetUnitWeaponStringField(unit_whichUnit, unitweaponstringfield_whichField, int_index, str_value) return boolean end
