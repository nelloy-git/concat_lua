local test = {}

local test_dir_test = {}

test_dir_test.aaa = 5

function test_dir_test.some_action(a, b)
    return a+b
end

test.aaa  = test_dir_test

function test.some_action(a, b)
    return a+b
end

local module  = test

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
    module.aaa.some_action(1,2)
    DisplayTextToPlayer(Player(0), 0, 0, 'azaza')
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
