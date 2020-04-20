--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

--=======
-- Class
--=======

local AbilityOldTypeOld = Class.new('AbilityOldTypeOld')
---@class AbilityOldTypeOld
local public = AbilityOldTypeOld.public
---@class AbilityOldTypeOldClass
local static = AbilityOldTypeOld.static
---@type AbilityOldTypeOldClass
local override = AbilityOldTypeOld.override
local private = {}

--========
-- Static
--========

---@alias AbilityOldTargetingTypeEnum number

---@type table<string, AbilityOldTargetingTypeEnum>
static.TargetingType = {}
---@type AbilityOldTargetingTypeEnum
static.TargetingType.None = 1
---@type AbilityOldTargetingTypeEnum
static.TargetingType.Point = 2
---@type AbilityOldTargetingTypeEnum
static.TargetingType.Unit = 3
---@type AbilityOldTargetingTypeEnum
static.TargetingType.UnitOrPoint = 4
---@type AbilityOldTargetingTypeEnum
static.TargetingType.PointWithArea = 5
---@type AbilityOldTargetingTypeEnum
static.TargetingType.UnitWithArea = 6
---@type AbilityOldTargetingTypeEnum
static.TargetingType.UnitOrPointWithArea = 7

---@param target_type AbilityOldTargetingTypeEnum
---@return AbilityOldTypeOld
function override.new(target_type, child_instance)
    if not private.isTargetType(target_type) then
        Log.error(AbilityOldTypeOld, 'unknown AbilityOldTargetingTypeEnum.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityOldTypeOld)
    private.newData(instance, target_type)

    return instance
end

--========
-- Public
--========

--- Virtual function
---@param caster Unit
---@param target AbilityOldTarget
---@param lvl number
function public:targeting(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityOldTarget
---@param lvl number
---@return boolean
function public:start(caster, target, lvl)
    return true
end

--- Virtual function
---@param caster Unit
---@param target AbilityOldTarget
---@param lvl number
function public:casting(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityOldTarget
---@param lvl number
function public:cancel(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityOldTarget
---@param lvl number
function public:interrupt(caster, target, lvl)
end

--- Virtual function
---@param caster Unit
---@param target AbilityOldTarget
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

---@return AbilityOldTarget
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

---@param self AbilityOldTypeOld
---@param target_type AbilityOldTargetingTypeEnum
function private.newData(self, target_type)
    local priv = {
        target_type = target_type
    }

    private.data[self] = priv
end

return static