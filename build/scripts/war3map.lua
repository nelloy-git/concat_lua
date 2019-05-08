local modules_Unit = {}


local Unit_mt = {__index = modules_Unit}

function modules_Unit.new(player, unitId, x, y, face)
    local u = {}
    setmetatable(u, Unit_mt)
    u.unit = CreateUnit(player, unitId, x, y, face)
    return u
end

function modules_Unit:show(this, bool) ShowUnit(this.unit, bool) end
function modules_Unit:setX(x) SetUnitX(self.unit, x) end
function modules_Unit:setY(y) SetUnitY(self.unit, y) end
function modules_Unit:setPos(x, y) SetUnitPosition(self.unit, x, y) end
function modules_Unit:setFacing(angle) SetUnitFacing(self.unit, angle) end
function modules_Unit:setFacingTimed(angle, duration) SetUnitFacingTimed(self.unit, angle, duration) end
function modules_Unit:setMoveSpeed(speed) SetUnitMoveSpeed(self.unit, speed) end
function modules_Unit:setFlyHeight(height, rate) SetUnitFlyHeight(self.unit, height, rate) end
function modules_Unit:setTurnSpeed(turnSpeed) SetUnitTurnSpeed(self.unit, turnSpeed) end
function modules_Unit:setPropWindowAngle(angle) SetUnitPropWindow(self.unit, angle) end
function modules_Unit:setAcquireRange(range) SetUnitAcquireRange(self.unit, range) end

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
    local id = 1751543663
    DisplayTextToPlayer(Player(0), 0 , 0, I2S(id))
    local f = Unit.new(Player(0), id, 0, 0, 0)
    f = Unit.new(Player(0), id, 0, 0, 0)
    local angle = 180
    f:setFacing(angle)
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
    SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
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
    DefineStartLocation(0, -1953.6, -3131.3)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end

