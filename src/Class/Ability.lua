--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type AbilityCallbacksContainerClass
local AbilityCallbacksContainer = require('Class.Ability.Callbacks')
---@type AbilityFlagsClass
local AbilityFlagsContainer = require('Class.Ability.Flags')
---@type DataBaseClass
local DataBase = require('Class.DataBase')

---@type IconAssetClass
local ObjEdit
local tmp = Compiletime(function()
    ObjEdit = require('compiletime.ObjectEdit')
end)

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
    instance.flags = AbilityFlagsContainer.new()

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
        local msg = string.format("wrong target type.\n%s", ObjEdit.Utils.getErrorPos())
        Log(Log.Err, Ability, msg)
        return nil
    end

    abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)

    return abil:toRuntime()
end

--========
-- Public
--========

public.callbacks = "AbilityCallbacksContainer"
public.flags = "AbilityFlags"

---@return number
function public:getId()
    return private[self].id
end

---@param caster unit
---@return number
function public:getCastingTime(caster)
    local priv = private[self]

    if type(priv.casting_time) == 'function' then
        return priv.casting_time(caster)
    elseif type(priv.casting_time) == 'number' then
        return priv.casting_time
    end
    Log(Log.Wrn, Ability, 'can not get ability casting time.')
    return 0
end

---@param func fun(caster:unit):number | number
function public:setCastingTime(func)
    private[self].casting_time = func
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
        casting_time = nil,
    }
    private[instance] = priv
    private.DB:set(ID(id), instance)
end

return static