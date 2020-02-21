--=========
-- Include
--=========

---@type AbilityAPI
local Ability = require('Ability.API')
local TargetingType = Ability.TargetingType

--=========
-- Ability
--=========

-- Ability type for using in casting system.
local ExampleAbility = Ability.Type.new('Example ability', TargetingType.UnitOrPoint)

---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function ExampleAbility:start(caster, target, lvl)
    local targ_unit = target:getObj()
    local t = 'Point'
    if targ_unit then
        t = 'Unit'
    end

    print('Started', t, target:getX(), target:getY())
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