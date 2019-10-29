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

    local Item = require('Class.Item.Main')

    local u1 = Unit.new(Player(0), 'Hpal', 0, 0, 0)

    local world = Frame.getOrigin(ORIGIN_FRAME_WORLD_FRAME, 0)
    --world:setX(function(self) return 0.0 * self:getParent():getWidth() end)
    --world:setY(function(self) return 0.25 * self:getParent():getHeight() end)
    world:setX(function(self) return -Frame.getScreenXOffset() end)
    world:setY(0)
    world:setWidth(function(self) return self:getParent():getWidth() end)
    world:setHeight(function(self) return self:getParent():getHeight() end)
    world:update()

    --local f1 = Frame.newDefaultType("BACKDROP", world)
    --f1:setX(function(self) return 0.5 * self:getParent():getWidth() end)
    --f1:setY(function(self) return 0.5 * self:getParent():getHeight() end)
    --f1:setWidth(function(self) return 0.25 * self:getParent():getWidth() end)
    --f1:setHeight(function(self) return 0.25 * self:getParent():getWidth() end)
    --f1:update()

    --f1 = Frame.WORLD
    --Debug(Frame:getParent())
    --Debug(Frame.getScreenWidth(), Frame.getScreenHeight())
    --Debug(Frame.GAME_UI:getAbsWidth(), Frame.GAME_UI:getAbsHeight())
    --Debug(world:getAbsX(), world:getAbsY(), world:getAbsWidth(), world:getAbsHeight())
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