--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type AbilityAPI
local Ability = require('Ability.API')
local TargetType = Ability.TargetType
local CallbackType = Ability.CallbackType
local Status = Ability.Status

---@type SmartTimerClass
local Timer = require('Timer.SmartTimer')

local fmt = string.format

--=========
-- Ability
--=========

-- Ability type for using in casting system.
local ExampleAbility = Ability.Type.new('Example ability', TargetType.Unit)

function ExampleAbility:start(caster, target, lvl)
    print('Started')
    return Ability.Status.OK
end

function ExampleAbility:cast(caster, target, lvl)
    print('Casting')
    return Ability.Status.OK
end

function ExampleAbility:finish(caster, target, lvl)
    print('Finished')
end

function ExampleAbility:getCastingTime(caster, target, lvl)
    return 3
end

function ExampleAbility:getRange(caster, lvl)
    return 1000
end

-- ===========
--  Callbacks
-- ===========



return ExampleAbility