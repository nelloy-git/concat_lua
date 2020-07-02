require('Libs.Lib')

---@type ParameterLib
local ParameterAPI = require(LibList.ParameterLib)
---@type AbilityLib
local AbilityAPI = require(LibList.AbilityLib)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
---@type FrameLib
local FrameLib = require(LibList.FrameLib)
---@type BuffLib
local BuffLib = require(LibList.BuffLib)
---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)

local foo_type = BinaryLib.Unit.new(FourCC('hfoo'), FourCC('U001'), 'TestFootman')
foo_type:setValue(BinaryLib.UnitDB.Name.value_id, BinaryLib.UnitDB.Name.value_type, 'TestFootman')

local fdf = FrameLib.FdfFrame.new('testFdf', 'SIMPLEBUTTON')
fdf:setParameter('Width', '0.03')
fdf:setParameter('Height', '0.03')

local texture = FrameLib.FdfTexture.new('testTexture')
texture:setParameter('File', '\"\"')
fdf:addTexture(texture)

if IsCompiletime() then
    return
end

local test_frame = FrameLib.SimpleButton.new(fdf)
test_frame:setX(0.4)
test_frame:setY(0.3)
--test_frame:setWidth(0.1)
--test_frame:setHeight(0.1)
test_frame:setTextureFile("ReplaceableTextures\\\\CommandButtons\\\\BTNBlackDragon.blp", 0, false)
test_frame:addMouseEnterAction(function() print('Enter') end)
test_frame:addMouseLeaveAction(function() print('Leave') end)
test_frame:addMouseDownAction(MOUSE_BUTTON_TYPE_LEFT, function() print('Down') end)
test_frame:addMouseUpAction(MOUSE_BUTTON_TYPE_LEFT, function() print('Up') end)
test_frame:addMouseClickAction(MOUSE_BUTTON_TYPE_LEFT, function() print('Click') end)

local u = UtilsLib.Handle.Unit.new(FourCC('hfoo'), 0, 0, Player(0))
local param_container = ParameterAPI.UnitContainer.new(u)
param_container:addBase(ParameterAPI.PhysicalDamage, 10)
param_container:addBase(ParameterAPI.Defence, 5)
param_container:addBase(ParameterAPI.Health, 1000)

local u2 = UtilsLib.Handle.Unit.new(FourCC('hfoo'), 0, 0, Player(0))
param_container = ParameterAPI.UnitContainer.new(u2)
param_container:addBase(ParameterAPI.PhysicalDamage, 10)
param_container:addBase(ParameterAPI.Defence, 5)
param_container:addBase(ParameterAPI.Health, 1000)
