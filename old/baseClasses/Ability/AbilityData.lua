---@type DataBase
local DataBase = require('utils.DataBase')
---@type Unit
local Unit = require('baseClasses.Unit')

---@class Ability
local Ability = {
    __type = 'AbilityClass',
    __db = DataBase.new('number', 'Ability'),
}
local Ability_meta = {
    __type = 'Ability',
    __index = Ability
}

---@param self Ability
---@return string
function Ability_meta.__tostring(self)
    return string.format('%s %s (%s)',self.__type, self.__name, ID2str(self.__id))
end

---Create new Ability instance.
---@param id string|number
---@return Ability
function Ability.new(id)
    ---@type Ability
    local ability = {
        __id = ID(id),
    }
    setmetatable(ability, Ability_meta)
    Ability.__db:add(ID(id), ability)

    return ability
end

---@param id number
---@return Ability
function Ability.get(id)
    return Ability.__db:get(id)
end

---@return number
function Ability:getId()
    return self.__id
end

---@return Ability
function Ability.GetSpellAbility()
    return Ability.get(GetSpellAbilityId())
end

return Ability