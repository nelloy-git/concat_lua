--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')
---@type UnitParametersContainerClass
local UnitParametersContainer = require('Class.Unit.UnitParametersContainer')

--=======
-- Class
--=======

local AbilityTypeFlags = Class.new('AbilityTypeFlags')

---@class AbilityTypeFlags
local public = AbilityTypeFlags.public
---@class AbilityTypeFlagsClass
local static = AbilityTypeFlags.static
local override = AbilityTypeFlags.override
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return AbilityTypeFlags
function static.new(instance_data)
    local instance = instance_data or Class.allocate(AbilityTypeFlags)
    local priv = {
        caster_can_move = true,
        caster_can_attack = true,
        caster_can_cast = false
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

    if not priv.caster_can_move then
        local params = UnitParametersContainer.get(caster)
        params:addMult(ParameterType.MS, -private.ms_const)
    end

    if not priv.caster_can_attack then
        UnitAddAbility(caster, private.disable_attack_id)
    end
end
---@param caster unit
function public:removeFlagsFromCaster(caster)
    local priv = private[self]

    if not priv.caster_can_move then
        local params = UnitParametersContainer.get(caster)
        params:addMult(ParameterType.MS, private.ms_const)
    end

    if not priv.caster_can_attack then
        UnitRemoveAbility(caster, private.disable_attack_id)
    end
end

---@param flag boolean
function public:setCasterCanMove(flag)
    local priv = private[self]
    priv.caster_can_move = flag
end

---@return boolean
function public:getCasterCanMove()
    local priv = private[self]
    return priv.caster_can_move
end

---@param flag boolean
function public:setCasterCanAttack(flag)
    local priv = private[self]
    priv.caster_can_attack = flag
end

---@return boolean
function public:getCasterCanAttack()
    local priv = private[self]
    return priv.caster_can_attack
end

return AbilityTypeFlags