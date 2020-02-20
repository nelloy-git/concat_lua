--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

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
function static.new(owner, ability_type, child_instance)
    local instance = child_instance or Class.allocate(Ability)
    private.newData(instance, owner, ability_type)

    return instance
end

--========
-- Public
--========

---@param target AbilityTarget
function public:use(target)
    local priv = private.data[self]
    local owner_obj = priv.owner:getObj()

    UnitAddAbility(owner_obj, priv.ability_type:getId())
    Issue
end

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

---@return number
function public:getLevel()
    return private.data[self].lvl
end

---@return AbilityType
function public:getType()
    return private.data[self].ability_type
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param owner Unit
---@param self Ability
---@param ability_type AbilityType
function private.newData(self, owner, ability_type)
    local priv = {
        owner = owner,
        ability_type = ability_type,

        lvl = 1,
        got_order =
    }
    private.data[self] = priv
end

return static