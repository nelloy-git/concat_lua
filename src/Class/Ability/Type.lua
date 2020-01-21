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

local _ = Compiletime(function() private.WeAbility = require('compiletime.ObjectEdit').Ability end)

private.ANcl_TargetType = {
    [static.TargetType.None] = Compiletime(private.WeAbility.ANcl_TargetType_None),
    [static.TargetType.Point] = Compiletime(private.WeAbility.ANcl_TargetType_Point),
    [static.TargetType.PointWithArea] = Compiletime(private.WeAbility.ANcl_TargetType_Point),
    [static.TargetType.Unit] = Compiletime(private.WeAbility.ANcl_TargetType_Unit),
    [static.TargetType.UnitOrPoint] = Compiletime(private.WeAbility.ANcl_TargetType_UnitOrPoint),
    [static.TargetType.UnitOrPointWithArea] = Compiletime(private.WeAbility.ANcl_TargetType_UnitOrPoint),
    [static.TargetType.UnitWithArea] = Compiletime(private.WeAbility.ANcl_TargetType_Unit),
}

private.ANcl_Options = {
    [static.TargetType.None] = Compiletime(private.WeAbility.ANcl_Options_Visible),
    [static.TargetType.Point] = Compiletime(private.WeAbility.ANcl_Options_Visible),
    [static.TargetType.PointWithArea] = Compiletime(private.WeAbility.ANcl_Options_Visible + private.WeAbility.ANcl_Options_AreaTarget),
    [static.TargetType.Unit] = Compiletime(private.WeAbility.ANcl_Options_Visible),
    [static.TargetType.UnitOrPoint] = Compiletime(private.WeAbility.ANcl_Options_Visible),
    [static.TargetType.UnitOrPointWithArea] = Compiletime(private.WeAbility.ANcl_Options_Visible + private.WeAbility.ANcl_Options_AreaTarget),
    [static.TargetType.UnitWithArea] = Compiletime(private.WeAbility.ANcl_Options_Visible + private.WeAbility.ANcl_Options_AreaTarget),
}

---@param target_type any
---@return boolean
function private.isTargetType(target_type)
    for _, v in pairs(static.TargetType) do
        if target_type == v then
            return true
        end
    end
    return false
end

-- Compiletime only.
---@param target_type AbilityDummyTargetType
---@param name string | nil
---@return string
function private.createDummy(target_type, name)
    if not IsCompiletime() then
        Log.error(AbilityType, 'dummy ability can be created in compiletime only.', 2)
    end

    if not private.isTargetType(target_type) then
        Log.error(AbilityType, 'wrong target type.', 3)
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
    abil:setField(WeAbility.Field.ANcl_TargetType, 1, private.ANcl_TargetType[target_type])
    abil:setField(WeAbility.Field.ANcl_Options, 1, private.ANcl_Options[target_type])

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