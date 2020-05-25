--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type AbilityTypeClass
local AbilityType = require('Ability.Type')
---@type TimerClass
local Timer = require('Timer.Timer')

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

--=========
-- Static
--=========

---@param owner unit
---@param ability_type AbilityType
---@param lvl number
---@param child_instance Ability | nil
---@return Ability
function override.new(owner, ability_type, lvl, child_instance)
    local instance = child_instance or Class.allocate(Ability)
    private.newData(instance, owner, ability_type, lvl)

    return instance
end

--========
-- Public
--========

public.casting_time_left = 0
public.charges_left = 0

---@param lvl number
function public:setLevel(lvl)
    private.data[self].lvl = lvl
end

---@return unit
function public:getOwner()
    return private.data[self].owner
end

---@return AbilityType
function public:getType()
    return private.data[self].ability_type
end

---@return number
function public:getLevel()
    return private.data[self].lvl
end

---@return string
function public:getName()
    local priv = private.data[self]
    ---@type AbilityType
    local abil_t = priv.ability_type
    return abil_t:getName(priv.owner, priv.lvl)
end

---@return string
function public:getIcon()
    local priv = private.data[self]
    ---@type AbilityType
    local abil_t = priv.ability_type
    return abil_t:getIcon(priv.owner, priv.lvl)
end

---@return string
function public:getDescription()
    local priv = private.data[self]
    ---@type AbilityType
    local abil_t = priv.ability_type
    return abil_t:getDescription(priv.owner, priv.lvl)
end

---@return number
function public:getFullCastingTime()
    local priv = private.data[self]
    ---@type AbilityType
    local abil_t = priv.ability_type
    return abil_t:getCastingTime(priv.owner, priv.lvl)
end

---@return number
function public:getFullCooldown()
    local priv = private.data[self]
    ---@type AbilityType
    local abil_t = priv.ability_type
    return abil_t:getCooldown(priv.owner, priv.lvl)
end

---@return number
function public:getManaCost()
    local priv = private.data[self]
    ---@type AbilityType
    local abil_t = priv.ability_type
    return abil_t:getManaCost(priv.owner, priv.lvl)
end

---@return number
function public:getChargesCost()
    local priv = private.data[self]
    ---@type AbilityType
    local abil_t = priv.ability_type
    return abil_t:getChargesCost(priv.owner, priv.lvl)
end

---@return number
function public:getRange()
    local priv = private.data[self]
    ---@type AbilityType
    local abil_t = priv.ability_type
    return abil_t:getRange(priv.owner, priv.lvl)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Ability
---@param owner Unit
---@param lvl number
---@param ability_type AbilityType
function private.newData(self, owner, ability_type, lvl)
    local priv = {
        owner = owner,
        ability_type = ability_type,
        lvl = lvl,
    }
    private.data[self] = priv
end

return static