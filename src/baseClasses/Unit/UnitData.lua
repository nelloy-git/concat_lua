---@type DataBase
local DataBase = require('utils.DataBase')
---@type Settings
local Settings = require('utils.Settings')

---@class Unit
local Unit = {
    __type = 'UnitClass',
    __db = DataBase.new('userdata', 'Unit'),
    __unit_creation_funcs = {},
    __unit_removal_funcs = {}
}

local Unit_meta = {
    __type = 'Unit',
    __index = Unit,
    __call = Unit.new,
    __gc = Unit.destroy,
}

---@param self Unit
function Unit_meta.__tostring(self)
    return string.format('Unit %s (%s)', "TODO", ID2str(self:getId()))
end

---@param player player
---@param id string | integer
---@param x number
---@param y number
---@param face number
---@param is_dead boolean|nil
---@return Unit
function Unit.new(player, id, x, y, face, is_dead)
    id = ID(id)
    local unit_obj
    if is_dead then
        unit_obj = CreateCorpse(player, id, x, y, face)
    else
        unit_obj = CreateUnit(player, id, x, y, face)
    end
    ---@type Unit
    local unit = {
        __id = id,
        __unit_obj = unit_obj,
        __owning_player = player
    }
    setmetatable(unit, Unit_meta)
    Unit.__db:add(unit.__unit_obj, unit)

    --- Run functions added by submodules.
    for i = 1, #Unit.__unit_creation_funcs do
        if Settings.Unit.DebugCreationFunctions then
            runFuncInDebug(Unit.__unit_creation_funcs[i], unit)
        else
            Unit.__unit_creation_funcs[i](unit)
        end
    end

    return unit
end

function Unit:destroy()
    --- Run functions added by submodules.
    for i = 0, #Unit.__unit_removal_funcs do
        if Settings.Unit.DebugRemovalFunctions then
            runFuncInDebug(Unit.__unit_removal_funcs[i], self)
        else
            Unit.__unit_removal_funcs[i](self)
        end
    end

    Unit.__db:rm(self.__unit_obj)
    RemoveUnit(self.__unit_obj)
    self.__unit_obj = nil
end

---@param unit unit
function Unit.get(unit)
    Unit.__db:get(unit)
end

---@param func fun(unit:Unit):boolean
function Unit.addCreationFunction(func)
    table.insert(Unit.__unit_creation_funcs, #Unit.__unit_creation_funcs + 1, func)
end

---@param func fun(unit:Unit):boolean
function Unit.addRemovalFunction(func)
    table.insert(Unit.__unit_removal_funcs, #Unit.__unit_removal_funcs + 1, func)
end

---@return unit
function Unit:getObj()
    return self.__unit_obj
end

---@return number
function Unit:getId()
    return self.__id
end

---@return player
function Unit:getOwner()
    return GetOwningPlayer(self.__unit_obj)
end

---@return Unit
function Unit.GetLevelingUnit()
    return Unit.__db:get(GetLevelingUnit())
end

---@return Unit
function Unit.GetLearningUnit()
    return Unit.__db:get(GetLearningUnit())
end

---@return Unit
function Unit.GetRevivableUnit()
    return Unit.__db:get(GetRevivableUnit())
end

---@return Unit
function Unit.GetRevivingUnit()
    return Unit.__db:get(GetRevivingUnit())
end

---@return Unit
function Unit.GetAttacker()
    return Unit.__db:get(GetAttacker())
end

---@return Unit
function Unit.GetRescuer()
    return Unit.__db:get(GetRescuer())
end

---@return Unit
function Unit.GetDyingUnit()
    return Unit.__db:get(GetDyingUnit())
end

---@return Unit
function Unit.GetKillingUnit()
    return Unit.__db:get(GetKillingUnit())
end

---@return Unit
function Unit.GetDecayingUnit()
    return Unit.__db:get(GetDecayingUnit())
end

---@return Unit
function Unit.GetConstructingStructure()
    return Unit.__db:get(GetConstructingStructure())
end

---@return Unit
function Unit.GetCancelledStructure()
    return Unit.__db:get(GetCancelledStructure())
end
---@return Unit
function Unit.GetConstructedStructure()
    return Unit.__db:get(GetConstructedStructure())
end

---@return Unit
function Unit.GetResearchingUnit()
    return Unit.__db:get(GetResearchingUnit())
end

---@return Unit
function Unit.GetTrainedUnit()
    return Unit.__db:get(GetTrainedUnit())
end

---@return Unit
function Unit.GetDetectedUnit()
    return Unit.__db:get(GetDetectedUnit())
end

---@return Unit
function Unit.GetSummoningUnit()
    return Unit.__db:get(GetSummoningUnit())
end

---@return Unit
function Unit.GetSummonedUnit()
    return Unit.__db:get(GetSummonedUnit())
end

---@return Unit
function Unit.GetTransportUnit()
    return Unit.__db:get(GetTransportUnit())
end

---@return Unit
function Unit.GetLoadedUnit()
    return Unit.__db:get(GetLoadedUnit())
end

---@return Unit
function Unit.GetSellingUnit()
    return Unit.__db:get(GetSellingUnit())
end

---@return Unit
function Unit.GetSoldUnit()
    return Unit.__db:get(GetSoldUnit())
end

---@return Unit
function Unit.GetBuyingUnit()
    return Unit.__db:get(GetBuyingUnit())
end

---@return Unit
function Unit.GetChangingUnit()
    return Unit.__db:get(GetChangingUnit())
end

---@return Unit
function Unit.GetManipulatingUnit()
    return Unit.__db:get(GetManipulatingUnit())
end

---@return Unit
function Unit.GetOrderedUnit()
    return Unit.__db:get(GetOrderedUnit())
end

---@return Unit
function Unit.GetOrderTargetUnit()
    return Unit.__db:get(GetOrderTargetUnit())
end

---@return Unit
function Unit.GetSpellAbilityUnit()
    return Unit.__db:get(GetSpellAbilityUnit())
end

---@return Unit
function Unit.GetSpellTargetUnit()
    return Unit.__db:get(GetSpellTargetUnit())
end

---@return Unit
function Unit.GetTriggerUnit()
    return Unit.__db:get(GetTriggerUnit())
end

---@return Unit
function Unit.GetEventDamageSource()
    return Unit.__db:get(GetEventDamageSource())
end

---@return Unit
function Unit.GetEventTarget()
    return Unit.__db:get(GetEventTargetUnit())
end

---@return Unit
function Unit.GetEventDamageTarget()
    return Unit.__db:get(BlzGetEventDamageTarget())
end

return Unit