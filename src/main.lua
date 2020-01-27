require('utils.Globals')

--local Log = require('utils.Log')

---@type UnitClass
local Unit = require('Class..Unit.Unit')
---@type UnitTypeClass
local UnitType = require('Class.Unit.Type')
---@type AbilityType
local ExampleAbility = require('Class.Ability.Example')
---@type BetterTimerClass
local BetterTimer = require('Class.Timer.BetterTimer')

local footman_type = UnitType.new('Footman', UnitType.UnitTypeClassification.Unit)

local icon = Compiletime(function() return require('compiletime.Icon').BTN3M1 end)
--print(Class.type('azaza', 'string'))

local SimpleFrameType = require('Class.Frame.SimpleType')
local frame_type = SimpleFrameType.new('Test', SimpleFrameType.Type.BUTTON)

---@type FrameSimpleClass
local SimpleFrame = require('Class.Frame.Simple')

if not IsCompiletime() then
    local frame = SimpleFrame.new(frame_type)
    frame:setX(0.4)
    frame:setY(0.3)
    frame:setTexture('ReplaceableTextures\\CommandButtons\\BTNHeroPaladin')

    local tooltip = SimpleFrame.new(frame_type)
    tooltip:setX(0.5)
    tooltip:setY(0.3)
    tooltip:setTexture('ReplaceableTextures\\CommandButtons\\BTNHeroPaladin')

    frame:setTooltip(tooltip)
    frame:setOnClick(function() print('Button clicked') end)
    
    local u = Unit.new(Player(0), footman_type:getId(), 0, 0, 0)
    UnitAddAbility(u:getWc3Unit(), ExampleAbility:getId())
end
