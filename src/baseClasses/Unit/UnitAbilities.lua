---@type Ability
local Ability = require('baseClasses.Ability')
---@type Unit
local Unit = require('baseClasses.Unit.UnitData')

local UnitAbilities = {}

Unit.addCreationFunction(function(unit)
    if unit.__abilities then
        Debug("UnitAbilities error: Unit instance already has field __abilities.")
        return false
    end
    unit.__abilities = {}
end)

---@param ability Ability
function Unit:addAbility(ability)
    table.insert(self.__abilities, #self.__abilities, ability)
    UnitAddAbility(self:getObj(), ability:getId())
end

---@param ability Ability
---@return boolean
function Unit:removeAbility(ability)
    local pos = -1
    for i = 1, #self.__abilities do
        if self.__abilities[i] == ability then
            pos = i
            break
        end
    end

    if pos <= 0 then return false end

    table.remove(self.__abilities, pos)
    UnitRemoveAbility(self:getObj(), ability:getId())
    return true
end

---@param percent number
function Unit:setCooldownReduction(percent)
    for i = 1, #self.__abilities do
        local abil = self.__abilities[i]
        BlzSetUnitAbilityCooldown(self:getObj(), abil:getId(), 1, percent * abil:getCooldown())
    end
end