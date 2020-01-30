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

if not IsCompiletime() then
    local frame = SimpleButton.new(frame_type)
    frame:setX(0.4)
    frame:setY(0.3)
    frame:setTexture('ReplaceableTextures\\CommandButtons\\BTNHeroPaladin')

    local frame2 = SimpleButton.new(frame_type)
    frame2:setX(0.05)
    frame2:setY(0.05)
    frame2:setTexture('ReplaceableTextures\\CommandButtons\\BTNHeroPaladin')

    frame2:setParent(frame)
    frame2:addAction(function() print('Button clicked') end)
    frame:setAlpha(127)

    local u = Unit.new(Player(0), footman_type:getId(), 0, 0, 0)
    UnitAddAbility(u:getWc3Unit(), ExampleAbility:getId())
end


local Button = require('Class.Frame.Types.Gluebutton')
local btn = Button.new('TestButton')

print(btn:getControlDisabledName())
