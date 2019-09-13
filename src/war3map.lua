compiletime(
    function ()
        ---@type ObjEdit
        WeObjEdit = require('compiletime.objEdit.objEdit')
        WeObjEdit.init(src_dir, dst_dir)
        addCompiletimeFinalize(function() WeObjEdit.close() WeObjEdit = nil end)
    end)


GG_trg_Melee_Initialization = nil
function InitGlobals()
end

function Trig_Melee_Initialization_Actions()
end

function InitTrig_Melee_Initialization()
    GG_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(GG_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
end

function InitCustomTriggers()
    InitTrig_Melee_Initialization()
end

function RunInitialization()
    DestroyTimer(GetExpiredTimer())

    local Init = require('utils.Init')
    Init.start()

    local Unit = require('baseClasses.Unit')
    local Ability = require('baseClasses.Ability')

    local u1 = Unit.new(Player(0), 'Hpal', 0, 0, 0)
    local u2 = Unit.new(Player(1), 'Hpal', 0, 0, 0)

    --local u2 = Unit.new(Player(1), 'hfoo', 0, 0, 0)
    --Debug(u)
    --Debug(Player(0))

    ---@type Ability
    --local summon_ability = require('heroes.warlord.summon')
    --summon_ability:giveToUnit(u:getObj())
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
    ---@type Trigger
    TimerStart(CreateTimer(), 0.1, false, RunInitialization)
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, 0, 0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end