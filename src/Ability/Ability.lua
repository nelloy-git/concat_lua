local AbilityAPI = {}

local data = {}

---@param self Ability
---@param ability_type AbilityType
---@return nil
---@overload fun(self:Ability):AbilityType
local function abilType(self, ability_type)
    if ability_type == nil then
        return data[self].ability_type
    end
    data[self].ability_type = ability_type
end

---@param self Ability
---@return unit
local function abilOwner(self)
    return data[self].owner
end

---@param self Ability
---@return number
local function getAbilityLevel(self)
    return data[self].lvl
end

---@param self Ability
local function getAbilityName(self)
    local type = getAbilityType(self)
    local owner = getAbilityOwner(self)
    local lvl = getAbilityLevel(self)
    type:getName(owner, lvl)
end

---@param ability_type AbilityType
---@param owner unit
function AbilityAPI.new(ability_type, owner)
    ---@class Ability
    local Ability = {
        getType = getAbilityType,
        getOwner = getAbilityOwner,

        getName = function(self) return self:getType(). end,
    }

    data[Ability] = {
        ability_type = ability_type,
        owner = owner
    }

    return Ability
end

return AbilityAPI