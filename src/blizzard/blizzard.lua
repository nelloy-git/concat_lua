--===========================================================================
-- Blizzard.j ( define Jass2 functions that need to be in every map script )
--===========================================================================

-------------------------------------------------------------------------
-- Constants
--

-- Misc constants
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

-- Game constants
bj_MAX_INVENTORY = 6
bj_MAX_PLAYERS = GetBJMaxPlayers()
bj_PLAYER_NEUTRAL_VICTIM = GetBJPlayerNeutralVictim()
bj_PLAYER_NEUTRAL_EXTRA = GetBJPlayerNeutralExtra()
bj_MAX_PLAYER_SLOTS = GetBJMaxPlayerSlots()
bj_MAX_SKELETONS = 25
bj_MAX_STOCK_ITEM_SLOTS = 11
bj_MAX_STOCK_UNIT_SLOTS = 11
bj_MAX_ITEM_LEVEL = 10

-- Ideally these would be looked up from Units/MiscData.txt,
-- but there is currently no script functionality exposed to do that
bj_TOD_DAWN = 6.00
bj_TOD_DUSK = 18.00

-- Melee game settings:
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

-- Delay between a creep's death and the time it may drop an item.
bj_CREEP_ITEM_DELAY = 0.50

-- Timing settings for Marketplace inventories.
bj_STOCK_RESTOCK_INITIAL_DELAY = 120
bj_STOCK_RESTOCK_INTERVAL = 30
bj_STOCK_MAX_ITERATIONS = 20

-- Max events registered by a single "dest dies in region" event.
bj_MAX_DEST_IN_REGION_EVENTS = 64

-- Camera settings
bj_CAMERA_MIN_FARZ = 100
bj_CAMERA_DEFAULT_DISTANCE = 1650
bj_CAMERA_DEFAULT_FARZ = 5000
bj_CAMERA_DEFAULT_AOA = 304
bj_CAMERA_DEFAULT_FOV = 70
bj_CAMERA_DEFAULT_ROLL = 0
bj_CAMERA_DEFAULT_ROTATION = 90

-- Rescue
bj_RESCUE_PING_TIME = 2.00

-- Transmission behavior settings
bj_NOTHING_SOUND_DURATION = 5.00
bj_TRANSMISSION_PING_TIME = 1.00
bj_TRANSMISSION_IND_RED = 255
bj_TRANSMISSION_IND_BLUE = 255
bj_TRANSMISSION_IND_GREEN = 255
bj_TRANSMISSION_IND_ALPHA = 255
bj_TRANSMISSION_PORT_HANGTIME = 1.50

-- Cinematic mode settings
bj_CINEMODE_INTERFACEFADE = 0.50
bj_CINEMODE_GAMESPEED = MAP_SPEED_NORMAL

-- Cinematic mode volume levels
bj_CINEMODE_VOLUME_UNITMOVEMENT = 0.40
bj_CINEMODE_VOLUME_UNITSOUNDS = 0.00
bj_CINEMODE_VOLUME_COMBAT = 0.40
bj_CINEMODE_VOLUME_SPELLS = 0.40
bj_CINEMODE_VOLUME_UI = 0.00
bj_CINEMODE_VOLUME_MUSIC = 0.55
bj_CINEMODE_VOLUME_AMBIENTSOUNDS = 1.00
bj_CINEMODE_VOLUME_FIRE = 0.60

-- Speech mode volume levels
bj_SPEECH_VOLUME_UNITMOVEMENT = 0.25
bj_SPEECH_VOLUME_UNITSOUNDS = 0.00
bj_SPEECH_VOLUME_COMBAT = 0.25
bj_SPEECH_VOLUME_SPELLS = 0.25
bj_SPEECH_VOLUME_UI = 0.00
bj_SPEECH_VOLUME_MUSIC = 0.55
bj_SPEECH_VOLUME_AMBIENTSOUNDS = 1.00
bj_SPEECH_VOLUME_FIRE = 0.60

-- Smart pan settings
bj_SMARTPAN_TRESHOLD_PAN = 500
bj_SMARTPAN_TRESHOLD_SNAP = 3500

-- QueuedTriggerExecute settings
bj_MAX_QUEUED_TRIGGERS = 100
bj_QUEUED_TRIGGER_TIMEOUT = 180.00

-- Campaign indexing constants
bj_CAMPAIGN_INDEX_T = 0
bj_CAMPAIGN_INDEX_H = 1
bj_CAMPAIGN_INDEX_U = 2
bj_CAMPAIGN_INDEX_O = 3
bj_CAMPAIGN_INDEX_N = 4
bj_CAMPAIGN_INDEX_XN = 5
bj_CAMPAIGN_INDEX_XH = 6
bj_CAMPAIGN_INDEX_XU = 7
bj_CAMPAIGN_INDEX_XO = 8

-- Campaign offset constants (for mission indexing)
bj_CAMPAIGN_OFFSET_T = 0
bj_CAMPAIGN_OFFSET_H = 1
bj_CAMPAIGN_OFFSET_U = 2
bj_CAMPAIGN_OFFSET_O = 3
bj_CAMPAIGN_OFFSET_N = 4
bj_CAMPAIGN_OFFSET_XN = 0
bj_CAMPAIGN_OFFSET_XH = 1
bj_CAMPAIGN_OFFSET_XU = 2
bj_CAMPAIGN_OFFSET_XO = 3

-- Mission indexing constants
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

-- Expansion Orc
bj_MISSION_INDEX_XO00 = bj_CAMPAIGN_OFFSET_XO * 1000 + 0
bj_MISSION_INDEX_XO01 = bj_CAMPAIGN_OFFSET_XO * 1000 + 1
bj_MISSION_INDEX_XO02 = bj_CAMPAIGN_OFFSET_XO * 1000 + 2
bj_MISSION_INDEX_XO03 = bj_CAMPAIGN_OFFSET_XO * 1000 + 3

-- Cinematic indexing constants
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

-- Alliance settings
bj_ALLIANCE_UNALLIED = 0
bj_ALLIANCE_UNALLIED_VISION = 1
bj_ALLIANCE_ALLIED = 2
bj_ALLIANCE_ALLIED_VISION = 3
bj_ALLIANCE_ALLIED_UNITS = 4
bj_ALLIANCE_ALLIED_ADVUNITS = 5
bj_ALLIANCE_NEUTRAL = 6
bj_ALLIANCE_NEUTRAL_VISION = 7

-- Keyboard Event Types
bj_KEYEVENTTYPE_DEPRESS = 0
bj_KEYEVENTTYPE_RELEASE = 1

-- Keyboard Event Keys
bj_KEYEVENTKEY_LEFT = 0
bj_KEYEVENTKEY_RIGHT = 1
bj_KEYEVENTKEY_DOWN = 2
bj_KEYEVENTKEY_UP = 3

-- Mouse Event Types
bj_MOUSEEVENTTYPE_DOWN = 0
bj_MOUSEEVENTTYPE_UP = 1
bj_MOUSEEVENTTYPE_MOVE = 2

-- Transmission timing methods
bj_TIMETYPE_ADD = 0
bj_TIMETYPE_SET = 1
bj_TIMETYPE_SUB = 2

-- Camera bounds adjustment methods
bj_CAMERABOUNDS_ADJUST_ADD = 0
bj_CAMERABOUNDS_ADJUST_SUB = 1

-- Quest creation states
bj_QUESTTYPE_REQ_DISCOVERED = 0
bj_QUESTTYPE_REQ_UNDISCOVERED = 1
bj_QUESTTYPE_OPT_DISCOVERED = 2
bj_QUESTTYPE_OPT_UNDISCOVERED = 3

-- Quest message types
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

-- Leaderboard sorting methods
bj_SORTTYPE_SORTBYVALUE = 0
bj_SORTTYPE_SORTBYPLAYER = 1
bj_SORTTYPE_SORTBYLABEL = 2

-- Cinematic fade filter methods
bj_CINEFADETYPE_FADEIN = 0
bj_CINEFADETYPE_FADEOUT = 1
bj_CINEFADETYPE_FADEOUTIN = 2

-- Buff removal methods
bj_REMOVEBUFFS_POSITIVE = 0
bj_REMOVEBUFFS_NEGATIVE = 1
bj_REMOVEBUFFS_ALL = 2
bj_REMOVEBUFFS_NONTLIFE = 3

-- Buff properties - polarity
bj_BUFF_POLARITY_POSITIVE = 0
bj_BUFF_POLARITY_NEGATIVE = 1
bj_BUFF_POLARITY_EITHER = 2

-- Buff properties - resist type
bj_BUFF_RESIST_MAGIC = 0
bj_BUFF_RESIST_PHYSICAL = 1
bj_BUFF_RESIST_EITHER = 2
bj_BUFF_RESIST_BOTH = 3

-- Hero stats
bj_HEROSTAT_STR = 0
bj_HEROSTAT_AGI = 1
bj_HEROSTAT_INT = 2

-- Hero skill point modification methods
bj_MODIFYMETHOD_ADD = 0
bj_MODIFYMETHOD_SUB = 1
bj_MODIFYMETHOD_SET = 2

-- Unit state adjustment methods (for replaced units)
bj_UNIT_STATE_METHOD_ABSOLUTE = 0
bj_UNIT_STATE_METHOD_RELATIVE = 1
bj_UNIT_STATE_METHOD_DEFAULTS = 2
bj_UNIT_STATE_METHOD_MAXIMUM = 3

-- Gate operations
bj_GATEOPERATION_CLOSE = 0
bj_GATEOPERATION_OPEN = 1
bj_GATEOPERATION_DESTROY = 2

-- Game cache value types
bj_GAMECACHE_BOOLEAN = 0
bj_GAMECACHE_INTEGER = 1
bj_GAMECACHE_REAL = 2
bj_GAMECACHE_UNIT = 3
bj_GAMECACHE_STRING = 4

-- Hashtable value types
bj_HASHTABLE_BOOLEAN = 0
bj_HASHTABLE_INTEGER = 1
bj_HASHTABLE_REAL = 2
bj_HASHTABLE_STRING = 3
bj_HASHTABLE_HANDLE = 4

-- Item status types
bj_ITEM_STATUS_HIDDEN = 0
bj_ITEM_STATUS_OWNED = 1
bj_ITEM_STATUS_INVULNERABLE = 2
bj_ITEM_STATUS_POWERUP = 3
bj_ITEM_STATUS_SELLABLE = 4
bj_ITEM_STATUS_PAWNABLE = 5

-- Itemcode status types
bj_ITEMCODE_STATUS_POWERUP = 0
bj_ITEMCODE_STATUS_SELLABLE = 1
bj_ITEMCODE_STATUS_PAWNABLE = 2

-- Minimap ping styles
bj_MINIMAPPINGSTYLE_SIMPLE = 0
bj_MINIMAPPINGSTYLE_FLASHY = 1
bj_MINIMAPPINGSTYLE_ATTACK = 2

-- Corpse creation settings
bj_CORPSE_MAX_DEATH_TIME = 8.00

-- Corpse creation styles
bj_CORPSETYPE_FLESH = 0
bj_CORPSETYPE_BONE = 1

-- Elevator pathing-blocker destructable code
bj_ELEVATOR_BLOCKER_CODE = 'DTep'
bj_ELEVATOR_CODE01 = 'DTrf'
bj_ELEVATOR_CODE02 = 'DTrx'

-- Elevator wall codes
bj_ELEVATOR_WALL_TYPE_ALL = 0
bj_ELEVATOR_WALL_TYPE_EAST = 1
bj_ELEVATOR_WALL_TYPE_NORTH = 2
bj_ELEVATOR_WALL_TYPE_SOUTH = 3
bj_ELEVATOR_WALL_TYPE_WEST = 4

-------------------------------------------------------------------------
-- Variables
--

-- Force predefs

-- Map area rects

-- Utility function vars

-- Game started detection vars

-- Singleplayer check

-- Day/Night Cycle vars

-- Triggered sounds
--sound bj_pingMinimapSound = null

-- Marketplace vars

-- Melee vars

-- Rescue behavior vars

-- Transmission vars

-- Cinematic mode vars

-- Cinematic fade vars

-- QueuedTriggerExecute vars

-- Helper vars (for Filter and Enum funcs)

-- Random distribution vars

-- Last X'd vars

-- Filter function vars

-- Memory cleanup vars

-- Instanced Operation Results

--***************************************************************************
--*
--* Debugging Functions
--*
--***************************************************************************

--===========================================================================
function BJDebugMsg(s_msg) end

--***************************************************************************
--*
--* Math Utility Functions
--*
--***************************************************************************

--===========================================================================
function RMinBJ(r_a, r_b) return real end

--===========================================================================
function RMaxBJ(r_a, r_b) return real end

--===========================================================================
function RAbsBJ(r_a) return real end

--===========================================================================
function RSignBJ(r_a) return real end

--===========================================================================
function IMinBJ(i_a, i_b) return integer end

--===========================================================================
function IMaxBJ(i_a, i_b) return integer end

--===========================================================================
function IAbsBJ(i_a) return integer end

--===========================================================================
function ISignBJ(i_a) return integer end

--===========================================================================
function SinBJ(r_degrees) return real end

--===========================================================================
function CosBJ(r_degrees) return real end

--===========================================================================
function TanBJ(r_degrees) return real end

--===========================================================================
function AsinBJ(r_degrees) return real end

--===========================================================================
function AcosBJ(r_degrees) return real end

--===========================================================================
function AtanBJ(r_degrees) return real end

--===========================================================================
function Atan2BJ(r_y, r_x) return real end

--===========================================================================
function AngleBetweenPoints(location_locA, location_locB) return real end

--===========================================================================
function DistanceBetweenPoints(location_locA, location_locB) return real end

--===========================================================================
function PolarProjectionBJ(location_source, r_dist, r_angle) return location end

--===========================================================================
function GetRandomDirectionDeg() return real end

--===========================================================================
function GetRandomPercentageBJ() return real end

--===========================================================================
function GetRandomLocInRect(rect_whichRect) return location end

--===========================================================================
-- Calculate the modulus/remainder of (dividend) divided by (divisor).
-- Examples: 18 mod 5 = 3. 15 mod 5 = 0. -8 mod 5 = 2.
--
function ModuloInteger(i_dividend, i_divisor) return integer end

-- If the dividend was negative, the above modulus calculation will
-- be negative, but within (-divisor..0). We can add (divisor) to
-- shift this result into the desired range of (0..divisor).

--===========================================================================
-- Calculate the modulus/remainder of (dividend) divided by (divisor).
-- Examples: 13.000 mod 2.500 = 0.500. -6.000 mod 2.500 = 1.500.
--
function ModuloReal(r_dividend, r_divisor) return real end

-- If the dividend was negative, the above modulus calculation will
-- be negative, but within (-divisor..0). We can add (divisor) to
-- shift this result into the desired range of (0..divisor).

--===========================================================================
function OffsetLocation(location_loc, r_dx, r_dy) return location end

--===========================================================================
function OffsetRectBJ(rect_r, r_dx, r_dy) return rect end

--===========================================================================
function RectFromCenterSizeBJ(location_center, r_width, r_height) return rect end

--===========================================================================
function RectContainsCoords(rect_r, r_x, r_y) return boolean end

--===========================================================================
function RectContainsLoc(rect_r, location_loc) return boolean end

--===========================================================================
function RectContainsUnit(rect_r, unit_whichUnit) return boolean end

--===========================================================================
function RectContainsItem(item_whichItem, rect_r) return boolean end

--***************************************************************************
--*
--* Utility Constructs
--*
--***************************************************************************

--===========================================================================
-- Runs the trigger's actions if the trigger's conditions evaluate to true.
--
function ConditionalTriggerExecute(trigger_trig) end

--===========================================================================
-- Runs the trigger's actions if the trigger's conditions evaluate to true.
--
function TriggerExecuteBJ(trigger_trig, b_checkConditions) return boolean end

--===========================================================================
-- Arranges for a trigger to fire almost immediately, except that the calling
-- trigger is not interrupted as is the case with a TriggerExecute call.
-- Since the trigger executes normally, its conditions are still evaluated.
--
function PostTriggerExecuteBJ(trigger_trig, b_checkConditions) return boolean end

--===========================================================================
-- Debug - Display the contents of the trigger queue (as either null or "x"
-- for each entry).
function QueuedTriggerCheck() end

--===========================================================================
-- Searches the queue for a given trigger, returning the index of the
-- trigger within the queue if it is found, or -1 if it is not found.
--
function QueuedTriggerGetIndex(trigger_trig) return integer end
-- Determine which, if any, of the queued triggers is being removed.

--===========================================================================
-- Removes a trigger from the trigger queue, shifting other triggers down
-- to fill the unused space. If the currently running trigger is removed
-- in this manner, this function does NOT attempt to run the next trigger.
--
function QueuedTriggerRemoveByIndex(i_trigIndex) return boolean end

-- If the to-be-removed index is out of range, fail.

-- Shift all queue entries down to fill in the gap.

--===========================================================================
-- Attempt to execute the first trigger in the queue. If it fails, remove
-- it and execute the next one. Continue this cycle until a trigger runs,
-- or until the queue is empty.
--
function QueuedTriggerAttemptExec() return boolean end

-- Timeout the queue if it sits at the front of the queue for too long.

--===========================================================================
-- Queues a trigger to be executed, assuring that such triggers are not
-- executed at the same time.
--
function QueuedTriggerAddBJ(trigger_trig, b_checkConditions) return boolean end
-- Make sure our queue isn't full. If it is, return failure.

-- Add the trigger to an array of to-be-executed triggers.

-- If this is the only trigger in the queue, run it.

--===========================================================================
-- Denotes the end of a queued trigger. Be sure to call this only once per
-- queued trigger, or risk stepping on the toes of other queued triggers.
--
function QueuedTriggerRemoveBJ(trigger_trig) end

-- Find the trigger's index.

-- Shuffle the other trigger entries down to fill in the gap.

-- If we just axed the currently running trigger, run the next one.

--===========================================================================
-- Denotes the end of a queued trigger. Be sure to call this only once per
-- queued trigger, lest you step on the toes of other queued triggers.
--
function QueuedTriggerDoneBJ() end

-- Make sure there's something on the queue to remove.

-- Remove the currently running trigger from the array.

-- If other triggers are waiting to run, run one of them.

--===========================================================================
-- Empty the trigger queue.
--
function QueuedTriggerClearBJ() end

--===========================================================================
-- Remove all but the currently executing trigger from the trigger queue.
--
function QueuedTriggerClearInactiveBJ() end

--===========================================================================
function QueuedTriggerCountBJ() return integer end

--===========================================================================
function IsTriggerQueueEmptyBJ() return boolean end

--===========================================================================
function IsTriggerQueuedBJ(trigger_trig) return boolean end

--===========================================================================
function GetForLoopIndexA() return integer end

--===========================================================================
function SetForLoopIndexA(i_newIndex) end

--===========================================================================
function GetForLoopIndexB() return integer end

--===========================================================================
function SetForLoopIndexB(i_newIndex) end

--===========================================================================
-- We can't do game-time waits, so this simulates one by starting a timer
-- and polling until the timer expires.
function PolledWait(r_duration) end

-- If we have a bit of time left, skip past 10% of the remaining
-- duration instead of checking every interval, to minimize the
-- polling on long waits.

--===========================================================================
function IntegerTertiaryOp(b_flag, i_valueA, i_valueB) return integer end

--***************************************************************************
--*
--* General Utility Functions
--* These functions exist purely to make the trigger dialogs cleaner and
--* more comprehensible.
--*
--***************************************************************************

--===========================================================================
function DoNothing() end

--===========================================================================
-- This function does . WorldEdit should should eventually ignore
-- CommentString triggers during script generation, but until such a time,
-- this function will serve as a stub.
--
function CommentString(s_commentString) end

--===========================================================================
-- This function returns the input string, converting it from the localized text, if necessary
--
function StringIdentity(s_theString) return string end

--===========================================================================
function GetBooleanAnd(b_valueA, b_valueB) return boolean end

--===========================================================================
function GetBooleanOr(b_valueA, b_valueB) return boolean end

--===========================================================================
-- Converts a percentage (real, 0..100) into a scaled integer (0..max),
-- clipping the result to 0..max in case the input is invalid.
--
function PercentToInt(r_percentage, i_max) return integer end

--===========================================================================
function PercentTo255(r_percentage) return integer end

--===========================================================================
function GetTimeOfDay() return real end

--===========================================================================
function SetTimeOfDay(r_whatTime) end

--===========================================================================
function SetTimeOfDayScalePercentBJ(r_scalePercent) end

--===========================================================================
function GetTimeOfDayScalePercentBJ() return real end

--===========================================================================
function PlaySound(s_soundName) end

--===========================================================================
function CompareLocationsBJ(location_A, location_B) return boolean end

--===========================================================================
function CompareRectsBJ(rect_A, rect_B) return boolean end

--===========================================================================
-- Returns a square rect that exactly encompasses the specified circle.
--
function GetRectFromCircleBJ(location_center, r_radius) return rect end

--***************************************************************************
--*
--* Camera Utility Functions
--*
--***************************************************************************

--===========================================================================
function GetCurrentCameraSetup() return camerasetup end

--===========================================================================
function CameraSetupApplyForPlayer(b_doPan, camerasetup_whichSetup, player_whichPlayer, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function CameraSetupGetFieldSwap(camerafield_whichField, camerasetup_whichSetup) return real end

--===========================================================================
function SetCameraFieldForPlayer(player_whichPlayer, camerafield_whichField, r_value, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetCameraTargetControllerNoZForPlayer(player_whichPlayer, unit_whichUnit, r_xoffset, r_yoffset, b_inheritOrientation) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetCameraPositionForPlayer(player_whichPlayer, r_x, r_y) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetCameraPositionLocForPlayer(player_whichPlayer, location_loc) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function RotateCameraAroundLocBJ(r_degrees, location_loc, player_whichPlayer, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function PanCameraToForPlayer(player_whichPlayer, r_x, r_y) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function PanCameraToLocForPlayer(player_whichPlayer, location_loc) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function PanCameraToTimedForPlayer(player_whichPlayer, r_x, r_y, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function PanCameraToTimedLocForPlayer(player_whichPlayer, location_loc, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function PanCameraToTimedLocWithZForPlayer(player_whichPlayer, location_loc, r_zOffset, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SmartCameraPanBJ(player_whichPlayer, location_loc, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- If the user is too far away, snap the camera.

-- If the user is moderately close, pan the camera.

-- User is close enough, so don't touch the camera.

--===========================================================================
function SetCinematicCameraForPlayer(player_whichPlayer, s_cameraModelFile) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function ResetToGameCameraForPlayer(player_whichPlayer, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function CameraSetSourceNoiseForPlayer(player_whichPlayer, r_magnitude, r_velocity) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function CameraSetTargetNoiseForPlayer(player_whichPlayer, r_magnitude, r_velocity) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function CameraSetEQNoiseForPlayer(player_whichPlayer, r_magnitude) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function CameraClearNoiseForPlayer(player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
-- Query the current camera bounds.
--
function GetCurrentCameraBoundsMapRectBJ() return rect end

--===========================================================================
-- Query the initial camera bounds, as defined at map init.
--
function GetCameraBoundsMapRect() return rect end

--===========================================================================
-- Query the playable map area, as defined at map init.
--
function GetPlayableMapRect() return rect end

--===========================================================================
-- Query the entire map area, as defined at map init.
--
function GetEntireMapRect() return rect end

--===========================================================================
function SetCameraBoundsToRect(rect_r) end

--===========================================================================
function SetCameraBoundsToRectForPlayerBJ(player_whichPlayer, rect_r) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function AdjustCameraBoundsBJ(i_adjustMethod, r_dxWest, r_dxEast, r_dyNorth, r_dySouth) end

-- Unrecognized adjustment method - ignore the request.

-- Adjust the actual camera values

-- Make sure the camera bounds are still valid.

-- Apply the new camera values.

--===========================================================================
function AdjustCameraBoundsForPlayerBJ(i_adjustMethod, player_whichPlayer, r_dxWest, r_dxEast, r_dyNorth, r_dySouth) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetCameraQuickPositionForPlayer(player_whichPlayer, r_x, r_y) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetCameraQuickPositionLocForPlayer(player_whichPlayer, location_loc) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetCameraQuickPositionLoc(location_loc) end

--===========================================================================
function StopCameraForPlayerBJ(player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetCameraOrientControllerForPlayerBJ(player_whichPlayer, unit_whichUnit, r_xoffset, r_yoffset) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function CameraSetSmoothingFactorBJ(r_factor) end

--===========================================================================
function CameraResetSmoothingFactorBJ() end

--***************************************************************************
--*
--* Text Utility Functions
--*
--***************************************************************************

--===========================================================================
function DisplayTextToForce(force_toForce, s_message) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function DisplayTimedTextToForce(force_toForce, r_duration, s_message) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function ClearTextMessagesBJ(force_toForce) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
-- The parameters for the API Substring function are unintuitive, so this
-- merely performs a translation for the starting index.
--
function SubStringBJ(s_source, i_start, i_end) return string end

function GetHandleIdBJ(h_h) return integer end

function StringHashBJ(s_s) return integer end

--***************************************************************************
--*
--* Event Registration Utility Functions
--*
--***************************************************************************

--===========================================================================
function TriggerRegisterTimerEventPeriodic(trigger_trig, r_timeout) return event end

--===========================================================================
function TriggerRegisterTimerEventSingle(trigger_trig, r_timeout) return event end

--===========================================================================
function TriggerRegisterTimerExpireEventBJ(trigger_trig, timer_t) return event end

--===========================================================================
function TriggerRegisterPlayerUnitEventSimple(trigger_trig, player_whichPlayer, playerunitevent_whichEvent) return event end

--===========================================================================
function TriggerRegisterAnyUnitEventBJ(trigger_trig, playerunitevent_whichEvent) end

--===========================================================================
function TriggerRegisterPlayerSelectionEventBJ(trigger_trig, player_whichPlayer, b_selected) return event end

--===========================================================================
function TriggerRegisterPlayerKeyEventBJ(trigger_trig, player_whichPlayer, i_keType, i_keKey) return event end

-- Depress event - find out what key

-- Unrecognized key - ignore the request and return failure.

-- Release event - find out what key

-- Unrecognized key - ignore the request and return failure.

-- Unrecognized type - ignore the request and return failure.

--===========================================================================
function TriggerRegisterPlayerMouseEventBJ(trigger_trig, player_whichPlayer, i_meType) return event end

-- Mouse down event

-- Mouse up event

-- Mouse move event

-- Unrecognized type - ignore the request and return failure.

--===========================================================================
function TriggerRegisterPlayerEventVictory(trigger_trig, player_whichPlayer) return event end

--===========================================================================
function TriggerRegisterPlayerEventDefeat(trigger_trig, player_whichPlayer) return event end

--===========================================================================
function TriggerRegisterPlayerEventLeave(trigger_trig, player_whichPlayer) return event end

--===========================================================================
function TriggerRegisterPlayerEventAllianceChanged(trigger_trig, player_whichPlayer) return event end

--===========================================================================
function TriggerRegisterPlayerEventEndCinematic(trigger_trig, player_whichPlayer) return event end

--===========================================================================
function TriggerRegisterGameStateEventTimeOfDay(trigger_trig, limitop_opcode, r_limitval) return event end

--===========================================================================
function TriggerRegisterEnterRegionSimple(trigger_trig, region_whichRegion) return event end

--===========================================================================
function TriggerRegisterLeaveRegionSimple(trigger_trig, region_whichRegion) return event end

--===========================================================================
function TriggerRegisterEnterRectSimple(trigger_trig, rect_r) return event end

--===========================================================================
function TriggerRegisterLeaveRectSimple(trigger_trig, rect_r) return event end

--===========================================================================
function TriggerRegisterDistanceBetweenUnits(trigger_trig, unit_whichUnit, boolexpr_condition, r_range) return event end

--===========================================================================
function TriggerRegisterUnitInRangeSimple(trigger_trig, r_range, unit_whichUnit) return event end

--===========================================================================
function TriggerRegisterUnitLifeEvent(trigger_trig, unit_whichUnit, limitop_opcode, r_limitval) return event end

--===========================================================================
function TriggerRegisterUnitManaEvent(trigger_trig, unit_whichUnit, limitop_opcode, r_limitval) return event end

--===========================================================================
function TriggerRegisterDialogEventBJ(trigger_trig, dialog_whichDialog) return event end

--===========================================================================
function TriggerRegisterShowSkillEventBJ(trigger_trig) return event end

--===========================================================================
function TriggerRegisterBuildSubmenuEventBJ(trigger_trig) return event end

--===========================================================================
function TriggerRegisterGameLoadedEventBJ(trigger_trig) return event end

--===========================================================================
function TriggerRegisterGameSavedEventBJ(trigger_trig) return event end

--===========================================================================
function RegisterDestDeathInRegionEnum() end

--===========================================================================
function TriggerRegisterDestDeathInRegionEvent(trigger_trig, rect_r) end

--***************************************************************************
--*
--* Environment Utility Functions
--*
--***************************************************************************

--===========================================================================
function AddWeatherEffectSaveLast(rect_where, i_effectID) return weathereffect end

--===========================================================================
function GetLastCreatedWeatherEffect() return weathereffect end

--===========================================================================
function RemoveWeatherEffectBJ(weathereffect_whichWeatherEffect) end

--===========================================================================
function TerrainDeformationCraterBJ(r_duration, b_permanent, location_where, r_radius, r_depth) return terraindeformation end

--===========================================================================
function TerrainDeformationRippleBJ(r_duration, b_limitNeg, location_where, r_startRadius, r_endRadius, r_depth, r_wavePeriod, r_waveWidth) return terraindeformation end

--===========================================================================
function TerrainDeformationWaveBJ(r_duration, location_source, location_target, r_radius, r_depth, r_trailDelay) return terraindeformation end

--===========================================================================
function TerrainDeformationRandomBJ(r_duration, location_where, r_radius, r_minDelta, r_maxDelta, r_updateInterval) return terraindeformation end

--===========================================================================
function TerrainDeformationStopBJ(terraindeformation_deformation, r_duration) end

--===========================================================================
function GetLastCreatedTerrainDeformation() return terraindeformation end

--===========================================================================
function AddLightningLoc(s_codeName, location_where1, location_where2) return lightning end

--===========================================================================
function DestroyLightningBJ(lightning_whichBolt) return boolean end

--===========================================================================
function MoveLightningLoc(lightning_whichBolt, location_where1, location_where2) return boolean end

--===========================================================================
function GetLightningColorABJ(lightning_whichBolt) return real end

--===========================================================================
function GetLightningColorRBJ(lightning_whichBolt) return real end

--===========================================================================
function GetLightningColorGBJ(lightning_whichBolt) return real end

--===========================================================================
function GetLightningColorBBJ(lightning_whichBolt) return real end

--===========================================================================
function SetLightningColorBJ(lightning_whichBolt, r_r, r_g, r_b, r_a) return boolean end

--===========================================================================
function GetLastCreatedLightningBJ() return lightning end

--===========================================================================
function GetAbilityEffectBJ(i_abilcode, effecttype_t, i_index) return string end

--===========================================================================
function GetAbilitySoundBJ(i_abilcode, soundtype_t) return string end

--===========================================================================
function GetTerrainCliffLevelBJ(location_where) return integer end

--===========================================================================
function GetTerrainTypeBJ(location_where) return integer end

--===========================================================================
function GetTerrainVarianceBJ(location_where) return integer end

--===========================================================================
function SetTerrainTypeBJ(location_where, i_terrainType, i_variation, i_area, i_shape) end

--===========================================================================
function IsTerrainPathableBJ(location_where, pathingtype_t) return boolean end

--===========================================================================
function SetTerrainPathableBJ(location_where, pathingtype_t, b_flag) end

--===========================================================================
function SetWaterBaseColorBJ(r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function CreateFogModifierRectSimple(player_whichPlayer, fogstate_whichFogState, rect_r, b_afterUnits) return fogmodifier end

--===========================================================================
function CreateFogModifierRadiusLocSimple(player_whichPlayer, fogstate_whichFogState, location_center, r_radius, b_afterUnits) return fogmodifier end

--===========================================================================
-- Version of CreateFogModifierRect that assumes use of sharedVision and
-- gives the option of immediately enabling the modifier, so that triggers
-- can default to modifiers that are immediately enabled.
--
function CreateFogModifierRectBJ(b_enabled, player_whichPlayer, fogstate_whichFogState, rect_r) return fogmodifier end

--===========================================================================
-- Version of CreateFogModifierRadius that assumes use of sharedVision and
-- gives the option of immediately enabling the modifier, so that triggers
-- can default to modifiers that are immediately enabled.
--
function CreateFogModifierRadiusLocBJ(b_enabled, player_whichPlayer, fogstate_whichFogState, location_center, r_radius) return fogmodifier end

--===========================================================================
function GetLastCreatedFogModifier() return fogmodifier end

--===========================================================================
function FogEnableOn() end

--===========================================================================
function FogEnableOff() end

--===========================================================================
function FogMaskEnableOn() end

--===========================================================================
function FogMaskEnableOff() end

--===========================================================================
function UseTimeOfDayBJ(b_flag) end

--===========================================================================
function SetTerrainFogExBJ(i_style, r_zstart, r_zend, r_density, r_red, r_green, r_blue) end

--===========================================================================
function ResetTerrainFogBJ() end

--===========================================================================
function SetDoodadAnimationBJ(s_animName, i_doodadID, r_radius, location_center) end

--===========================================================================
function SetDoodadAnimationRectBJ(s_animName, i_doodadID, rect_r) end

--===========================================================================
function AddUnitAnimationPropertiesBJ(b_add, s_animProperties, unit_whichUnit) end

--============================================================================
function CreateImageBJ(s_file, r_size, location_where, r_zOffset, i_imageType) return image end

--============================================================================
function ShowImageBJ(b_flag, image_whichImage) end

--============================================================================
function SetImagePositionBJ(image_whichImage, location_where, r_zOffset) end

--============================================================================
function SetImageColorBJ(image_whichImage, r_red, r_green, r_blue, r_alpha) end

--============================================================================
function GetLastCreatedImage() return image end

--============================================================================
function CreateUbersplatBJ(location_where, s_name, r_red, r_green, r_blue, r_alpha, b_forcePaused, b_noBirthTime) return ubersplat end

--============================================================================
function ShowUbersplatBJ(b_flag, ubersplat_whichSplat) end

--============================================================================
function GetLastCreatedUbersplat() return ubersplat end

--***************************************************************************
--*
--* Sound Utility Functions
--*
--***************************************************************************

--===========================================================================
function PlaySoundBJ(sound_soundHandle) end

--===========================================================================
function StopSoundBJ(sound_soundHandle, b_fadeOut) end

--===========================================================================
function SetSoundVolumeBJ(sound_soundHandle, r_volumePercent) end

--===========================================================================
function SetSoundOffsetBJ(r_newOffset, sound_soundHandle) end

--===========================================================================
function SetSoundDistanceCutoffBJ(sound_soundHandle, r_cutoff) end

--===========================================================================
function SetSoundPitchBJ(sound_soundHandle, r_pitch) end

--===========================================================================
function SetSoundPositionLocBJ(sound_soundHandle, location_loc, r_z) end

--===========================================================================
function AttachSoundToUnitBJ(sound_soundHandle, unit_whichUnit) end

--===========================================================================
function SetSoundConeAnglesBJ(sound_soundHandle, r_inside, r_outside, r_outsideVolumePercent) end

--===========================================================================
function KillSoundWhenDoneBJ(sound_soundHandle) end

--===========================================================================
function PlaySoundAtPointBJ(sound_soundHandle, r_volumePercent, location_loc, r_z) end

--===========================================================================
function PlaySoundOnUnitBJ(sound_soundHandle, r_volumePercent, unit_whichUnit) end

--===========================================================================
function PlaySoundFromOffsetBJ(sound_soundHandle, r_volumePercent, r_startingOffset) end

--===========================================================================
function PlayMusicBJ(s_musicFileName) end

--===========================================================================
function PlayMusicExBJ(s_musicFileName, r_startingOffset, r_fadeInTime) end

--===========================================================================
function SetMusicOffsetBJ(r_newOffset) end

--===========================================================================
function PlayThematicMusicBJ(s_musicName) end

--===========================================================================
function PlayThematicMusicExBJ(s_musicName, r_startingOffset) end

--===========================================================================
function SetThematicMusicOffsetBJ(r_newOffset) end

--===========================================================================
function EndThematicMusicBJ() end

--===========================================================================
function StopMusicBJ(b_fadeOut) end

--===========================================================================
function ResumeMusicBJ() end

--===========================================================================
function SetMusicVolumeBJ(r_volumePercent) end

--===========================================================================
function GetSoundDurationBJ(sound_soundHandle) return real end

--===========================================================================
function GetSoundFileDurationBJ(s_musicFileName) return real end

--===========================================================================
function GetLastPlayedSound() return sound end

--===========================================================================
function GetLastPlayedMusic() return string end

--===========================================================================
function VolumeGroupSetVolumeBJ(volumegroup_vgroup, r_percent) end

--===========================================================================
function SetCineModeVolumeGroupsImmediateBJ() end

--===========================================================================
function SetCineModeVolumeGroupsBJ() end
-- Delay the request if it occurs at map init.

--===========================================================================
function SetSpeechVolumeGroupsImmediateBJ() end

--===========================================================================
function SetSpeechVolumeGroupsBJ() end
-- Delay the request if it occurs at map init.

--===========================================================================
function VolumeGroupResetImmediateBJ() end

--===========================================================================
function VolumeGroupResetBJ() end
-- Delay the request if it occurs at map init.

--===========================================================================
function GetSoundIsPlayingBJ(sound_soundHandle) return boolean end

--===========================================================================
function WaitForSoundBJ(sound_soundHandle, r_offset) end

--===========================================================================
function SetMapMusicIndexedBJ(s_musicName, i_index) end

--===========================================================================
function SetMapMusicRandomBJ(s_musicName) end

--===========================================================================
function ClearMapMusicBJ() end

--===========================================================================
function SetStackedSoundBJ(b_add, sound_soundHandle, rect_r) end

--===========================================================================
function StartSoundForPlayerBJ(player_whichPlayer, sound_soundHandle) end

--===========================================================================
function VolumeGroupSetVolumeForPlayerBJ(player_whichPlayer, volumegroup_vgroup, r_scale) end

--===========================================================================
function EnableDawnDusk(b_flag) end

--===========================================================================
function IsDawnDuskEnabled() return boolean end

--***************************************************************************
--*
--* Day/Night ambient sounds
--*
--***************************************************************************

--===========================================================================
function SetAmbientDaySound(s_inLabel) end

-- Stop old sound, if necessary

-- Create new sound

-- Start the sound if necessary, based on current time

--===========================================================================
function SetAmbientNightSound(s_inLabel) end

-- Stop old sound, if necessary

-- Create new sound

-- Start the sound if necessary, based on current time

--***************************************************************************
--*
--* Special Effect Utility Functions
--*
--***************************************************************************

--===========================================================================
function AddSpecialEffectLocBJ(location_where, s_modelName) return effect end

--===========================================================================
function AddSpecialEffectTargetUnitBJ(s_attachPointName, widget_targetWidget, s_modelName) return effect end

--===========================================================================
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
-- Commented out - Destructibles have no attachment points.
--
--function AddSpecialEffectTargetDestructableBJ takes string attachPointName, widget targetWidget, string modelName returns effect
-- return AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName)
--endfunction

--===========================================================================
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
-- Commented out - Items have no attachment points.
--
--function AddSpecialEffectTargetItemBJ takes string attachPointName, widget targetWidget, string modelName returns effect
-- return AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName)
--endfunction

--===========================================================================
function DestroyEffectBJ(effect_whichEffect) end

--===========================================================================
function GetLastCreatedEffectBJ() return effect end

--***************************************************************************
--*
--* Hero and Item Utility Functions
--*
--***************************************************************************

--===========================================================================
function GetItemLoc(item_whichItem) return location end

--===========================================================================
function GetItemLifeBJ(widget_whichWidget) return real end

--===========================================================================
function SetItemLifeBJ(widget_whichWidget, r_life) end

--===========================================================================
function AddHeroXPSwapped(i_xpToAdd, unit_whichHero, b_showEyeCandy) end

--===========================================================================
function SetHeroLevelBJ(unit_whichHero, i_newLevel, b_showEyeCandy) end

-- No change in level - ignore the request.

--===========================================================================
function DecUnitAbilityLevelSwapped(i_abilcode, unit_whichUnit) return integer end

--===========================================================================
function IncUnitAbilityLevelSwapped(i_abilcode, unit_whichUnit) return integer end

--===========================================================================
function SetUnitAbilityLevelSwapped(i_abilcode, unit_whichUnit, i_level) return integer end

--===========================================================================
function GetUnitAbilityLevelSwapped(i_abilcode, unit_whichUnit) return integer end

--===========================================================================
function UnitHasBuffBJ(unit_whichUnit, i_buffcode) return boolean end

--===========================================================================
function UnitRemoveBuffBJ(i_buffcode, unit_whichUnit) return boolean end

--===========================================================================
function UnitAddItemSwapped(item_whichItem, unit_whichHero) return boolean end

--===========================================================================
function UnitAddItemByIdSwapped(i_itemId, unit_whichHero) return item end
-- Create the item at the hero's feet first, and then give it to him.
-- This is to ensure that the item will be left at the hero's feet if
-- his inventory is full.

--===========================================================================
function UnitRemoveItemSwapped(item_whichItem, unit_whichHero) end

--===========================================================================
-- Translates 0-based slot indices to 1-based slot indices.
--
function UnitRemoveItemFromSlotSwapped(i_itemSlot, unit_whichHero) return item end

--===========================================================================
function CreateItemLoc(i_itemId, location_loc) return item end

--===========================================================================
function GetLastCreatedItem() return item end

--===========================================================================
function GetLastRemovedItem() return item end

--===========================================================================
function SetItemPositionLoc(item_whichItem, location_loc) end

--===========================================================================
function GetLearnedSkillBJ() return integer end

--===========================================================================
function SuspendHeroXPBJ(b_flag, unit_whichHero) end

--===========================================================================
function SetPlayerHandicapXPBJ(player_whichPlayer, r_handicapPercent) end

--===========================================================================
function GetPlayerHandicapXPBJ(player_whichPlayer) return real end

--===========================================================================
function SetPlayerHandicapBJ(player_whichPlayer, r_handicapPercent) end

--===========================================================================
function GetPlayerHandicapBJ(player_whichPlayer) return real end

--===========================================================================
function GetHeroStatBJ(i_whichStat, unit_whichHero, b_includeBonuses) return integer end

-- Unrecognized hero stat - return 0

--===========================================================================
function SetHeroStat(unit_whichHero, i_whichStat, i_value) end
-- Ignore requests for negative hero stats.

-- Unrecognized hero stat - ignore the request.

--===========================================================================
function ModifyHeroStat(i_whichStat, unit_whichHero, i_modifyMethod, i_value) end

-- Unrecognized modification method - ignore the request.

--===========================================================================
function ModifyHeroSkillPoints(unit_whichHero, i_modifyMethod, i_value) return boolean end

-- Unrecognized modification method - ignore the request and return failure.

--===========================================================================
function UnitDropItemPointBJ(unit_whichUnit, item_whichItem, r_x, r_y) return boolean end

--===========================================================================
function UnitDropItemPointLoc(unit_whichUnit, item_whichItem, location_loc) return boolean end

--===========================================================================
function UnitDropItemSlotBJ(unit_whichUnit, item_whichItem, i_slot) return boolean end

--===========================================================================
function UnitDropItemTargetBJ(unit_whichUnit, item_whichItem, widget_target) return boolean end

--===========================================================================
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
function UnitUseItemDestructable(unit_whichUnit, item_whichItem, widget_target) return boolean end

--===========================================================================
function UnitUseItemPointLoc(unit_whichUnit, item_whichItem, location_loc) return boolean end

--===========================================================================
-- Translates 0-based slot indices to 1-based slot indices.
--
function UnitItemInSlotBJ(unit_whichUnit, i_itemSlot) return item end

--===========================================================================
-- Translates 0-based slot indices to 1-based slot indices.
--
function GetInventoryIndexOfItemTypeBJ(unit_whichUnit, i_itemId) return integer end

--===========================================================================
function GetItemOfTypeFromUnitBJ(unit_whichUnit, i_itemId) return item end

--===========================================================================
function UnitHasItemOfTypeBJ(unit_whichUnit, i_itemId) return boolean end

--===========================================================================
function UnitInventoryCount(unit_whichUnit) return integer end

--===========================================================================
function UnitInventorySizeBJ(unit_whichUnit) return integer end

--===========================================================================
function SetItemInvulnerableBJ(item_whichItem, b_flag) end

--===========================================================================
function SetItemDropOnDeathBJ(item_whichItem, b_flag) end

--===========================================================================
function SetItemDroppableBJ(item_whichItem, b_flag) end

--===========================================================================
function SetItemPlayerBJ(item_whichItem, player_whichPlayer, b_changeColor) end

--===========================================================================
function SetItemVisibleBJ(b_show, item_whichItem) end

--===========================================================================
function IsItemHiddenBJ(item_whichItem) return boolean end

--===========================================================================
function ChooseRandomItemBJ(i_level) return integer end

--===========================================================================
function ChooseRandomItemExBJ(i_level, itemtype_whichType) return integer end

--===========================================================================
function ChooseRandomNPBuildingBJ() return integer end

--===========================================================================
function ChooseRandomCreepBJ(i_level) return integer end

--===========================================================================
function EnumItemsInRectBJ(rect_r, c_actionFunc) end

--===========================================================================
-- See GroupPickRandomUnitEnum for the details of this algorithm.
--
function RandomItemInRectBJEnum() end

--===========================================================================
-- Picks a random item from within a rect, matching a condition
--
function RandomItemInRectBJ(rect_r, boolexpr_filter) return item end

--===========================================================================
-- Picks a random item from within a rect
--
function RandomItemInRectSimpleBJ(rect_r) return item end

--===========================================================================
function CheckItemStatus(item_whichItem, i_status) return boolean end

-- Unrecognized status - return false

--===========================================================================
function CheckItemcodeStatus(i_itemId, i_status) return boolean end

-- Unrecognized status - return false

--***************************************************************************
--*
--* Unit Utility Functions
--*
--***************************************************************************

--===========================================================================
function UnitId2OrderIdBJ(i_unitId) return integer end

--===========================================================================
function String2UnitIdBJ(s_unitIdString) return integer end

--===========================================================================
function UnitId2StringBJ(i_unitId) return string end

-- The unitId was not recognized - return an empty string.

--===========================================================================
function String2OrderIdBJ(s_orderIdString) return integer end

-- Check to see if it's a generic order.

-- Check to see if it's a (train) unit order.

-- Unrecognized - return 0

--===========================================================================
function OrderId2StringBJ(i_orderId) return string end

-- Check to see if it's a generic order.

-- Check to see if it's a (train) unit order.

-- Unrecognized - return an empty string.

--===========================================================================
function GetIssuedOrderIdBJ() return integer end

--===========================================================================
function GetKillingUnitBJ() return unit end

--===========================================================================
function CreateUnitAtLocSaveLast(player_id, i_unitid, location_loc, r_face) return unit end

--===========================================================================
function GetLastCreatedUnit() return unit end

--===========================================================================
function CreateNUnitsAtLoc(i_count, i_unitId, player_whichPlayer, location_loc, r_face) return group end

--===========================================================================
function CreateNUnitsAtLocFacingLocBJ(i_count, i_unitId, player_whichPlayer, location_loc, location_lookAt) return group end

--===========================================================================
function GetLastCreatedGroupEnum() end

--===========================================================================
function GetLastCreatedGroup() return group end

--===========================================================================
function CreateCorpseLocBJ(i_unitid, player_whichPlayer, location_loc) return unit end

--===========================================================================
function UnitSuspendDecayBJ(b_suspend, unit_whichUnit) end

--===========================================================================
function DelayedSuspendDecayStopAnimEnum() end

--===========================================================================
function DelayedSuspendDecayBoneEnum() end

--===========================================================================
-- Game code explicitly sets the animation back to "decay bone" after the
-- initial corpse fades away, so we reset it now. It's best not to show
-- off corpses thus created until after this grace period has passed.
--
function DelayedSuspendDecayFleshEnum() end

--===========================================================================
-- Waits a short period of time to ensure that the corpse is decaying, and
-- then suspend the animation and corpse decay.
--
function DelayedSuspendDecay() end

-- Switch the global unit groups over to local variables and recreate
-- the global versions, so that this function can handle overlapping
-- calls.

--===========================================================================
function DelayedSuspendDecayCreate() end

--===========================================================================
function CreatePermanentCorpseLocBJ(i_style, i_unitid, player_whichPlayer, location_loc, r_facing) return unit end

-- Unknown decay style - treat as skeletal.

--===========================================================================
function GetUnitStateSwap(unitstate_whichState, unit_whichUnit) return real end

--===========================================================================
function GetUnitStatePercent(unit_whichUnit, unitstate_whichState, unitstate_whichMaxState) return real end

-- Return 0 for null units.

--===========================================================================
function GetUnitLifePercent(unit_whichUnit) return real end

--===========================================================================
function GetUnitManaPercent(unit_whichUnit) return real end

--===========================================================================
function SelectUnitSingle(unit_whichUnit) end

--===========================================================================
function SelectGroupBJEnum() end

--===========================================================================
function SelectGroupBJ(group_g) end

--===========================================================================
function SelectUnitAdd(unit_whichUnit) end

--===========================================================================
function SelectUnitRemove(unit_whichUnit) end

--===========================================================================
function ClearSelectionForPlayer(player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SelectUnitForPlayerSingle(unit_whichUnit, player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SelectGroupForPlayerBJ(group_g, player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SelectUnitAddForPlayer(unit_whichUnit, player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SelectUnitRemoveForPlayer(unit_whichUnit, player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetUnitLifeBJ(unit_whichUnit, r_newValue) end

--===========================================================================
function SetUnitManaBJ(unit_whichUnit, r_newValue) end

--===========================================================================
function SetUnitLifePercentBJ(unit_whichUnit, r_percent) end

--===========================================================================
function SetUnitManaPercentBJ(unit_whichUnit, r_percent) end

--===========================================================================
function IsUnitDeadBJ(unit_whichUnit) return boolean end

--===========================================================================
function IsUnitAliveBJ(unit_whichUnit) return boolean end

--===========================================================================
function IsUnitGroupDeadBJEnum() end

--===========================================================================
-- Returns true if every unit of the group is dead.
--
function IsUnitGroupDeadBJ(group_g) return boolean end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.

-- If the user wants the group destroyed, do so now.

--===========================================================================
function IsUnitGroupEmptyBJEnum() end

--===========================================================================
-- Returns true if the group contains no units.
--
function IsUnitGroupEmptyBJ(group_g) return boolean end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.

-- If the user wants the group destroyed, do so now.

--===========================================================================
function IsUnitGroupInRectBJEnum() end

--===========================================================================
-- Returns true if every unit of the group is within the given rect.
--
function IsUnitGroupInRectBJ(group_g, rect_r) return boolean end

--===========================================================================
function IsUnitHiddenBJ(unit_whichUnit) return boolean end

--===========================================================================
function ShowUnitHide(unit_whichUnit) end

--===========================================================================
function ShowUnitShow(unit_whichUnit) end
-- Prevent dead heroes from being unhidden.

--===========================================================================
function IssueHauntOrderAtLocBJFilter() return boolean end

--===========================================================================
function IssueHauntOrderAtLocBJ(unit_whichPeon, location_loc) return boolean end

-- Search for a gold mine within a 1-cell radius of the specified location.

-- If no mine was found, abort the request.

-- Issue the Haunt Gold Mine order.

--===========================================================================
function IssueBuildOrderByIdLocBJ(unit_whichPeon, i_unitId, location_loc) return boolean end

--===========================================================================
function IssueTrainOrderByIdBJ(unit_whichUnit, i_unitId) return boolean end

--===========================================================================
function GroupTrainOrderByIdBJ(group_g, i_unitId) return boolean end

--===========================================================================
function IssueUpgradeOrderByIdBJ(unit_whichUnit, i_techId) return boolean end

--===========================================================================
function GetAttackedUnitBJ() return unit end

--===========================================================================
function SetUnitFlyHeightBJ(unit_whichUnit, r_newHeight, r_rate) end

--===========================================================================
function SetUnitTurnSpeedBJ(unit_whichUnit, r_turnSpeed) end

--===========================================================================
function SetUnitPropWindowBJ(unit_whichUnit, r_propWindow) end

--===========================================================================
function GetUnitPropWindowBJ(unit_whichUnit) return real end

--===========================================================================
function GetUnitDefaultPropWindowBJ(unit_whichUnit) return real end

--===========================================================================
function SetUnitBlendTimeBJ(unit_whichUnit, r_blendTime) end

--===========================================================================
function SetUnitAcquireRangeBJ(unit_whichUnit, r_acquireRange) end

--===========================================================================
function UnitSetCanSleepBJ(unit_whichUnit, b_canSleep) end

--===========================================================================
function UnitCanSleepBJ(unit_whichUnit) return boolean end

--===========================================================================
function UnitWakeUpBJ(unit_whichUnit) end

--===========================================================================
function UnitIsSleepingBJ(unit_whichUnit) return boolean end

--===========================================================================
function WakePlayerUnitsEnum() end

--===========================================================================
function WakePlayerUnits(player_whichPlayer) end

--===========================================================================
function EnableCreepSleepBJ(b_enable) end

-- If we're disabling, attempt to wake any already-sleeping creeps.

--===========================================================================
function UnitGenerateAlarms(unit_whichUnit, b_generate) return boolean end

--===========================================================================
function DoesUnitGenerateAlarms(unit_whichUnit) return boolean end

--===========================================================================
function PauseAllUnitsBJEnum() end

--===========================================================================
-- Pause all units
function PauseAllUnitsBJ(b_pause) end

-- If this is a computer slot, pause/resume the AI.

-- Enumerate and unpause every unit owned by the player.

--===========================================================================
function PauseUnitBJ(b_pause, unit_whichUnit) end

--===========================================================================
function IsUnitPausedBJ(unit_whichUnit) return boolean end

--===========================================================================
function UnitPauseTimedLifeBJ(b_flag, unit_whichUnit) end

--===========================================================================
function UnitApplyTimedLifeBJ(r_duration, i_buffId, unit_whichUnit) end

--===========================================================================
function UnitShareVisionBJ(b_share, unit_whichUnit, player_whichPlayer) end

--===========================================================================
function UnitRemoveBuffsBJ(i_buffType, unit_whichUnit) end

-- Unrecognized dispel type - ignore the request.

--===========================================================================
function UnitRemoveBuffsExBJ(i_polarity, i_resist, unit_whichUnit, b_bTLife, b_bAura) end

--===========================================================================
function UnitCountBuffsExBJ(i_polarity, i_resist, unit_whichUnit, b_bTLife, b_bAura) return integer end

--===========================================================================
function UnitRemoveAbilityBJ(i_abilityId, unit_whichUnit) return boolean end

--===========================================================================
function UnitAddAbilityBJ(i_abilityId, unit_whichUnit) return boolean end

--===========================================================================
function UnitRemoveTypeBJ(unittype_whichType, unit_whichUnit) return boolean end

--===========================================================================
function UnitAddTypeBJ(unittype_whichType, unit_whichUnit) return boolean end

--===========================================================================
function UnitMakeAbilityPermanentBJ(b_permanent, i_abilityId, unit_whichUnit) return boolean end

--===========================================================================
function SetUnitExplodedBJ(unit_whichUnit, b_exploded) end

--===========================================================================
function ExplodeUnitBJ(unit_whichUnit) end

--===========================================================================
function GetTransportUnitBJ() return unit end

--===========================================================================
function GetLoadedUnitBJ() return unit end

--===========================================================================
function IsUnitInTransportBJ(unit_whichUnit, unit_whichTransport) return boolean end

--===========================================================================
function IsUnitLoadedBJ(unit_whichUnit) return boolean end

--===========================================================================
function IsUnitIllusionBJ(unit_whichUnit) return boolean end

--===========================================================================
-- This attempts to replace a unit with a new unit type by creating a new
-- unit of the desired type using the old unit's location, facing, etc.
--
function ReplaceUnitBJ(unit_whichUnit, i_newUnitId, i_unitStateMethod) return unit end

-- If we have bogus data, don't attempt the replace.

-- Hide the original unit.

-- Create the replacement unit.

-- Set the unit's life and mana according to the requested method.

-- Set the replacement's current/max life ratio to that of the old unit.
-- If both units have mana, do the same for mana.

-- Set the replacement's current life to that of the old unit.
-- If the new unit has mana, do the same for mana.

-- The newly created unit should already have default life and mana.

-- Use max life and mana.

-- Unrecognized unit state method - ignore the request.

-- Mirror properties of the old unit onto the new unit.
--call PauseUnit(newUnit, IsUnitPaused(oldUnit))

-- If both the old and new units are heroes, handle their hero info.

-- Remove or kill the original unit. It is sometimes unsafe to remove
-- hidden units, so kill the original unit if it was previously hidden.

--===========================================================================
function GetLastReplacedUnitBJ() return unit end

--===========================================================================
function SetUnitPositionLocFacingBJ(unit_whichUnit, location_loc, r_facing) end

--===========================================================================
function SetUnitPositionLocFacingLocBJ(unit_whichUnit, location_loc, location_lookAt) end

--===========================================================================
function AddItemToStockBJ(i_itemId, unit_whichUnit, i_currentStock, i_stockMax) end

--===========================================================================
function AddUnitToStockBJ(i_unitId, unit_whichUnit, i_currentStock, i_stockMax) end

--===========================================================================
function RemoveItemFromStockBJ(i_itemId, unit_whichUnit) end

--===========================================================================
function RemoveUnitFromStockBJ(i_unitId, unit_whichUnit) end

--===========================================================================
function SetUnitUseFoodBJ(b_enable, unit_whichUnit) end

--===========================================================================
function UnitDamagePointLoc(unit_whichUnit, r_delay, r_radius, location_loc, r_amount, attacktype_whichAttack, damagetype_whichDamage) return boolean end

--===========================================================================
function UnitDamageTargetBJ(unit_whichUnit, unit_target, r_amount, attacktype_whichAttack, damagetype_whichDamage) return boolean end

--***************************************************************************
--*
--* Destructable Utility Functions
--*
--***************************************************************************

--===========================================================================
function CreateDestructableLoc(i_objectid, location_loc, r_facing, r_scale, i_variation) return destructable end

--===========================================================================
function CreateDeadDestructableLocBJ(i_objectid, location_loc, r_facing, r_scale, i_variation) return destructable end

--===========================================================================
function GetLastCreatedDestructable() return destructable end

--===========================================================================
function ShowDestructableBJ(b_flag, destructable_d) end

--===========================================================================
function SetDestructableInvulnerableBJ(destructable_d, b_flag) end

--===========================================================================
function IsDestructableInvulnerableBJ(destructable_d) return boolean end

--===========================================================================
function GetDestructableLoc(destructable_whichDestructable) return location end

--===========================================================================
function EnumDestructablesInRectAll(rect_r, c_actionFunc) end

--===========================================================================
function EnumDestructablesInCircleBJFilter() return boolean end

--===========================================================================
function IsDestructableDeadBJ(destructable_d) return boolean end

--===========================================================================
function IsDestructableAliveBJ(destructable_d) return boolean end

--===========================================================================
-- See GroupPickRandomUnitEnum for the details of this algorithm.
--
function RandomDestructableInRectBJEnum() end

--===========================================================================
-- Picks a random destructable from within a rect, matching a condition
--
function RandomDestructableInRectBJ(rect_r, boolexpr_filter) return destructable end

--===========================================================================
-- Picks a random destructable from within a rect
--
function RandomDestructableInRectSimpleBJ(rect_r) return destructable end

--===========================================================================
-- Enumerates within a rect, with a filter to narrow the enumeration down
-- objects within a circular area.
--
function EnumDestructablesInCircleBJ(r_radius, location_loc, c_actionFunc) end

--===========================================================================
function SetDestructableLifePercentBJ(destructable_d, r_percent) end

--===========================================================================
function SetDestructableMaxLifeBJ(destructable_d, r_max) end

--===========================================================================
function ModifyGateBJ(i_gateOperation, destructable_d) end

-- Unrecognized gate state - ignore the request.

--===========================================================================
-- Determine the elevator's height from its occlusion height.
--
function GetElevatorHeight(destructable_d) return integer end

--===========================================================================
-- To properly animate an elevator, we must know not only what height we
-- want to change to, but also what height we are currently at. This code
-- determines the elevator's current height from its occlusion height.
-- Arbitrarily changing an elevator's occlusion height is thus inadvisable.
--
function ChangeElevatorHeight(destructable_d, i_newHeight) end

-- Cap the new height within the supported range.

-- Find out what height the elevator is already at.

-- Set the elevator's occlusion height.

-- Unrecognized old height - snap to new height.

-- Unrecognized old height - snap to new height.

-- Unrecognized old height - snap to new height.

-- Unrecognized new height - ignore the request.

--===========================================================================
-- Grab the unit and throw his own coords in his face, forcing him to push
-- and shove until he finds a spot where noone will bother him.
--
function NudgeUnitsInRectEnum() end

--===========================================================================
function NudgeItemsInRectEnum() end

--===========================================================================
-- Nudge the items and units within a given rect ever so gently, so as to
-- encourage them to find locations where they can peacefully coexist with
-- pathing restrictions and live happy, fruitful lives.
--
function NudgeObjectsInRect(rect_nudgeArea) end

--===========================================================================
function NearbyElevatorExistsEnum() end

--===========================================================================
function NearbyElevatorExists(r_x, r_y) return boolean end

-- If another elevator is overlapping this one, ignore the wall.

--===========================================================================
function FindElevatorWallBlockerEnum() end

--===========================================================================
-- This toggles pathing on or off for one wall of an elevator by killing
-- or reviving a pathing blocker at the appropriate location (and creating
-- the pathing blocker in the first place, if it does not yet exist).
--
function ChangeElevatorWallBlocker(r_x, r_y, r_facing, b_open) end

-- Search for the pathing blocker within the general area.

-- Ensure that the blocker exists.

-- If a different destructible exists in the blocker's spot, ignore
-- the request. (Two destructibles cannot occupy the same location
-- on the map, so we cannot create an elevator blocker here.)

-- Ensure that the blocker is dead.

-- Ensure that the blocker is alive.

-- Nudge any objects standing in the blocker's way.

-- Unrecognized blocker angle - don't nudge anything.

--===========================================================================
function ChangeElevatorWalls(b_open, i_walls, destructable_d) end

--***************************************************************************
--*
--* Neutral Building Utility Functions
--*
--***************************************************************************

--===========================================================================
function WaygateActivateBJ(b_activate, unit_waygate) end

--===========================================================================
function WaygateIsActiveBJ(unit_waygate) return boolean end

--===========================================================================
function WaygateSetDestinationLocBJ(unit_waygate, location_loc) end

--===========================================================================
function WaygateGetDestinationLocBJ(unit_waygate) return location end

--===========================================================================
function UnitSetUsesAltIconBJ(b_flag, unit_whichUnit) end

--***************************************************************************
--*
--* UI Utility Functions
--*
--***************************************************************************

--===========================================================================
function ForceUIKeyBJ(player_whichPlayer, s_key) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function ForceUICancelBJ(player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--***************************************************************************
--*
--* Group and Force Utility Functions
--*
--***************************************************************************

--===========================================================================
function ForGroupBJ(group_whichGroup, c_callback) end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.

-- If the user wants the group destroyed, do so now.

--===========================================================================
function GroupAddUnitSimple(unit_whichUnit, group_whichGroup) end

--===========================================================================
function GroupRemoveUnitSimple(unit_whichUnit, group_whichGroup) end

--===========================================================================
function GroupAddGroupEnum() end

--===========================================================================
function GroupAddGroup(group_sourceGroup, group_destGroup) end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.

-- If the user wants the group destroyed, do so now.

--===========================================================================
function GroupRemoveGroupEnum() end

--===========================================================================
function GroupRemoveGroup(group_sourceGroup, group_destGroup) end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.

-- If the user wants the group destroyed, do so now.

--===========================================================================
function ForceAddPlayerSimple(player_whichPlayer, force_whichForce) end

--===========================================================================
function ForceRemovePlayerSimple(player_whichPlayer, force_whichForce) end

--===========================================================================
-- Consider each unit, one at a time, keeping a "current pick". Once all units
-- are considered, this "current pick" will be the resulting random unit.
--
-- The chance of picking a given unit over the "current pick" is 1/N, where N is
-- the number of units considered thusfar (including the current consideration).
--
function GroupPickRandomUnitEnum() end

--===========================================================================
-- Picks a random unit from a group.
--
function GroupPickRandomUnit(group_whichGroup) return unit end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.

-- If the user wants the group destroyed, do so now.

--===========================================================================
-- See GroupPickRandomUnitEnum for the details of this algorithm.
--
function ForcePickRandomPlayerEnum() end

--===========================================================================
-- Picks a random player from a force.
--
function ForcePickRandomPlayer(force_whichForce) return player end

--===========================================================================
function EnumUnitsSelected(player_whichPlayer, boolexpr_enumFilter, c_enumAction) end

--===========================================================================
function GetUnitsInRectMatching(rect_r, boolexpr_filter) return group end

--===========================================================================
function GetUnitsInRectAll(rect_r) return group end

--===========================================================================
function GetUnitsInRectOfPlayerFilter() return boolean end

--===========================================================================
function GetUnitsInRectOfPlayer(rect_r, player_whichPlayer) return group end

--===========================================================================
function GetUnitsInRangeOfLocMatching(r_radius, location_whichLocation, boolexpr_filter) return group end

--===========================================================================
function GetUnitsInRangeOfLocAll(r_radius, location_whichLocation) return group end

--===========================================================================
function GetUnitsOfTypeIdAllFilter() return boolean end

--===========================================================================
function GetUnitsOfTypeIdAll(i_unitid) return group end

--===========================================================================
function GetUnitsOfPlayerMatching(player_whichPlayer, boolexpr_filter) return group end

--===========================================================================
function GetUnitsOfPlayerAll(player_whichPlayer) return group end

--===========================================================================
function GetUnitsOfPlayerAndTypeIdFilter() return boolean end

--===========================================================================
function GetUnitsOfPlayerAndTypeId(player_whichPlayer, i_unitid) return group end

--===========================================================================
function GetUnitsSelectedAll(player_whichPlayer) return group end

--===========================================================================
function GetForceOfPlayer(player_whichPlayer) return force end

--===========================================================================
function GetPlayersAll() return force end

--===========================================================================
function GetPlayersByMapControl(mapcontrol_whichControl) return force end

--===========================================================================
function GetPlayersAllies(player_whichPlayer) return force end

--===========================================================================
function GetPlayersEnemies(player_whichPlayer) return force end

--===========================================================================
function GetPlayersMatching(boolexpr_filter) return force end

--===========================================================================
function CountUnitsInGroupEnum() end

--===========================================================================
function CountUnitsInGroup(group_g) return integer end
-- If the user wants the group destroyed, remember that fact and clear
-- the flag, in case it is used again in the callback.

-- If the user wants the group destroyed, do so now.

--===========================================================================
function CountPlayersInForceEnum() end

--===========================================================================
function CountPlayersInForceBJ(force_f) return integer end

--===========================================================================
function GetRandomSubGroupEnum() end

-- We either need every remaining unit, or the unit passed its chance check.

--===========================================================================
function GetRandomSubGroup(i_count, group_sourceGroup) return group end

--===========================================================================
function LivingPlayerUnitsOfTypeIdFilter() return boolean end

--===========================================================================
function CountLivingPlayerUnitsOfTypeId(i_unitId, player_whichPlayer) return integer end

--***************************************************************************
--*
--* Animation Utility Functions
--*
--***************************************************************************

--===========================================================================
function ResetUnitAnimation(unit_whichUnit) end

--===========================================================================
function SetUnitTimeScalePercent(unit_whichUnit, r_percentScale) end

--===========================================================================
function SetUnitScalePercent(unit_whichUnit, r_percentScaleX, r_percentScaleY, r_percentScaleZ) end

--===========================================================================
-- This version differs from the common.j interface in that the alpha value
-- is reversed so as to be displayed as transparency, and all four parameters
-- are treated as percentages rather than bytes.
--
function SetUnitVertexColorBJ(unit_whichUnit, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function UnitAddIndicatorBJ(unit_whichUnit, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function DestructableAddIndicatorBJ(destructable_whichDestructable, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function ItemAddIndicatorBJ(item_whichItem, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
-- Sets a unit's facing to point directly at a location.
--
function SetUnitFacingToFaceLocTimed(unit_whichUnit, location_target, r_duration) end

--===========================================================================
-- Sets a unit's facing to point directly at another unit.
--
function SetUnitFacingToFaceUnitTimed(unit_whichUnit, unit_target, r_duration) end

--===========================================================================
function QueueUnitAnimationBJ(unit_whichUnit, s_whichAnimation) end

--===========================================================================
function SetDestructableAnimationBJ(destructable_d, s_whichAnimation) end

--===========================================================================
function QueueDestructableAnimationBJ(destructable_d, s_whichAnimation) end

--===========================================================================
function SetDestAnimationSpeedPercent(destructable_d, r_percentScale) end

--***************************************************************************
--*
--* Dialog Utility Functions
--*
--***************************************************************************

--===========================================================================
function DialogDisplayBJ(b_flag, dialog_whichDialog, player_whichPlayer) end

--===========================================================================
function DialogSetMessageBJ(dialog_whichDialog, s_message) end

--===========================================================================
function DialogAddButtonBJ(dialog_whichDialog, s_buttonText) return button end

--===========================================================================
function DialogAddButtonWithHotkeyBJ(dialog_whichDialog, s_buttonText, i_hotkey) return button end

--===========================================================================
function DialogClearBJ(dialog_whichDialog) end

--===========================================================================
function GetLastCreatedButtonBJ() return button end

--===========================================================================
function GetClickedButtonBJ() return button end

--===========================================================================
function GetClickedDialogBJ() return dialog end

--***************************************************************************
--*
--* Alliance Utility Functions
--*
--***************************************************************************

--===========================================================================
function SetPlayerAllianceBJ(player_sourcePlayer, alliancetype_whichAllianceSetting, b_value, player_otherPlayer) end
-- Prevent players from attempting to ally with themselves.

--===========================================================================
-- Set all flags used by the in-game "Ally" checkbox.
--
function SetPlayerAllianceStateAllyBJ(player_sourcePlayer, player_otherPlayer, b_flag) end

--===========================================================================
-- Set all flags used by the in-game "Shared Vision" checkbox.
--
function SetPlayerAllianceStateVisionBJ(player_sourcePlayer, player_otherPlayer, b_flag) end

--===========================================================================
-- Set all flags used by the in-game "Shared Units" checkbox.
--
function SetPlayerAllianceStateControlBJ(player_sourcePlayer, player_otherPlayer, b_flag) end

--===========================================================================
-- Set all flags used by the in-game "Shared Units" checkbox with the Full
-- Shared Unit Control feature enabled.
--
function SetPlayerAllianceStateFullControlBJ(player_sourcePlayer, player_otherPlayer, b_flag) end

--===========================================================================
function SetPlayerAllianceStateBJ(player_sourcePlayer, player_otherPlayer, i_allianceState) end
-- Prevent players from attempting to ally with themselves.

-- Unrecognized alliance state - ignore the request.

--===========================================================================
-- Set the alliance states for an entire force towards another force.
--
function SetForceAllianceStateBJ(force_sourceForce, force_targetForce, i_allianceState) end

--===========================================================================
-- Test to see if two players are co-allied (allied with each other).
--
function PlayersAreCoAllied(player_playerA, player_playerB) return boolean end
-- Players are considered to be allied with themselves.

-- Co-allies are both allied with each other.

--===========================================================================
-- Force (whichPlayer) AI player to share vision and advanced unit control
-- with all AI players of its allies.
--
function ShareEverythingWithTeamAI(player_whichPlayer) end

--===========================================================================
-- Force (whichPlayer) to share vision and advanced unit control with all of his/her allies.
--
function ShareEverythingWithTeam(player_whichPlayer) end

--===========================================================================
-- Creates a 'Neutral Victim' player slot. This slot is passive towards all
-- other players, but all other players are aggressive towards him/her.
--
function ConfigureNeutralVictim() end

-- Neutral Victim and Neutral Aggressive should not fight each other.

-- Neutral Victim does not give bounties.

--===========================================================================
function MakeUnitsPassiveForPlayerEnum() end

--===========================================================================
-- Change ownership for every unit of (whichPlayer)'s team to neutral passive.
--
function MakeUnitsPassiveForPlayer(player_whichPlayer) end

--===========================================================================
-- Change ownership for every unit of (whichPlayer)'s team to neutral passive.
--
function MakeUnitsPassiveForTeam(player_whichPlayer) end

--===========================================================================
-- Determine whether or not victory/defeat is disabled via cheat codes.
--
function AllowVictoryDefeat(playergameresult_gameResult) return boolean end

--===========================================================================
function EndGameBJ() end

--===========================================================================
function MeleeVictoryDialogBJ(player_whichPlayer, b_leftGame) end

-- Display "player was victorious" or "player has left the game" message

--===========================================================================
function MeleeDefeatDialogBJ(player_whichPlayer, b_leftGame) end

-- Display "player was defeated" or "player has left the game" message

-- Only show the continue button if the game is not over and observers on death are allowed

--===========================================================================
function GameOverDialogBJ(player_whichPlayer, b_leftGame) end

-- Display "player left the game" message

--===========================================================================
function RemovePlayerPreserveUnitsBJ(player_whichPlayer, playergameresult_gameResult, b_leftGame) end

--===========================================================================
function CustomVictoryOkBJ() end

-- Bump the difficulty back up to the default.

--===========================================================================
function CustomVictoryQuitBJ() end

-- Bump the difficulty back up to the default.

--===========================================================================
function CustomVictoryDialogBJ(player_whichPlayer) end

--===========================================================================
function CustomVictorySkipBJ(player_whichPlayer) end

-- Bump the difficulty back up to the default.

--===========================================================================
function CustomVictoryBJ(player_whichPlayer, b_showDialog, b_showScores) end

-- UI only needs to be displayed to users.

--===========================================================================
function CustomDefeatRestartBJ() end

--===========================================================================
function CustomDefeatReduceDifficultyBJ() end

-- Knock the difficulty down, if possible.

-- Sorry, but it doesn't get any easier than this.

-- Unrecognized difficulty

--===========================================================================
function CustomDefeatLoadBJ() end

--===========================================================================
function CustomDefeatQuitBJ() end

-- Bump the difficulty back up to the default.

--===========================================================================
function CustomDefeatDialogBJ(player_whichPlayer, s_message) end

--===========================================================================
function CustomDefeatBJ(player_whichPlayer, s_message) end

-- UI only needs to be displayed to users.

--===========================================================================
function SetNextLevelBJ(s_nextLevel) end

--===========================================================================
function SetPlayerOnScoreScreenBJ(b_flag, player_whichPlayer) end

--***************************************************************************
--*
--* Quest Utility Functions
--*
--***************************************************************************

--===========================================================================
function CreateQuestBJ(i_questType, s_title, s_description, s_iconPath) return quest end

--===========================================================================
function DestroyQuestBJ(quest_whichQuest) end

--===========================================================================
function QuestSetEnabledBJ(b_enabled, quest_whichQuest) end

--===========================================================================
function QuestSetTitleBJ(quest_whichQuest, s_title) end

--===========================================================================
function QuestSetDescriptionBJ(quest_whichQuest, s_description) end

--===========================================================================
function QuestSetCompletedBJ(quest_whichQuest, b_completed) end

--===========================================================================
function QuestSetFailedBJ(quest_whichQuest, b_failed) end

--===========================================================================
function QuestSetDiscoveredBJ(quest_whichQuest, b_discovered) end

--===========================================================================
function GetLastCreatedQuestBJ() return quest end

--===========================================================================
function CreateQuestItemBJ(quest_whichQuest, s_description) return questitem end

--===========================================================================
function QuestItemSetDescriptionBJ(questitem_whichQuestItem, s_description) end

--===========================================================================
function QuestItemSetCompletedBJ(questitem_whichQuestItem, b_completed) end

--===========================================================================
function GetLastCreatedQuestItemBJ() return questitem end

--===========================================================================
function CreateDefeatConditionBJ(s_description) return defeatcondition end

--===========================================================================
function DestroyDefeatConditionBJ(defeatcondition_whichCondition) end

--===========================================================================
function DefeatConditionSetDescriptionBJ(defeatcondition_whichCondition, s_description) end

--===========================================================================
function GetLastCreatedDefeatConditionBJ() return defeatcondition end

--===========================================================================
function FlashQuestDialogButtonBJ() end

--===========================================================================
function QuestMessageBJ(force_f, i_messageType, s_message) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- Unrecognized message type - ignore the request.

--***************************************************************************
--*
--* Timer Utility Functions
--*
--***************************************************************************

--===========================================================================
function StartTimerBJ(timer_t, b_periodic, r_timeout) return timer end

--===========================================================================
function CreateTimerBJ(b_periodic, r_timeout) return timer end

--===========================================================================
function DestroyTimerBJ(timer_whichTimer) end

--===========================================================================
function PauseTimerBJ(b_pause, timer_whichTimer) end

--===========================================================================
function GetLastCreatedTimerBJ() return timer end

--===========================================================================
function CreateTimerDialogBJ(timer_t, s_title) return timerdialog end

--===========================================================================
function DestroyTimerDialogBJ(timerdialog_td) end

--===========================================================================
function TimerDialogSetTitleBJ(timerdialog_td, s_title) end

--===========================================================================
function TimerDialogSetTitleColorBJ(timerdialog_td, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function TimerDialogSetTimeColorBJ(timerdialog_td, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function TimerDialogSetSpeedBJ(timerdialog_td, r_speedMultFactor) end

--===========================================================================
function TimerDialogDisplayForPlayerBJ(b_show, timerdialog_td, player_whichPlayer) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function TimerDialogDisplayBJ(b_show, timerdialog_td) end

--===========================================================================
function GetLastCreatedTimerDialogBJ() return timerdialog end

--***************************************************************************
--*
--* Leaderboard Utility Functions
--*
--***************************************************************************

--===========================================================================
function LeaderboardResizeBJ(leaderboard_lb) end

--===========================================================================
function LeaderboardSetPlayerItemValueBJ(player_whichPlayer, leaderboard_lb, i_val) end

--===========================================================================
function LeaderboardSetPlayerItemLabelBJ(player_whichPlayer, leaderboard_lb, s_val) end

--===========================================================================
function LeaderboardSetPlayerItemStyleBJ(player_whichPlayer, leaderboard_lb, b_showLabel, b_showValue, b_showIcon) end

--===========================================================================
function LeaderboardSetPlayerItemLabelColorBJ(player_whichPlayer, leaderboard_lb, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function LeaderboardSetPlayerItemValueColorBJ(player_whichPlayer, leaderboard_lb, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function LeaderboardSetLabelColorBJ(leaderboard_lb, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function LeaderboardSetValueColorBJ(leaderboard_lb, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function LeaderboardSetLabelBJ(leaderboard_lb, s_label) end

--===========================================================================
function LeaderboardSetStyleBJ(leaderboard_lb, b_showLabel, b_showNames, b_showValues, b_showIcons) end

--===========================================================================
function LeaderboardGetItemCountBJ(leaderboard_lb) return integer end

--===========================================================================
function LeaderboardHasPlayerItemBJ(leaderboard_lb, player_whichPlayer) return boolean end

--===========================================================================
function ForceSetLeaderboardBJ(leaderboard_lb, force_toForce) end

--===========================================================================
function CreateLeaderboardBJ(force_toForce, s_label) return leaderboard end

--===========================================================================
function DestroyLeaderboardBJ(leaderboard_lb) end

--===========================================================================
function LeaderboardDisplayBJ(b_show, leaderboard_lb) end

--===========================================================================
function LeaderboardAddItemBJ(player_whichPlayer, leaderboard_lb, s_label, i_value) end

--call LeaderboardSetSizeByItemCount(lb, LeaderboardGetItemCount(lb))

--===========================================================================
function LeaderboardRemovePlayerItemBJ(player_whichPlayer, leaderboard_lb) end

--===========================================================================
function LeaderboardSortItemsBJ(leaderboard_lb, i_sortType, b_ascending) end

-- Unrecognized sort type - ignore the request.

--===========================================================================
function LeaderboardSortItemsByPlayerBJ(leaderboard_lb, b_ascending) end

--===========================================================================
function LeaderboardSortItemsByLabelBJ(leaderboard_lb, b_ascending) end

--===========================================================================
function LeaderboardGetPlayerIndexBJ(player_whichPlayer, leaderboard_lb) return integer end

--===========================================================================
-- Returns the player who is occupying a specified position in a leaderboard.
-- The position parameter is expected in the range of 1..16.
--
function LeaderboardGetIndexedPlayerBJ(i_position, leaderboard_lb) return player end

--===========================================================================
function PlayerGetLeaderboardBJ(player_whichPlayer) return leaderboard end

--===========================================================================
function GetLastCreatedLeaderboard() return leaderboard end

--***************************************************************************
--*
--* Multiboard Utility Functions
--*
--***************************************************************************

--===========================================================================
function CreateMultiboardBJ(i_cols, i_rows, s_title) return multiboard end

--===========================================================================
function DestroyMultiboardBJ(multiboard_mb) end

--===========================================================================
function GetLastCreatedMultiboard() return multiboard end

--===========================================================================
function MultiboardDisplayBJ(b_show, multiboard_mb) end

--===========================================================================
function MultiboardMinimizeBJ(b_minimize, multiboard_mb) end

--===========================================================================
function MultiboardSetTitleTextColorBJ(multiboard_mb, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function MultiboardAllowDisplayBJ(b_flag) end

--===========================================================================
function MultiboardSetItemStyleBJ(multiboard_mb, i_col, i_row, b_showValue, b_showIcon) end

-- Loop over rows, using 1-based index

-- Apply setting to the requested row, or all rows (if row is 0)

-- Loop over columns, using 1-based index

-- Apply setting to the requested column, or all columns (if col is 0)

--===========================================================================
function MultiboardSetItemValueBJ(multiboard_mb, i_col, i_row, s_val) end

-- Loop over rows, using 1-based index

-- Apply setting to the requested row, or all rows (if row is 0)

-- Loop over columns, using 1-based index

-- Apply setting to the requested column, or all columns (if col is 0)

--===========================================================================
function MultiboardSetItemColorBJ(multiboard_mb, i_col, i_row, r_red, r_green, r_blue, r_transparency) end

-- Loop over rows, using 1-based index

-- Apply setting to the requested row, or all rows (if row is 0)

-- Loop over columns, using 1-based index

-- Apply setting to the requested column, or all columns (if col is 0)

--===========================================================================
function MultiboardSetItemWidthBJ(multiboard_mb, i_col, i_row, r_width) end

-- Loop over rows, using 1-based index

-- Apply setting to the requested row, or all rows (if row is 0)

-- Loop over columns, using 1-based index

-- Apply setting to the requested column, or all columns (if col is 0)

--===========================================================================
function MultiboardSetItemIconBJ(multiboard_mb, i_col, i_row, s_iconFileName) end

-- Loop over rows, using 1-based index

-- Apply setting to the requested row, or all rows (if row is 0)

-- Loop over columns, using 1-based index

-- Apply setting to the requested column, or all columns (if col is 0)

--***************************************************************************
--*
--* Text Tag Utility Functions
--*
--***************************************************************************

--===========================================================================
-- Scale the font size linearly such that size 10 equates to height 0.023.
-- Screen-relative font heights are harder to grasp and than font sizes.
--
function TextTagSize2Height(r_size) return real end

--===========================================================================
-- Scale the speed linearly such that speed 128 equates to 0.071.
-- Screen-relative speeds are hard to grasp.
--
function TextTagSpeed2Velocity(r_speed) return real end

--===========================================================================
function SetTextTagColorBJ(texttag_tt, r_red, r_green, r_blue, r_transparency) end

--===========================================================================
function SetTextTagVelocityBJ(texttag_tt, r_speed, r_angle) end

--===========================================================================
function SetTextTagTextBJ(texttag_tt, s_s, r_size) end

--===========================================================================
function SetTextTagPosBJ(texttag_tt, location_loc, r_zOffset) end

--===========================================================================
function SetTextTagPosUnitBJ(texttag_tt, unit_whichUnit, r_zOffset) end

--===========================================================================
function SetTextTagSuspendedBJ(texttag_tt, b_flag) end

--===========================================================================
function SetTextTagPermanentBJ(texttag_tt, b_flag) end

--===========================================================================
function SetTextTagAgeBJ(texttag_tt, r_age) end

--===========================================================================
function SetTextTagLifespanBJ(texttag_tt, r_lifespan) end

--===========================================================================
function SetTextTagFadepointBJ(texttag_tt, r_fadepoint) end

--===========================================================================
function CreateTextTagLocBJ(s_s, location_loc, r_zOffset, r_size, r_red, r_green, r_blue, r_transparency) return texttag end

--===========================================================================
function CreateTextTagUnitBJ(s_s, unit_whichUnit, r_zOffset, r_size, r_red, r_green, r_blue, r_transparency) return texttag end

--===========================================================================
function DestroyTextTagBJ(texttag_tt) end

--===========================================================================
function ShowTextTagForceBJ(b_show, texttag_tt, force_whichForce) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function GetLastCreatedTextTag() return texttag end

--***************************************************************************
--*
--* Cinematic Utility Functions
--*
--***************************************************************************

--===========================================================================
function PauseGameOn() end

--===========================================================================
function PauseGameOff() end

--===========================================================================
function SetUserControlForceOn(force_whichForce) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function SetUserControlForceOff(force_whichForce) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function ShowInterfaceForceOn(force_whichForce, r_fadeDuration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function ShowInterfaceForceOff(force_whichForce, r_fadeDuration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function PingMinimapForForce(force_whichForce, r_x, r_y, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--call StartSound(bj_pingMinimapSound)

--===========================================================================
function PingMinimapLocForForce(force_whichForce, location_loc, r_duration) end

--===========================================================================
function PingMinimapForPlayer(player_whichPlayer, r_x, r_y, r_duration) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--call StartSound(bj_pingMinimapSound)

--===========================================================================
function PingMinimapLocForPlayer(player_whichPlayer, location_loc, r_duration) end

--===========================================================================
function PingMinimapForForceEx(force_whichForce, r_x, r_y, r_duration, i_style, r_red, r_green, r_blue) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- Prevent 100% red simple and flashy pings, as they become "attack" pings.

-- Unrecognized ping style - ignore the request.

--call StartSound(bj_pingMinimapSound)

--===========================================================================
function PingMinimapLocForForceEx(force_whichForce, location_loc, r_duration, i_style, r_red, r_green, r_blue) end

--===========================================================================
function EnableWorldFogBoundaryBJ(b_enable, force_f) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--===========================================================================
function EnableOcclusionBJ(b_enable, force_f) end

-- Use only local code (no net traffic) within this block to avoid desyncs.

--***************************************************************************
--*
--* Cinematic Transmission Utility Functions
--*
--***************************************************************************

--===========================================================================
-- If cancelled, stop the sound and end the cinematic scene.
--
function CancelCineSceneBJ() end

--===========================================================================
-- Init a trigger to listen for END_CINEMATIC events and respond to them if
-- a cinematic scene is in progress. For performance reasons, this should
-- only be called once a cinematic scene has been started, so that maps
-- lacking such scenes do not bother to register for these events.
--
function TryInitCinematicBehaviorBJ() end

--===========================================================================
function SetCinematicSceneBJ(sound_soundHandle, i_portraitUnitId, playercolor_color, s_speakerTitle, s_text, r_sceneDuration, r_voiceoverDuration) end

--===========================================================================
function GetTransmissionDuration(sound_soundHandle, i_timeType, r_timeVal) return real end

-- Unrecognized timeType - ignore timeVal.

-- Make sure we have a non-negative duration.

--===========================================================================
function WaitTransmissionDuration(sound_soundHandle, i_timeType, r_timeVal) end

-- If we have a static duration wait, just perform the wait.

-- If the sound does not exist, perform a default length wait.

-- If the transmission is cutting off the sound, wait for the sound
-- to be mostly finished.

-- If the transmission is extending beyond the sound's length, wait
-- for it to finish, and then wait the additional time.

-- Unrecognized timeType - ignore.

--===========================================================================
function DoTransmissionBasicsXYBJ(i_unitId, playercolor_color, r_x, r_y, sound_soundHandle, s_unitName, s_message, r_duration) end

--call SetCameraQuickPosition(x, y)

--===========================================================================
-- Display a text message to a Player Group with an accompanying sound,
-- portrait, speech indicator, and all that good stuff.
-- - Query duration of sound
-- - Play sound
-- - Display text message for duration
-- - Display animating portrait for duration
-- - Display a speech indicator for the unit
-- - Ping the minimap
--
function TransmissionFromUnitWithNameBJ(force_toForce, unit_whichUnit, s_unitName, sound_soundHandle, s_message, i_timeType, r_timeVal, b_wait) end

-- Ensure that the time value is non-negative.

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- If the unit reference is invalid, send the transmission from the center of the map with no portrait.

-- call TriggerSleepAction(bj_lastTransmissionDuration)

--===========================================================================
-- This operates like TransmissionFromUnitWithNameBJ, but for a unit type
-- rather than a unit instance. As such, no speech indicator is employed.
--
function TransmissionFromUnitTypeWithNameBJ(force_toForce, player_fromPlayer, i_unitId, s_unitName, location_loc, sound_soundHandle, s_message, i_timeType, r_timeVal, b_wait) end

-- Ensure that the time value is non-negative.

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- call TriggerSleepAction(bj_lastTransmissionDuration)

--===========================================================================
function GetLastTransmissionDurationBJ() return real end

--===========================================================================
function ForceCinematicSubtitlesBJ(b_flag) end

--***************************************************************************
--*
--* Cinematic Mode Utility Functions
--*
--***************************************************************************

--===========================================================================
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

-- Save the UI state so that we can restore it later.

-- Perform local changes

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- Perform global changes

-- Use a fixed random seed, so that cinematics play consistently.

-- Perform local changes

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- Perform global changes

--===========================================================================
function CinematicModeBJ(b_cineMode, force_forForce) end

--***************************************************************************
--*
--* Cinematic Filter Utility Functions
--*
--***************************************************************************

--===========================================================================
function DisplayCineFilterBJ(b_flag) end

--===========================================================================
function CinematicFadeCommonBJ(r_red, r_green, r_blue, r_duration, s_tex, r_startTrans, r_endTrans) end

-- If the fade is instant, use the same starting and ending values,
-- so that we effectively do a set rather than a fade.

--===========================================================================
function FinishCinematicFadeBJ() end

--===========================================================================
function FinishCinematicFadeAfterBJ(r_duration) end
-- Create a timer to end the cinematic fade.

--===========================================================================
function ContinueCinematicFadeBJ() end

--===========================================================================
function ContinueCinematicFadeAfterBJ(r_duration, r_red, r_green, r_blue, r_trans, s_tex) end

-- Create a timer to continue the cinematic fade.

--===========================================================================
function AbortCinematicFadeBJ() end

--===========================================================================
function CinematicFadeBJ(i_fadetype, r_duration, s_tex, r_red, r_green, r_blue, r_trans) end

-- Fade out to the requested color.

-- Fade in from the requested color.

-- Fade out to the requested color, and then fade back in from it.

-- Unrecognized fadetype - ignore the request.

--===========================================================================
function CinematicFilterGenericBJ(r_duration, blendmode_bmode, s_tex, r_red0, r_green0, r_blue0, r_trans0, r_red1, r_green1, r_blue1, r_trans1) end

--***************************************************************************
--*
--* Rescuable Unit Utility Functions
--*
--***************************************************************************

--===========================================================================
-- Rescues a unit for a player. This performs the default rescue behavior,
-- including a rescue sound, flashing selection circle, ownership change,
-- and optionally a unit color change.
--
function RescueUnitBJ(unit_whichUnit, player_rescuer, b_changeColor) end

--===========================================================================
function TriggerActionUnitRescuedBJ() end

--===========================================================================
-- Attempt to init triggers for default rescue behavior. For performance
-- reasons, this should only be attempted if a player is set to Rescuable,
-- or if a specific unit is thus flagged.
--
function TryInitRescuableTriggersBJ() end

--===========================================================================
-- Determines whether or not rescued units automatically change color upon
-- being rescued.
--
function SetRescueUnitColorChangeBJ(b_changeColor) end

--===========================================================================
-- Determines whether or not rescued buildings automatically change color
-- upon being rescued.
--
function SetRescueBuildingColorChangeBJ(b_changeColor) end

--===========================================================================
function MakeUnitRescuableToForceBJEnum() end

--===========================================================================
function MakeUnitRescuableToForceBJ(unit_whichUnit, b_isRescuable, force_whichForce) end
-- Flag the unit as rescuable/unrescuable for the appropriate players.

--===========================================================================
function InitRescuableBehaviorBJ() end

-- If at least one player slot is "Rescuable"-controlled, init the
-- rescue behavior triggers.

--***************************************************************************
--*
--* Research and Upgrade Utility Functions
--*
--***************************************************************************

--===========================================================================
function SetPlayerTechResearchedSwap(i_techid, i_levels, player_whichPlayer) end

--===========================================================================
function SetPlayerTechMaxAllowedSwap(i_techid, i_maximum, player_whichPlayer) end

--===========================================================================
function SetPlayerMaxHeroesAllowed(i_maximum, player_whichPlayer) end

--===========================================================================
function GetPlayerTechCountSimple(i_techid, player_whichPlayer) return integer end

--===========================================================================
function GetPlayerTechMaxAllowedSwap(i_techid, player_whichPlayer) return integer end

--===========================================================================
function SetPlayerAbilityAvailableBJ(b_avail, i_abilid, player_whichPlayer) end

--***************************************************************************
--*
--* Campaign Utility Functions
--*
--***************************************************************************

function SetCampaignMenuRaceBJ(i_campaignNumber) end

-- Unrecognized campaign - ignore the request

--===========================================================================
-- Converts a single campaign mission designation into campaign and mission
-- numbers. The 1000's digit is considered the campaign index, and the 1's
-- digit is considered the mission index within that campaign. This is done
-- so that the trigger for this can use a single drop-down to list all of
-- the campaign missions.
--
function SetMissionAvailableBJ(b_available, i_missionIndex) end

--===========================================================================
function SetCampaignAvailableBJ(b_available, i_campaignNumber) end

--===========================================================================
function SetCinematicAvailableBJ(b_available, i_cinematicIndex) end

-- Unrecognized cinematic - ignore the request.

--===========================================================================
function InitGameCacheBJ(s_campaignFile) return gamecache end

--===========================================================================
function SaveGameCacheBJ(gamecache_cache) return boolean end

--===========================================================================
function GetLastCreatedGameCacheBJ() return gamecache end

--===========================================================================
function InitHashtableBJ() return hashtable end

--===========================================================================
function GetLastCreatedHashtableBJ() return hashtable end

--===========================================================================
function StoreRealBJ(r_value, s_key, s_missionKey, gamecache_cache) end

--===========================================================================
function StoreIntegerBJ(i_value, s_key, s_missionKey, gamecache_cache) end

--===========================================================================
function StoreBooleanBJ(b_value, s_key, s_missionKey, gamecache_cache) end

--===========================================================================
function StoreStringBJ(s_value, s_key, s_missionKey, gamecache_cache) return boolean end

--===========================================================================
function StoreUnitBJ(unit_whichUnit, s_key, s_missionKey, gamecache_cache) return boolean end

--===========================================================================
function SaveRealBJ(r_value, i_key, i_missionKey, hashtable_table) end

--===========================================================================
function SaveIntegerBJ(i_value, i_key, i_missionKey, hashtable_table) end

--===========================================================================
function SaveBooleanBJ(b_value, i_key, i_missionKey, hashtable_table) end

--===========================================================================
function SaveStringBJ(s_value, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SavePlayerHandleBJ(player_whichPlayer, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveWidgetHandleBJ(widget_whichWidget, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveDestructableHandleBJ(destructable_whichDestructable, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveItemHandleBJ(item_whichItem, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveUnitHandleBJ(unit_whichUnit, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveAbilityHandleBJ(ability_whichAbility, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveTimerHandleBJ(timer_whichTimer, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveTriggerHandleBJ(trigger_whichTrigger, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveTriggerConditionHandleBJ(triggercondition_whichTriggercondition, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveTriggerActionHandleBJ(triggeraction_whichTriggeraction, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveTriggerEventHandleBJ(event_whichEvent, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveForceHandleBJ(force_whichForce, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveGroupHandleBJ(group_whichGroup, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveLocationHandleBJ(location_whichLocation, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveRectHandleBJ(rect_whichRect, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveBooleanExprHandleBJ(boolexpr_whichBoolexpr, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveSoundHandleBJ(sound_whichSound, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveEffectHandleBJ(effect_whichEffect, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveUnitPoolHandleBJ(unitpool_whichUnitpool, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveItemPoolHandleBJ(itempool_whichItempool, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveQuestHandleBJ(quest_whichQuest, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveQuestItemHandleBJ(questitem_whichQuestitem, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveDefeatConditionHandleBJ(defeatcondition_whichDefeatcondition, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveTimerDialogHandleBJ(timerdialog_whichTimerdialog, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveLeaderboardHandleBJ(leaderboard_whichLeaderboard, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveMultiboardHandleBJ(multiboard_whichMultiboard, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveMultiboardItemHandleBJ(multiboarditem_whichMultiboarditem, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveTrackableHandleBJ(trackable_whichTrackable, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveDialogHandleBJ(dialog_whichDialog, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveButtonHandleBJ(button_whichButton, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveTextTagHandleBJ(texttag_whichTexttag, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveLightningHandleBJ(lightning_whichLightning, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveImageHandleBJ(image_whichImage, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveUbersplatHandleBJ(ubersplat_whichUbersplat, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveRegionHandleBJ(region_whichRegion, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveFogStateHandleBJ(fogstate_whichFogState, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveFogModifierHandleBJ(fogmodifier_whichFogModifier, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveAgentHandleBJ(agent_whichAgent, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function SaveHashtableHandleBJ(hashtable_whichHashtable, i_key, i_missionKey, hashtable_table) return boolean end

--===========================================================================
function GetStoredRealBJ(s_key, s_missionKey, gamecache_cache) return real end
--call SyncStoredReal(cache, missionKey, key)

--===========================================================================
function GetStoredIntegerBJ(s_key, s_missionKey, gamecache_cache) return integer end
--call SyncStoredInteger(cache, missionKey, key)

--===========================================================================
function GetStoredBooleanBJ(s_key, s_missionKey, gamecache_cache) return boolean end
--call SyncStoredBoolean(cache, missionKey, key)

--===========================================================================
function GetStoredStringBJ(s_key, s_missionKey, gamecache_cache) return string end

--call SyncStoredString(cache, missionKey, key)

--===========================================================================
function LoadRealBJ(i_key, i_missionKey, hashtable_table) return real end
--call SyncStoredReal(table, missionKey, key)

--===========================================================================
function LoadIntegerBJ(i_key, i_missionKey, hashtable_table) return integer end
--call SyncStoredInteger(table, missionKey, key)

--===========================================================================
function LoadBooleanBJ(i_key, i_missionKey, hashtable_table) return boolean end
--call SyncStoredBoolean(table, missionKey, key)

--===========================================================================
function LoadStringBJ(i_key, i_missionKey, hashtable_table) return string end

--call SyncStoredString(table, missionKey, key)

--===========================================================================
function LoadPlayerHandleBJ(i_key, i_missionKey, hashtable_table) return player end

--===========================================================================
function LoadWidgetHandleBJ(i_key, i_missionKey, hashtable_table) return widget end

--===========================================================================
function LoadDestructableHandleBJ(i_key, i_missionKey, hashtable_table) return destructable end

--===========================================================================
function LoadItemHandleBJ(i_key, i_missionKey, hashtable_table) return item end

--===========================================================================
function LoadUnitHandleBJ(i_key, i_missionKey, hashtable_table) return unit end

--===========================================================================
function LoadAbilityHandleBJ(i_key, i_missionKey, hashtable_table) return ability end

--===========================================================================
function LoadTimerHandleBJ(i_key, i_missionKey, hashtable_table) return timer end

--===========================================================================
function LoadTriggerHandleBJ(i_key, i_missionKey, hashtable_table) return trigger end

--===========================================================================
function LoadTriggerConditionHandleBJ(i_key, i_missionKey, hashtable_table) return triggercondition end

--===========================================================================
function LoadTriggerActionHandleBJ(i_key, i_missionKey, hashtable_table) return triggeraction end

--===========================================================================
function LoadTriggerEventHandleBJ(i_key, i_missionKey, hashtable_table) return event end

--===========================================================================
function LoadForceHandleBJ(i_key, i_missionKey, hashtable_table) return force end

--===========================================================================
function LoadGroupHandleBJ(i_key, i_missionKey, hashtable_table) return group end

--===========================================================================
function LoadLocationHandleBJ(i_key, i_missionKey, hashtable_table) return location end

--===========================================================================
function LoadRectHandleBJ(i_key, i_missionKey, hashtable_table) return rect end

--===========================================================================
function LoadBooleanExprHandleBJ(i_key, i_missionKey, hashtable_table) return boolexpr end

--===========================================================================
function LoadSoundHandleBJ(i_key, i_missionKey, hashtable_table) return sound end

--===========================================================================
function LoadEffectHandleBJ(i_key, i_missionKey, hashtable_table) return effect end

--===========================================================================
function LoadUnitPoolHandleBJ(i_key, i_missionKey, hashtable_table) return unitpool end

--===========================================================================
function LoadItemPoolHandleBJ(i_key, i_missionKey, hashtable_table) return itempool end

--===========================================================================
function LoadQuestHandleBJ(i_key, i_missionKey, hashtable_table) return quest end

--===========================================================================
function LoadQuestItemHandleBJ(i_key, i_missionKey, hashtable_table) return questitem end

--===========================================================================
function LoadDefeatConditionHandleBJ(i_key, i_missionKey, hashtable_table) return defeatcondition end

--===========================================================================
function LoadTimerDialogHandleBJ(i_key, i_missionKey, hashtable_table) return timerdialog end

--===========================================================================
function LoadLeaderboardHandleBJ(i_key, i_missionKey, hashtable_table) return leaderboard end

--===========================================================================
function LoadMultiboardHandleBJ(i_key, i_missionKey, hashtable_table) return multiboard end

--===========================================================================
function LoadMultiboardItemHandleBJ(i_key, i_missionKey, hashtable_table) return multiboarditem end

--===========================================================================
function LoadTrackableHandleBJ(i_key, i_missionKey, hashtable_table) return trackable end

--===========================================================================
function LoadDialogHandleBJ(i_key, i_missionKey, hashtable_table) return dialog end

--===========================================================================
function LoadButtonHandleBJ(i_key, i_missionKey, hashtable_table) return button end

--===========================================================================
function LoadTextTagHandleBJ(i_key, i_missionKey, hashtable_table) return texttag end

--===========================================================================
function LoadLightningHandleBJ(i_key, i_missionKey, hashtable_table) return lightning end

--===========================================================================
function LoadImageHandleBJ(i_key, i_missionKey, hashtable_table) return image end

--===========================================================================
function LoadUbersplatHandleBJ(i_key, i_missionKey, hashtable_table) return ubersplat end

--===========================================================================
function LoadRegionHandleBJ(i_key, i_missionKey, hashtable_table) return region end

--===========================================================================
function LoadFogStateHandleBJ(i_key, i_missionKey, hashtable_table) return fogstate end

--===========================================================================
function LoadFogModifierHandleBJ(i_key, i_missionKey, hashtable_table) return fogmodifier end

--===========================================================================
function LoadHashtableHandleBJ(i_key, i_missionKey, hashtable_table) return hashtable end

--===========================================================================
function RestoreUnitLocFacingAngleBJ(s_key, s_missionKey, gamecache_cache, player_forWhichPlayer, location_loc, r_facing) return unit end
--call SyncStoredUnit(cache, missionKey, key)

--===========================================================================
function RestoreUnitLocFacingPointBJ(s_key, s_missionKey, gamecache_cache, player_forWhichPlayer, location_loc, location_lookAt) return unit end
--call SyncStoredUnit(cache, missionKey, key)

--===========================================================================
function GetLastRestoredUnitBJ() return unit end

--===========================================================================
function FlushGameCacheBJ(gamecache_cache) end

--===========================================================================
function FlushStoredMissionBJ(s_missionKey, gamecache_cache) end

--===========================================================================
function FlushParentHashtableBJ(hashtable_table) end

--===========================================================================
function FlushChildHashtableBJ(i_missionKey, hashtable_table) end

--===========================================================================
function HaveStoredValue(s_key, i_valueType, s_missionKey, gamecache_cache) return boolean end

-- Unrecognized value type - ignore the request.

--===========================================================================
function HaveSavedValue(i_key, i_valueType, i_missionKey, hashtable_table) return boolean end

-- Unrecognized value type - ignore the request.

--===========================================================================
function ShowCustomCampaignButton(b_show, i_whichButton) end

--===========================================================================
function IsCustomCampaignButtonVisibile(i_whichButton) return boolean end

--===========================================================================
function LoadGameBJ(s_loadFileName, b_doScoreScreen) end

--===========================================================================
function SaveAndChangeLevelBJ(s_saveFileName, s_newLevel, b_doScoreScreen) end

--===========================================================================
function SaveAndLoadGameBJ(s_saveFileName, s_loadFileName, b_doScoreScreen) end

--===========================================================================
function RenameSaveDirectoryBJ(s_sourceDirName, s_destDirName) return boolean end

--===========================================================================
function RemoveSaveDirectoryBJ(s_sourceDirName) return boolean end

--===========================================================================
function CopySaveGameBJ(s_sourceSaveName, s_destSaveName) return boolean end

--***************************************************************************
--*
--* Miscellaneous Utility Functions
--*
--***************************************************************************

--===========================================================================
function GetPlayerStartLocationX(player_whichPlayer) return real end

--===========================================================================
function GetPlayerStartLocationY(player_whichPlayer) return real end

--===========================================================================
function GetPlayerStartLocationLoc(player_whichPlayer) return location end

--===========================================================================
function GetRectCenter(rect_whichRect) return location end

--===========================================================================
function IsPlayerSlotState(player_whichPlayer, playerslotstate_whichState) return boolean end

--===========================================================================
function GetFadeFromSeconds(r_seconds) return integer end

--===========================================================================
function GetFadeFromSecondsAsReal(r_seconds) return real end

--===========================================================================
function AdjustPlayerStateSimpleBJ(player_whichPlayer, playerstate_whichPlayerState, i_delta) end

--===========================================================================
function AdjustPlayerStateBJ(i_delta, player_whichPlayer, playerstate_whichPlayerState) end
-- If the change was positive, apply the difference to the player's
-- gathered resources property as well.

--===========================================================================
function SetPlayerStateBJ(player_whichPlayer, playerstate_whichPlayerState, i_value) end

--===========================================================================
function SetPlayerFlagBJ(playerstate_whichPlayerFlag, b_flag, player_whichPlayer) end

--===========================================================================
function SetPlayerTaxRateBJ(i_rate, playerstate_whichResource, player_sourcePlayer, player_otherPlayer) end

--===========================================================================
function GetPlayerTaxRateBJ(playerstate_whichResource, player_sourcePlayer, player_otherPlayer) return integer end

--===========================================================================
function IsPlayerFlagSetBJ(playerstate_whichPlayerFlag, player_whichPlayer) return boolean end

--===========================================================================
function AddResourceAmountBJ(i_delta, unit_whichUnit) end

--===========================================================================
function GetConvertedPlayerId(player_whichPlayer) return integer end

--===========================================================================
function ConvertedPlayer(i_convertedPlayerId) return player end

--===========================================================================
function GetRectWidthBJ(rect_r) return real end

--===========================================================================
function GetRectHeightBJ(rect_r) return real end

--===========================================================================
-- Replaces a gold mine with a blighted gold mine for the given player.
--
function BlightGoldMineForPlayerBJ(unit_goldMine, player_whichPlayer) return unit end

-- Make sure we're replacing a Gold Mine and not some other type of unit.

-- Save the Gold Mine's properties and remove it.

-- Create a Haunted Gold Mine to replace the Gold Mine.

--===========================================================================
function BlightGoldMineForPlayer(unit_goldMine, player_whichPlayer) return unit end

--===========================================================================
function GetLastHauntedGoldMine() return unit end

--===========================================================================
function IsPointBlightedBJ(location_where) return boolean end

--===========================================================================
function SetPlayerColorBJEnum() end

--===========================================================================
function SetPlayerColorBJ(player_whichPlayer, playercolor_color, b_changeExisting) end

--===========================================================================
function SetPlayerUnitAvailableBJ(i_unitId, b_allowed, player_whichPlayer) end

--===========================================================================
function LockGameSpeedBJ() end

--===========================================================================
function UnlockGameSpeedBJ() end

--===========================================================================
function IssueTargetOrderBJ(unit_whichUnit, s_order, widget_targetWidget) return boolean end

--===========================================================================
function IssuePointOrderLocBJ(unit_whichUnit, s_order, location_whichLocation) return boolean end

--===========================================================================
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
function IssueTargetDestructableOrder(unit_whichUnit, s_order, widget_targetWidget) return boolean end

function IssueTargetItemOrder(unit_whichUnit, s_order, widget_targetWidget) return boolean end

--===========================================================================
function IssueImmediateOrderBJ(unit_whichUnit, s_order) return boolean end

--===========================================================================
function GroupTargetOrderBJ(group_whichGroup, s_order, widget_targetWidget) return boolean end

--===========================================================================
function GroupPointOrderLocBJ(group_whichGroup, s_order, location_whichLocation) return boolean end

--===========================================================================
function GroupImmediateOrderBJ(group_whichGroup, s_order) return boolean end

--===========================================================================
-- Two distinct trigger actions can't share the same function name, so this
-- dummy function simply mimics the behavior of an existing call.
--
function GroupTargetDestructableOrder(group_whichGroup, s_order, widget_targetWidget) return boolean end

function GroupTargetItemOrder(group_whichGroup, s_order, widget_targetWidget) return boolean end

--===========================================================================
function GetDyingDestructable() return destructable end

--===========================================================================
-- Rally point setting
--
function SetUnitRallyPoint(unit_whichUnit, location_targPos) end

--===========================================================================
function SetUnitRallyUnit(unit_whichUnit, unit_targUnit) end

--===========================================================================
function SetUnitRallyDestructable(unit_whichUnit, destructable_targDest) end

--===========================================================================
-- Utility function for use by editor-generated item drop table triggers.
-- This function is added as an action to all destructable drop triggers,
-- so that a widget drop may be differentiated from a unit drop.
--
function SaveDyingWidget() end

--===========================================================================
function SetBlightRectBJ(b_addBlight, player_whichPlayer, rect_r) end

--===========================================================================
function SetBlightRadiusLocBJ(b_addBlight, player_whichPlayer, location_loc, r_radius) end

--===========================================================================
function GetAbilityName(i_abilcode) return string end

--***************************************************************************
--*
--* Melee Template Visibility Settings
--*
--***************************************************************************

--===========================================================================
function MeleeStartingVisibility() end
-- Start by setting the ToD.

-- call FogMaskEnable(true)
-- call FogEnable(true)

--***************************************************************************
--*
--* Melee Template Starting Resources
--*
--***************************************************************************

--===========================================================================
function MeleeStartingResources() end

-- Set each player's starting resources.

--***************************************************************************
--*
--* Melee Template Hero Limit
--*
--***************************************************************************

--===========================================================================
function ReducePlayerTechMaxAllowed(player_whichPlayer, i_techId, i_limit) end

-- A value of -1 is used to indicate no limit, so check for that as well.

--===========================================================================
function MeleeStartingHeroLimit() end

-- max heroes per player

-- each player is restricted to a limit per hero type as well

--***************************************************************************
--*
--* Melee Template Granted Hero Items
--*
--***************************************************************************

--===========================================================================
function MeleeTrainedUnitIsHeroBJFilter() return boolean end

--===========================================================================
-- The first N heroes trained or hired for each player start off with a
-- standard set of items. This is currently:
-- - 1x Scroll of Town Portal
--
function MeleeGrantItemsToHero(unit_whichUnit) end

-- If we haven't twinked N heroes for this player yet, twink away.

--===========================================================================
function MeleeGrantItemsToTrainedHero() end

--===========================================================================
function MeleeGrantItemsToHiredHero() end

--===========================================================================
function MeleeGrantHeroItems() end

-- Initialize the twinked hero counts.

-- Register for an event whenever a hero is trained, so that we can give
-- him/her their starting items.

-- Register for an event whenever a neutral hero is hired, so that we
-- can give him/her their starting items.

-- Flag that we are giving starting items to heroes, so that the melee
-- starting units code can create them as necessary.

--***************************************************************************
--*
--* Melee Template Clear Start Locations
--*
--***************************************************************************

--===========================================================================
function MeleeClearExcessUnit() end

-- Remove any Neutral Hostile units from the area.

-- Remove non-structure Neutral Passive units from the area.

--===========================================================================
function MeleeClearNearbyUnits(r_x, r_y, r_range) end

--===========================================================================
function MeleeClearExcessUnits() end

-- If the player slot is being used, clear any nearby creeps.

--***************************************************************************
--*
--* Melee Template Starting Units
--*
--***************************************************************************

--===========================================================================
function MeleeEnumFindNearestMine() end

-- If this is our first mine, or the closest thusfar, use it instead.

--===========================================================================
function MeleeFindNearestMine(location_src, r_range) return unit end

--===========================================================================
function MeleeRandomHeroLoc(player_p, i_id1, i_id2, i_id3, i_id4, location_loc) return unit end

-- The selection of heroes is dependant on the game version.

-- Translate the roll into a unitid.

-- Unrecognized id index - pick the first hero in the list.

-- Create the hero.

--===========================================================================
-- Returns a location which is (distance) away from (src) in the direction of (targ).
--
function MeleeGetProjectedLoc(location_src, location_targ, r_distance, r_deltaAngle) return location end

--===========================================================================
function MeleeGetNearestValueWithin(r_val, r_minVal, r_maxVal) return real end

--===========================================================================
function MeleeGetLocWithinRect(location_src, rect_r) return location end

--===========================================================================
-- Starting Units for Human Players
-- - 1 Town Hall, placed at start location
-- - 5 Peasants, placed between start location and nearest gold mine
--
function MeleeStartingUnitsHuman(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end

-- Spawn Town Hall at the start location.

-- Spawn Peasants near the mine.

-- Set random hero spawn point to be off to the side of the start location.

-- Spawn Town Hall at the start location.

-- Spawn Peasants directly south of the town hall.

-- Set random hero spawn point to be just south of the start location.

-- If the "Random Hero" option is set, start the player with a random hero.
-- Otherwise, give them a "free hero" token.

-- Center the camera on the initial Peasants.

--===========================================================================
-- Starting Units for Orc Players
-- - 1 Great Hall, placed at start location
-- - 5 Peons, placed between start location and nearest gold mine
--
function MeleeStartingUnitsOrc(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end

-- Spawn Great Hall at the start location.

-- Spawn Peons near the mine.

-- Set random hero spawn point to be off to the side of the start location.

-- Spawn Great Hall at the start location.

-- Spawn Peons directly south of the town hall.

-- Set random hero spawn point to be just south of the start location.

-- If the "Random Hero" option is set, start the player with a random hero.
-- Otherwise, give them a "free hero" token.

-- Center the camera on the initial Peons.

--===========================================================================
-- Starting Units for Undead Players
-- - 1 Necropolis, placed at start location
-- - 1 Haunted Gold Mine, placed on nearest gold mine
-- - 3 Acolytes, placed between start location and nearest gold mine
-- - 1 Ghoul, placed between start location and nearest gold mine
-- - Blight, centered on nearest gold mine, spread across a "large area"
--
function MeleeStartingUnitsUndead(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end

-- Spawn Necropolis at the start location.

-- Replace the nearest gold mine with a blighted version.

-- Spawn Ghoul near the Necropolis.

-- Spawn Acolytes near the mine.

-- Create a patch of blight around the gold mine.

-- Set random hero spawn point to be off to the side of the start location.

-- Spawn Necropolis at the start location.

-- Spawn Acolytes and Ghoul directly south of the Necropolis.

-- Create a patch of blight around the start location.

-- Set random hero spawn point to be just south of the start location.

-- If the "Random Hero" option is set, start the player with a random hero.
-- Otherwise, give them a "free hero" token.

-- Center the camera on the initial Acolytes.

--===========================================================================
-- Starting Units for Night Elf Players
-- - 1 Tree of Life, placed by nearest gold mine, already entangled
-- - 5 Wisps, placed between Tree of Life and nearest gold mine
--
function MeleeStartingUnitsNightElf(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end

-- Spawn Tree of Life near the mine and have it entangle the mine.
-- Project the Tree's coordinates from the gold mine, and then snap
-- the X and Y values to within minTreeDist of the Gold Mine.

-- Spawn Wisps at the start location.

-- Set random hero spawn point to be off to the side of the start location.

-- Spawn Tree of Life at the start location.

-- Spawn Wisps directly south of the town hall.

-- Set random hero spawn point to be just south of the start location.

-- If the "Random Hero" option is set, start the player with a random hero.
-- Otherwise, give them a "free hero" token.

-- Center the camera on the initial Wisps.

--===========================================================================
-- Starting Units for Players Whose Race is Unknown
-- - 12 Sheep, placed randomly around the start location
--
function MeleeStartingUnitsUnknownRace(player_whichPlayer, location_startLoc, b_doHeroes, b_doCamera, b_doPreload) end

-- Give them a "free hero" token, out of pity.

-- Center the camera on the initial sheep.

--===========================================================================
function MeleeStartingUnits() end

-- Create initial race-specific starting units

--===========================================================================
function MeleeStartingUnitsForPlayer(race_whichRace, player_whichPlayer, location_loc, b_doHeroes) end
-- Create initial race-specific starting units

-- Unrecognized race - ignore the request.

--***************************************************************************
--*
--* Melee Template Starting AI Scripts
--*
--***************************************************************************

--===========================================================================
function PickMeleeAI(player_num, s_s1, s_s2, s_s3) end

-- easy difficulty never uses any custom AI scripts
-- that are designed to be a bit more challenging
--

--===========================================================================
function MeleeStartingAI() end

-- Run a race-specific melee AI script.

-- Unrecognized race.

function LockGuardPosition(unit_targ) end

--***************************************************************************
--*
--* Melee Template Victory / Defeat Conditions
--*
--***************************************************************************

--===========================================================================
function MeleePlayerIsOpponent(i_playerIndex, i_opponentIndex) return boolean end

-- The player himself is not an opponent.

-- Unused player slots are not opponents.

-- Players who are already defeated are not opponents.

-- Allied players with allied victory set are not opponents.

--===========================================================================
-- Count buildings currently owned by all allies, including the player themself.
--
function MeleeGetAllyStructureCount(player_whichPlayer) return integer end

-- Count the number of buildings controlled by all not-yet-defeated co-allies.

-- uncomment to cause defeat even if you have control of ally structures, but yours have been nixed
--if (PlayersAreCoAllied(whichPlayer, indexPlayer) and not bj_meleeDefeated[playerIndex]) then

--===========================================================================
-- Count allies, excluding dead players and the player themself.
--
function MeleeGetAllyCount(player_whichPlayer) return integer end

-- Count the number of not-yet-defeated co-allies.

--===========================================================================
-- Counts key structures owned by a player and his or her allies, including
-- structures currently upgrading or under construction.
--
-- Key structures: Town Hall, Great Hall, Tree of Life, Necropolis
--
function MeleeGetAllyKeyStructureCount(player_whichPlayer) return integer end

-- Count the number of buildings controlled by all not-yet-defeated co-allies.

--===========================================================================
-- Enum: Draw out a specific player.
--
function MeleeDoDrawEnum() end

--===========================================================================
-- Enum: Victory out a specific player.
--
function MeleeDoVictoryEnum() end

--===========================================================================
-- Defeat out a specific player.
--
function MeleeDoDefeat(player_whichPlayer) end

--===========================================================================
-- Enum: Defeat out a specific player.
--
function MeleeDoDefeatEnum() end

-- needs to happen before ownership change

--===========================================================================
-- A specific player left the game.
--
function MeleeDoLeave(player_whichPlayer) end

--===========================================================================
-- Remove all observers
--
function MeleeRemoveObservers() end

-- Give all observers the game over dialog

--===========================================================================
-- Test all players to determine if a team has won. For a team to win, all
-- remaining (read: undefeated) players need to be co-allied with all other
-- remaining players. If even one player is not allied towards another,
-- everyone must be denied victory.
--
function MeleeCheckForVictors() return force end

-- Check to see if any players have opponents remaining.

-- Determine whether or not this player has any remaining opponents.

-- If anyone has an opponent, noone can be victorious yet.

-- Keep track of each opponentless player so that we can give
-- them a victory later.

-- Set the game over global flag

--===========================================================================
-- Test each player to determine if anyone has been defeated.
--
function MeleeCheckForLosersAndVictors() end

-- If the game is already over, do 

-- If the game was disconnected then it is over, in this case we
-- don't want to report results for anyone as they will most likely
-- conflict with the actual game results

-- Check each player to see if he or she has been defeated yet.

--call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 60, "Player"+I2S(playerIndex)+" has "+I2S(MeleeGetAllyStructureCount(indexPlayer))+" ally buildings.")

-- Keep track of each defeated player so that we can give
-- them a defeat later.

-- Set their defeated flag now so MeleeCheckForVictors
-- can detect victors.

-- Now that the defeated flags are set, check if there are any victors

-- Defeat all defeated players

-- Give victory to all victorious players

-- If the game is over we should remove all observers

--===========================================================================
-- Returns a race-specific "build X or be revealed" message.
--
function MeleeGetCrippledWarningMessage(player_whichPlayer) return string end

-- Unrecognized Race

--===========================================================================
-- Returns a race-specific "build X" label for cripple timers.
--
function MeleeGetCrippledTimerMessage(player_whichPlayer) return string end

-- Unrecognized Race

--===========================================================================
-- Returns a race-specific "build X" label for cripple timers.
--
function MeleeGetCrippledRevealedMessage(player_whichPlayer) return string end

--===========================================================================
function MeleeExposePlayer(player_whichPlayer, b_expose) end

--===========================================================================
function MeleeExposeAllPlayers() end

--===========================================================================
function MeleeCrippledPlayerTimeout() end

-- Determine which player's timer expired.

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- Hide the timer window for this player.

-- Display a text message to all players, explaining the exposure.

-- Expose the player.

--===========================================================================
function MeleePlayerIsCrippled(player_whichPlayer) return boolean end

-- Dead teams are not considered to be crippled.

--===========================================================================
-- Test each player to determine if anyone has become crippled.
--
function MeleeCheckForCrippledPlayers() end

-- The "finish soon" exposure of all players overrides any "crippled" exposure

-- Check each player to see if he or she has been crippled or uncrippled.

-- Player became crippled; start their cripple timer.

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- Show the timer window.

-- Display a warning message.

-- Player became uncrippled; stop their cripple timer.

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- Hide the timer window for this player.

-- Display a confirmation message if the player's team is still alive.

-- If the player granted shared vision, deny that vision now.

--===========================================================================
-- Determine if the lost unit should result in any defeats or victories.
--
function MeleeCheckLostUnit(unit_lostUnit) end

-- We only need to check for mortality if this was the last building.

-- Check if the lost unit has crippled or uncrippled the player.
-- (A team with 0 units is dead, and thus considered uncrippled.)

--===========================================================================
-- Determine if the gained unit should result in any defeats, victories,
-- or cripple-status changes.
--
function MeleeCheckAddedUnit(unit_addedUnit) end

-- If the player was crippled, this unit may have uncrippled him/her.

--===========================================================================
function MeleeTriggerActionConstructCancel() end

--===========================================================================
function MeleeTriggerActionUnitDeath() end

--===========================================================================
function MeleeTriggerActionUnitConstructionStart() end

--===========================================================================
function MeleeTriggerActionPlayerDefeated() end

-- If at least one ally is still alive and kicking, share units with
-- them and proceed with death.

-- If no living allies remain, swap all units and buildings over to
-- neutral_passive and proceed with death.

--===========================================================================
function MeleeTriggerActionPlayerLeft() end

-- Just show game over for observers when they leave

-- This is the same as defeat except the player generates the message
-- "player left the game" as opposed to "player was defeated".

-- If at least one ally is still alive and kicking, share units with
-- them and proceed with death.

-- If no living allies remain, swap all units and buildings over to
-- neutral_passive and proceed with death.

--===========================================================================
function MeleeTriggerActionAllianceChange() end

--===========================================================================
function MeleeTriggerTournamentFinishSoon() end
-- Note: We may get this trigger multiple times

-- Reset all crippled players and their timers, and hide the local crippled timer dialog

-- Uncripple the player

-- Use only local code (no net traffic) within this block to avoid desyncs.

-- Hide the timer window.

-- Expose all players

-- Show the "finish soon" timer dialog and set the real time remaining

--===========================================================================
function MeleeWasUserPlayer(player_whichPlayer) return boolean end

--===========================================================================
function MeleeTournamentFinishNowRuleA(i_multiplier) end

-- Compute individual player scores

-- Compute team scores and team forces

-- The game is now over

-- There should always be at least one team, but continue to work if not

-- Find best team score

-- Check whether the best team's score is 'multiplier' times better than
-- every other team. In the case of multiplier == 1 and exactly equal team
-- scores, the first team (which was randomly chosen by the server) will win.

-- Give draw to all players on all teams

-- Give defeat to all players on teams other than the best team

-- Give victory to all players on the best team

--===========================================================================
function MeleeTriggerTournamentFinishNow() end

-- If the game is already over, do 

-- Finals games

-- Preliminary games

-- Since the game is over we should remove all observers

--===========================================================================
function MeleeInitVictoryDefeat() end

-- Create a timer window for the "finish soon" timeout period, it has no timer
-- because it is driven by real time (outside of the game state to avoid desyncs)

-- Set a trigger to fire when we receive a "finish soon" game event

-- Set a trigger to fire when we receive a "finish now" game event

-- Set up each player's mortality code.

-- Make sure this player slot is playing.

-- Create a timer and timer window in case the player is crippled.

-- Set a trigger to fire whenever a building is cancelled for this player.

-- Set a trigger to fire whenever a unit dies for this player.

-- Set a trigger to fire whenever a unit begins construction for this player

-- Set a trigger to fire whenever this player defeats-out

-- Set a trigger to fire whenever this player leaves

-- Set a trigger to fire whenever this player changes his/her alliances.

-- Handle leave events for observers

-- Set a trigger to fire whenever this player leaves

-- Test for victory / defeat at startup, in case the user has already won / lost.
-- Allow for a short time to pass first, so that the map can finish loading.

--***************************************************************************
--*
--* Player Slot Availability
--*
--***************************************************************************

--===========================================================================
function CheckInitPlayerSlotAvailability() end

--===========================================================================
function SetPlayerSlotAvailable(player_whichPlayer, mapcontrol_control) end

--***************************************************************************
--*
--* Generic Template Player-slot Initialization
--*
--***************************************************************************

--===========================================================================
function TeamInitPlayerSlots(i_teamCount) end

--===========================================================================
function MeleeInitPlayerSlots() end

--===========================================================================
function FFAInitPlayerSlots() end

--===========================================================================
function OneOnOneInitPlayerSlots() end
-- Limit the game to 2 players.

--===========================================================================
function InitGenericPlayerSlots() end

-- Do ; the map-specific script handles this.

-- Unrecognized Game Type

--***************************************************************************
--*
--* Blizzard.j Initialization
--*
--***************************************************************************

--===========================================================================
function SetDNCSoundsDawn() end

--===========================================================================
function SetDNCSoundsDusk() end

--===========================================================================
function SetDNCSoundsDay() end

-- change ambient sounds

--===========================================================================
function SetDNCSoundsNight() end

-- change ambient sounds

--===========================================================================
function InitDNCSounds() end
-- Create sounds to be played at dawn and dusk.

-- Set up triggers to respond to dawn and dusk.

-- Set up triggers to respond to changes from day to night or vice-versa.

--===========================================================================
function InitBlizzardGlobals() end

-- Init filter function vars

-- Init force presets

-- Init Cinematic Mode history

-- Init Trigger Queue

-- Init singleplayer check

-- Init sounds
--set bj_pingMinimapSound = CreateSoundFromLabel("AutoCastButtonClick", false, false, false, 10000, 10000)

-- Init corpse creation triggers.

-- Init version-specific data

--===========================================================================
function InitQueuedTriggers() end

--===========================================================================
function InitMapRects() end

--===========================================================================
function InitSummonableCaps() end

-- upgraded units
-- Note: Only do this if the corresponding upgrade is not yet researched
-- Barrage - Siege Engines

-- Berserker Upgrade - Troll Berserkers

-- max skeletons per player

--===========================================================================
-- Update the per-class stock limits.
--
function UpdateStockAvailability(item_whichItem) end

-- Update allowed type/level combinations.

-- Not interested in this item type - ignore the item.

--===========================================================================
-- Find a sellable item of the given type and level, and then add it.
--
function UpdateEachStockBuildingEnum() end

-- If we get hung up on an entire class/level combo of unsellable
-- items, or a very unlucky series of random numbers, give up.

--===========================================================================
function UpdateEachStockBuilding(itemtype_iType, i_iLevel) end

--===========================================================================
-- Update stock inventory.
--
function PerformStockUpdates() end

-- Give each type/level combination a chance of being picked.

-- Make sure we found a valid item type to add.

--===========================================================================
-- Perform the first update, and then arrange future updates.
--
function StartStockUpdates() end

--===========================================================================
function RemovePurchasedItem() end

--===========================================================================
function InitNeutralBuildings() end

-- Chart of allowed stock items.

-- Limit stock inventory slots.

-- Arrange the first update.

-- Set up a trigger to fire whenever an item is sold.

--===========================================================================
function MarkGameStarted() end

--===========================================================================
function DetectGameStarted() end

--===========================================================================
function InitBlizzard() end
-- Set up the Neutral Victim player slot, to torture the abandoned units
-- of defeated players. Since some triggers expect this player slot to
-- exist, this is performed for all maps.

--***************************************************************************
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

--===========================================================================
function RandomDistReset() end

--===========================================================================
function RandomDistAddItem(i_inID, i_inChance) end

--===========================================================================
function RandomDistChoose() return integer end

-- No items?

-- Find sum of all chances

-- Choose random number within the total range

-- Find ID which corresponds to this chance

--***************************************************************************
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

function UnitDropItem(unit_inUnit, i_inItemID) return item end

--===========================================================================
function WidgetDropItem(widget_inWidget, i_inItemID) return item end

--***************************************************************************
--*
--* Instanced Object Operation Functions
--*
--* Get/Set specific fields for single unit/item/ability instance
--*
--***************************************************************************

--===========================================================================
function BlzIsLastInstanceObjectFunctionSuccessful() return boolean end

-- Ability
--===========================================================================
function BlzSetAbilityBooleanFieldBJ(ability_whichAbility, abilitybooleanfield_whichField, b_value) end

--===========================================================================
function BlzSetAbilityIntegerFieldBJ(ability_whichAbility, abilityintegerfield_whichField, i_value) end

--===========================================================================
function BlzSetAbilityRealFieldBJ(ability_whichAbility, abilityrealfield_whichField, r_value) end

--===========================================================================
function BlzSetAbilityStringFieldBJ(ability_whichAbility, abilitystringfield_whichField, s_value) end

--===========================================================================
function BlzSetAbilityBooleanLevelFieldBJ(ability_whichAbility, abilitybooleanlevelfield_whichField, i_level, b_value) end

--===========================================================================
function BlzSetAbilityIntegerLevelFieldBJ(ability_whichAbility, abilityintegerlevelfield_whichField, i_level, i_value) end

--===========================================================================
function BlzSetAbilityRealLevelFieldBJ(ability_whichAbility, abilityreallevelfield_whichField, i_level, r_value) end

--===========================================================================
function BlzSetAbilityStringLevelFieldBJ(ability_whichAbility, abilitystringlevelfield_whichField, i_level, s_value) end

--===========================================================================
function BlzSetAbilityBooleanLevelArrayFieldBJ(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, i_level, i_index, b_value) end

--===========================================================================
function BlzSetAbilityIntegerLevelArrayFieldBJ(ability_whichAbility, abilityintegerlevelarrayfield_whichField, i_level, i_index, i_value) end

--===========================================================================
function BlzSetAbilityRealLevelArrayFieldBJ(ability_whichAbility, abilityreallevelarrayfield_whichField, i_level, i_index, r_value) end

--===========================================================================
function BlzSetAbilityStringLevelArrayFieldBJ(ability_whichAbility, abilitystringlevelarrayfield_whichField, i_level, i_index, s_value) end

--===========================================================================
function BlzAddAbilityBooleanLevelArrayFieldBJ(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, i_level, b_value) end

--===========================================================================
function BlzAddAbilityIntegerLevelArrayFieldBJ(ability_whichAbility, abilityintegerlevelarrayfield_whichField, i_level, i_value) end

--===========================================================================
function BlzAddAbilityRealLevelArrayFieldBJ(ability_whichAbility, abilityreallevelarrayfield_whichField, i_level, r_value) end

--===========================================================================
function BlzAddAbilityStringLevelArrayFieldBJ(ability_whichAbility, abilitystringlevelarrayfield_whichField, i_level, s_value) end

--===========================================================================
function BlzRemoveAbilityBooleanLevelArrayFieldBJ(ability_whichAbility, abilitybooleanlevelarrayfield_whichField, i_level, b_value) end

--===========================================================================
function BlzRemoveAbilityIntegerLevelArrayFieldBJ(ability_whichAbility, abilityintegerlevelarrayfield_whichField, i_level, i_value) end

--===========================================================================
function BlzRemoveAbilityRealLevelArrayFieldBJ(ability_whichAbility, abilityreallevelarrayfield_whichField, i_level, r_value) end

--===========================================================================
function BlzRemoveAbilityStringLevelArrayFieldBJ(ability_whichAbility, abilitystringlevelarrayfield_whichField, i_level, s_value) end

-- Item
--=============================================================
function BlzItemAddAbilityBJ(item_whichItem, i_abilCode) end

--===========================================================================
function BlzItemRemoveAbilityBJ(item_whichItem, i_abilCode) end

--===========================================================================
function BlzSetItemBooleanFieldBJ(item_whichItem, itembooleanfield_whichField, b_value) end

--===========================================================================
function BlzSetItemIntegerFieldBJ(item_whichItem, itemintegerfield_whichField, i_value) end

--===========================================================================
function BlzSetItemRealFieldBJ(item_whichItem, itemrealfield_whichField, r_value) end

--===========================================================================
function BlzSetItemStringFieldBJ(item_whichItem, itemstringfield_whichField, s_value) end

-- Unit
--===========================================================================
function BlzSetUnitBooleanFieldBJ(unit_whichUnit, unitbooleanfield_whichField, b_value) end

--===========================================================================
function BlzSetUnitIntegerFieldBJ(unit_whichUnit, unitintegerfield_whichField, i_value) end

--===========================================================================
function BlzSetUnitRealFieldBJ(unit_whichUnit, unitrealfield_whichField, r_value) end

--===========================================================================
function BlzSetUnitStringFieldBJ(unit_whichUnit, unitstringfield_whichField, s_value) end

-- Unit Weapon
--===========================================================================
function BlzSetUnitWeaponBooleanFieldBJ(unit_whichUnit, unitweaponbooleanfield_whichField, i_index, b_value) end

--===========================================================================
function BlzSetUnitWeaponIntegerFieldBJ(unit_whichUnit, unitweaponintegerfield_whichField, i_index, i_value) end

--===========================================================================
function BlzSetUnitWeaponRealFieldBJ(unit_whichUnit, unitweaponrealfield_whichField, i_index, r_value) end

--===========================================================================
function BlzSetUnitWeaponStringFieldBJ(unit_whichUnit, unitweaponstringfield_whichField, i_index, s_value) end

