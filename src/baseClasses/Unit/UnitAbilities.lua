---@type Unit
local Unit = require('baseClasses.Unit.UnitData')
---@type UnitEvent
local UnitEvent = require('baseClasses.Unit.UnitEvent')
---@type UnitParameterContainer
local UnitParameterContainer = require('baseClasses.Unit.Parameters.Container')
---@type UnitParameterType
local UnitParameterType = require('baseClasses.Unit.Parameters.Type')

local UnitAbilities = {}
function UnitAbilities.init()
    ---@type Trigger
    UnitParameterContainer.init()
    Debug(type(UnitEvent.UNIT_CHANGED_PARAMETERS))
    UnitEvent.UNIT_CHANGED_PARAMETERS:addAction(runFuncInDebug, Unit.updateAbilities)
end

Unit.addCreationFunction(function(unit)
    if not unit.__abilities then
        unit.__abilities = {}
    end
end)

---@param ability Ability
function Unit:addAbility(ability)
    table.insert(self.__abilities, #self.__abilities + 1, ability)
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

function Unit:updateAbilitiesTooltips()
    for i = 1, #self.__abilities do
        self.__abilities[i]:updateTooltipForOwner(self)
    end
end

function Unit.updateAbilities()
    local unit = UnitEvent.GetUnitWithChangedParameters()
    local param_type = UnitEvent.GetChangedParameterType()

    if not unit.__abilities then
        unit.__abilities = {}
    end

    for i = 1, #unit.__abilities do
        unit.__abilities[i]:updateTooltipForOwner(unit)
    end

    if param_type == UnitParameterType.CD_REDUC then
        local value = UnitEvent.GetChangedParameterNewValue()
        for i = 1, #unit.__abilities do
            local abil = unit.__abilities[i]
            BlzSetUnitAbilityCooldown(unit:getObj(), abil:getId(), 1, (1 - value) * abil:getCooldown())
        end
    end
end

return UnitAbilities