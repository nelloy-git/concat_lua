--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type AbilityTargetNoneClass
local TargetNone = require('Ability.Target.None')
---@type AbilityTargetPointClass
local TargetPoint = require('Ability.Target.Point')
---@type AbilityTargetUnitClass
local TargetUnit = require('Ability.Target.Unit')
---@type AbilityTargetDestructableClass
local TargetDestructable = require('Ability.Target.Destructable')
---@type AbilityTargetItemClass
local TargetItem = require('Ability.Target.Item')
---@type CompiletimeDataClass
local CompiletimeData = require('Utils.CompiletimeData')

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

---@alias AbilityTargetingTypeEnum number

---@type table<string, AbilityTargetingTypeEnum>
static.TargetingType = {}
---@type AbilityTargetingTypeEnum
static.TargetingType.None = 1
---@type AbilityTargetingTypeEnum
static.TargetingType.Point = 2
---@type AbilityTargetingTypeEnum
static.TargetingType.Unit = 3
---@type AbilityTargetingTypeEnum
static.TargetingType.UnitOrPoint = 4
---@type AbilityTargetingTypeEnum
static.TargetingType.PointWithArea = 5
---@type AbilityTargetingTypeEnum
static.TargetingType.UnitWithArea = 6
---@type AbilityTargetingTypeEnum
static.TargetingType.UnitOrPointWithArea = 7

---@param uniq_name string
---@param target_type AbilityTargetingTypeEnum
---@return AbilityType
function static.new(uniq_name, target_type, child_instance)
    if not private.isTargetType(target_type) then
        Log.error(AbilityType, 'unknown AbilityTargetingTypeEnum.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityType)
    private.newData(instance, uniq_name, target_type)

    return instance
end

---@return number
function static.getOrderId()
    return private.orderId
end

---@return AbilityType
function static.getInstance(id)
    return private.id2abil[id]
end

--========
-- Public
--========

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
---@return AbilityStatusEnum
function public:start(caster, target, lvl)
    return 1
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
---@return AbilityStatusEnum
function public:cast(caster, target, lvl)
    return 1
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function public:cancel(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function public:interrupt(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function public:finish(caster, target, lvl)
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return string
function public:getName(owner, lvl)
    return private.data[self].name
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return string
function public:getIcon(owner, lvl)
    return private.default_icon
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return string
function public:getDescription(owner, lvl)
    return private.default_description
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getCastingTime(owner, lvl)
    return private.default_casting_time
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getCooldown(owner, lvl)
    return private.default_cooldown
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getManaCost(owner, lvl)
    return private.default_mana_cost
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getRange(owner, lvl)
    return private.default_range
end

---@return AbilityTarget
function public:getEventTarget()
    return private.getEventTarget[private.data[self].target_type]()
end

---@return number
function public:getId()
    return private.data[self].id
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.id2abil = setmetatable({}, {__mode = 'kv'})

private.default_icon = ''
private.default_description = ''
private.default_casting_time = 1
private.default_cooldown = 0
private.default_mana_cost = 0
private.default_range = 1000000

private.CompiletimeData = CompiletimeData.new(AbilityType)

if not IsCompiletime() then
    private.local_player = GetLocalPlayer()
end

private.getEventTarget = {
    [static.TargetingType.None] = function()
        return TargetNone.new()
    end,

    [static.TargetingType.Point] = function()
        return TargetPoint.new(GetSpellTargetX(), GetSpellTargetY())
    end,

    [static.TargetingType.Unit] = function()
        return TargetUnit.new(GetSpellTargetUnit())
    end,

    [static.TargetingType.UnitOrPoint] = function()
        local unit = GetSpellTargetUnit()
        if unit then
            return TargetUnit.new(unit)
        else
            return TargetPoint.new(GetSpellTargetX(), GetSpellTargetY())
        end
    end,

    [static.TargetingType.PointWithArea] = function()
        return TargetPoint.new(GetSpellTargetX(), GetSpellTargetY())
    end,

    [static.TargetingType.UnitWithArea] = function()
        return TargetUnit.new(GetSpellTargetUnit())
    end,

    [static.TargetingType.UnitOrPointWithArea] = function()
        local unit = GetSpellTargetUnit()
        if unit then
            return TargetUnit.new(unit)
        else
            return TargetPoint.new(GetSpellTargetX(), GetSpellTargetY())
        end
    end,
}

---@param target_type any
---@return boolean
function private.isTargetType(target_type)
    for _, v in pairs(static.TargetingType) do
        if target_type == v then
            return true
        end
    end
    return false
end

---@param self AbilityType
---@param uniq_name string | number
---@param target_type AbilityTargetingTypeEnum
function private.newData(self, uniq_name, target_type)
    local priv = {}

    if IsCompiletime() then
        if private.CompiletimeData:get(uniq_name) then
            Log.error(AbilityType, 'name is not unique.', 2)
        end
        priv.we_abil = private.createWc3Ability(uniq_name, target_type)
        private.CompiletimeData:set(uniq_name, priv.we_abil:getId())
    end

    priv.name = uniq_name
    priv.id = ID(private.CompiletimeData:get(uniq_name))
    priv.target_type = target_type

    private.data[self] = priv
    private.id2abil[priv.id] = self
end

--=============
-- Compiletime
--=============

private.ANcl_TargetType = {
    [static.TargetingType.None] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_None),
    [static.TargetingType.Point] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_Point),
    [static.TargetingType.PointWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_Point),
    [static.TargetingType.Unit] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_Unit),
    [static.TargetingType.UnitOrPoint] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_UnitOrPoint),
    [static.TargetingType.UnitOrPointWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_UnitOrPoint),
    [static.TargetingType.UnitWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_TargetType_Unit),
}

private.ANcl_Options = {
    [static.TargetingType.None] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible),
    [static.TargetingType.Point] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible),
    [static.TargetingType.PointWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible + require('compiletime.ObjectEdit').Ability.ANcl_Options_AreaTarget),
    [static.TargetingType.Unit] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible),
    [static.TargetingType.UnitOrPoint] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible),
    [static.TargetingType.UnitOrPointWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible + require('compiletime.ObjectEdit').Ability.ANcl_Options_AreaTarget),
    [static.TargetingType.UnitWithArea] = Compiletime(require('compiletime.ObjectEdit').Ability.ANcl_Options_Visible + require('compiletime.ObjectEdit').Ability.ANcl_Options_AreaTarget),
}

private.orderId = Compiletime(function()
    return require('compiletime.ObjectEdit').getOrderId()
end)
if not IsCompiletime() then
    private.orderId = OrderId(private.orderId)
end

-- Compiletime only.
---@param target_type AbilityTargetingTypeEnum
---@param name string
---@return string
function private.createWc3Ability(name, target_type)
    if not private.isTargetType(target_type) then
        Log.error(AbilityType, 'wrong target type.', 3)
    end

    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local WeAbility = ObjEdit.Ability
    local Field = WeAbility.Field

    local id = ObjEdit.getAbilityId()
    local abil = WeAbility.new(id, 'ANcl', name)

    abil:setField(Field.TooltipNormal, 1, name)
    abil:setField(Field.TooltipNormalExtended, 1, '')
    abil:setField(Field.IconNormal, 0, '')
    abil:setField(Field.CastingTime, 1, 0)
    abil:setField(Field.Cooldown, 1, 0)
    abil:setField(Field.ArtCaster, 0, '')
    abil:setField(Field.ArtEffect, 0, '')
    abil:setField(Field.ArtSpecial, 0, '')
    abil:setField(Field.ArtTarget, 0, '')
    abil:setField(Field.AnimationNames, 0, '')
    abil:setField(Field.ManaCost, 1, 0)
    abil:setField(Field.CastRange, 1, 1000000)
    abil:setField(Field.HotkeyNormal, 0, '')
    abil:setField(Field.ANcl_FollowThroughTime, 1, 0)
    abil:setField(Field.ANcl_TargetType, 1, private.ANcl_TargetType[target_type])
    abil:setField(Field.ANcl_Options, 1, private.ANcl_Options[target_type])
    abil:setField(Field.ANcl_BaseOrderID, 1, private.orderId)

    return abil
end

return static