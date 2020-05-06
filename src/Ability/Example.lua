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
local ExampleAbility = Ability.Type.new(TargetingType.UnitOrPoint)

---@param caster Unit
---@param target AbilityTarget
---@param lvl number
---@return boolean
function ExampleAbility:start(caster, target, lvl)
    local targ_unit = target:getObj()
    local t = 'Point'
    if targ_unit then
        t = 'Unit'
    end

    print('Started', t, target:getX(), target:getY())
    return true
end

function ExampleAbility:finish(caster, target, lvl)
    print('Finished')
end

function ExampleAbility:cancel(caster, target, lvl)
    print('Canceled')
end

function ExampleAbility:getIcon(owner, lvl)
    return "ReplaceableTextures\\\\CommandButtons\\\\BTNCharm.blp"
end

function ExampleAbility:getCooldown()
    return 5
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