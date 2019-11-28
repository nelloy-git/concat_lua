--=========
-- Include
--=========

local Log = require('utils.Log')
---@type AbilityTypeCallbacksContainerClass
local AbilityTypeCallbacksContainer = require('Class.Ability.AbilityTypeCallbacksContainer')
---@type AbilityTypeFlagsClass
local AbilityTypeFlagsContainer = require('Class.Ability.AbilityTypeFlagsContainer')
---@type DataBaseClass
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

---@type AbilityTypeClass
local AbilityType = newClass('AbilityType')

---@class AbilityType
local public = AbilityType.public
---@class AbilityTypeClass
local static = AbilityType.static
---@type table
local override = AbilityType.override
---@type table(Ability, table)
local private = {}


---@type AbilityTypeCallbacksContainer
public.callbacks = "AbilityTypeCallbacksContainer"
---@type AbilityTypeFlagsClass
public.flags = "AbilityTypeFlags"

private.DB = DataBase.new('number', getClassName(AbilityType))
--=========
-- Methods
--=========

---@param instance_data table | nil
---@return AbilityType
function static.new(id, instance_data)
    local instance = instance_data or newInstanceData(AbilityType)

    instance.callbacks = AbilityTypeCallbacksContainer.new()
    instance.flags = AbilityTypeFlagsContainer.new()

    local priv = {
        id = ID(id),
        casting_time = nil,
    }
    private[instance] = priv
    private.DB:set(ID(id), instance)

    return instance
end

---@return AbilityType
function static.get(id)
    return private.DB:get(id)
end

-- Compiletime only.
---@param target string | "'none'" | "'point'" | "'unit'" | "'both'" | "'pointArea'" | '"unitArea"' | "'bothArea'"
---@param log_name string | nil
---@return table(string, any)
function static.createDummy(target, log_name)
    if not is_compiletime then
        Log(Log.Warn, getClassName(AbilityType), 'dummy ability can be created in compiletime only.')
        return nil
    end

    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    ---@type WeAbilityClass
    local WeAbility = WeObjEdit.Ability
    local abil = WeAbility.new(WeObjEdit.getAbilityId(), 'ANcl', log_name or 'Dummy ability')

    abil:setField(WeAbility.TooltipNormal, 1, 'Dummy Ability')
    abil:setField(WeAbility.TooltipNormalExtended, 1, 'No description.')
    abil:setField(WeAbility.CastingTime, 1, 0)
    abil:setField(WeAbility.Cooldown, 1, 1)
    abil:setField(WeAbility.Cooldown, 2, 1)
    abil:setField(WeAbility.ArtCaster, 0, "")
    abil:setField(WeAbility.ArtEffect, 0, "")
    abil:setField(WeAbility.ArtSpecial, 0, "")
    abil:setField(WeAbility.ArtTarget, 0, "")
    abil:setField(WeAbility.AnimationNames, 0, "")
    abil:setField(WeAbility.ANcl_FollowThroughTime, 1, 0)

    if target == 'none' then
        abil:setField(WeAbility.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_None)
        abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
    elseif target == 'unit' then
        abil:setField(WeAbility.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Unit)
        abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
    elseif target == 'point' then
        abil:setField(WeAbility.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Point)
        abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
    elseif target == 'both' then
        abil:setField(WeAbility.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_UnitOrPoint)
        abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
    elseif target == 'pointArea' then
        abil:setField(WeAbility.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Point)
        abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible + WeAbility.ANcl_Options_AreaTarget)
    elseif target == 'unitArea' then
        abil:setField(WeAbility.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Unit)
        abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible + WeAbility.ANcl_Options_AreaTarget)
    elseif target == 'bothArea' then
        abil:setField(WeAbility.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_UnitOrPoint)
        abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible + WeAbility.ANcl_Options_AreaTarget)
    else
        local msg = string.format("wrong target type.\n%s", WeObjEdit.Utils.getErrorPos())
        Log(Log.Err, getClassName(AbilityType), msg)
        return nil
    end

    abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)

    return abil:toRuntime()
end

---@return number
function public:getId()
    local priv = private[self]
    return priv.id
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
    return 0
end

---@param func fun(caster:unit):number | number
function public:setCastingTime(func)
    local priv = private[self]
    priv.casting_time = func
end

return AbilityType