--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')
---@type UnitParametersContainerClass
local UnitParametersContainer = require('Class.Unit.Parameters.Container')

--=======
-- Class
--=======

local AbilityTypeFlags = Class.new('AbilityTypeFlags')

---@class AbilityTypeFlags
local public = AbilityTypeFlags.public
---@class AbilityTypeFlagsClass
local static = AbilityTypeFlags.static
---@type AbilityTypeFlagsClass
local override = AbilityTypeFlags.override
local private = {}

--========
-- Static
--========

---@param child_instance AbilityTypeFlags | nil
---@return AbilityTypeFlags
function static.new(child_instance)
    local instance = child_instance or Class.allocate(AbilityTypeFlags)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

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

function public:free()
   private.freeData(self)
   Class.free(self)
end

--=========
-- Private
--=========

---@param instance AbilityTypeFlagsClass
function private.newData(instance)
    local priv = {
        caster_can_move = true,
        caster_can_attack = true,
        caster_can_cast = false
    }
    private[instance] = priv
end

---@param instance AbilityTypeFlagsClass
function private.freeData(instance)
    private[instance] = nil
end

return static