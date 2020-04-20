--=========
-- Include
--=========

---@type AbilityOldAPI
local AbilityOld = require('AbilityOld.API')
local TargetingType = AbilityOld.TargetingType

--=========
-- AbilityOld
--=========

-- AbilityOld type for using in casting system.
local ExampleAbilityOld = AbilityOld.Type.new(TargetingType.UnitOrPoint)

---@param caster Unit
---@param target AbilityOldTarget
---@param lvl number
---@return boolean
function ExampleAbilityOld:start(caster, target, lvl)
    local targ_unit = target:getObj()
    local t = 'Point'
    if targ_unit then
        t = 'Unit'
    end

    print('Started', t, target:getX(), target:getY())
    return true
end

function ExampleAbilityOld:finish(caster, target, lvl)
    print('Finished')
end

function ExampleAbilityOld:cancel(caster, target, lvl)
    print('Canceled')
end

function ExampleAbilityOld:getIcon(owner, lvl)
    return "ReplaceableTextures\\\\CommandButtons\\\\BTNCharm.blp"
end

function ExampleAbilityOld:getCooldown()
    return 5
end

function ExampleAbilityOld:getCastingTime(caster, target, lvl)
    return 3
end

function ExampleAbilityOld:getRange(caster, lvl)
    return 1000
end

-- ===========
--  Callbacks
-- ===========



return ExampleAbilityOld