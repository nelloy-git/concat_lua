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

if not IsCompiletime() then
    local u = Unit.new(Player(0), footman_type:getId(), 0, 0, 0)
    UnitAddAbility(u:getWc3Unit(), ExampleAbility:getId())
end
