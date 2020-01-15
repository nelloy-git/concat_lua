--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

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

---@param block_move boolean
---@param block_attack boolean
---@param child_instance AbilityFlags | nil
---@return AbilityFlags
function static.new(block_move, block_attack, child_instance)
    local instance = child_instance or Class.allocate(AbilityFlags)
    private.newData(instance, block_move, block_attack)

    return instance
end

--========
-- Public
--========

---@param caster unit
function public:applyFlagsToCaster(caster)
    print(self)
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
private.disable_move_buff_type = Compiletime(function()
    return 1
end)
private.disable_move_type = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local WeAbility = ObjEdit.Ability
    print(ObjEdit:getAbilityId())
    print(ObjEdit:getAbilityId())
    print(ObjEdit:getAbilityId())
    local abil_type = WeAbility.new(ObjEdit:getAbilityId(), 'Aasl', 'DisableMovement')
    abil_type:setField(WeAbility.Field.Aasl_MovementSpeedFactor, 1, -100)
    abil_type:setField(WeAbility.Field.TargetsAllowed, 1, "self")
    abil_type:setField(WeAbility.Field.Buffs, 1, "")
    
    return abil_type:toRuntime()
end)
private.disable_move_id = ID(private.disable_move_type.id)

private.move_blocked = {}
private.attack_blocked = {}

---@param flag boolean
---@param target unit
function private.setMoveFlag(flag, target)
    if flag then
        if not private.move_blocked[target] then
            UnitAddAbility(target, private.disable_move_id)
            private.move_blocked[target] = true
        else
            Log.error(AbilityFlags, 'block move flag already applied.', 3)

        end
    else
        if private.move_blocked[target] then
            UnitRemoveAbility(target, private.disable_move_id)
            private.move_blocked[target] = nil
        else
            Log.error(AbilityFlags, 'unit does not have move block flag', 3)
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
            Log.error(AbilityFlags, 'block attack flag already applied.', 3)
        end
    else
        if private.attack_blocked[target] then
            UnitRemoveAbility(target, private.disable_attack_id)
            private.attack_blocked[target] = nil
        else
            Log.error(AbilityFlags, 'unit does not have attack block flag.', 3)
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
    print(tostring(instance)..' created')
end

---@param instance AbilityFlags
function private.freeData(instance)
    private[instance] = nil
end

return static