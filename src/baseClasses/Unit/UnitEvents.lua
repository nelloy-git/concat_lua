local DataBase = require('utils.DataBase')
local Unit = require('baseClasses.Unit.UnitData')
local Trigger = require('baseClasses.Trigger')

local __db = DataBase.new("userdata", "Trigger")
local __custom_db = DataBase.new("string", "Trigger")

---Returns trigger for any unit event.
---@param event playerunitevent
---@return Trigger
function Unit.getTrigger(event)
    local trigger
    if type(event) == 'userdata' then
        ---@type Trigger
        trigger = __db:get(event)

        if not trigger or not trigger:isValid() then
            trigger = Trigger.new()
            __db:add(event, trigger)
            for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
                trigger:addPlayerUnitEvent(event, Player(i))
            end
        end
    else
        ---@type Trigger
        trigger = __custom_db:get(event)

        if not trigger or not trigger:isValid() then
            trigger = Trigger.new()
            __custom_db:add(event, trigger)
        end
    end

    return trigger
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