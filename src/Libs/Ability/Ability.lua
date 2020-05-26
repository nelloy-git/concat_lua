--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType

---@type AbilityTypeClass
local AbilityType = require(lib_modname..'.Type')

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
    checkType(owner, 'unit', 'owner')
    checkType(ability_type, AbilityType, 'ability_type')
    checkType(lvl, 'number', 'lvl')
    if child_instance then
        checkType(child_instance, Ability, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Ability)
    private.newData(instance, owner, ability_type, lvl)

    return instance
end

--========
-- Public
--========

---@param lvl number
function public:setLevel(lvl)
    private.data[self].lvl = lvl
end

---@return number
function public:getLevel()
    return private.data[self].lvl
end

---@return unit
function public:getOwner()
    return private.data[self].owner
end

---@return AbilityType
function public:getType()
    return private.data[self].ability_type
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