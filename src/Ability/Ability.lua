--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

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

---@param owner Unit
---@param ability_type AbilityType
---@param child_instance Ability | nil
---@return Ability
function override.new(owner, ability_type, child_instance)
    local instance = child_instance or Class.allocate(Ability)
    private.newData(instance, owner, ability_type)

    return instance
end

--========
-- Public
--========

---@param lvl number
function public:setLevel(lvl)
    private.data[self].lvl = lvl
end

---@return string
function public:getName()
    local priv = private.data[self]
    return priv.ability_type:getName(priv.owner, priv.lvl)
end

---@return string
function public:getDescription()
    local priv = private.data[self]
    return priv.ability_type:getDescription(priv.owner, priv.lvl)
end

---@return string
function public:getIcon()
    local priv = private.data[self]
    return priv.ability_type:getIcon(priv.owner, priv.lvl)
end

---@return number
function public:getLevel()
    return private.data[self].lvl
end

---@return AbilityType
function public:getType()
    return private.data[self].ability_type
end

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Ability
---@param owner Unit
---@param ability_type AbilityType
function private.newData(self, owner, ability_type)
    local priv = {
        owner = owner,
        ability_type = ability_type,

        lvl = 1,
    }
    private.data[self] = priv
end

return static