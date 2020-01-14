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

local AbilityFlags = Class.new('AbilityFlags')

---@class AbilityFlags
local public = AbilityFlags.public
---@class AbilityFlagsClass
local static = AbilityFlags.static
---@type AbilityFlagsClass
local override = AbilityFlags.override
local private = {}

--========
-- Static
--========

---@param child_instance AbilityFlags | nil
---@return AbilityFlags
function static.new(child_instance, block_move, block_attack)
    local instance = child_instance or Class.allocate(AbilityFlags)
    private.newData(instance, block_move, block_attack)

    return instance
end

--========
-- Public
--========

---@param caster unit
function public:applyFlagsToCaster(caster)
    local priv = private[self]

    if priv.block_move then
        private.setMoveFlag(true, caster)
    end

    if priv.block_attack then
        private.setAttackFlag(true, caster)
    end
end

---@param caster unit
function public:removeFlagsFromCaster(caster)
    local priv = private[self]

    if priv.block_move then
        private.setMoveFlag(false, caster)
    end

    if priv.block_attack then
        private.setAttackFlag(false, caster)
    end
end

function public:free()
   private.freeData(self)
   Class.free(self)
end

--=========
-- Private
--=========

private.ms_const = 10^10
private.disable_attack_id = ID('Abun')

private.move_blocked = {}
private.attack_blocked = {}

---@param flag boolean
---@param target unit
function private.setMoveFlag(flag, target)
    local params = UnitParametersContainer.get(target)
    if flag then
        if not private.move_blocked[target] then
            params:addMult(ParameterType.MS, -private.ms_const)
            private.move_blocked[target] = true
        else
            Error(AbilityFlags, 'block move flag already applied.', 3)
        end
    else
        if private.move_blocked[target] then
            params:addMult(ParameterType.MS, private.ms_const)
            private.move_blocked[target] = nil
        else
            Error(AbilityFlags, 'unit does not have move block flag', 3)
        end
    end
end

---@param flag boolean
---@param target unit
function private.setAttackFlag(flag, target)
    if flag then
        if not private.attack_blocked[target] then
            UnitAddAbility(target, private.disable_attack_id)
            private.attack_blocked[target] = true
        else
            Error(AbilityFlags, 'block attack flag already applied.', 3)
        end
    else
        if not private.attack_blocked[target] then
            UnitRemoveAbility(target, private.disable_attack_id)
        else
            Error(AbilityFlags, 'unit does not have attack block flag.', 3)
        end
    end
end

---@param instance AbilityFlags
---@param block_move boolean
---@param block_attack boolean
function private.newData(instance, block_move, block_attack)
    local priv = {
        block_move = block_move,
        block_attack = block_attack,
    }
    private[instance] = priv
end

---@param instance AbilityFlags
function private.freeData(instance)
    private[instance] = nil
end

return static