--=========
-- Include
--=========

local Class = require(Lib.Class)

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

---@return AbilityType
function override.new(child_instance)
    local instance = child_instance or Class.allocate(AbilityType)

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
function public:getMaxCharges(owner, lvl)
    return private.default_max_charges
end

--- Virtual function
---@param owner Unit
---@param lvl number
---@return number
function public:getRange(owner, lvl)
    return private.default_range
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
private.default_max_charges = 1
private.default_range = 1000000

return static