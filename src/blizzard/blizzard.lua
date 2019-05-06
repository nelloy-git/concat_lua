-- Blizzard.j ( define Jass2 functions that need to be in every map script )
--===========================================================================
-- Constants
--
bj_PI = 3.14159
bj_E = 2.71828
bj_CELLWIDTH = 128.0
bj_CLIFFHEIGHT = 128.0
bj_UNIT_FACING = 270.0
bj_RADTODEG = 180.0/bj_PI
bj_DEGTORAD = bj_PI/180.0
bj_TEXT_DELAY_QUEST = 20.00
bj_TEXT_DELAY_QUESTUPDATE = 20.00
bj_TEXT_DELAY_QUESTDONE = 20.00
bj_TEXT_DELAY_QUESTFAILED = 20.00
bj_TEXT_DELAY_QUESTREQUIREMENT = 20.00
bj_TEXT_DELAY_MISSIONFAILED = 20.00
bj_TEXT_DELAY_ALWAYSHINT = 12.00
bj_TEXT_DELAY_HINT = 12.00
bj_TEXT_DELAY_SECRET = 10.00
bj_TEXT_DELAY_UNITACQUIRED = 15.00
bj_TEXT_DELAY_UNITAVAILABLE = 10.00
bj_TEXT_DELAY_ITEMACQUIRED = 10.00
bj_TEXT_DELAY_WARNING = 12.00
bj_QUEUE_DELAY_QUEST = 5.00
bj_QUEUE_DELAY_HINT = 5.00
bj_QUEUE_DELAY_SECRET = 3.00
bj_HANDICAP_EASY = 60.00
bj_GAME_STARTED_THRESHOLD = 0.01
bj_WAIT_FOR_COND_MIN_INTERVAL = 0.10
bj_POLLED_WAIT_INTERVAL = 0.10
bj_POLLED_WAIT_SKIP_THRESHOLD = 2.00
bj_MAX_INVENTORY = 6
bj_MAX_PLAYERS = GetBJMaxPlayers()
bj_PLAYER_NEUTRAL_VICTIM = GetBJPlayerNeutralVictim()
bj_PLAYER_NEUTRAL_EXTRA = GetBJPlayerNeutralExtra()
bj_MAX_PLAYER_SLOTS = GetBJMaxPlayerSlots()
bj_MAX_SKELETONS = 25
bj_MAX_STOCK_ITEM_SLOTS = 11
bj_MAX_STOCK_UNIT_SLOTS = 11
bj_MAX_ITEM_LEVEL = 10
-- but there is currently no script functionality exposed to do that
bj_TOD_DAWN = 6.00
bj_TOD_DUSK = 18.00
-- - Starting Time of Day (TOD)
-- - Starting Gold
-- - Starting Lumber
-- - Starting Hero Tokens (free heroes)
-- - Max heroes allowed per player
-- - Max heroes allowed per hero type
-- - Distance from start loc to search for nearby mines
--
bj_MELEE_STARTING_TOD = 8.00
bj_MELEE_STARTING_GOLD_V0 = 750
bj_MELEE_STARTING_GOLD_V1 = 500
bj_MELEE_STARTING_LUMBER_V0 = 200
bj_MELEE_STARTING_LUMBER_V1 = 150
bj_MELEE_STARTING_HERO_TOKENS = 1
bj_MELEE_HERO_LIMIT = 3
bj_MELEE_HERO_TYPE_LIMIT = 1
bj_MELEE_MINE_SEARCH_RADIUS = 2000
bj_MELEE_CLEAR_UNITS_RADIUS = 1500
bj_MELEE_CRIPPLE_TIMEOUT = 120.00
bj_MELEE_CRIPPLE_MSG_DURATION = 20.00
bj_MELEE_MAX_TWINKED_HEROES_V0 = 3
bj_MELEE_MAX_TWINKED_HEROES_V1 = 1
bj_CREEP_ITEM_DELAY = 0.50
bj_STOCK_RESTOCK_INITIAL_DELAY = 120
bj_STOCK_RESTOCK_INTERVAL = 30
bj_STOCK_MAX_ITERATIONS = 20
bj_MAX_DEST_IN_REGION_EVENTS = 64
bj_CAMERA_MIN_FARZ = 100
bj_CAMERA_DEFAULT_DISTANCE = 1650
bj_CAMERA_DEFAULT_FARZ = 5000
bj_CAMERA_DEFAULT_AOA = 304
bj_CAMERA_DEFAULT_FOV = 70
bj_CAMERA_DEFAULT_ROLL = 0
bj_CAMERA_DEFAULT_ROTATION = 90
bj_RESCUE_PING_TIME = 2.00
bj_NOTHING_SOUND_DURATION = 5.00
bj_TRANSMISSION_PING_TIME = 1.00
bj_TRANSMISSION_IND_RED = 255
bj_TRANSMISSION_IND_BLUE = 255
bj_TRANSMISSION_IND_GREEN = 255
bj_TRANSMISSION_IND_ALPHA = 255
bj_TRANSMISSION_PORT_HANGTIME = 1.50
bj_CINEMODE_INTERFACEFADE = 0.50
bj_CINEMODE_GAMESPEED = MAP_SPEED_NORMAL
bj_CINEMODE_VOLUME_UNITMOVEMENT = 0.40
bj_CINEMODE_VOLUME_UNITSOUNDS = 0.00
bj_CINEMODE_VOLUME_COMBAT = 0.40
bj_CINEMODE_VOLUME_SPELLS = 0.40
bj_CINEMODE_VOLUME_UI = 0.00
bj_CINEMODE_VOLUME_MUSIC = 0.55
bj_CINEMODE_VOLUME_AMBIENTSOUNDS = 1.00
bj_CINEMODE_VOLUME_FIRE = 0.60
bj_SPEECH_VOLUME_UNITMOVEMENT = 0.25
bj_SPEECH_VOLUME_UNITSOUNDS = 0.00
bj_SPEECH_VOLUME_COMBAT = 0.25
bj_SPEECH_VOLUME_SPELLS = 0.25
bj_SPEECH_VOLUME_UI = 0.00
bj_SPEECH_VOLUME_MUSIC = 0.55
bj_SPEECH_VOLUME_AMBIENTSOUNDS = 1.00
bj_SPEECH_VOLUME_FIRE = 0.60
bj_SMARTPAN_TRESHOLD_PAN = 500
bj_SMARTPAN_TRESHOLD_SNAP = 3500
bj_MAX_QUEUED_TRIGGERS = 100
bj_QUEUED_TRIGGER_TIMEOUT = 180.00
bj_CAMPAIGN_INDEX_T = 0
bj_CAMPAIGN_INDEX_H = 1
bj_CAMPAIGN_INDEX_U = 2
bj_CAMPAIGN_INDEX_O = 3
bj_CAMPAIGN_INDEX_N = 4
bj_CAMPAIGN_INDEX_XN = 5
bj_CAMPAIGN_INDEX_XH = 6
bj_CAMPAIGN_INDEX_XU = 7
bj_CAMPAIGN_INDEX_XO = 8
bj_CAMPAIGN_OFFSET_T = 0
bj_CAMPAIGN_OFFSET_H = 1
bj_CAMPAIGN_OFFSET_U = 2
bj_CAMPAIGN_OFFSET_O = 3
bj_CAMPAIGN_OFFSET_N = 4
bj_CAMPAIGN_OFFSET_XN = 0
bj_CAMPAIGN_OFFSET_XH = 1
bj_CAMPAIGN_OFFSET_XU = 2
bj_CAMPAIGN_OFFSET_XO = 3
-- Tutorial
bj_MISSION_INDEX_T00 = bj_CAMPAIGN_OFFSET_T * 1000 + 0
bj_MISSION_INDEX_T01 = bj_CAMPAIGN_OFFSET_T * 1000 + 1
-- Human
bj_MISSION_INDEX_H00 = bj_CAMPAIGN_OFFSET_H * 1000 + 0
bj_MISSION_INDEX_H01 = bj_CAMPAIGN_OFFSET_H * 1000 + 1
bj_MISSION_INDEX_H02 = bj_CAMPAIGN_OFFSET_H * 1000 + 2
bj_MISSION_INDEX_H03 = bj_CAMPAIGN_OFFSET_H * 1000 + 3
bj_MISSION_INDEX_H04 = bj_CAMPAIGN_OFFSET_H * 1000 + 4
bj_MISSION_INDEX_H05 = bj_CAMPAIGN_OFFSET_H * 1000 + 5
bj_MISSION_INDEX_H06 = bj_CAMPAIGN_OFFSET_H * 1000 + 6
bj_MISSION_INDEX_H07 = bj_CAMPAIGN_OFFSET_H * 1000 + 7
bj_MISSION_INDEX_H08 = bj_CAMPAIGN_OFFSET_H * 1000 + 8
bj_MISSION_INDEX_H09 = bj_CAMPAIGN_OFFSET_H * 1000 + 9
bj_MISSION_INDEX_H10 = bj_CAMPAIGN_OFFSET_H * 1000 + 10
bj_MISSION_INDEX_H11 = bj_CAMPAIGN_OFFSET_H * 1000 + 11
-- Undead
bj_MISSION_INDEX_U00 = bj_CAMPAIGN_OFFSET_U * 1000 + 0
bj_MISSION_INDEX_U01 = bj_CAMPAIGN_OFFSET_U * 1000 + 1
bj_MISSION_INDEX_U02 = bj_CAMPAIGN_OFFSET_U * 1000 + 2
bj_MISSION_INDEX_U03 = bj_CAMPAIGN_OFFSET_U * 1000 + 3
bj_MISSION_INDEX_U05 = bj_CAMPAIGN_OFFSET_U * 1000 + 4
bj_MISSION_INDEX_U07 = bj_CAMPAIGN_OFFSET_U * 1000 + 5
bj_MISSION_INDEX_U08 = bj_CAMPAIGN_OFFSET_U * 1000 + 6
bj_MISSION_INDEX_U09 = bj_CAMPAIGN_OFFSET_U * 1000 + 7
bj_MISSION_INDEX_U10 = bj_CAMPAIGN_OFFSET_U * 1000 + 8
bj_MISSION_INDEX_U11 = bj_CAMPAIGN_OFFSET_U * 1000 + 9
-- Orc
bj_MISSION_INDEX_O00 = bj_CAMPAIGN_OFFSET_O * 1000 + 0
bj_MISSION_INDEX_O01 = bj_CAMPAIGN_OFFSET_O * 1000 + 1
bj_MISSION_INDEX_O02 = bj_CAMPAIGN_OFFSET_O * 1000 + 2
bj_MISSION_INDEX_O03 = bj_CAMPAIGN_OFFSET_O * 1000 + 3
bj_MISSION_INDEX_O04 = bj_CAMPAIGN_OFFSET_O * 1000 + 4
bj_MISSION_INDEX_O05 = bj_CAMPAIGN_OFFSET_O * 1000 + 5
bj_MISSION_INDEX_O06 = bj_CAMPAIGN_OFFSET_O * 1000 + 6
bj_MISSION_INDEX_O07 = bj_CAMPAIGN_OFFSET_O * 1000 + 7
bj_MISSION_INDEX_O08 = bj_CAMPAIGN_OFFSET_O * 1000 + 8
bj_MISSION_INDEX_O09 = bj_CAMPAIGN_OFFSET_O * 1000 + 9
bj_MISSION_INDEX_O10 = bj_CAMPAIGN_OFFSET_O * 1000 + 10
-- Night Elf
bj_MISSION_INDEX_N00 = bj_CAMPAIGN_OFFSET_N * 1000 + 0
bj_MISSION_INDEX_N01 = bj_CAMPAIGN_OFFSET_N * 1000 + 1
bj_MISSION_INDEX_N02 = bj_CAMPAIGN_OFFSET_N * 1000 + 2
bj_MISSION_INDEX_N03 = bj_CAMPAIGN_OFFSET_N * 1000 + 3
bj_MISSION_INDEX_N04 = bj_CAMPAIGN_OFFSET_N * 1000 + 4
bj_MISSION_INDEX_N05 = bj_CAMPAIGN_OFFSET_N * 1000 + 5
bj_MISSION_INDEX_N06 = bj_CAMPAIGN_OFFSET_N * 1000 + 6
bj_MISSION_INDEX_N07 = bj_CAMPAIGN_OFFSET_N * 1000 + 7
bj_MISSION_INDEX_N08 = bj_CAMPAIGN_OFFSET_N * 1000 + 8
bj_MISSION_INDEX_N09 = bj_CAMPAIGN_OFFSET_N * 1000 + 9
-- Expansion Night Elf
bj_MISSION_INDEX_XN00 = bj_CAMPAIGN_OFFSET_XN * 1000 + 0
bj_MISSION_INDEX_XN01 = bj_CAMPAIGN_OFFSET_XN * 1000 + 1
bj_MISSION_INDEX_XN02 = bj_CAMPAIGN_OFFSET_XN * 1000 + 2
bj_MISSION_INDEX_XN03 = bj_CAMPAIGN_OFFSET_XN * 1000 + 3
bj_MISSION_INDEX_XN04 = bj_CAMPAIGN_OFFSET_XN * 1000 + 4
bj_MISSION_INDEX_XN05 = bj_CAMPAIGN_OFFSET_XN * 1000 + 5
bj_MISSION_INDEX_XN06 = bj_CAMPAIGN_OFFSET_XN * 1000 + 6
bj_MISSION_INDEX_XN07 = bj_CAMPAIGN_OFFSET_XN * 1000 + 7
bj_MISSION_INDEX_XN08 = bj_CAMPAIGN_OFFSET_XN * 1000 + 8
bj_MISSION_INDEX_XN09 = bj_CAMPAIGN_OFFSET_XN * 1000 + 9
bj_MISSION_INDEX_XN10 = bj_CAMPAIGN_OFFSET_XN * 1000 + 10
-- Expansion Human
bj_MISSION_INDEX_XH00 = bj_CAMPAIGN_OFFSET_XH * 1000 + 0
bj_MISSION_INDEX_XH01 = bj_CAMPAIGN_OFFSET_XH * 1000 + 1
bj_MISSION_INDEX_XH02 = bj_CAMPAIGN_OFFSET_XH * 1000 + 2
bj_MISSION_INDEX_XH03 = bj_CAMPAIGN_OFFSET_XH * 1000 + 3
bj_MISSION_INDEX_XH04 = bj_CAMPAIGN_OFFSET_XH * 1000 + 4
bj_MISSION_INDEX_XH05 = bj_CAMPAIGN_OFFSET_XH * 1000 + 5
bj_MISSION_INDEX_XH06 = bj_CAMPAIGN_OFFSET_XH * 1000 + 6
bj_MISSION_INDEX_XH07 = bj_CAMPAIGN_OFFSET_XH * 1000 + 7
bj_MISSION_INDEX_XH08 = bj_CAMPAIGN_OFFSET_XH * 1000 + 8
bj_MISSION_INDEX_XH09 = bj_CAMPAIGN_OFFSET_XH * 1000 + 9
-- Expansion Undead
bj_MISSION_INDEX_XU00 = bj_CAMPAIGN_OFFSET_XU * 1000 + 0
bj_MISSION_INDEX_XU01 = bj_CAMPAIGN_OFFSET_XU * 1000 + 1
bj_MISSION_INDEX_XU02 = bj_CAMPAIGN_OFFSET_XU * 1000 + 2
bj_MISSION_INDEX_XU03 = bj_CAMPAIGN_OFFSET_XU * 1000 + 3
bj_MISSION_INDEX_XU04 = bj_CAMPAIGN_OFFSET_XU * 1000 + 4
bj_MISSION_INDEX_XU05 = bj_CAMPAIGN_OFFSET_XU * 1000 + 5
bj_MISSION_INDEX_XU06 = bj_CAMPAIGN_OFFSET_XU * 1000 + 6
bj_MISSION_INDEX_XU07 = bj_CAMPAIGN_OFFSET_XU * 1000 + 7
bj_MISSION_INDEX_XU08 = bj_CAMPAIGN_OFFSET_XU * 1000 + 8
bj_MISSION_INDEX_XU09 = bj_CAMPAIGN_OFFSET_XU * 1000 + 9
bj_MISSION_INDEX_XU10 = bj_CAMPAIGN_OFFSET_XU * 1000 + 10
bj_MISSION_INDEX_XU11 = bj_CAMPAIGN_OFFSET_XU * 1000 + 11
bj_MISSION_INDEX_XU12 = bj_CAMPAIGN_OFFSET_XU * 1000 + 12
bj_MISSION_INDEX_XU13 = bj_CAMPAIGN_OFFSET_XU * 1000 + 13
bj_MISSION_INDEX_XO00 = bj_CAMPAIGN_OFFSET_XO * 1000 + 0
bj_MISSION_INDEX_XO01 = bj_CAMPAIGN_OFFSET_XO * 1000 + 1
bj_MISSION_INDEX_XO02 = bj_CAMPAIGN_OFFSET_XO * 1000 + 2
bj_MISSION_INDEX_XO03 = bj_CAMPAIGN_OFFSET_XO * 1000 + 3
bj_CINEMATICINDEX_TOP = 0
bj_CINEMATICINDEX_HOP = 1
bj_CINEMATICINDEX_HED = 2
bj_CINEMATICINDEX_OOP = 3
bj_CINEMATICINDEX_OED = 4
bj_CINEMATICINDEX_UOP = 5
bj_CINEMATICINDEX_UED = 6
bj_CINEMATICINDEX_NOP = 7
bj_CINEMATICINDEX_NED = 8
bj_CINEMATICINDEX_XOP = 9
bj_CINEMATICINDEX_XED = 10
bj_ALLIANCE_UNALLIED = 0
bj_ALLIANCE_UNALLIED_VISION = 1
bj_ALLIANCE_ALLIED = 2
bj_ALLIANCE_ALLIED_VISION = 3
bj_ALLIANCE_ALLIED_UNITS = 4
bj_ALLIANCE_ALLIED_ADVUNITS = 5
bj_ALLIANCE_NEUTRAL = 6
bj_ALLIANCE_NEUTRAL_VISION = 7
bj_KEYEVENTTYPE_DEPRESS = 0
bj_KEYEVENTTYPE_RELEASE = 1
bj_KEYEVENTKEY_LEFT = 0
bj_KEYEVENTKEY_RIGHT = 1
bj_KEYEVENTKEY_DOWN = 2
bj_KEYEVENTKEY_UP = 3
bj_MOUSEEVENTTYPE_DOWN = 0
bj_MOUSEEVENTTYPE_UP = 1
bj_MOUSEEVENTTYPE_MOVE = 2
bj_TIMETYPE_ADD = 0
bj_TIMETYPE_SET = 1
bj_TIMETYPE_SUB = 2
bj_CAMERABOUNDS_ADJUST_ADD = 0
bj_CAMERABOUNDS_ADJUST_SUB = 1
bj_QUESTTYPE_REQ_DISCOVERED = 0
bj_QUESTTYPE_REQ_UNDISCOVERED = 1
bj_QUESTTYPE_OPT_DISCOVERED = 2
bj_QUESTTYPE_OPT_UNDISCOVERED = 3
bj_QUESTMESSAGE_DISCOVERED = 0
bj_QUESTMESSAGE_UPDATED = 1
bj_QUESTMESSAGE_COMPLETED = 2
bj_QUESTMESSAGE_FAILED = 3
bj_QUESTMESSAGE_REQUIREMENT = 4
bj_QUESTMESSAGE_MISSIONFAILED = 5
bj_QUESTMESSAGE_ALWAYSHINT = 6
bj_QUESTMESSAGE_HINT = 7
bj_QUESTMESSAGE_SECRET = 8
bj_QUESTMESSAGE_UNITACQUIRED = 9
bj_QUESTMESSAGE_UNITAVAILABLE = 10
bj_QUESTMESSAGE_ITEMACQUIRED = 11
bj_QUESTMESSAGE_WARNING = 12
bj_SORTTYPE_SORTBYVALUE = 0
bj_SORTTYPE_SORTBYPLAYER = 1
bj_SORTTYPE_SORTBYLABEL = 2
bj_CINEFADETYPE_FADEIN = 0
bj_CINEFADETYPE_FADEOUT = 1
bj_CINEFADETYPE_FADEOUTIN = 2
bj_REMOVEBUFFS_POSITIVE = 0
bj_REMOVEBUFFS_NEGATIVE = 1
bj_REMOVEBUFFS_ALL = 2
bj_REMOVEBUFFS_NONTLIFE = 3
bj_BUFF_POLARITY_POSITIVE = 0
bj_BUFF_POLARITY_NEGATIVE = 1
bj_BUFF_POLARITY_EITHER = 2
bj_BUFF_RESIST_MAGIC = 0
bj_BUFF_RESIST_PHYSICAL = 1
bj_BUFF_RESIST_EITHER = 2
bj_BUFF_RESIST_BOTH = 3
bj_HEROSTAT_STR = 0
bj_HEROSTAT_AGI = 1
bj_HEROSTAT_INT = 2
bj_MODIFYMETHOD_ADD = 0
bj_MODIFYMETHOD_SUB = 1
bj_MODIFYMETHOD_SET = 2
bj_UNIT_STATE_METHOD_ABSOLUTE = 0
bj_UNIT_STATE_METHOD_RELATIVE = 1
bj_UNIT_STATE_METHOD_DEFAULTS = 2
bj_UNIT_STATE_METHOD_MAXIMUM = 3
bj_GATEOPERATION_CLOSE = 0
bj_GATEOPERATION_OPEN = 1
bj_GATEOPERATION_DESTROY = 2
bj_GAMECACHE_BOOLEAN = 0
bj_GAMECACHE_INTEGER = 1
bj_GAMECACHE_REAL = 2
bj_GAMECACHE_UNIT = 3
bj_GAMECACHE_STRING = 4
bj_HASHTABLE_BOOLEAN = 0
bj_HASHTABLE_INTEGER = 1
bj_HASHTABLE_REAL = 2
bj_HASHTABLE_STRING = 3
bj_HASHTABLE_HANDLE = 4
bj_ITEM_STATUS_HIDDEN = 0
bj_ITEM_STATUS_OWNED = 1
bj_ITEM_STATUS_INVULNERABLE = 2
bj_ITEM_STATUS_POWERUP = 3
bj_ITEM_STATUS_SELLABLE = 4
bj_ITEM_STATUS_PAWNABLE = 5
bj_ITEMCODE_STATUS_POWERUP = 0
bj_ITEMCODE_STATUS_SELLABLE = 1
bj_ITEMCODE_STATUS_PAWNABLE = 2
bj_MINIMAPPINGSTYLE_SIMPLE = 0
bj_MINIMAPPINGSTYLE_FLASHY = 1
bj_MINIMAPPINGSTYLE_ATTACK = 2
bj_CORPSE_MAX_DEATH_TIME = 8.00
bj_CORPSETYPE_FLESH = 0
bj_CORPSETYPE_BONE = 1
bj_ELEVATOR_BLOCKER_CODE = 'DTep'
bj_ELEVATOR_CODE01 = 'DTrf'
bj_ELEVATOR_CODE02 = 'DTrx'
bj_ELEVATOR_WALL_TYPE_ALL = 0
bj_ELEVATOR_WALL_TYPE_EAST = 1
bj_ELEVATOR_WALL_TYPE_NORTH = 2
bj_ELEVATOR_WALL_TYPE_SOUTH = 3
bj_ELEVATOR_WALL_TYPE_WEST = 4
-- Variables
--
--sound bj_pingMinimapSound = null
--*
--* Debugging Functions
--*
--***************************************************************************
function BJDebugMsg(str_msg) end
--*
--* Math Utility Functions
--*
--***************************************************************************
function RMinBJ(r_a, r_b) return real end
function RMaxBJ(r_a, r_b) return real end
function RAbsBJ(r_a) return real end
function RSignBJ(r_a) return real end
function IMinBJ(int_a, int_b) return integer end
function IMaxBJ(int_a, int_b) return integer end
function IAbsBJ(int_a) return integer end
function ISignBJ(int_a) return integer end
function SinBJ(r_degrees) return real end
function CosBJ(r_degrees) return real end
function TanBJ(r_degrees) return real end
function AsinBJ(r_degrees) return real end
function AcosBJ(r_degrees) return real end
function AtanBJ(r_degrees) return real end
function Atan2BJ(r_y, r_x) return real end
function AngleBetweenPoints(location_locA, location_locB) return real end
function DistanceBetweenPoints(location_locA, location_locB) return real end
function PolarProjectionBJ(location_source, r_dist, r_angle) return location end
function GetRandomDirectionDeg() return real end
function GetRandomPercentageBJ() return real end
function GetRandomLocInRect(rect_whichRect) return location end
-- Calculate the modulus/remainder of (dividend) divided by (divisor).
-- Examples: 18 mod 5 = 3. 15 mod 5 = 0. -8 mod 5 = 2.
--
function ModuloInteger(int_dividend, int_divisor) return integer end
-- be negative, but within (-divisor..0). We can add (divisor) to
-- shift this result into the desired range of (0..divisor).
-- Calculate the modulus/remainder of (dividend) divided by (divisor).
-- Examples: 13.000 mod 2.500 = 0.500. -6.000 mod 2.500 = 1.500.
--
function ModuloReal(r_dividend, r_divisor) return real end
-- be negative, but within (-divisor..0). We can add (divisor) to
-- shift this result into the desired range of (0..divisor).
function OffsetLocation(location_loc, r_dx, r_dy) return location end
function OffsetRectBJ(rect_r, r_dx, r_dy) return rect end
function RectFromCenterSizeBJ(location_center, r_width, r_height) return rect end
function RectContainsCoords(rect_r, r_x, r_y) return boolean end
function RectContainsLoc(rect_r, location_loc) return boolean end
function RectContainsUnit(rect_r, unit_whichUnit) return boolean end
function RectContainsItem(item_whichItem, rect_r) return boolean end
--*
--* Utility Constructs
--*
--***************************************************************************
-- Runs the trigger's actions if the trigger's conditions evaluate to true.
--
function ConditionalTriggerExecute(trigger_trig) end
-- Runs the trigger's actions if the trigger's conditions evaluate to true.
--
function TriggerExecuteBJ(trigger_trig, b_checkConditions) return boolean end
-- Arranges for a trigger to fire almost immediately, except that the calling
-- trigger is not interrupted as is the case with a TriggerExecute call.
-- Since the trigger executes normally, its conditions are still evaluated.
--
function PostTriggerExecuteBJ(trigger_trig, b_checkConditions) return boolean end
-- Debug - Display the contents of the trigger queue (as either null or "x"
-- for each entry).
function QueuedTriggerCheck() end
-- Searches the queue for a given trigger, returning the index of the
-- trigger within the queue if it is found, or -1 if it is not found.
--
function QueuedTriggerGetIndex(trigger_trig) return integer end
-- Determine which, if any, of the queued triggers is being removed.
-- Removes a trigger from the trigger queue, shifting other triggers down
-- to fill the unused space. If the currently running trigger is removed
-- in this manner, this function does NOT attempt to run the next trigger.
--
function QueuedTriggerRemoveByIndex(int_trigIndex) return boolean end
-- Attempt to execute the first trigger in the queue. If it fails, remove
-- it and execute the next one. Continue this cycle until a trigger runs,
-- or until the queue is empty.
--
function QueuedTriggerAttemptExec() return boolean end
-- Queues a trigger to be executed, assuring that such triggers are not
-- executed at the same time.
--
function QueuedTriggerAddBJ(trigger_trig, b_checkConditions) return boolean end
-- Make sure our queue isn't full. If it is, return failure.
-- Denotes the end of a queued trigger. Be sure to call this only once per
-- queued trigger, or risk stepping on the toes of other queued triggers.
--
function QueuedTriggerRemoveBJ(trigger_trig) end
-- Denotes the end of a queued trigger. Be sure to call this only once per
-- queued trigger, lest you step on the toes of other queued triggers.
--
function QueuedTriggerDoneBJ() end
-- Empty the trigger queue.
--
function QueuedTriggerClearBJ() end
-- Remove all but the currently executing trigger from the trigger queue.
--
function QueuedTriggerClearInactiveBJ() end
function QueuedTriggerCountBJ() return integer end
function IsTriggerQueueEmptyBJ() return boolean end
function IsTriggerQueuedBJ(trigger_trig) return boolean end
function GetForLoopIndexA() return integer end
function SetForLoopIndexA(int_newIndex) end
function GetForLoopIndexB() return integer end
function SetForLoopIndexB(int_newIndex) end
-- We can't do game-time waits, so this simulates one by starting a timer
-- and polling until the timer expires.
function PolledWait(r_duration) end
-- duration instead of checking every interval, to minimize the
-- polling on long waits.
function IntegerTertiaryOp(b_flag, int_valueA, int_valueB) return integer end
--*
--* General Utility Functions
--* These functions exist purely to make the trigger dialogs cleaner and
--* more comprehensible.
--*
--***************************************************************************
function DoNothing() end
-- This function does . WorldEdit should should eventually ignore
-- CommentString triggers during script generation, but until such a time,
-- this function will serve as a stub.
--
function CommentString(str_commentString) end
-- This function returns the input string, converting it from the localized text, if necessary
--
function StringIdentity(str_theString) return string end
function GetBooleanAnd(b_valueA, b_valueB) return boolean end
function GetBooleanOr(b_valueA, b_valueB) return boolean end
-- Converts a percentage (real, 0..100) into a scaled integer (0..max),
-- clipping the result to 0..max in case the input is invalid.
--
function PercentToInt(r_percentage, int_max) return integer end
function PercentTo255(r_percentage) return integer end
function GetTimeOfDay() return real end
function SetTimeOfDay(r_whatTime) end
function SetTimeOfDayScalePercentBJ(r_scalePercent) end
function GetTimeOfDayScalePercentBJ() return real end
function PlaySound(str_soundName) end
function CompareLocationsBJ(location_A, location_B) return boolean end
function CompareRectsBJ(rect_A, rect_B) return boolean end
-- Returns a square rect that exactly encompasses the specified circle.
--
function GetRectFromCircleBJ(location_center, r_radius) return rect end
--*
--* Camera Utility Functions
--*
--***************************************************************************
function GetCurrentCameraSetup() return camerasetup end
function CameraSetupApplyForPlayer(b_doPan, camerasetup_whichSetup, player_whichPlayer, r_duration) end
function CameraSetupGetFieldSwap(camerafield_whichField, camerasetup_whichSetup) return real end
function SetCameraFieldForPlayer(player_whichPlayer, camerafield_whichField, r_value, r_duration) end
function SetCameraTargetControllerNoZForPlayer(player_whichPlayer, unit_whichUnit, r_xoffset, r_yoffset, b_inheritOrientation) end
function SetCameraPositionForPlayer(player_whichPlayer, r_x, r_y) end
function SetCameraPositionLocForPlayer(player_whichPlayer, location_loc) end
function RotateCameraAroundLocBJ(r_degrees, location_loc, player_whichPlayer, r_duration) end
function PanCameraToForPlayer(player_whichPlayer, r_x, r_y) end
function PanCameraToLocForPlayer(player_whichPlayer, location_loc) end
function PanCameraToTimedForPlayer(player_whichPlayer, r_x, r_y, r_duration) end
function PanCameraToTimedLocForPlayer(player_whichPlayer, location_loc, r_duration) end
function PanCameraToTimedLocWithZForPlayer(player_whichPlayer, location_loc, r_zOffset, r_duration) end
function SmartCameraPanBJ(player_whichPlayer, location_loc, r_duration) end
function SetCinematicCameraForPlayer(player_whichPlayer, str_cameraModelFile) end
function ResetToGameCameraForPlayer(player_whichPlayer, r_duration) end
function CameraSetSourceNoiseForPlayer(player_whichPlayer, r_magnitude, r_velocity) end
function CameraSetTargetNoiseForPlayer(player_whichPlayer, r_magnitude, r_velocity) end
function CameraSetEQNoiseForPlayer(player_whichPlayer, r_magnitude) end
function CameraClearNoiseForPlayer(player_whichPlayer) end
-- Query the current camera bounds.
--
function GetCurrentCameraBoundsMapRectBJ() return rect end
-- Query the initial camera bounds, as defined at map init.
--
function GetCameraBoundsMapRect() return rect end
-- Query the playable map area, as defined at map init.
--
function GetPlayableMapRect() return rect end
-- Query the entire map area, as defined at map init.
--
function GetEntireMapRect() return rect end
function SetCameraBoundsToRect(rect_r) end
function SetCameraBoundsToRectForPlayerBJ(player_whichPlayer, rect_r) end
function AdjustCameraBoundsBJ(int_adjustMethod, r_dxWest, r_dxEast, r_dyNorth, r_dySouth) end
function AdjustCameraBoundsForPlayerBJ(int_adjustMethod, player_whichPlayer, r_dxWest, r_dxEast, r_dyNorth, r_dySouth) end
function SetCameraQuickPositionForPlayer(player_whichPlayer, r_x, r_y) end
function SetCameraQuickPositionLocForPlayer(player_whichPlayer, location_loc) end
function SetCameraQuickPositionLoc(location_loc) end
function StopCameraForPlayerBJ(player_whichPlayer) end
function SetCameraOrientControllerForPlayerBJ(player_whichPlayer, unit_whichUnit, r_xoffset, r_yoffset) end
function CameraSetSmoothingFactorBJ(r_factor) end
function CameraResetSmoothingFactorBJ() end
--*
--* Text Utility Functions
--*
--***************************************************************************
function DisplayTextToForce(force_toForce, str_message) end
function DisplayTimedTextToForce(force_toForce, r_duration, str_message) end
function ClearTextMessagesBJ(force_toForce) end
-- The parameters for the API Substring function are unintuitive, so this
-- merely performs a translation for the starting index.
--
function SubStringBJ(str_source, int_start, int_end) return string end
--*
--* Event Registration Utility Functions
--*
--***************************************************************************
function TriggerRegisterTimerEventPeriodic(trigger_trig, r_timeout) return event end
function TriggerRegisterTimerEventSingle(trigger_trig, r_timeout) return event end
function TriggerRegisterTimerExpireEventBJ(trigger_trig, timer_t) return event end
function TriggerRegisterPlayerUnitEventSimple(trigger_trig, player_whichPlayer, playerunitevent_whichEvent) return event end
function TriggerRegisterAnyUnitEventBJ(trigger_trig, playerunitevent_whichEvent) end
function TriggerRegisterPlayerSelectionEventBJ(trigger_trig, player_whichPlayer, b_selected) return event end
function TriggerRegisterPlayerKeyEventBJ(trigger_trig, player_whichPlayer, int_keType, int_keKey) return event end
function TriggerRegisterPlayerMouseEventBJ(trigger_trig, player_whichPlayer, int_meType) return event end
function TriggerRegisterPlayerEventVictory(trigger_trig, player_whichPlayer) return event end
function TriggerRegisterPlayerEventDefeat(trigger_trig, player_whichPlayer) return event end
function TriggerRegisterPlayerEventLeave(trigger_trig, player_whichPlayer) return event end
function TriggerRegisterPlayerEventAllianceChanged(trigger_trig, player_whichPlayer) return event end
function TriggerRegisterPlayerEventEndCinematic(trigger_trig, player_whichPlayer) return event end
function TriggerRegisterGameStateEventTimeOfDay(trigger_trig, limitop_opcode, r_limitval) return event end
function TriggerRegisterEnterRegionSimple(trigger_trig, region_whichRegion) return event end
function TriggerRegisterLeaveRegionSimple(trigger_trig, region_whichRegion) return event end
function TriggerRegisterEnterRectSimple(trigger_trig, rect_r) return event end
function TriggerRegisterLeaveRectSimple(trigger_trig, rect_r) return event end
function TriggerRegisterDistanceBetweenUnits(trigger_trig, unit_whichUnit, boolexpr_condition, r_range) return event end
function TriggerRegisterUnitInRangeSimple(trigger_trig, r_range, unit_whichUnit) return event end
function TriggerRegisterUnitLifeEvent(trigger_trig, unit_whichUnit, limitop_opcode, r_limitval) return event end
function TriggerRegisterUnitManaEvent(trigger_trig, unit_whichUnit, limitop_opcode, r_limitval) return event end
function TriggerRegisterDialogEventBJ(trigger_trig, dialog_whichDialog) return event end
function TriggerRegisterShowSkillEventBJ(trigger_trig) return event end
function TriggerRegisterBuildSubmenuEventBJ(trigger_trig) return event end
function TriggerRegisterGameLoadedEventBJ(trigger_trig) return event end
function TriggerRegisterGameSavedEventBJ(trigger_trig) return event end
function RegisterDestDeathInRegionEnum() end
function TriggerRegisterDestDeathInRegionEvent(trigger_trig, rect_r) end
--*
--* Environment Utility Functions
--*
--***************************************************************************
function AddWeatherEffectSaveLast(rect_where, int_effectID) return weathereffect end
function GetLastCreatedWeatherEffect() return weathereffect end
function RemoveWeatherEffectBJ(weathereffect_whichWeatherEffect) end
function TerrainDeformationCraterBJ(r_duration, b_permanent, location_where, r_radius, r_depth) return terraindeformation end
function TerrainDeformationRippleBJ(r_duration, b_limitNeg, location_where, r_startRadius, r_endRadius, r_depth, r_wavePeriod, r_waveWidth) return terraindeformation end
function TerrainDeformationWaveBJ(r_duration, location_source, location_target, r_radius, r_depth, r_trailDelay) return terraindeformation end
function TerrainDeformationRandomBJ(r_duration, location_where, r_radius, r_minDelta, r_maxDelta, r_updateInterval) return terraindeformation end
function TerrainDeformationStopBJ(terraindeformation_deformation, r_duration) end
function GetLastCreatedTerrainDeformation() return terraindeformation end
function AddLightningLoc(str_codeName, location_where1, location_where2) return lightning end
function DestroyLightningBJ(lightning_whichBolt) return boolean end
function MoveLightningLoc(lightning_whichBolt, location_where1, location_where2) return boolean end
function GetLightningColorABJ(lightning_whichBolt) return real end
function GetLightningColorRBJ(lightning_whichBolt) return real end
function GetLightningColorGBJ(lightning_whichBolt) return real end
function GetLightningColorBBJ(lightning_whichBolt) return real end
function SetLightningColorBJ(lightning_whichBolt, r_r, r_g, r_b, r_a) return boolean end
function GetLastCreatedLightningBJ() return lightning end
function GetAbilityEffectBJ(int_abilcode, effecttype_t, int_index) return string end
function GetAbilitySoundBJ(int_abilcode, soundtype_t) return string end
function GetTerrainCliffLevelBJ(location_where) return integer end
function GetTerrainTypeBJ(location_where) return integer end
function GetTerrainVarianceBJ(location_where) return integer end
function SetTerrainTypeBJ(location_where, int_terrainType, int_variation, int_area, int_shape) end
function IsTerrainPathableBJ(location_where, pathingtype_t) return boolean end
function SetTerrainPathableBJ(location_where, pathingtype_t, b_flag) end
function SetWaterBaseColorBJ(r_red, r_green, r_blue, r_transparency) end
function CreateFogModifierRectSimple(player_whichPlayer, fogstate_whichFogState, rect_r, b_afterUnits) return fogmodifier end
function CreateFogModifierRadiusLocSimple(player_whichPlayer, fogstate_whichFogState, location_center, r_radius, b_afterUnits) return fogmodifier end
-- Version of CreateFogModifierRect that assumes use of sharedVision and
-- gives the option of immediately enabling the modifier, so that triggers
-- can default to modifiers that are immediately enabled.
--
function CreateFogModifierRectBJ(b_enabled, player_whichPlayer, fogstate_whichFogState, rect_r) return fogmodifier end
-- Version of CreateFogModifierRadius that assumes use of sharedVision and
-- gives the option of immediately enabling the modifier, so that triggers
-- can default to modifiers that are immediately enabled.
--
function CreateFogModifierRadiusLocBJ(b_enabled, player_whichPlayer, fogstate_whichFogState, location_center, r_radius) return fogmodifier end
function GetLastCreatedFogModifier() return fogmodifier end
function FogEnableOn() end
function FogEnableOff() end
function FogMaskEnableOn() end
function FogMaskEnableOff() end
function UseTimeOfDayBJ(b_flag) end
function SetTerrainFogExBJ(int_style, r_zstart, r_zend, r_density, r_red, r_green, r_blue) end
function ResetTerrainFogBJ() end
function SetDoodadAnimationBJ(str_animName, int_doodadID, r_radius, location_center) end
function SetDoodadAnimationRectBJ(str_animName, int_doodadID, rect_r) end
function AddUnitAnimationPropertiesBJ(b_add, str_animProperties, unit_whichUnit) end
function CreateImageBJ(str_file, r_size, location_where, r_zOffset, int_imageType) return image end
function ShowImageBJ(b_flag, image_whichImage) end
function SetImagePositionBJ(image_whichImage, location_where, r_zOffset) end
function SetImageColorBJ(image_whichImage, r_red, r_green, r_blue, r_alpha) end
function GetLastCreatedImage() return image end
function CreateUbersplatBJ(location_where, str_name, r_red, r_green, r_blue, r_alpha, b_forcePaused, b_noBirthTime) return ubersplat end
function ShowUbersplatBJ(b_flag, ubersplat_whichSplat) end
function GetLastCreatedUbersplat() return ubersplat end
--*
--* Sound Utility Functions
--*
--***************************************************************************
function PlaySoundBJ(sound_soundHandle) end
function StopSoundBJ(sound_soundHandle, b_fadeOut) end
function SetSoundVolumeBJ(sound_soundHandle, r_volumePercent) end
function SetSoundOffsetBJ(r_newOffset, sound_soundHandle) end
function SetSoundDistanceCutoffBJ(sound_soundHandle, r_cutoff) end
function SetSoundPitchBJ(sound_soundHandle, r_pitch) end
function SetSoundPositionLocBJ(sound_soundHandle, location_loc, r_z) end
function AttachSoundToUnitBJ(sound_soundHandle, unit_whichUnit) end
function SetSoundConeAnglesBJ(sound_soundHandle, r_inside, r_outside, r_outsideVolumePercent) end
function KillSoundWhenDoneBJ(sound_soundHandle) end
function PlaySoundAtPointBJ(sound_soundHandle, r_volumePercent, location_loc, r_z) end
function PlaySoundOnUnitBJ(sound_soundHandle, r_volumePercent, unit_whichUnit) end
function PlaySoundFromOffsetBJ(sound_soundHandle, r_volumePercent, r_startingOffset) end
function PlayMusicBJ(str_musicFileName) end
function PlayMusicExBJ(str_musicFileName, r_startingOffset, r_fadeInTime) end
function SetMusicOffsetBJ(r_newOffset) end
function PlayThematicMusicBJ(str_musicName) end
function PlayThematicMusicExBJ(str_musicName, r_startingOffset) end
function SetThematicMusicOffsetBJ(r_newOffset) end
function EndThematicMusicBJ() end
function StopMusicBJ(b_fadeOut) end
function ResumeMusicBJ() end
function SetMusicVolumeBJ(r_volumePercent) end
function GetSoundDurationBJ(sound_soundHandle) return real end
function GetSoundFileDurationBJ(str_musicFileName) return real end
function GetLastPlayedSound() return sound end
function GetLastPlayedMusic() return string end
function VolumeGroupSetVolumeBJ(volumegroup_vgroup, r_percent) end
function SetCineModeVolumeGroupsImmediateBJ() end
function SetCineModeVolumeGroupsBJ() end
-- Delay the request if it occurs at map init.
function SetSpeechVolumeGroupsImmediateBJ() end
function SetSpeechVolumeGroupsBJ() end
-- Delay the request if it occurs at map init.
function VolumeGroupResetImmediateBJ() end
function VolumeGroupResetBJ() end
-- Delay the request if it occurs at map init.
function GetSoundIsPlayingBJ(sound_soundHandle) return boolean end
function WaitForSoundBJ(sound_soundHandle, r_offset) end
function SetMapMusicIndexedBJ(str_musicName, int_index) end
function SetMapMusicRandomBJ(str_musicName) end
function ClearMapMusicBJ() end
function SetStackedSoundBJ(b_add, sound_soundHandle, rect_r) end
function StartSoundForPlayerBJ(player_whichPlayer, sound_soundHandle) end
function VolumeGroupSetVolumeForPlayerBJ(player_whichPlayer, volumegroup_vgroup, r_scale) end
function EnableDawnDusk(b_flag) end
function IsDawnDuskEnabled() return boolean end
--*
--* Day/Night ambient sounds
--*
--***************************************************************************
function SetAmbientDaySound(str_inLabel) end
function SetAmbientNightSound(str_inLabel) end
--*
--* Special Effect Utility Functions
--*
--***************************************************************************
function AddSpecialEffectLocBJ(location_where, str_modelName) return effect end
function AddSpecialEffectTargetUnitBJ(str_attachPointName, widget_targetWidget, str_modelName) return effect end
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
-- Commented out - Destructibles have no attachment points.
--
--function AddSpecialEffectTargetDestructableBJ takes string attachPointName, widget targetWidget, string modelName returns effect
-- return AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName)
--endfunction
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
-- Commented out - Items have no attachment points.
--
--function AddSpecialEffectTargetItemBJ takes string attachPointName, widget targetWidget, string modelName returns effect
-- return AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName)
--endfunction
function DestroyEffectBJ(effect_whichEffect) end
function GetLastCreatedEffectBJ() return effect end
--*
--* Hero and Item Utility Functions
--*
--***************************************************************************
function GetItemLoc(item_whichItem) return location end
function GetItemLifeBJ(widget_whichWidget) return real end
function SetItemLifeBJ(widget_whichWidget, r_life) end
function AddHeroXPSwapped(int_xpToAdd, unit_whichHero, b_showEyeCandy) end
function SetHeroLevelBJ(unit_whichHero, int_newLevel, b_showEyeCandy) end
function DecUnitAbilityLevelSwapped(int_abilcode, unit_whichUnit) return integer end
function IncUnitAbilityLevelSwapped(int_abilcode, unit_whichUnit) return integer end
function SetUnitAbilityLevelSwapped(int_abilcode, unit_whichUnit, int_level) return integer end
function GetUnitAbilityLevelSwapped(int_abilcode, unit_whichUnit) return integer end
function UnitHasBuffBJ(unit_whichUnit, int_buffcode) return boolean end
function UnitRemoveBuffBJ(int_buffcode, unit_whichUnit) return boolean end
function UnitAddItemSwapped(item_whichItem, unit_whichHero) return boolean end
function UnitAddItemByIdSwapped(int_itemId, unit_whichHero) return item end
-- Create the item at the hero's feet first, and then give it to him.
-- This is to ensure that the item will be left at the hero's feet if
-- his inventory is full.
function UnitRemoveItemSwapped(item_whichItem, unit_whichHero) end
-- Translates 0-based slot indices to 1-based slot indices.
--
function UnitRemoveItemFromSlotSwapped(int_itemSlot, unit_whichHero) return item end
function CreateItemLoc(int_itemId, location_loc) return item end
function GetLastCreatedItem() return item end
function GetLastRemovedItem() return item end
function SetItemPositionLoc(item_whichItem, location_loc) end
function GetLearnedSkillBJ() return integer end
function SuspendHeroXPBJ(b_flag, unit_whichHero) end
function SetPlayerHandicapXPBJ(player_whichPlayer, r_handicapPercent) end
function GetPlayerHandicapXPBJ(player_whichPlayer) return real end
function SetPlayerHandicapBJ(player_whichPlayer, r_handicapPercent) end
function GetPlayerHandicapBJ(player_whichPlayer) return real end
function GetHeroStatBJ(int_whichStat, unit_whichHero, b_includeBonuses) return integer end
function SetHeroStat(unit_whichHero, int_whichStat, int_value) end
-- Ignore requests for negative hero stats.
function ModifyHeroStat(int_whichStat, unit_whichHero, int_modifyMethod, int_value) end
function ModifyHeroSkillPoints(unit_whichHero, int_modifyMethod, int_value) return boolean end
function UnitDropItemPointBJ(unit_whichUnit, item_whichItem, r_x, r_y) return boolean end
function UnitDropItemPointLoc(unit_whichUnit, item_whichItem, location_loc) return boolean end
function UnitDropItemSlotBJ(unit_whichUnit, item_whichItem, int_slot) return boolean end
function UnitDropItemTargetBJ(unit_whichUnit, item_whichItem, widget_target) return boolean end
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
function UnitUseItemDestructable(unit_whichUnit, item_whichItem, widget_target) return boolean end
function UnitUseItemPointLoc(unit_whichUnit, item_whichItem, location_loc) return boolean end
-- Translates 0-based slot indices to 1-based slot indices.
--
function UnitItemInSlotBJ(unit_whichUnit, int_itemSlot) return item end
-- Translates 0-based slot indices to 1-based slot indices.
--
function GetInventoryIndexOfItemTypeBJ(unit_whichUnit, int_itemId) return integer end
function GetItemOfTypeFromUnitBJ(unit_whichUnit, int_itemId) return item end
function UnitHasItemOfTypeBJ(unit_whichUnit, int_itemId) return boolean end
function UnitInventoryCount(unit_whichUnit) return integer end
function UnitInventorySizeBJ(unit_whichUnit) return integer end
function SetItemInvulnerableBJ(item_whichItem, b_flag) end
function SetItemDropOnDeathBJ(item_whichItem, b_flag) end
function SetItemDroppableBJ(item_whichItem, b_flag) end
function SetItemPlayerBJ(item_whichItem, player_whichPlayer, b_changeColor) end
function SetItemVisibleBJ(b_show, item_whichItem) end
function IsItemHiddenBJ(item_whichItem) return boolean end
function ChooseRandomItemBJ(int_level) return integer end
function ChooseRandomItemExBJ(int_level, itemtype_whichType) return integer end
function ChooseRandomNPBuildingBJ() return integer end
function ChooseRandomCreepBJ(int_level) return integer end
function EnumItemsInRectBJ(rect_r, code_actionFunc) end
-- See GroupPickRandomUnitEnum for the details of this algorithm.
--
function RandomItemInRectBJEnum() end
-- Picks a random item from within a rect, matching a condition
--
function RandomItemInRectBJ(rect_r, boolexpr_filter) return item end
-- Picks a random item from within a rect
--
function RandomItemInRectSimpleBJ(rect_r) return item end
function CheckItemStatus(item_whichItem, int_status) return boolean end
function CheckItemcodeStatus(int_itemId, int_status) return boolean end
--*
--* Unit Utility Functions
--*
--***************************************************************************
function UnitId2OrderIdBJ(int_unitId) return integer end
function String2UnitIdBJ(str_unitIdString) return integer end
function UnitId2StringBJ(int_unitId) return string end
function String2OrderIdBJ(str_orderIdString) return integer end
function OrderId2StringBJ(int_orderId) return string end
function GetIssuedOrderIdBJ() return integer end
function GetKillingUnitBJ() return unit end
function CreateUnitAtLocSaveLast(player_id, int_unitid, location_loc, r_face) return unit end
function GetLastCreatedUnit() return unit end
function CreateNUnitsAtLoc(int_count, int_unitId, player_whichPlayer, location_loc, r_face) return group end
function CreateNUnitsAtLocFacingLocBJ(int_count, int_unitId, player_whichPlayer, location_loc, location_lookAt) return group end
function GetLastCreatedGroupEnum() end
function GetLastCreatedGroup() return group end
function CreateCorpseLocBJ(int_unitid, player_whichPlayer, location_loc) return unit end
function UnitSuspendDecayBJ(b_suspend, unit_whichUnit) end
function DelayedSuspendDecayStopAnimEnum() end
function DelayedSuspendDecayBoneEnum() end
-- Game code explicitly sets the animation back to "decay bone" after the
-- initial corpse fades away, so we reset it now. It's best not to show
-- off corpses thus created until after this grace period has passed.
--
function DelayedSuspendDecayFleshEnum() end
-- Waits a short period of time to ensure that the corpse is decaying, and
-- then suspend the animation and corpse decay.
--
function DelayedSuspendDecay() end
-- the global versions, so that this function can handle overlapping
-- calls.
function DelayedSuspendDecayCreate() end
function CreatePermanentCorpseLocBJ(int_style, int_unitid, player_whichPlayer, location_loc, r_facing) return unit end
function GetUnitStateSwap(unitstate_whichState, unit_whichUnit) return real end
function GetUnitStatePercent(unit_whichUnit, unitstate_whichState, unitstate_whichMaxState) return real end
function GetUnitLifePercent(unit_whichUnit) return real end
function GetUnitManaPercent(unit_whichUnit) return real end
function SelectUnitSingle(unit_whichUnit) end
function SelectGroupBJEnum() end
function SelectGroupBJ(group_g) end
function SelectUnitAdd(unit_whichUnit) end
function SelectUnitRemove(unit_whichUnit) end
function ClearSelectionForPlayer(player_whichPlayer) end
function SelectUnitForPlayerSingle(unit_whichUnit, player_whichPlayer) end
function SelectGroupForPlayerBJ(group_g, player_whichPlayer) end
function SelectUnitAddForPlayer(unit_whichUnit, player_whichPlayer) end
function SelectUnitRemoveForPlayer(unit_whichUnit, player_whichPlayer) end
function SetUnitLifeBJ(unit_whichUnit, r_newValue) end
function SetUnitManaBJ(unit_whichUnit, r_newValue) end
function SetUnitLifePercentBJ(unit_whichUnit, r_percent) end
function SetUnitManaPercentBJ(unit_whichUnit, r_percent) end
function IsUnitDeadBJ(unit_whichUnit) return boolean end
function IsUnitAliveBJ(unit_whichUnit) return boolean end
function IsUnitGroupDeadBJEnum() end
-- Returns true if every unit of the group is dead.
--
function IsUnitGroupDeadBJ(group_g) return boolean end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.
function IsUnitGroupEmptyBJEnum() end
-- Returns true if the group contains no units.
--
function IsUnitGroupEmptyBJ(group_g) return boolean end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.
function IsUnitGroupInRectBJEnum() end
-- Returns true if every unit of the group is within the given rect.
--
function IsUnitGroupInRectBJ(group_g, rect_r) return boolean end
function IsUnitHiddenBJ(unit_whichUnit) return boolean end
function ShowUnitHide(unit_whichUnit) end
function ShowUnitShow(unit_whichUnit) end
-- Prevent dead heroes from being unhidden.
function IssueHauntOrderAtLocBJFilter() return boolean end
function IssueHauntOrderAtLocBJ(unit_whichPeon, location_loc) return boolean end
function IssueBuildOrderByIdLocBJ(unit_whichPeon, int_unitId, location_loc) return boolean end
function IssueTrainOrderByIdBJ(unit_whichUnit, int_unitId) return boolean end
function GroupTrainOrderByIdBJ(group_g, int_unitId) return boolean end
function IssueUpgradeOrderByIdBJ(unit_whichUnit, int_techId) return boolean end
function GetAttackedUnitBJ() return unit end
function SetUnitFlyHeightBJ(unit_whichUnit, r_newHeight, r_rate) end
function SetUnitTurnSpeedBJ(unit_whichUnit, r_turnSpeed) end
function SetUnitPropWindowBJ(unit_whichUnit, r_propWindow) end
function GetUnitPropWindowBJ(unit_whichUnit) return real end
function GetUnitDefaultPropWindowBJ(unit_whichUnit) return real end
function SetUnitBlendTimeBJ(unit_whichUnit, r_blendTime) end
function SetUnitAcquireRangeBJ(unit_whichUnit, r_acquireRange) end
function UnitSetCanSleepBJ(unit_whichUnit, b_canSleep) end
function UnitCanSleepBJ(unit_whichUnit) return boolean end
function UnitWakeUpBJ(unit_whichUnit) end
function UnitIsSleepingBJ(unit_whichUnit) return boolean end
function WakePlayerUnitsEnum() end
function WakePlayerUnits(player_whichPlayer) end
function EnableCreepSleepBJ(b_enable) end
function UnitGenerateAlarms(unit_whichUnit, b_generate) return boolean end
function DoesUnitGenerateAlarms(unit_whichUnit) return boolean end
function PauseAllUnitsBJEnum() end
-- Pause all units
function PauseAllUnitsBJ(b_pause) end
function PauseUnitBJ(b_pause, unit_whichUnit) end
function IsUnitPausedBJ(unit_whichUnit) return boolean end
function UnitPauseTimedLifeBJ(b_flag, unit_whichUnit) end
function UnitApplyTimedLifeBJ(r_duration, int_buffId, unit_whichUnit) end
function UnitShareVisionBJ(b_share, unit_whichUnit, player_whichPlayer) end
function UnitRemoveBuffsBJ(int_buffType, unit_whichUnit) end
function UnitRemoveBuffsExBJ(int_polarity, int_resist, unit_whichUnit, b_bTLife, b_bAura) end
function UnitCountBuffsExBJ(int_polarity, int_resist, unit_whichUnit, b_bTLife, b_bAura) return integer end
function UnitRemoveAbilityBJ(int_abilityId, unit_whichUnit) return boolean end
function UnitAddAbilityBJ(int_abilityId, unit_whichUnit) return boolean end
function UnitRemoveTypeBJ(unittype_whichType, unit_whichUnit) return boolean end
function UnitAddTypeBJ(unittype_whichType, unit_whichUnit) return boolean end
function UnitMakeAbilityPermanentBJ(b_permanent, int_abilityId, unit_whichUnit) return boolean end
function SetUnitExplodedBJ(unit_whichUnit, b_exploded) end
function ExplodeUnitBJ(unit_whichUnit) end
function GetTransportUnitBJ() return unit end
function GetLoadedUnitBJ() return unit end
function IsUnitInTransportBJ(unit_whichUnit, unit_whichTransport) return boolean end
function IsUnitLoadedBJ(unit_whichUnit) return boolean end
function IsUnitIllusionBJ(unit_whichUnit) return boolean end
-- This attempts to replace a unit with a new unit type by creating a new
-- unit of the desired type using the old unit's location, facing, etc.
--
function ReplaceUnitBJ(unit_whichUnit, int_newUnitId, int_unitStateMethod) return unit end
-- If both units have mana, do the same for mana.
-- If the new unit has mana, do the same for mana.
--call PauseUnit(newUnit, IsUnitPaused(oldUnit))
-- hidden units, so kill the original unit if it was previously hidden.
function GetLastReplacedUnitBJ() return unit end
function SetUnitPositionLocFacingBJ(unit_whichUnit, location_loc, r_facing) end
function SetUnitPositionLocFacingLocBJ(unit_whichUnit, location_loc, location_lookAt) end
function AddItemToStockBJ(int_itemId, unit_whichUnit, int_currentStock, int_stockMax) end
function AddUnitToStockBJ(int_unitId, unit_whichUnit, int_currentStock, int_stockMax) end
function RemoveItemFromStockBJ(int_itemId, unit_whichUnit) end
function RemoveUnitFromStockBJ(int_unitId, unit_whichUnit) end
function SetUnitUseFoodBJ(b_enable, unit_whichUnit) end
function UnitDamagePointLoc(unit_whichUnit, r_delay, r_radius, location_loc, r_amount, attacktype_whichAttack, damagetype_whichDamage) return boolean end
function UnitDamageTargetBJ(unit_whichUnit, unit_target, r_amount, attacktype_whichAttack, damagetype_whichDamage) return boolean end
--*
--* Destructable Utility Functions
--*
--***************************************************************************
function CreateDestructableLoc(int_objectid, location_loc, r_facing, r_scale, int_variation) return destructable end
function CreateDeadDestructableLocBJ(int_objectid, location_loc, r_facing, r_scale, int_variation) return destructable end
function GetLastCreatedDestructable() return destructable end
function ShowDestructableBJ(b_flag, destructable_d) end
function SetDestructableInvulnerableBJ(destructable_d, b_flag) end
function IsDestructableInvulnerableBJ(destructable_d) return boolean end
function GetDestructableLoc(destructable_whichDestructable) return location end
function EnumDestructablesInRectAll(rect_r, code_actionFunc) end
function EnumDestructablesInCircleBJFilter() return boolean end
function IsDestructableDeadBJ(destructable_d) return boolean end
function IsDestructableAliveBJ(destructable_d) return boolean end
-- See GroupPickRandomUnitEnum for the details of this algorithm.
--
function RandomDestructableInRectBJEnum() end
-- Picks a random destructable from within a rect, matching a condition
--
function RandomDestructableInRectBJ(rect_r, boolexpr_filter) return destructable end
-- Picks a random destructable from within a rect
--
function RandomDestructableInRectSimpleBJ(rect_r) return destructable end
-- Enumerates within a rect, with a filter to narrow the enumeration down
-- objects within a circular area.
--
function EnumDestructablesInCircleBJ(r_radius, location_loc, code_actionFunc) end
function SetDestructableLifePercentBJ(destructable_d, r_percent) end
function SetDestructableMaxLifeBJ(destructable_d, r_max) end
function ModifyGateBJ(int_gateOperation, destructable_d) end
-- Determine the elevator's height from its occlusion height.
--
function GetElevatorHeight(destructable_d) return integer end
-- To properly animate an elevator, we must know not only what height we
-- want to change to, but also what height we are currently at. This code
-- determines the elevator's current height from its occlusion height.
-- Arbitrarily changing an elevator's occlusion height is thus inadvisable.
--
function ChangeElevatorHeight(destructable_d, int_newHeight) end
-- Grab the unit and throw his own coords in his face, forcing him to push
-- and shove until he finds a spot where noone will bother him.
--
function NudgeUnitsInRectEnum() end
function NudgeItemsInRectEnum() end
-- Nudge the items and units within a given rect ever so gently, so as to
-- encourage them to find locations where they can peacefully coexist with
-- pathing restrictions and live happy, fruitful lives.
--
function NudgeObjectsInRect(rect_nudgeArea) end
function NearbyElevatorExistsEnum() end
function NearbyElevatorExists(r_x, r_y) return boolean end
function FindElevatorWallBlockerEnum() end
-- This toggles pathing on or off for one wall of an elevator by killing
-- or reviving a pathing blocker at the appropriate location (and creating
-- the pathing blocker in the first place, if it does not yet exist).
--
function ChangeElevatorWallBlocker(r_x, r_y, r_facing, b_open) end
-- the request. (Two destructibles cannot occupy the same location
-- on the map, so we cannot create an elevator blocker here.)
function ChangeElevatorWalls(b_open, int_walls, destructable_d) end
--*
--* Neutral Building Utility Functions
--*
--***************************************************************************
function WaygateActivateBJ(b_activate, unit_waygate) end
function WaygateIsActiveBJ(unit_waygate) return boolean end
function WaygateSetDestinationLocBJ(unit_waygate, location_loc) end
function WaygateGetDestinationLocBJ(unit_waygate) return location end
function UnitSetUsesAltIconBJ(b_flag, unit_whichUnit) end
--*
--* UI Utility Functions
--*
--***************************************************************************
function ForceUIKeyBJ(player_whichPlayer, str_key) end
function ForceUICancelBJ(player_whichPlayer) end
--*
--* Group and Force Utility Functions
--*
--***************************************************************************
function ForGroupBJ(group_whichGroup, code_callback) end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.
function GroupAddUnitSimple(unit_whichUnit, group_whichGroup) end
function GroupRemoveUnitSimple(unit_whichUnit, group_whichGroup) end
function GroupAddGroupEnum() end
function GroupAddGroup(group_sourceGroup, group_destGroup) end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.
function GroupRemoveGroupEnum() end
function GroupRemoveGroup(group_sourceGroup, group_destGroup) end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.
function ForceAddPlayerSimple(player_whichPlayer, force_whichForce) end
function ForceRemovePlayerSimple(player_whichPlayer, force_whichForce) end
-- Consider each unit, one at a time, keeping a "current pick". Once all units
-- are considered, this "current pick" will be the resulting random unit.
--
-- The chance of picking a given unit over the "current pick" is 1/N, where N is
-- the number of units considered thusfar (including the current consideration).
--
function GroupPickRandomUnitEnum() end
-- Picks a random unit from a group.
--
function GroupPickRandomUnit(group_whichGroup) return unit end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.
-- See GroupPickRandomUnitEnum for the details of this algorithm.
--
function ForcePickRandomPlayerEnum() end
-- Picks a random player from a force.
--
function ForcePickRandomPlayer(force_whichForce) return player end
function EnumUnitsSelected(player_whichPlayer, boolexpr_enumFilter, code_enumAction) end
function GetUnitsInRectMatching(rect_r, boolexpr_filter) return group end
function GetUnitsInRectAll(rect_r) return group end
function GetUnitsInRectOfPlayerFilter() return boolean end
function GetUnitsInRectOfPlayer(rect_r, player_whichPlayer) return group end
function GetUnitsInRangeOfLocMatching(r_radius, location_whichLocation, boolexpr_filter) return group end
function GetUnitsInRangeOfLocAll(r_radius, location_whichLocation) return group end
function GetUnitsOfTypeIdAllFilter() return boolean end
function GetUnitsOfTypeIdAll(int_unitid) return group end
function GetUnitsOfPlayerMatching(player_whichPlayer, boolexpr_filter) return group end
function GetUnitsOfPlayerAll(player_whichPlayer) return group end
function GetUnitsOfPlayerAndTypeIdFilter() return boolean end
function GetUnitsOfPlayerAndTypeId(player_whichPlayer, int_unitid) return group end
function GetUnitsSelectedAll(player_whichPlayer) return group end
function GetForceOfPlayer(player_whichPlayer) return force end
function GetPlayersAll() return force end
function GetPlayersByMapControl(mapcontrol_whichControl) return force end
function GetPlayersAllies(player_whichPlayer) return force end
function GetPlayersEnemies(player_whichPlayer) return force end
function GetPlayersMatching(boolexpr_filter) return force end
function CountUnitsInGroupEnum() end
function CountUnitsInGroup(group_g) return integer end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.
function CountPlayersInForceEnum() end
function CountPlayersInForceBJ(force_f) return integer end
function GetRandomSubGroupEnum() end
function GetRandomSubGroup(int_count, group_sourceGroup) return group end
function LivingPlayerUnitsOfTypeIdFilter() return boolean end
function CountLivingPlayerUnitsOfTypeId(int_unitId, player_whichPlayer) return integer end
--*
--* Animation Utility Functions
--*
--***************************************************************************
function ResetUnitAnimation(unit_whichUnit) end
function SetUnitTimeScalePercent(unit_whichUnit, r_percentScale) end
function SetUnitScalePercent(unit_whichUnit, r_percentScaleX, r_percentScaleY, r_percentScaleZ) end
-- This version differs from the common.j interface in that the alpha value
-- is reversed so as to be displayed as transparency, and all four parameters
-- are treated as percentages rather than bytes.
--
function SetUnitVertexColorBJ(unit_whichUnit, r_red, r_green, r_blue, r_transparency) end
function UnitAddIndicatorBJ(unit_whichUnit, r_red, r_green, r_blue, r_transparency) end
function DestructableAddIndicatorBJ(destructable_whichDestructable, r_red, r_green, r_blue, r_transparency) end
function ItemAddIndicatorBJ(item_whichItem, r_red, r_green, r_blue, r_transparency) end
-- Sets a unit's facing to point directly at a location.
--
function SetUnitFacingToFaceLocTimed(unit_whichUnit, location_target, r_duration) end
-- Sets a unit's facing to point directly at another unit.
--
function SetUnitFacingToFaceUnitTimed(unit_whichUnit, unit_target, r_duration) end
function QueueUnitAnimationBJ(unit_whichUnit, str_whichAnimation) end
function SetDestructableAnimationBJ(destructable_d, str_whichAnimation) end
function QueueDestructableAnimationBJ(destructable_d, str_whichAnimation) end
function SetDestAnimationSpeedPercent(destructable_d, r_percentScale) end
--*
--* Dialog Utility Functions
--*
--***************************************************************************
function DialogDisplayBJ(b_flag, dialog_whichDialog, player_whichPlayer) end
function DialogSetMessageBJ(dialog_whichDialog, str_message) end
function DialogAddButtonBJ(dialog_whichDialog, str_buttonText) return button end
function DialogAddButtonWithHotkeyBJ(dialog_whichDialog, str_buttonText, int_hotkey) return button end
function DialogClearBJ(dialog_whichDialog) end
function GetLastCreatedButtonBJ() return button end
function GetClickedButtonBJ() return button end
function GetClickedDialogBJ() return dialog end
--*
--* Alliance Utility Functions
--*
--***************************************************************************
function SetPlayerAllianceBJ(player_sourcePlayer, alliancetype_whichAllianceSetting, b_value, player_otherPlayer) end
-- Prevent players from attempting to ally with themselves.
-- Set all flags used by the in-game "Ally" checkbox.
--
function SetPlayerAllianceStateAllyBJ(player_sourcePlayer, player_otherPlayer, b_flag) end
-- Set all flags used by the in-game "Shared Vision" checkbox.
--
function SetPlayerAllianceStateVisionBJ(player_sourcePlayer, player_otherPlayer, b_flag) end
-- Set all flags used by the in-game "Shared Units" checkbox.
--
function SetPlayerAllianceStateControlBJ(player_sourcePlayer, player_otherPlayer, b_flag) end
-- Set all flags used by the in-game "Shared Units" checkbox with the Full
-- Shared Unit Control feature enabled.
--
function SetPlayerAllianceStateFullControlBJ(player_sourcePlayer, player_otherPlayer, b_flag) end
function SetPlayerAllianceStateBJ(player_sourcePlayer, player_otherPlayer, int_allianceState) end
-- Prevent players from attempting to ally with themselves.
-- Set the alliance states for an entire force towards another force.
--
function SetForceAllianceStateBJ(force_sourceForce, force_targetForce, int_allianceState) end
-- Test to see if two players are co-allied (allied with each other).
--
function PlayersAreCoAllied(player_playerA, player_playerB) return boolean end
-- Players are considered to be allied with themselves.
-- Force (whichPlayer) AI player to share vision and advanced unit control
-- with all AI players of its allies.
--
function ShareEverythingWithTeamAI(player_whichPlayer) end
-- Force (whichPlayer) to share vision and advanced unit control with all of his/her allies.
--
function ShareEverythingWithTeam(player_whichPlayer) end
-- Creates a 'Neutral Victim' player slot. This slot is passive towards all
-- other players, but all other players are aggressive towards him/her.
--
function ConfigureNeutralVictim() end
function MakeUnitsPassiveForPlayerEnum() end
-- Change ownership for every unit of (whichPlayer)'s team to neutral passive.
--
function MakeUnitsPassiveForPlayer(player_whichPlayer) end
-- Change ownership for every unit of (whichPlayer)'s team to neutral passive.
--
function MakeUnitsPassiveForTeam(player_whichPlayer) end
-- Determine whether or not victory/defeat is disabled via cheat codes.
--
function AllowVictoryDefeat(playergameresult_gameResult) return boolean end
function EndGameBJ() end
function MeleeVictoryDialogBJ(player_whichPlayer, b_leftGame) end
function MeleeDefeatDialogBJ(player_whichPlayer, b_leftGame) end
function GameOverDialogBJ(player_whichPlayer, b_leftGame) end
function RemovePlayerPreserveUnitsBJ(player_whichPlayer, playergameresult_gameResult, b_leftGame) end
function CustomVictoryOkBJ() end
function CustomVictoryQuitBJ() end
function CustomVictoryDialogBJ(player_whichPlayer) end
function CustomVictorySkipBJ(player_whichPlayer) end
function CustomVictoryBJ(player_whichPlayer, b_showDialog, b_showScores) end
function CustomDefeatRestartBJ() end
function CustomDefeatReduceDifficultyBJ() end
function CustomDefeatLoadBJ() end
function CustomDefeatQuitBJ() end
function CustomDefeatDialogBJ(player_whichPlayer, str_message) end
function CustomDefeatBJ(player_whichPlayer, str_message) end
function SetNextLevelBJ(str_nextLevel) end
function SetPlayerOnScoreScreenBJ(b_flag, player_whichPlayer) end
--*
--* Quest Utility Functions
--*
--***************************************************************************
function CreateQuestBJ(int_questType, str_title, str_description, str_iconPath) return quest end
function DestroyQuestBJ(quest_whichQuest) end
function QuestSetEnabledBJ(b_enabled, quest_whichQuest) end
function QuestSetTitleBJ(quest_whichQuest, str_title) end
function QuestSetDescriptionBJ(quest_whichQuest, str_description) end
function QuestSetCompletedBJ(quest_whichQuest, b_completed) end
function QuestSetFailedBJ(quest_whichQuest, b_failed) end
function QuestSetDiscoveredBJ(quest_whichQuest, b_discovered) end
function GetLastCreatedQuestBJ() return quest end
function CreateQuestItemBJ(quest_whichQuest, str_description) return questitem end
function QuestItemSetDescriptionBJ(questitem_whichQuestItem, str_description) end
function QuestItemSetCompletedBJ(questitem_whichQuestItem, b_completed) end
function GetLastCreatedQuestItemBJ() return questitem end
function CreateDefeatConditionBJ(str_description) return defeatcondition end
function DestroyDefeatConditionBJ(defeatcondition_whichCondition) end
function DefeatConditionSetDescriptionBJ(defeatcondition_whichCondition, str_description) end
function GetLastCreatedDefeatConditionBJ() return defeatcondition end
function FlashQuestDialogButtonBJ() end
function QuestMessageBJ(force_f, int_messageType, str_message) end
--*
--* Timer Utility Functions
--*
--***************************************************************************
function StartTimerBJ(timer_t, b_periodic, r_timeout) return timer end
function CreateTimerBJ(b_periodic, r_timeout) return timer end
function DestroyTimerBJ(timer_whichTimer) end
function PauseTimerBJ(b_pause, timer_whichTimer) end
function GetLastCreatedTimerBJ() return timer end
function CreateTimerDialogBJ(timer_t, str_title) return timerdialog end
function DestroyTimerDialogBJ(timerdialog_td) end
function TimerDialogSetTitleBJ(timerdialog_td, str_title) end
function TimerDialogSetTitleColorBJ(timerdialog_td, r_red, r_green, r_blue, r_transparency) end
function TimerDialogSetTimeColorBJ(timerdialog_td, r_red, r_green, r_blue, r_transparency) end
function TimerDialogSetSpeedBJ(timerdialog_td, r_speedMultFactor) end
function TimerDialogDisplayForPlayerBJ(b_show, timerdialog_td, player_whichPlayer) end
function TimerDialogDisplayBJ(b_show, timerdialog_td) end
function GetLastCreatedTimerDialogBJ() return timerdialog end
--*
--* Leaderboard Utility Functions
--*
--***************************************************************************
function LeaderboardResizeBJ(leaderboard_lb) end
function LeaderboardSetPlayerItemValueBJ(player_whichPlayer, leaderboard_lb, int_val) end
function LeaderboardSetPlayerItemLabelBJ(player_whichPlayer, leaderboard_lb, str_val) end
function LeaderboardSetPlayerItemStyleBJ(player_whichPlayer, leaderboard_lb, b_showLabel, b_showValue, b_showIcon) end
function LeaderboardSetPlayerItemLabelColorBJ(player_whichPlayer, leaderboard_lb, r_red, r_green, r_blue, r_transparency) end
function LeaderboardSetPlayerItemValueColorBJ(player_whichPlayer, leaderboard_lb, r_red, r_green, r_blue, r_transparency) end
function LeaderboardSetLabelColorBJ(leaderboard_lb, r_red, r_green, r_blue, r_transparency) end
function LeaderboardSetValueColorBJ(leaderboard_lb, r_red, r_green, r_blue, r_transparency) end
function LeaderboardSetLabelBJ(leaderboard_lb, str_label) end
function LeaderboardSetStyleBJ(leaderboard_lb, b_showLabel, b_showNames, b_showValues, b_showIcons) end
function LeaderboardGetItemCountBJ(leaderboard_lb) return integer end
function LeaderboardHasPlayerItemBJ(leaderboard_lb, player_whichPlayer) return boolean end
function ForceSetLeaderboardBJ(leaderboard_lb, force_toForce) end
function CreateLeaderboardBJ(force_toForce, str_label) return leaderboard end
function DestroyLeaderboardBJ(leaderboard_lb) end
function LeaderboardDisplayBJ(b_show, leaderboard_lb) end
function LeaderboardAddItemBJ(player_whichPlayer, leaderboard_lb, str_label, int_value) end
function LeaderboardRemovePlayerItemBJ(player_whichPlayer, leaderboard_lb) end
function LeaderboardSortItemsBJ(leaderboard_lb, int_sortType, b_ascending) end
function LeaderboardSortItemsByPlayerBJ(leaderboard_lb, b_ascending) end
function LeaderboardSortItemsByLabelBJ(leaderboard_lb, b_ascending) end
function LeaderboardGetPlayerIndexBJ(player_whichPlayer, leaderboard_lb) return integer end
-- Returns the player who is occupying a specified position in a leaderboard.
-- The position parameter is expected in the range of 1..16.
--
function LeaderboardGetIndexedPlayerBJ(int_position, leaderboard_lb) return player end
function PlayerGetLeaderboardBJ(player_whichPlayer) return leaderboard end
function GetLastCreatedLeaderboard() return leaderboard end
--*
--* Multiboard Utility Functions
--*
--***************************************************************************
function CreateMultiboardBJ(int_cols, int_rows, str_title) return multiboard end
function DestroyMultiboardBJ(multiboard_mb) end
function GetLastCreatedMultiboard() return multiboard end
function MultiboardDisplayBJ(b_show, multiboard_mb) end
function MultiboardMinimizeBJ(b_minimize, multiboard_mb) end
function MultiboardSetTitleTextColorBJ(multiboard_mb, r_red, r_green, r_blue, r_transparency) end
function MultiboardAllowDisplayBJ(b_flag) end
function MultiboardSetItemStyleBJ(multiboard_mb, int_col, int_row, b_showValue, b_showIcon) end
function MultiboardSetItemValueBJ(multiboard_mb, int_col, int_row, str_val) end
function MultiboardSetItemColorBJ(multiboard_mb, int_col, int_row, r_red, r_green, r_blue, r_transparency) end
function MultiboardSetItemWidthBJ(multiboard_mb, int_col, int_row, r_width) end
function MultiboardSetItemIconBJ(multiboard_mb, int_col, int_row, str_iconFileName) end
--*
--* Text Tag Utility Functions
--*
--***************************************************************************
-- Scale the font size linearly such that size 10 equates to height 0.023.
-- Screen-relative font heights are harder to grasp and than font sizes.
--
function TextTagSize2Height(r_size) return real end
-- Scale the speed linearly such that speed 128 equates to 0.071.
-- Screen-relative speeds are hard to grasp.
--
function TextTagSpeed2Velocity(r_speed) return real end
function SetTextTagColorBJ(texttag_tt, r_red, r_green, r_blue, r_transparency) end
function SetTextTagVelocityBJ(texttag_tt, r_speed, r_angle) end
function SetTextTagTextBJ(texttag_tt, str_s, r_size) end
function SetTextTagPosBJ(texttag_tt, location_loc, r_zOffset) end
function SetTextTagPosUnitBJ(texttag_tt, unit_whichUnit, r_zOffset) end
function SetTextTagSuspendedBJ(texttag_tt, b_flag) end
function SetTextTagPermanentBJ(texttag_tt, b_flag) end
function SetTextTagAgeBJ(texttag_tt, r_age) end
function SetTextTagLifespanBJ(texttag_tt, r_lifespan) end
function SetTextTagFadepointBJ(texttag_tt, r_fadepoint) end
function CreateTextTagLocBJ(str_s, location_loc, r_zOffset, r_size, r_red, r_green, r_blue, r_transparency) return texttag end
function CreateTextTagUnitBJ(str_s, unit_whichUnit, r_zOffset, r_size, r_red, r_green, r_blue, r_transparency) return texttag end
function DestroyTextTagBJ(texttag_tt) end
function ShowTextTagForceBJ(b_show, texttag_tt, force_whichForce) end
function GetLastCreatedTextTag() return texttag end
--*
--* Cinematic Utility Functions
--*
--***************************************************************************
function PauseGameOn() end
function PauseGameOff() end
function SetUserControlForceOn(force_whichForce) end
function SetUserControlForceOff(force_whichForce) end
function ShowInterfaceForceOn(force_whichForce, r_fadeDuration) end
function ShowInterfaceForceOff(force_whichForce, r_fadeDuration) end
function PingMinimapForForce(force_whichForce, r_x, r_y, r_duration) end
function PingMinimapLocForForce(force_whichForce, location_loc, r_duration) end
function PingMinimapForPlayer(player_whichPlayer, r_x, r_y, r_duration) end
function PingMinimapLocForPlayer(player_whichPlayer, location_loc, r_duration) end
function PingMinimapForForceEx(force_whichForce, r_x, r_y, r_duration, int_style, r_red, r_green, r_blue) end
function PingMinimapLocForForceEx(force_whichForce, location_loc, r_duration, int_style, r_red, r_green, r_blue) end
function EnableWorldFogBoundaryBJ(b_enable, force_f) end
function EnableOcclusionBJ(b_enable, force_f) end
--*
--* Cinematic Transmission Utility Functions
--*
--***************************************************************************
-- If cancelled, stop the sound and end the cinematic scene.
--
function CancelCineSceneBJ() end
-- Init a trigger to listen for END_CINEMATIC events and respond to them if
-- a cinematic scene is in progress. For performance reasons, this should
-- only be called once a cinematic scene has been started, so that maps
-- lacking such scenes do not bother to register for these events.
--
function TryInitCinematicBehaviorBJ() end
function SetCinematicSceneBJ(sound_soundHandle, int_portraitUnitId, playercolor_color, str_speakerTitle, str_text, r_sceneDuration, r_voiceoverDuration) end
function GetTransmissionDuration(sound_soundHandle, int_timeType, r_timeVal) return real end
function WaitTransmissionDuration(sound_soundHandle, int_timeType, r_timeVal) end
-- to be mostly finished.
-- for it to finish, and then wait the additional time.
function DoTransmissionBasicsXYBJ(int_unitId, playercolor_color, r_x, r_y, sound_soundHandle, str_unitName, str_message, r_duration) end
-- Display a text message to a Player Group with an accompanying sound,
-- portrait, speech indicator, and all that good stuff.
-- - Query duration of sound
-- - Play sound
-- - Display text message for duration
-- - Display animating portrait for duration
-- - Display a speech indicator for the unit
-- - Ping the minimap
--
function TransmissionFromUnitWithNameBJ(force_toForce, unit_whichUnit, str_unitName, sound_soundHandle, str_message, int_timeType, r_timeVal, b_wait) end
-- This operates like TransmissionFromUnitWithNameBJ, but for a unit type
-- rather than a unit instance. As such, no speech indicator is employed.
--
function TransmissionFromUnitTypeWithNameBJ(force_toForce, player_fromPlayer, int_unitId, str_unitName, location_loc, sound_soundHandle, str_message, int_timeType, r_timeVal, b_wait) end
function GetLastTransmissionDurationBJ() return real end
function ForceCinematicSubtitlesBJ(b_flag) end
--*
--* Cinematic Mode Utility Functions
--*
--***************************************************************************
-- Makes many common UI settings changes at once, for use when beginning and
-- ending cinematic sequences. Note that some affects apply to all players,
-- such as game speed. This is unavoidable.
-- - Clear the screen of text messages
-- - Hide interface UI (letterbox mode)
-- - Hide game messages (ally under attack, etc.)
-- - Disable user control
-- - Disable occlusion
-- - Set game speed (for all players)
-- - Lock game speed (for all players)
-- - Disable black mask (for all players)
-- - Disable fog of war (for all players)
-- - Disable world boundary fog (for all players)
-- - Dim non-speech sound channels
-- - End any outstanding music themes
-- - Fix the random seed to a set value
-- - Reset the camera smoothing factor
--
function CinematicModeExBJ(b_cineMode, force_forForce, r_interfaceFadeTime) end
-- If the game hasn't started yet, perform interface fades immediately
function CinematicModeBJ(b_cineMode, force_forForce) end
--*
--* Cinematic Filter Utility Functions
--*
--***************************************************************************
function DisplayCineFilterBJ(b_flag) end
function CinematicFadeCommonBJ(r_red, r_green, r_blue, r_duration, str_tex, r_startTrans, r_endTrans) end
-- so that we effectively do a set rather than a fade.
function FinishCinematicFadeBJ() end
function FinishCinematicFadeAfterBJ(r_duration) end
-- Create a timer to end the cinematic fade.
function ContinueCinematicFadeBJ() end
function ContinueCinematicFadeAfterBJ(r_duration, r_red, r_green, r_blue, r_trans, str_tex) end
function AbortCinematicFadeBJ() end
function CinematicFadeBJ(int_fadetype, r_duration, str_tex, r_red, r_green, r_blue, r_trans) end
function CinematicFilterGenericBJ(r_duration, blendmode_bmode, str_tex, r_red0, r_green0, r_blue0, r_trans0, r_red1, r_green1, r_blue1, r_trans1) end
--*
--* Rescuable Unit Utility Functions
--*
--***************************************************************************
-- Rescues a unit for a player. This performs the default rescue behavior,
-- including a rescue sound, flashing selection circle, ownership change,
-- and optionally a unit color change.
--
function RescueUnitBJ(unit_whichUnit, player_rescuer, b_changeColor) end
function TriggerActionUnitRescuedBJ() end
-- Attempt to init triggers for default rescue behavior. For performance
-- reasons, this should only be attempted if a player is set to Rescuable,
-- or if a specific unit is thus flagged.
--
function TryInitRescuableTriggersBJ() end
-- Determines whether or not rescued units automatically change color upon
-- being rescued.
--
function SetRescueUnitColorChangeBJ(b_changeColor) end
-- Determines whether or not rescued buildings automatically change color
-- upon being rescued.
--
function SetRescueBuildingColorChangeBJ(b_changeColor) end
function MakeUnitRescuableToForceBJEnum() end
function MakeUnitRescuableToForceBJ(unit_whichUnit, b_isRescuable, force_whichForce) end
-- Flag the unit as rescuable/unrescuable for the appropriate players.
function InitRescuableBehaviorBJ() end
-- rescue behavior triggers.
--*
--* Research and Upgrade Utility Functions
--*
--***************************************************************************
function SetPlayerTechResearchedSwap(int_techid, int_levels, player_whichPlayer) end
function SetPlayerTechMaxAllowedSwap(int_techid, int_maximum, player_whichPlayer) end
function SetPlayerMaxHeroesAllowed(int_maximum, player_whichPlayer) end
function GetPlayerTechCountSimple(int_techid, player_whichPlayer) return integer end
function GetPlayerTechMaxAllowedSwap(int_techid, player_whichPlayer) return integer end
function SetPlayerAbilityAvailableBJ(b_avail, int_abilid, player_whichPlayer) end
--*
--* Campaign Utility Functions
--*
--***************************************************************************
-- Converts a single campaign mission designation into campaign and mission
-- numbers. The 1000's digit is considered the campaign index, and the 1's
-- digit is considered the mission index within that campaign. This is done
-- so that the trigger for this can use a single drop-down to list all of
-- the campaign missions.
--
function SetMissionAvailableBJ(b_available, int_missionIndex) end
function SetCampaignAvailableBJ(b_available, int_campaignNumber) end
function SetCinematicAvailableBJ(b_available, int_cinematicIndex) end
function InitGameCacheBJ(str_campaignFile) return gamecache end
function SaveGameCacheBJ(gamecache_cache) return boolean end
function GetLastCreatedGameCacheBJ() return gamecache end
function InitHashtableBJ() return hashtable end
function GetLastCreatedHashtableBJ() return hashtable end
function StoreRealBJ(r_value, str_key, str_missionKey, gamecache_cache) end
function StoreIntegerBJ(int_value, str_key, str_missionKey, gamecache_cache) end
function StoreBooleanBJ(b_value, str_key, str_missionKey, gamecache_cache) end
function StoreStringBJ(str_value, str_key, str_missionKey, gamecache_cache) return boolean end
function StoreUnitBJ(unit_whichUnit, str_key, str_missionKey, gamecache_cache) return boolean end
function SaveRealBJ(r_value, int_key, int_missionKey, hashtable_table) end
function SaveIntegerBJ(int_value, int_key, int_missionKey, hashtable_table) end
function SaveBooleanBJ(b_value, int_key, int_missionKey, hashtable_table) end
function SaveStringBJ(str_value, int_key, int_missionKey, hashtable_table) return boolean end
function SavePlayerHandleBJ(player_whichPlayer, int_key, int_missionKey, hashtable_table) return boolean end
function SaveWidgetHandleBJ(widget_whichWidget, int_key, int_missionKey, hashtable_table) return boolean end
function SaveDestructableHandleBJ(destructable_whichDestructable, int_key, int_missionKey, hashtable_table) return boolean end
function SaveItemHandleBJ(item_whichItem, int_key, int_missionKey, hashtable_table) return boolean end
function SaveUnitHandleBJ(unit_whichUnit, int_key, int_missionKey, hashtable_table) return boolean end
function SaveAbilityHandleBJ(ability_whichAbility, int_key, int_missionKey, hashtable_table) return boolean end
function SaveTimerHandleBJ(timer_whichTimer, int_key, int_missionKey, hashtable_table) return boolean end
function SaveTriggerHandleBJ(trigger_whichTrigger, int_key, int_missionKey, hashtable_table) return boolean end
function SaveTriggerConditionHandleBJ(triggercondition_whichTriggercondition, int_key, int_missionKey, hashtable_table) return boolean end
function SaveTriggerActionHandleBJ(triggeraction_whichTriggeraction, int_key, int_missionKey, hashtable_table) return boolean end
function SaveTriggerEventHandleBJ(event_whichEvent, int_key, int_missionKey, hashtable_table) return boolean end
function SaveForceHandleBJ(force_whichForce, int_key, int_missionKey, hashtable_table) return boolean end
function SaveGroupHandleBJ(group_whichGroup, int_key, int_missionKey, hashtable_table) return boolean end
function SaveLocationHandleBJ(location_whichLocation, int_key, int_missionKey, hashtable_table) return boolean end
function SaveRectHandleBJ(rect_whichRect, int_key, int_missionKey, hashtable_table) return boolean end
function SaveBooleanExprHandleBJ(boolexpr_whichBoolexpr, int_key, int_missionKey, hashtable_table) return boolean end
function SaveSoundHandleBJ(sound_whichSound, int_key, int_missionKey, hashtable_table) return boolean end
function SaveEffectHandleBJ(effect_whichEffect, int_key, int_missionKey, hashtable_table) return boolean end
function SaveUnitPoolHandleBJ(unitpool_whichUnitpool, int_key, int_missionKey, hashtable_table) return boolean end
function SaveItemPoolHandleBJ(itempool_whichItempool, int_key, int_missionKey, hashtable_table) return boolean end
function SaveQuestHandleBJ(quest_whichQuest, int_key, int_missionKey, hashtable_table) return boolean end
function SaveQuestItemHandleBJ(questitem_whichQuestitem, int_key, int_missionKey, hashtable_table) return boolean end
function SaveDefeatConditionHandleBJ(defeatcondition_whichDefeatcondition, int_key, int_missionKey, hashtable_table) return boolean end
function SaveTimerDialogHandleBJ(timerdialog_whichTimerdialog, int_key, int_missionKey, hashtable_table) return boolean end
function SaveLeaderboardHandleBJ(leaderboard_whichLeaderboard, int_key, int_missionKey, hashtable_table) return boolean end
function SaveMultiboardHandleBJ(multiboard_whichMultiboard, int_key, int_missionKey, hashtable_table) return boolean end
function SaveMultiboardItemHandleBJ(multiboarditem_whichMultiboarditem, int_key, int_missionKey, hashtable_table) return boolean end
function SaveTrackableHandleBJ(trackable_whichTrackable, int_key, int_missionKey, hashtable_table) return boolean end
function SaveDialogHandleBJ(dialog_whichDialog, int_key, int_missionKey, hashtable_table) return boolean end
function SaveButtonHandleBJ(button_whichButton, int_key, int_missionKey, hashtable_table) return boolean end
function SaveTextTagHandleBJ(texttag_whichTexttag, int_key, int_missionKey, hashtable_table) return boolean end
function SaveLightningHandleBJ(lightning_whichLightning, int_key, int_missionKey, hashtable_table) return boolean end
function SaveImageHandleBJ(image_whichImage, int_key, int_missionKey, hashtable_table) return boolean end
function SaveUbersplatHandleBJ(ubersplat_whichUbersplat, int_key, int_missionKey, hashtable_table) return boolean end
function SaveRegionHandleBJ(region_whichRegion, int_key, int_missionKey, hashtable_table) return boolean end
function SaveFogStateHandleBJ(fogstate_whichFogState, int_key, int_missionKey, hashtable_table) return boolean end
function SaveFogModifierHandleBJ(fogmodifier_whichFogModifier, int_key, int_missionKey, hashtable_table) return boolean end
function SaveAgentHandleBJ(agent_whichAgent, int_key, int_missionKey, hashtable_table) return boolean end
function SaveHashtableHandleBJ(hashtable_whichHashtable, int_key, int_missionKey, hashtable_table) return boolean end
function GetStoredRealBJ(str_key, str_missionKey, gamecache_cache) return real end
--call SyncStoredReal(cache, missionKey, key)
function GetStoredIntegerBJ(str_key, str_missionKey, gamecache_cache) return integer end
--call SyncStoredInteger(cache, missionKey, key)
function GetStoredBooleanBJ(str_key, str_missionKey, gamecache_cache) return boolean end
--call SyncStoredBoolean(cache, missionKey, key)
function GetStoredStringBJ(str_key, str_missionKey, gamecache_cache) return string end
function LoadRealBJ(int_key, int_missionKey, hashtable_table) return real end
--call SyncStoredReal(table, missionKey, key)
function LoadIntegerBJ(int_key, int_missionKey, hashtable_table) return integer end
--call SyncStoredInteger(table, missionKey, key)
function LoadBooleanBJ(int_key, int_missionKey, hashtable_table) return boolean end
--call SyncStoredBoolean(table, missionKey, key)
function LoadStringBJ(int_key, int_missionKey, hashtable_table) return string end
function LoadPlayerHandleBJ(int_key, int_missionKey, hashtable_table) return player end
function LoadWidgetHandleBJ(int_key, int_missionKey, hashtable_table) return widget end
function LoadDestructableHandleBJ(int_key, int_missionKey, hashtable_table) return destructable end
function LoadItemHandleBJ(int_key, int_missionKey, hashtable_table) return item end
function LoadUnitHandleBJ(int_key, int_missionKey, hashtable_table) return unit end
function LoadAbilityHandleBJ(int_key, int_missionKey, hashtable_table) return ability end
function LoadTimerHandleBJ(int_key, int_missionKey, hashtable_table) return timer end
function LoadTriggerHandleBJ(int_key, int_missionKey, hashtable_table) return trigger end
function LoadTriggerConditionHandleBJ(int_key, int_missionKey, hashtable_table) return triggercondition end
function LoadTriggerActionHandleBJ(int_key, int_missionKey, hashtable_table) return triggeraction end
function LoadTriggerEventHandleBJ(int_key, int_missionKey, hashtable_table) return event end
function LoadForceHandleBJ(int_key, int_missionKey, hashtable_table) return force end
function LoadGroupHandleBJ(int_key, int_missionKey, hashtable_table) return group end
function LoadLocationHandleBJ(int_key, int_missionKey, hashtable_table) return location end
function LoadRectHandleBJ(int_key, int_missionKey, hashtable_table) return rect end
function LoadBooleanExprHandleBJ(int_key, int_missionKey, hashtable_table) return boolexpr end
function LoadSoundHandleBJ(int_key, int_missionKey, hashtable_table) return sound end
function LoadEffectHandleBJ(int_key, int_missionKey, hashtable_table) return effect end
function LoadUnitPoolHandleBJ(int_key, int_missionKey, hashtable_table) return unitpool end
function LoadItemPoolHandleBJ(int_key, int_missionKey, hashtable_table) return itempool end
function LoadQuestHandleBJ(int_key, int_missionKey, hashtable_table) return quest end
function LoadQuestItemHandleBJ(int_key, int_missionKey, hashtable_table) return questitem end
function LoadDefeatConditionHandleBJ(int_key, int_missionKey, hashtable_table) return defeatcondition end
function LoadTimerDialogHandleBJ(int_key, int_missionKey, hashtable_table) return timerdialog end
function LoadLeaderboardHandleBJ(int_key, int_missionKey, hashtable_table) return leaderboard end
function LoadMultiboardHandleBJ(int_key, int_missionKey, hashtable_table) return multiboard end
function LoadMultiboardItemHandleBJ(int_key, int_missionKey, hashtable_table) return multiboarditem end
function LoadTrackableHandleBJ(int_key, int_missionKey, hashtable_table) return trackable end
function LoadDialogHandleBJ(int_key, int_missionKey, hashtable_table) return dialog end
function LoadButtonHandleBJ(int_key, int_missionKey, hashtable_table) return button end
function LoadTextTagHandleBJ(int_key, int_missionKey, hashtable_table) return texttag end
function LoadLightningHandleBJ(int_key, int_missionKey, hashtable_table) return lightning end
function LoadImageHandleBJ(int_key, int_missionKey, hashtable_table) return image end
function LoadUbersplatHandleBJ(int_key, int_missionKey, hashtable_table) return ubersplat end
function LoadRegionHandleBJ(int_key, int_missionKey, hashtable_table) return region end
function LoadFogStateHandleBJ(int_key, int_missionKey, hashtable_table) return fogstate end
function LoadFogModifierHandleBJ(int_key, int_missionKey, hashtable_table) return fogmodifier end
function LoadHashtableHandleBJ(int_key, int_missionKey, hashtable_table) return hashtable end
function RestoreUnitLocFacingAngleBJ(str_key, str_missionKey, gamecache_cache, player_forWhichPlayer, location_loc, r_facing) return unit end
--call SyncStoredUnit(cache, missionKey, key)
function RestoreUnitLocFacingPointBJ(str_key, str_missionKey, gamecache_cache, player_forWhichPlayer, location_loc, location_lookAt) return unit end
--call SyncStoredUnit(cache, missionKey, key)
function GetLastRestoredUnitBJ() return unit end
function FlushGameCacheBJ(gamecache_cache) end
function FlushStoredMissionBJ(str_missionKey, gamecache_cache) end
function FlushParentHashtableBJ(hashtable_table) end
function FlushChildHashtableBJ(int_missionKey, hashtable_table) end
function HaveStoredValue(str_key, int_valueType, str_missionKey, gamecache_cache) return boolean end
function HaveSavedValue(int_key, int_valueType, int_missionKey, hashtable_table) return boolean end
function ShowCustomCampaignButton(b_show, int_whichButton) end
function IsCustomCampaignButtonVisibile(int_whichButton) return boolean end
function LoadGameBJ(str_loadFileName, b_doScoreScreen) end
function SaveAndChangeLevelBJ(str_saveFileName, str_newLevel, b_doScoreScreen) end
function SaveAndLoadGameBJ(str_saveFileName, str_loadFileName, b_doScoreScreen) end
function RenameSaveDirectoryBJ(str_sourceDirName, str_destDirName) return boolean end
function RemoveSaveDirectoryBJ(str_sourceDirName) return boolean end
function CopySaveGameBJ(str_sourceSaveName, str_destSaveName) return boolean end
--*
--* Miscellaneous Utility Functions
--*
--***************************************************************************
function GetPlayerStartLocationX(player_whichPlayer) return real end
function GetPlayerStartLocationY(player_whichPlayer) return real end
function GetPlayerStartLocationLoc(player_whichPlayer) return location end
function GetRectCenter(rect_whichRect) return location end
function IsPlayerSlotState(player_whichPlayer, playerslotstate_whichState) return boolean end
function GetFadeFromSeconds(r_seconds) return integer end
function GetFadeFromSecondsAsReal(r_seconds) return real end
function AdjustPlayerStateSimpleBJ(player_whichPlayer, playerstate_whichPlayerState, int_delta) end
function AdjustPlayerStateBJ(int_delta, player_whichPlayer, playerstate_whichPlayerState) end
-- If the change was positive, apply the difference to the player's
-- gathered resources property as well.
function SetPlayerStateBJ(player_whichPlayer, playerstate_whichPlayerState, int_value) end
function SetPlayerFlagBJ(playerstate_whichPlayerFlag, b_flag, player_whichPlayer) end
function SetPlayerTaxRateBJ(int_rate, playerstate_whichResource, player_sourcePlayer, player_otherPlayer) end
function GetPlayerTaxRateBJ(playerstate_whichResource, player_sourcePlayer, player_otherPlayer) return integer end
function IsPlayerFlagSetBJ(playerstate_whichPlayerFlag, player_whichPlayer) return boolean end
function AddResourceAmountBJ(int_delta, unit_whichUnit) end
function GetConvertedPlayerId(player_whichPlayer) return integer end
function ConvertedPlayer(int_convertedPlayerId) return player end
function GetRectWidthBJ(rect_r) return real end
function GetRectHeightBJ(rect_r) return real end
-- Replaces a gold mine with a blighted gold mine for the given player.
--
function BlightGoldMineForPlayerBJ(unit_goldMine, player_whichPlayer) return unit end
function BlightGoldMineForPlayer(unit_goldMine, player_whichPlayer) return unit end
function GetLastHauntedGoldMine() return unit end
function IsPointBlightedBJ(location_where) return boolean end
function SetPlayerColorBJEnum() end
function SetPlayerColorBJ(player_whichPlayer, playercolor_color, b_changeExisting) end
function SetPlayerUnitAvailableBJ(int_unitId, b_allowed, player_whichPlayer) end
function LockGameSpeedBJ() end
function UnlockGameSpeedBJ() end
function IssueTargetOrderBJ(unit_whichUnit, str_order, widget_targetWidget) return boolean end
function IssuePointOrderLocBJ(unit_whichUnit, str_order, location_whichLocation) return boolean end
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
function IssueTargetDestructableOrder(unit_whichUnit, str_order, widget_targetWidget) return boolean end
function IssueImmediateOrderBJ(unit_whichUnit, str_order) return boolean end
function GroupTargetOrderBJ(group_whichGroup, str_order, widget_targetWidget) return boolean end
function GroupPointOrderLocBJ(group_whichGroup, str_order, location_whichLocation) return boolean end
function GroupImmediateOrderBJ(group_whichGroup, str_order) return boolean end
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
function GroupTargetDestructableOrder(group_whichGroup, str_order, widget_targetWidget) return boolean end
function GetDyingDestructable() return destructable end
-- Rally point setting
--
function SetUnitRallyPoint(unit_whichUnit, location_targPos) end
function SetUnitRallyUnit(unit_whichUnit, unit_targUnit) end
function SetUnitRallyDestructable(unit_whichUnit, destructable_targDest) end
-- Utility function for use by editor-generated item drop table triggers.
-- This function is added as an action to all destructable drop triggers,
-- so that a widget drop may be differentiated from a unit drop.
--
function SaveDyingWidget() end
function SetBlightRectBJ(b_addBlight, player_whichPlayer, rect_r) end
function SetBlightRadiusLocBJ(b_addBlight, player_whichPlayer, location_loc, r_radius) end
function GetAbilityName(int_abilcode) return string end
--*
--* Melee Template Visibility Settings
--*
--***************************************************************************
function MeleeStartingVisibility() end
-- Start by setting the ToD.
-- call FogEnable(true)
--*
--* Melee Template Starting Resources
--*
--***************************************************************************
function MeleeStartingResources() end
--*
--* Melee Template Hero Limit
--*
--***************************************************************************
function ReducePlayerTechMaxAllowed(player_whichPlayer, int_techId, int_limit) end
function MeleeStartingHeroLimit() end
--*
--* Melee Template Granted Hero Items
--*
--***************************************************************************
function MeleeTrainedUnitIsHeroBJFilter() return boolean end
-- The first N heroes trained or hired for each player start off with a
-- standard set of items. This is currently:
-- - 1x Scroll of Town Portal
--
function MeleeGrantItemsToHero(unit_whichUnit) end
function MeleeGrantItemsToTrainedHero() end
function MeleeGrantItemsToHiredHero() end
function MeleeGrantHeroItems() end
-- him/her their starting items.
-- can give him/her their starting items.
-- starting units code can create them as necessary.
--*
--* Melee Template Clear Start Locations
--*
--***************************************************************************
function MeleeClearExcessUnit() end
function MeleeClearNearbyUnits(r_x, r_y, r_range) end
function MeleeClearExcessUnits() end
--*
--* Melee Template Starting Units
--*
--***************************************************************************
function MeleeEnumFindNearestMine() end
function MeleeFindNearestMine(location_src, r_range) return unit end
function MeleeRandomHeroLoc(player_p, int_id1, int_id2, int_id3, int_id4, location_loc) return unit end
-- Returns a location which is (distance) away from (src) in the direction of (targ).
--
function MeleeGetProjectedLoc(location_src, location_targ, r_distance, r_deltaAngle) return location end
function MeleeGetNearestValueWithin(r_val, r_minVal, r_maxVal) return real end
function MeleeGetLocWithinRect(location_src, rect_r) return location end
-- Starting Units for Human Players
-- - 1 Town Hall, placed at start location
-- - 5 Peasants, placed between start location and nearest gold mine
--
function MeleeStartingUnitsHuman(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end
-- Otherwise, give them a "free hero" token.
-- Starting Units for Orc Players
-- - 1 Great Hall, placed at start location
-- - 5 Peons, placed between start location and nearest gold mine
--
function MeleeStartingUnitsOrc(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end
-- Otherwise, give them a "free hero" token.
-- Starting Units for Undead Players
-- - 1 Necropolis, placed at start location
-- - 1 Haunted Gold Mine, placed on nearest gold mine
-- - 3 Acolytes, placed between start location and nearest gold mine
-- - 1 Ghoul, placed between start location and nearest gold mine
-- - Blight, centered on nearest gold mine, spread across a "large area"
--
function MeleeStartingUnitsUndead(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end
-- Otherwise, give them a "free hero" token.
-- Starting Units for Night Elf Players
-- - 1 Tree of Life, placed by nearest gold mine, already entangled
-- - 5 Wisps, placed between Tree of Life and nearest gold mine
--
function MeleeStartingUnitsNightElf(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end
-- Project the Tree's coordinates from the gold mine, and then snap
-- the X and Y values to within minTreeDist of the Gold Mine.
-- Otherwise, give them a "free hero" token.
-- Starting Units for Players Whose Race is Unknown
-- - 12 Sheep, placed randomly around the start location
--
function MeleeStartingUnitsUnknownRace(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end
function MeleeStartingUnits() end
function MeleeStartingUnitsForPlayer(race_whichRace, player_whichPlayer, location_loc, b_doHeroes) end
-- Create initial race-specific starting units
--*
--* Melee Template Starting AI Scripts
--*
--***************************************************************************
function PickMeleeAI(player_num, str_s1, str_s2, str_s3) end
-- that are designed to be a bit more challenging
--
function MeleeStartingAI() end
--*
--* Melee Template Victory / Defeat Conditions
--*
--***************************************************************************
function MeleePlayerIsOpponent(int_playerIndex, int_opponentIndex) return boolean end
-- Count buildings currently owned by all allies, including the player themself.
--
function MeleeGetAllyStructureCount(player_whichPlayer) return integer end
--if (PlayersAreCoAllied(whichPlayer, indexPlayer) and not bj_meleeDefeated[playerIndex]) then
-- Count allies, excluding dead players and the player themself.
--
function MeleeGetAllyCount(player_whichPlayer) return integer end
-- Counts key structures owned by a player and his or her allies, including
-- structures currently upgrading or under construction.
--
-- Key structures: Town Hall, Great Hall, Tree of Life, Necropolis
--
function MeleeGetAllyKeyStructureCount(player_whichPlayer) return integer end
-- Enum: Draw out a specific player.
--
function MeleeDoDrawEnum() end
-- Enum: Victory out a specific player.
--
function MeleeDoVictoryEnum() end
-- Defeat out a specific player.
--
function MeleeDoDefeat(player_whichPlayer) end
-- Enum: Defeat out a specific player.
--
function MeleeDoDefeatEnum() end
-- A specific player left the game.
--
function MeleeDoLeave(player_whichPlayer) end
-- Remove all observers
--
function MeleeRemoveObservers() end
-- Test all players to determine if a team has won. For a team to win, all
-- remaining (read: undefeated) players need to be co-allied with all other
-- remaining players. If even one player is not allied towards another,
-- everyone must be denied victory.
--
function MeleeCheckForVictors() return force end
-- them a victory later.
-- Test each player to determine if anyone has been defeated.
--
function MeleeCheckForLosersAndVictors() end
-- don't want to report results for anyone as they will most likely
-- conflict with the actual game results
-- them a defeat later.
-- can detect victors.
-- Returns a race-specific "build X or be revealed" message.
--
function MeleeGetCrippledWarningMessage(player_whichPlayer) return string end
-- Returns a race-specific "build X" label for cripple timers.
--
function MeleeGetCrippledTimerMessage(player_whichPlayer) return string end
-- Returns a race-specific "build X" label for cripple timers.
--
function MeleeGetCrippledRevealedMessage(player_whichPlayer) return string end
function MeleeExposePlayer(player_whichPlayer, b_expose) end
function MeleeExposeAllPlayers() end
function MeleeCrippledPlayerTimeout() end
function MeleePlayerIsCrippled(player_whichPlayer) return boolean end
-- Test each player to determine if anyone has become crippled.
--
function MeleeCheckForCrippledPlayers() end
-- Determine if the lost unit should result in any defeats or victories.
--
function MeleeCheckLostUnit(unit_lostUnit) end
-- (A team with 0 units is dead, and thus considered uncrippled.)
-- Determine if the gained unit should result in any defeats, victories,
-- or cripple-status changes.
--
function MeleeCheckAddedUnit(unit_addedUnit) end
function MeleeTriggerActionConstructCancel() end
function MeleeTriggerActionUnitDeath() end
function MeleeTriggerActionUnitConstructionStart() end
function MeleeTriggerActionPlayerDefeated() end
-- them and proceed with death.
-- neutral_passive and proceed with death.
function MeleeTriggerActionPlayerLeft() end
-- "player left the game" as opposed to "player was defeated".
-- them and proceed with death.
-- neutral_passive and proceed with death.
function MeleeTriggerActionAllianceChange() end
function MeleeTriggerTournamentFinishSoon() end
-- Note: We may get this trigger multiple times
function MeleeWasUserPlayer(player_whichPlayer) return boolean end
function MeleeTournamentFinishNowRuleA(int_multiplier) end
-- every other team. In the case of multiplier == 1 and exactly equal team
-- scores, the first team (which was randomly chosen by the server) will win.
function MeleeTriggerTournamentFinishNow() end
function MeleeInitVictoryDefeat() end
-- because it is driven by real time (outside of the game state to avoid desyncs)
-- Allow for a short time to pass first, so that the map can finish loading.
--*
--* Player Slot Availability
--*
--***************************************************************************
function CheckInitPlayerSlotAvailability() end
function SetPlayerSlotAvailable(player_whichPlayer, mapcontrol_control) end
--*
--* Generic Template Player-slot Initialization
--*
--***************************************************************************
function TeamInitPlayerSlots(int_teamCount) end
function MeleeInitPlayerSlots() end
function FFAInitPlayerSlots() end
function OneOnOneInitPlayerSlots() end
-- Limit the game to 2 players.
function InitGenericPlayerSlots() end
--*
--* Blizzard.j Initialization
--*
--***************************************************************************
function SetDNCSoundsDawn() end
function SetDNCSoundsDusk() end
function SetDNCSoundsDay() end
function SetDNCSoundsNight() end
function InitDNCSounds() end
-- Create sounds to be played at dawn and dusk.
function InitBlizzardGlobals() end
--set bj_pingMinimapSound = CreateSoundFromLabel("AutoCastButtonClick", false, false, false, 10000, 10000)
function InitQueuedTriggers() end
function InitMapRects() end
function InitSummonableCaps() end
-- Note: Only do this if the corresponding upgrade is not yet researched
-- Barrage - Siege Engines
-- Update the per-class stock limits.
--
function UpdateStockAvailability(item_whichItem) end
-- Find a sellable item of the given type and level, and then add it.
--
function UpdateEachStockBuildingEnum() end
-- items, or a very unlucky series of random numbers, give up.
function UpdateEachStockBuilding(itemtype_iType, int_iLevel) end
-- Update stock inventory.
--
function PerformStockUpdates() end
-- Perform the first update, and then arrange future updates.
--
function StartStockUpdates() end
function RemovePurchasedItem() end
function InitNeutralBuildings() end
function MarkGameStarted() end
function DetectGameStarted() end
function InitBlizzard() end
-- Set up the Neutral Victim player slot, to torture the abandoned units
-- of defeated players. Since some triggers expect this player slot to
-- exist, this is performed for all maps.
--*
--* Random distribution
--*
--* Used to select a random object from a given distribution of chances
--*
--* - RandomDistReset clears the distribution list
--*
--* - RandomDistAddItem adds a new object to the distribution list
--* with a given identifier and an integer chance to be chosen
--*
--* - RandomDistChoose will use the current distribution list to choose
--* one of the objects randomly based on the chance distribution
--*
--* Note that the chances are effectively normalized by their sum,
--* so only the relative values of each chance are important
--*
--***************************************************************************
function RandomDistReset() end
function RandomDistAddItem(int_inID, int_inChance) end
function RandomDistChoose() return integer end
--*
--* Drop item
--*
--* Makes the given unit drop the given item
--*
--* Note: This could potentially cause problems if the unit is standing
--* right on the edge of an unpathable area and happens to drop the
--* item into the unpathable area where nobody can get it...
--*
--***************************************************************************
function WidgetDropItem(widget_inWidget, int_inItemID) return item end
--*
--* Instanced Object Operation Functions
--*
--* Get/Set specific fields for single unit/item/ability instance
--*
--***************************************************************************
function BlzIsLastInstanceObjectFunctionSuccessful() return boolean end
--===========================================================================
function BlzSetAbilityBooleanFieldBJ(ability_whichAbility, abilitybooleanfield_whichField, b_value) end
function BlzSetAbilityIntegerFieldBJ(ability_whichAbility, abilityintegerfield_whichField, int_value) end
function BlzSetAbilityRealFieldBJ(ability_whichAbility, abilityrealfield_whichField, r_value) end
function BlzSetAbilityStringFieldBJ(ability_whichAbility, abilitystringfield_whichField, str_value) end
function BlzSetAbilityBooleanLevelFieldBJ(ability_whichAbility, abilitybooleanlevelfield_whichField, int_level, b_value) end
function BlzSetAbilityIntegerLevelFieldBJ(ability_whichAbility, abilityintegerlevelfield_whichField, int_level, int_value) end
function BlzSetAbilityRealLevelFieldBJ(ability_whichAbility, abilityreallevelfield_whichField, int_level, r_value) end
function BlzSetAbilityStringLevelFieldBJ(ability_whichAbility, abilitystringlevelfield_whichField, int_level, str_value) end
function BlzSetAbilityBooleanLevelArrayFieldBJ(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, int_level, int_index, b_value) end
function BlzSetAbilityIntegerLevelArrayFieldBJ(ability_whichAbility, abilityintegerlevelarrayfield_whichField, int_level, int_index, int_value) end
function BlzSetAbilityRealLevelArrayFieldBJ(ability_whichAbility, abilityreallevelarrayfield_whichField, int_level, int_index, r_value) end
function BlzSetAbilityStringLevelArrayFieldBJ(ability_whichAbility, abilitystringlevelarrayfield_whichField, int_level, int_index, str_value) end
function BlzAddAbilityBooleanLevelArrayFieldBJ(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, int_level, b_value) end
function BlzAddAbilityIntegerLevelArrayFieldBJ(ability_whichAbility, abilityintegerlevelarrayfield_whichField, int_level, int_value) end
function BlzAddAbilityRealLevelArrayFieldBJ(ability_whichAbility, abilityreallevelarrayfield_whichField, int_level, r_value) end
function BlzAddAbilityStringLevelArrayFieldBJ(ability_whichAbility, abilitystringlevelarrayfield_whichField, int_level, str_value) end
function BlzRemoveAbilityBooleanLevelArrayFieldBJ(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, int_level, b_value) end
function BlzRemoveAbilityIntegerLevelArrayFieldBJ(ability_whichAbility, abilityintegerlevelarrayfield_whichField, int_level, int_value) end
function BlzRemoveAbilityRealLevelArrayFieldBJ(ability_whichAbility, abilityreallevelarrayfield_whichField, int_level, r_value) end
function BlzRemoveAbilityStringLevelArrayFieldBJ(ability_whichAbility, abilitystringlevelarrayfield_whichField, int_level, str_value) end
--=============================================================
function BlzItemAddAbilityBJ(item_whichItem, int_abilCode) end
function BlzItemRemoveAbilityBJ(item_whichItem, int_abilCode) end
function BlzSetItemBooleanFieldBJ(item_whichItem, itembooleanfield_whichField, b_value) end
function BlzSetItemIntegerFieldBJ(item_whichItem, itemintegerfield_whichField, int_value) end
function BlzSetItemRealFieldBJ(item_whichItem, itemrealfield_whichField, r_value) end
function BlzSetItemStringFieldBJ(item_whichItem, itemstringfield_whichField, str_value) end
--===========================================================================
function BlzSetUnitBooleanFieldBJ(unit_whichUnit, unitbooleanfield_whichField, b_value) end
function BlzSetUnitIntegerFieldBJ(unit_whichUnit, unitintegerfield_whichField, int_value) end
function BlzSetUnitRealFieldBJ(unit_whichUnit, unitrealfield_whichField, r_value) end
function BlzSetUnitStringFieldBJ(unit_whichUnit, unitstringfield_whichField, str_value) end
--===========================================================================
function BlzSetUnitWeaponBooleanFieldBJ(unit_whichUnit, unitweaponbooleanfield_whichField, int_index, b_value) end
function BlzSetUnitWeaponIntegerFieldBJ(unit_whichUnit, unitweaponintegerfield_whichField, int_index, int_value) end
function BlzSetUnitWeaponRealFieldBJ(unit_whichUnit, unitweaponrealfield_whichField, int_index, r_value) end
function BlzSetUnitWeaponStringFieldBJ(unit_whichUnit, unitweaponstringfield_whichField, int_index, str_value) end
