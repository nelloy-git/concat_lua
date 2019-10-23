compiletime(
    function ()
        ---@type ObjEdit
        WeObjEdit = require('compiletime.objEdit.objEdit')
        WeObjEdit.init(src_dir, dst_dir)
        addCompiletimeFinalize(function() WeObjEdit.close() WeObjEdit = nil end)

        --local weItem = WeObjEdit.Item.Item
        --local i = weItem.new()
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

local Test

function RunInitialization()
    DestroyTimer(GetExpiredTimer())

    local Init = require('utils.Init')
    Init.start()

    runFuncInDebug(Test)
end

Test = function()
    local Unit = require('Include.Unit')
    ---@type Frame
    local Frame = require('Include.Frame')

    local u1 = Unit.new(Player(0), 'Hpal', 0, 0, 0)

    local f1 = Frame.newDefault("BACKDROP", Frame.WORLD)
    f1:setX(0.5)
    f1:setY(0.5)
    f1:setWidth(0.2)
    f1:setHeight(0.2)

    f1 = Frame.WORLD
    --Debug(Frame:getParent())
    --Debug(Frame.getScreenWidth(), Frame.getScreenHeight())
    --Debug(Frame.GAME_UI:getAbsWidth(), Frame.GAME_UI:getAbsHeight())
    Debug(f1:getAbsX(), f1:getAbsY(), f1:getAbsWidth(), f1:getAbsHeight())
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