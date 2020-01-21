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
---@type CompiletimeDataClass
local CompiletimeData = require('Class.CompiletimeData')

--=======
-- Class
--=======

local AbilityType = Class.new('AbilityType')
---@class AbilityType
local public = AbilityType.public
---@class AbilityTypeClass
local static = AbilityType.static
---@type AbilityTypeClass
local override = AbilityType.override
local private = {}

--========
-- Static
--========

---@alias AbilityDummyTargetType string
---@type AbilityDummyTargetType[]
static.TargetType = {
    None = 1,
    Point = 2,
    Unit = 3,
    UnitOrPoint = 4,
    PointWithArea = 5,
    UnitWithArea = 6,
    UnitOrPointWithArea = 7
}

---@param child_instance AbilityType | nil
---@return AbilityType
function static.new(uniq_name, target_type, child_instance)
    if IsCompiletime() then
        local id = private.createDummy(target_type, uniq_name)
        private.CompiletimeData:set(uniq_name, id)
    end

    local instance = child_instance or Class.allocate(AbilityType)
    local id = private.CompiletimeData:get(uniq_name)
    private.newData(instance, id)

    instance.callbacks = AbilityCallbacksContainer.new()
    instance.flags = AbilityFlagsContainer.new(true, true)

    return instance
end

---@return AbilityType
function static.get(id)
    return private.DB:get(id)
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

private.DB = DataBase.new('number', AbilityType)
private.CompiletimeData = CompiletimeData.new(AbilityType)

local WeAbility = Compiletime()

private.ANcl_TargetType = {
    [static.TargetType.None] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_None),
    [static.TargetType.Point] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_Point),
    [static.TargetType.PointWithArea] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_Point),
    [static.TargetType.Unit] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_Unit),
    [static.TargetType.UnitOrPoint] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_UnitOrPoint),
    [static.TargetType.UnitOrPointWithArea] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_UnitOrPoint),
    [static.TargetType.UnitWithArea] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_Unit),
}

private.ANcl_Options = {
    [static.TargetType.None] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_Options_Visible),
    [static.TargetType.Point] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_Options_Visible),
    [static.TargetType.PointWithArea] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_Point),
    [static.TargetType.Unit] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_Options_Visible),
    [static.TargetType.UnitOrPoint] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_Options_Visible),
    [static.TargetType.UnitOrPointWithArea] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_UnitOrPoint),
    [static.TargetType.UnitWithArea] = Compiletime(require('compiletime.ObjectEdit').WeAbility.ANcl_TargetType_Unit),
}

-- Compiletime only.
---@param target AbilityDummyTargetType
---@param name string | nil
---@return table(string, any)
function private.createDummy(target, name)
    if not IsCompiletime() then
        Log.error(AbilityType, 'dummy ability can be created in compiletime only.', 2)
    end

    local ObjEdit = require('compiletime.ObjectEdit')
    local WeAbility = ObjEdit.Ability
    local id = ObjEdit.getAbilityId()
    local abil = WeAbility.new(id, 'ANcl', name or 'Dummy ability')

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
        Log.error(AbilityType, 'wrong target type', 2)
        return nil
    end

    abil:setField(WeAbility.Field.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)

    return id
end

---@param instance AbilityType
---@param id string | number
function private.newData(instance, id)
    id = ID(id)
    local priv = {
        id = id,
    }
    private[instance] = priv
    private.DB:set(id, instance)
end

return static