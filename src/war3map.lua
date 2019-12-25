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
--[[
local frame_type = compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local FdfFile = WeObjEdit.Fdf.File
    local SimpleFrame = WeObjEdit.Fdf.SimpleFrame
    local SimpleString = WeObjEdit.Fdf.SimpleString
    local SimpleTexture = WeObjEdit.Fdf.SimpleTexture

    local sub_string = SimpleString.new('TestSimpleString')
    sub_string:setField(SimpleString.Font, {"InfoPanelTextFont", 0.009})

    local sub_texture = SimpleTexture.new('TestSimpleTexture')
    sub_texture:setField(SimpleTexture.File, "ReplaceableTextures\\CommandButtons\\BTNHeroBloodElfPrince")

    local frame = SimpleFrame.new('TestSimpleFrame')
    frame:setField(SimpleFrame.Width, 0.05)
    frame:setField(SimpleFrame.Height, 0.05)
    frame:setField(SimpleFrame.String, {sub_string, sub_string, sub_string})
    frame:setField(SimpleFrame.Texture, {sub_texture, sub_texture, sub_texture})

    local file = FdfFile.new('TestSimple')
    file:addObject(frame)
    return file:toRuntime()
end)
]]--
--[[
local function testAbility()
    local Unit = require('Class.Unit.Unit')
    local AbilityExample = require('Class.Ability.AbilityExample')

    local foo = Unit.new(Player(0), unit_type.id, 0, 0, 0)
    UnitAddAbility(foo:getWc3Unit(), AbilityExample:getId())

    ---@type GroundItemClass
    local GroundItem = require('Class.Item.GroundItem')
    local it = GroundItem.new(0, 0)
    it:setName('Test')
    it:setDescription('Test')
end
--]]

--[[
local function testFrames()
    local FrameSpringTable = require('Class.Frame.Container.FrameSpringTable')
    local t = FrameSpringTable.new()
    
    t:setRows(4)
    t:setColumns(4)
    t:setRowRatioHeight(0.1, 4)
    t:setColumnRatioWidth(0.1, 4)
    --t:setRowHeightPart(0.1, 4)

    t:setX(0.4)
    t:setY(0.2)
    t:setWidth(0.25)
    t:setHeight(0.25)
    t:setRowAbsHeight(0.05, 1)
    t:setColumnAbsWidth(0.025, 1)

    local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')
    local t1 = FrameBackdrop.new()
    t1:setTexture(texture)
    local t2 = FrameBackdrop.new()
    t2:setTexture(texture)
    local t3 = FrameBackdrop.new()
    t3:setTexture(texture)
    local t4 = FrameBackdrop.new()
    t4:setTexture(texture)

    t:setCell(t1, 1, 1)
    t:setCell(t2, 2, 2)
    t:setCell(t3, 3, 3)
    t:setCell(t4, 4, 4)
end
--]]

local texture = compiletime(require('compiletime.Icon').BTNAcidBomb)
Test = function()
    local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')
    local FrameButton = require('Class.Frame.Default.FrameButton')
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