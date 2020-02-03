--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

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

---@alias AbilityTargetType number
static.TargetType = {}
---@type AbilityTargetType
static.TargetType.None = 1
---@type AbilityTargetType
static.TargetType.Point = 2
---@type AbilityTargetType
static.TargetType.Unit = 3
---@type AbilityTargetType
static.TargetType.UnitOrPoint = 4
---@type AbilityTargetType
static.TargetType.PointWithArea = 5
---@type AbilityTargetType
static.TargetType.UnitWithArea = 6
---@type AbilityTargetType
static.TargetType.UnitOrPointWithArea = 7

---@alias AbilityCallbackType number
static.CallbackType = {}
--- Must return AbilityStatus
---@type AbilityCallbackType
static.CallbackType.START = 1
--- Must return AbilityStatus
---@type AbilityCallbackType
static.CallbackType.CASTING = 2
---@type AbilityCallbackType
static.CallbackType.CANCEL = 3
---@type AbilityCallbackType
static.CallbackType.FINISH = 4
---@type AbilityCallbackType
static.CallbackType.INTERRUPT = 5
--- Must return number
---@type AbilityCallbackType
static.CallbackType.GET_TIME = 6
--- Must return boolean
---@type AbilityCallbackType
static.CallbackType.CASTER_CAN_MOVE = 7
--- Must return boolean
---@type AbilityCallbackType
static.CallbackType.CASTER_CAN_ATTACK = 8
--- Must return boolean
---@type AbilityCallbackType
static.CallbackType.CASTER_CANCEL_OTHER_CASTS = 9
--- Must return boolean
---@type AbilityCallbackType
static.CallbackType.IGNORE_CANCEL_BY_OTHER_CASTS = 10

---@alias AbilityStatus number
static.Status = {}
---@type AbilityStatus
static.Status.OK = 1
---@type AbilityStatus
static.Status.CANCEL = 2
---@type AbilityStatus
static.Status.INTERRUPT = 3
---@type AbilityStatus
static.Status.FINISH = 4
---@type AbilityStatus
static.Status.REMOVE = 5

---@param uniq_name string
---@param target_type AbilityTargetType
---@return AbilityType
function static.new(uniq_name, target_type)
    local instance = Class.allocate(AbilityType)
    private.newData(instance, uniq_name, target_type)

    return instance
end

---@return AbilityType
function static.get(id)
    return private.DB:get(id)
end

--========
-- Public
--========

---@return number
function public:getId()
    return private.data[self].id
end

---@return string
function public:getName()
    return private.data[self].name
end

local Player = Player
local GetLocalPlayer = GetLocalPlayer
---@param tooltip string
---@param player_index number | nil
function public:setTooltip(tooltip, player_index)
    local priv = private.data[self]
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
    return private.data[self].tooltip
end

---@param cb_type AbilityCallbackType
---@param cb fun | nil
function public:setCallback(cb_type, cb)
    if not private.isCallbackType(cb_type) then
        Log.error(AbilityType, 'wrong callback type', 2)
    end

    if not (type(cb) == 'function' or type(cb) == nil) then
        Log.error(AbilityType, 'callback must be function or nil', 2)
    end

    private.data[self].callbacks[cb_type] = cb
end

---@param cb_type AbilityCallbackType
---@param cast_instance AbilityCastInstance
function public:runCallback(cb_type, cast_instance)
    if not private.isCallbackType(cb_type) then
        Log.error(AbilityType, 'wrong callback type', 2)
    end

    local priv = private.data[self]
    if not priv.callbacks[cb_type] then
        return private.default_callback[cb_type]
    end

    return priv.callbacks[cb_type](cast_instance)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.DB = DataBase.new('number', AbilityType)
private.CompiletimeData = CompiletimeData.new(AbilityType)
local _ = Compiletime(function()
    private.WeAbility = require('compiletime.ObjectEdit').Ability
end)

-- Compiletime only.
---@param target_type AbilityTargetType
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
    abil:setField(Fields.ArtCaster, 0, '')
    abil:setField(Fields.ArtEffect, 0, '')
    abil:setField(Fields.ArtSpecial, 0, '')
    abil:setField(Fields.ArtTarget, 0, '')
    abil:setField(Fields.AnimationNames, 0, '')
    abil:setField(Fields.ManaCost, 1, 0)
    abil:setField(Fields.ANcl_FollowThroughTime, 1, 0)
    abil:setField(Fields.ANcl_TargetType, 1, private.ANcl_TargetType[target_type])
    abil:setField(Fields.ANcl_Options, 1, private.ANcl_Options[target_type])

    return abil
end

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

private.default_callback = {
    [static.CallbackType.START] = static.Status.OK,
    [static.CallbackType.CASTING] = static.Status.OK,
    [static.CallbackType.CANCEL] = nil,
    [static.CallbackType.FINISH] = nil,
    [static.CallbackType.INTERRUPT] = nil,
    [static.CallbackType.GET_TIME] = 2,
    [static.CallbackType.CASTER_CAN_MOVE] = false,
    [static.CallbackType.CASTER_CAN_ATTACK] = false,
    [static.CallbackType.CASTER_CANCEL_OTHER_CASTS] = true,
    [static.CallbackType.IGNORE_CANCEL_BY_OTHER_CASTS] = false,
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

---@param cb_type any
---@return boolean
function private.isCallbackType(cb_type)
    for _, v in pairs(static.CallbackType) do
        if cb_type == v then
            return true
        end
    end
    return false
end

---@param instance AbilityType
---@param uniq_name string | number
---@param target_type AbilityTargetType
function private.newData(instance, uniq_name, target_type)
    local priv = {}

    if IsCompiletime() then
        if private.CompiletimeData:get(uniq_name) then
            Log.error(AbilityType, 'name is not unique.', 2)
        end
        priv.we_abil = private.createWc3Ability(uniq_name, target_type)
        private.CompiletimeData:set(uniq_name, priv.we_abil:getId())
    end

    priv.name = uniq_name
    priv.tooltip = ''
    priv.id = ID(private.CompiletimeData:get(uniq_name))
    priv.callbacks = {}

    private.data[instance] = setmetatable(priv, private.metatable)
    private.DB:set(priv.id, instance)
end

private.metatable = {
    __gc = function(self) end
}

return static