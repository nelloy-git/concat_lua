--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

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

---@param uniq_name string
---@param target_type AbilityDummyTargetType
---@param child_instance AbilityType | nil
---@return AbilityType
function static.new(uniq_name, target_type, child_instance)
    local instance = child_instance or Class.allocate(AbilityType)
    private.newData(instance, uniq_name, target_type)

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
--- TODO
---@type AbilityFlags
public.flags = "AbilityFlags"

---@return number
function public:getId()
    return private[self].id
end

---@return string
function public:getName()
    return private[self].name
end

local Player = Player
local GetLocalPlayer = GetLocalPlayer
---@param tooltip string
---@param player_index number | nil
function public:setTooltip(tooltip, player_index)
    local priv = private[self]
    priv.tooltip = tooltip
    if IsCompiletime() then
        priv.we_abil:setField(private.WeAbility.Field.TooltipNormalExtended, 1, tooltip)
    else
        if not player_index or GetLocalPlayer() == Player(player_index) then
            BlzSetAbilityTooltip(priv.id, tooltip, 1)
        end
    end
end

---@return string
function public:getTooltip()
    return private[self].tooltip
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
---@param name string
---@return string
function private.createWc3Ability(name, target_type)
    if not private.isTargetType(target_type) then
        Log.error(AbilityType, 'wrong target type.', 3)
    end

    local id = require('compiletime.ObjectEdit').getAbilityId()
    local abil = private.WeAbility.new(id, 'ANcl', name)

    local Fields = private.WeAbility.Field
    abil:setField(Fields.TooltipNormal, 1, name)
    abil:setField(Fields.TooltipNormalExtended, 1, '')
    abil:setField(Fields.CastingTime, 1, 0)
    abil:setField(Fields.Cooldown, 1, 0)
    abil:setField(Fields.ArtCaster, 0, "")
    abil:setField(Fields.ArtEffect, 0, "")
    abil:setField(Fields.ArtSpecial, 0, "")
    abil:setField(Fields.ArtTarget, 0, "")
    abil:setField(Fields.AnimationNames, 0, "")
    abil:setField(Fields.ManaCost, 1, 0)
    abil:setField(Fields.ANcl_FollowThroughTime, 1, 0)
    abil:setField(Fields.ANcl_TargetType, 1, private.ANcl_TargetType[target_type])
    abil:setField(Fields.ANcl_Options, 1, private.ANcl_Options[target_type])

    return abil
end

---@param instance AbilityType
---@param uniq_name string | number
---@param target_type AbilityDummyTargetType
function private.newData(instance, uniq_name, target_type)
    local priv = {
        name = uniq_name,
        tooltip = '',
    }

    if IsCompiletime() then
        if private.CompiletimeData:get(uniq_name) then
            Log.error(AbilityType, 'name is not unique.', 2)
        end
        priv.we_abil = private.createWc3Ability(uniq_name, target_type)
        private.CompiletimeData:set(uniq_name, priv.we_abil:getId())
    end

    priv.id = ID(private.CompiletimeData:get(uniq_name))

    private[instance] = priv
    private.DB:set(priv.id, instance)
end

return static