--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

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
    local instance = child_instance or Class.allocate(UnitInventoryAbilities)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@param ability AbilityType
---@param pos number
function public:setAbility(ability, pos)
    private.data[self].abil[pos] = ability
end

---@param pos number
---@return AbilityType | nil
function public:getAbility(pos)
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
function private.newData(self, owner)
    local priv = {
        owner = owner,

        abil = {}
    }
    private.data[self] = priv
end

return static