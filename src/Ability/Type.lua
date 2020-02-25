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

---@param target_type AbilityTargetingTypeEnum
---@return AbilityType
function static.new(target_type, child_instance)
    if not private.isTargetType(target_type) then
        Log.error(AbilityType, 'unknown AbilityTargetingTypeEnum.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityType)
    private.newData(instance, target_type)

    return instance
end

--========
-- Public
--========

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function public:targeting(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
---@return boolean
function public:start(caster, target, lvl)
    return true
end

--- Virtual function
---@param caster Unit
---@param target AbilityTarget
---@param lvl number
function public:casting(caster, target, lvl)
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
function public:getChargesCost(owner, lvl)
    return private.default_charges_cost
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getRange(owner, lvl)
    return private.default_range
end

---@return AbilityTarget
function public:getTargetType()
    return private.data[self].target_type
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.default_icon = ''
private.default_description = ''
private.default_casting_time = 1
private.default_cooldown = 0
private.default_mana_cost = 0
private.default_charges_cost = 1
private.default_range = 1000000

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
---@param target_type AbilityTargetingTypeEnum
function private.newData(self, target_type)
    local priv = {
        target_type = target_type
    }

    private.data[self] = priv
end

return static