require('utils.Globals')

--local Log = require('utils.Log')

---@type UnitClass
local Unit = require('Class.Unit.Unit')
---@type UnitTypeClass
local UnitType = require('Class.Unit.Type')
---@type AbilityType
local ExampleAbility = require('Class.Ability.Example')
---@type BetterTimerClass
local BetterTimer = require('Class.Timer.BetterTimer')

local footman_type = UnitType.new('Footman', UnitType.UnitTypeClassification.Unit)

local icon = Compiletime(function() return require('compiletime.Icon').BTN3M1 end)
--print(Class.type('azaza', 'string'))

local SimpleButtonType = require('Class.Frame.Types.SimpleButton')
local frame_type = SimpleButtonType.new('Test')

---@type FrameSimpleButtonClass
local SimpleButton = require('Class.Frame.Default.SimpleButton')

local Button = require('Class.Frame.Types.GlueButton')
local btn_type = Button.new('TestButton')

---@type GlueButtonClass
local GlueButton = require('Class.Frame.Default.GlueButton')

local u = nil
if not IsCompiletime() then
    local frame = GlueButton.new(btn_type)
    frame:setX(0.3)
    frame:setY(0.3)
    frame:setWidth(0.05)
    frame:setHeight(0.05)

    print(BlzFrameGetWidth(frame:getFramehandle()), BlzFrameGetHeight(frame:getFramehandle()))

    frame:setTexture('ReplaceableTextures\\CommandButtons\\BTNHeroPaladin')
    frame:setPushedTexture('ReplaceableTextures\\CommandButtons\\BTNHeroPaladin')

    u = Unit.new(Player(0), footman_type:getId(), 0, 0, 0)
    UnitAddAbility(u:getWc3Unit(), ExampleAbility:getId()) 
    --u = nil
    collectgarbage()
end


--print(btn:getControlDisabledName())
