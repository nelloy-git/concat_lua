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
    require('init.Init')
    savetyRun(Test)
end

local unit_type = compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local WeUnit = WeObjEdit.Unit
    local u = WeUnit.new(WeObjEdit.getHeroId(), 'Hpal', 'Footman')
    u:setField(WeUnit.Name, 'Footman')
    return u:toRuntime()
end)

Test = function()
    local Unit = require('Class.Unit.Unit')
    --local ParameterType = require('Class.ParameterType')
    local AbilityExample = require('Class.Ability.AbilityExample')

    local foo = Unit.new(Player(0), unit_type.id, 0, 0, 0)
    --Debug(ID2str(AbilityExample:getId()))
    UnitAddAbility(foo:getWc3Unit(), AbilityExample:getId())

    ---@type GroundItemClass
    local GroundItem = require('Class.Item.GroundItem')
    local it = GroundItem.new(0, 0)
    it:setName('Test')
    it:setDescription('Test')
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