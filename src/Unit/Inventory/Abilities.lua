--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityAPI
local AbilityAPI = require('Ability.API')
local Ability = AbilityAPI.Ability

--=======
-- Class
--=======

local UnitInventoryAbilities = Class.new('UnitInventoryAbilities')
---@class UnitInventoryAbilities
local public = UnitInventoryAbilities.public
---@class UnitInventoryAbilitiesClass
local static = UnitInventoryAbilities.static
---@type UnitInventoryAbilitiesClass
local override = UnitInventoryAbilities.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child_instance UnitInventoryAbilities | nil
---@return UnitInventoryAbilities
function static.new(owner, child_instance)
    print(owner)
    local instance = child_instance or Class.allocate(UnitInventoryAbilities)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@param ability_type AbilityType
---@param pos number
function public:set(ability_type, pos)
    local priv = private.data[self]
    priv.abil[pos] = Ability.new(priv.owner, ability_type)
end

---@param pos number
---@return Ability | nil
function public:get(pos)
    return private.data[self].abil[pos]
end

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self UnitInventoryAbilities
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,

        abil = {}
    }
    private.data[self] = priv
end

return static