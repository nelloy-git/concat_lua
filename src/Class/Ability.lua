--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

require('Class.Ability.Event')

---@type AbilityCallbacksContainerClass
local AbilityCallbacksContainer = require('Class.Ability.Callbacks')
---@type AbilityFlagsClass
local AbilityFlagsContainer = require('Class.Ability.Flags')
---@type DataBaseClass
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

local Ability = Class.new('Ability')
---@class Ability
local public = Ability.public
---@class AbilityClass
local static = Ability.static
---@type AbilityClass
local override = Ability.override
local private = {}

--========
-- Static
--========

---@param child_instance Ability | nil
---@return Ability
function static.new(id, child_instance)
    local instance = child_instance or Class.allocate(Ability)
    private.newData(instance, id)

    instance.callbacks = AbilityCallbacksContainer.new()
    instance.flags = AbilityFlagsContainer.new(true, true)

    return instance
end

---@return Ability
function static.get(id)
    return private.DB:get(id)
end

---@alias AbilityDummyTarget string | "'none'" | "'point'" | "'unit'" | "'unitPoint'" | "'pointArea'" | '"unitArea"' | "'pointUnitArea'"

-- Compiletime only.
---@param target AbilityDummyTarget
---@param name string | nil
---@return table(string, any)
function static.createDummy(target, name)
    if not IsCompiletime() then
        Log(Log.Wrn, Ability, 'dummy ability can be created in Compiletime only.')
        return nil
    end

    local ObjEdit = require('compiletime.ObjectEdit')
    local WeAbility = ObjEdit.Ability
    local abil = WeAbility.new(ObjEdit.getAbilityId(), 'ANcl', name or 'Dummy ability')

    abil:setField(WeAbility.Field.TooltipNormal, 1, 'Dummy Ability')
    abil:setField(WeAbility.Field.TooltipNormalExtended, 1, 'No description.')
    abil:setField(WeAbility.Field.CastingTime, 1, 0)
    abil:setField(WeAbility.Field.Cooldown, 1, 1)
    abil:setField(WeAbility.Field.ArtCaster, 0, "")
    abil:setField(WeAbility.Field.ArtEffect, 0, "")
    abil:setField(WeAbility.Field.ArtSpecial, 0, "")
    abil:setField(WeAbility.Field.ArtTarget, 0, "")
    abil:setField(WeAbility.Field.AnimationNames, 0, "")
    abil:setField(WeAbility.Field.ANcl_FollowThroughTime, 1, 0)

    if target == 'none' then
        abil:setField(WeAbility.Field.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_None)
        abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
    elseif target == 'point' then
        abil:setField(WeAbility.Field.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Point)
        abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
    elseif target == 'unit' then
        abil:setField(WeAbility.Field.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Unit)
        abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
    elseif target == 'unitPoint' then
        abil:setField(WeAbility.Field.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_UnitOrPoint)
        abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
    elseif target == 'pointArea' then
        abil:setField(WeAbility.Field.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Point)
        abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible + WeAbility.ANcl_Options_AreaTarget)
    elseif target == 'unitArea' then
        abil:setField(WeAbility.Field.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Unit)
        abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible + WeAbility.ANcl_Options_AreaTarget)
    elseif target == 'pointUnitArea' then
        abil:setField(WeAbility.Field.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_UnitOrPoint)
        abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible + WeAbility.ANcl_Options_AreaTarget)
    else
        Log.error(Ability, 'wrong target type', 2)
        return nil
    end

    abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)

    return abil:toRuntime()
end

--========
-- Public
--========

---@type AbilityCallbacksContainer
public.callbacks = "AbilityCallbacksContainer"
---@type AbilityFlags
public.flags = "AbilityFlags"

---@return number
function public:getId()
    return private[self].id
end

--=========
-- Private
--=========

private.DB = DataBase.new('number', Ability)

---@param instance Ability
---@param id string | number
function private.newData(instance, id)
    local priv = {
        id = ID(id),
    }
    private[instance] = priv
    private.DB:set(ID(id), instance)
end

return static