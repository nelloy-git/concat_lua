--=========
-- Include
--=========

---@type ParameterTypeClass
local ParameterType = require('ParameterType')
---@type UnitParametersContainerClass
local UnitParametersContainer = require('UnitParametersContainer')

--=======
-- Class
--=======

---@type AbilityTypeFlagsClass
local AbilityTypeFlags = newClass('AbilityTypeFlags')

---@class AbilityTypeFlags
local public = AbilityTypeFlags.public
---@class AbilityTypeFlagsClass
local static = AbilityTypeFlags.static
---@type table
local override = AbilityTypeFlags.override
---@type table(AbilityTypeFlags, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return AbilityTypeFlags
function static.new(instance_data)
    local instance = instance_data or newInstanceData(AbilityTypeFlags)
    local priv = {
        caster_can_move = true,
        caster_can_attack = true,
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

---@param caster unit
function public:applyFlagsToCaster(caster)
    local priv = private[self]

    if not private.getFlag(priv.caster_can_move) then
        local params = UnitParametersContainer.get(caster)
        params:addMult(ParameterType.MS, -private.ms_const)
        priv.can_move = false
    end

    if not private.getFlag(priv.caster_can_attack) then
        UnitAddAbility(caster, private.disable_attack_id)
        priv.can_attack = false
    end
end

---@param flag callback | boolean
function public:setCasterCanMove(flag)
    local priv = private[self]
    priv.caster_can_move = flag
end

---@return boolean
function public:getCasterCanMove()
    local priv = private[self]
    return private.getFlag(priv.caster_can_move)
end

---@param flag callback | boolean
function public:setCasterCanAttack(flag)
    local priv = private[self]
    priv.caster_can_attack = flag
end

---@return boolean
function public:getCasterCanAttack()
    local priv = private[self]
    return private.getFlag(priv.caster_can_attack)
end

---@return boolean
function private.getFlag(flag)
    if type(flag) == 'function' then
        return flag()
    elseif type(flag) == 'boolean' then
        return flag
    else
        return true
    end
end

return AbilityTypeFlags