local Test = {}

local test_unit_type = Compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    ---@type WeUnitClass
    local WeUnit = WeObjEdit.Unit
    local u = WeUnit.new(WeObjEdit.getHeroId(), 'Hpal', 'Footman')
    u:setField(WeUnit.Name, 'Footman')
    u:setField(WeUnit.ArmorSoundType, 'Flesh')
    return u:toRuntime()
end)

local test_frame_type = Compiletime(function()
    local FdfEdit = require('compiletime.FdfEdit.FdfEdit')
    local FdfFile = FdfEdit.File
    local SimpleFrame = FdfEdit.SimpleFrame
    local SimpleString = FdfEdit.SimpleString
    local SimpleTexture = FdfEdit.SimpleTexture

    local sub_texture = SimpleTexture.new('TestSimpleTexture')
    sub_texture:setField(SimpleTexture.File, "ReplaceableTextures\\CommandButtons\\BTNHeroBloodElfPrince")
    local sub_texture1 = SimpleTexture.new('TestSimpleTexture1')
    sub_texture:setField(SimpleTexture.File, "ReplaceableTextures\\CommandButtons\\BTNHeroBloodElfPrince")
    local sub_texture2 = SimpleTexture.new('TestSimpleTexture2')
    sub_texture:setField(SimpleTexture.File, "ReplaceableTextures\\CommandButtons\\BTNHeroBloodElfPrince")

    local sub_string = SimpleString.new('TestSimpleString')
    sub_string:setField(SimpleString.Font, {"InfoPanelTextFont", 0.009})

    local frame = SimpleFrame.new('TestSimpleFrame')
    frame:setField(SimpleFrame.Width, 0.05)
    frame:setField(SimpleFrame.Height, 0.05)
    frame:setField(SimpleFrame.String, {sub_string})
    frame:setField(SimpleFrame.Texture, {sub_texture, sub_texture1, sub_texture2})

    local file = FdfFile.new('TestSimple')
    file:addObject(frame)
    return file:toRuntime()
end)

function Test.abilitySystem()
    ---@type UnitClass
    local Unit = require('Class.Unit.Unit')
    ---@type AbilityType
    local AbilityExample = require('Class.Ability.AbilityExample')
    ---@type Unit
    local foo = Unit.new(Player(0), test_unit_type.id, 0, 0, 0)
    UnitAddAbility(foo:getWc3Unit(), AbilityExample:getId())

    ---@type GroundItemClass
    local GroundItem = require('Class.Item.GroundItem')
    local it = GroundItem.new(0, 0)
    it:setName('Test')
    it:setDescription('Test')
end

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

return Test