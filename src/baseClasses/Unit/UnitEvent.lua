local DataBase = require('utils.DataBase')
local Unit = require('baseClasses.Unit.UnitData')
local Trigger = require('baseClasses.Trigger')

local __db = DataBase.new("userdata", "Trigger")
local __custom_db = DataBase.new("string", "Trigger")

local __db = {
    origin = DataBase.new('userdata', 'boolean'),
    custom = DataBase.new('string', 'boolean')
}

---@class UnitEvent
local UnitEvent = newClass("UnitEvent")
local UnitEvent_meta = newMeta(UnitEvent)
UnitEvent.__triggers_db = DataBase.new('UnitEvent', 'Trigger')

function UnitEvent.init()
    UnitEvent.UNIT_ATTACKED = UnitEvent.new(EVENT_PLAYER_UNIT_ATTACKED)
    UnitEvent.UNIT_RESCUED = UnitEvent.new(EVENT_PLAYER_UNIT_RESCUED)
    UnitEvent.UNIT_DEATH = UnitEvent.new(EVENT_PLAYER_UNIT_DEATH)
    UnitEvent.UNIT_DECAY = UnitEvent.new(EVENT_PLAYER_UNIT_DECAY)
    UnitEvent.UNIT_DETECTED = UnitEvent.new(EVENT_PLAYER_UNIT_DETECTED)
    UnitEvent.UNIT_HIDDEN = UnitEvent.new(EVENT_PLAYER_UNIT_HIDDEN)
    UnitEvent.UNIT_SELECTED = UnitEvent.new(EVENT_PLAYER_UNIT_SELECTED)
    UnitEvent.UNIT_DESELECTED = UnitEvent.new(EVENT_PLAYER_UNIT_DESELECTED)
    UnitEvent.UNIT_CONSTRUCT_START = UnitEvent.new(EVENT_PLAYER_UNIT_CONSTRUCT_START)
    UnitEvent.UNIT_CONSTRUCT_CANCEL = UnitEvent.new(EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    UnitEvent.UNIT_CONSTRUCT_FINISH = UnitEvent.new(EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    UnitEvent.UNIT_UPGRADE_START = UnitEvent.new(EVENT_PLAYER_UNIT_UPGRADE_START)
    UnitEvent.UNIT_UPGRADE_CANCEL = UnitEvent.new(EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    UnitEvent.UNIT_UPGRADE_FINISH = UnitEvent.new(EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    UnitEvent.UNIT_TRAIN_START = UnitEvent.new(EVENT_PLAYER_UNIT_TRAIN_START)
    UnitEvent.UNIT_TRAIN_CANCEL = UnitEvent.new(EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    UnitEvent.UNIT_TRAIN_FINISH = UnitEvent.new(EVENT_PLAYER_UNIT_TRAIN_FINISH)
    UnitEvent.UNIT_RESEARCH_START = UnitEvent.new(EVENT_PLAYER_UNIT_RESEARCH_START)
    UnitEvent.UNIT_RESEARCH_CANCEL = UnitEvent.new(EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    UnitEvent.UNIT_RESEARCH_FINISH = UnitEvent.new(EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    UnitEvent.UNIT_ISSUED_ORDER = UnitEvent.new(EVENT_PLAYER_UNIT_ISSUED_ORDER)
    UnitEvent.UNIT_ISSUED_POINT_ORDER = UnitEvent.new(EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    UnitEvent.UNIT_ISSUED_TARGET_ORDER = UnitEvent.new(EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    UnitEvent.UNIT_ISSUED_UNIT_ORDER = UnitEvent.new(EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    UnitEvent.UNIT_SUMMON = UnitEvent.new(EVENT_PLAYER_UNIT_SUMMON)
    UnitEvent.UNIT_DROP_ITEM = UnitEvent.new(EVENT_PLAYER_UNIT_DROP_ITEM)
    UnitEvent.UNIT_PICKUP_ITEM = UnitEvent.new(EVENT_PLAYER_UNIT_PICKUP_ITEM)
    UnitEvent.UNIT_USE_ITEM = UnitEvent.new(EVENT_PLAYER_UNIT_USE_ITEM)
    UnitEvent.UNIT_LOADED = UnitEvent.new(EVENT_PLAYER_UNIT_LOADED)
    UnitEvent.UNIT_DAMAGED = UnitEvent.new(EVENT_PLAYER_UNIT_DAMAGED)
    UnitEvent.UNIT_DAMAGING = UnitEvent.new(EVENT_PLAYER_UNIT_DAMAGING)
    UnitEvent.UNIT_SELL = UnitEvent.new(EVENT_PLAYER_UNIT_SELL)
    UnitEvent.UNIT_CHANGE_OWNER = UnitEvent.new(EVENT_PLAYER_UNIT_CHANGE_OWNER)
    UnitEvent.UNIT_SELL_ITEM = UnitEvent.new(EVENT_PLAYER_UNIT_SELL_ITEM)
    UnitEvent.UNIT_SPELL_CHANNEL = UnitEvent.new(EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    UnitEvent.UNIT_SPELL_CAST = UnitEvent.new(EVENT_PLAYER_UNIT_SPELL_CAST)
    UnitEvent.UNIT_SPELL_EFFECT = UnitEvent.new(EVENT_PLAYER_UNIT_SPELL_EFFECT)
    UnitEvent.UNIT_SPELL_FINISH = UnitEvent.new(EVENT_PLAYER_UNIT_SPELL_FINISH)
    UnitEvent.UNIT_SPELL_ENDCAST = UnitEvent.new(EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    UnitEvent.UNIT_PAWN_ITEM = UnitEvent.new(EVENT_PLAYER_UNIT_PAWN_ITEM)
end

---@param event userdata|string
---@return UnitEvent
function UnitEvent.new(event)
    local unit_event = {
        __event_obj = event
    }
    setmetatable(unit_event, UnitEvent_meta)

    return unit_event
end

---@return boolean
function UnitEvent:isOrigin()
    return self.__event_obj == 'userdata'
end

function UnitEvent:run()
    local trigger = UnitEvent.getTrigger(self)
    trigger:execute()
end

---@param action fun():nil
---@param data any
function UnitEvent:addAction(action, data)
    local trigger = UnitEvent.getTrigger(self)
    trigger:addAction(action, data)
end

---Returns trigger for "any unit" event.
---@param event UnitEvent
---@return Trigger
function UnitEvent.getTrigger(event)
    local trigger = UnitEvent.__triggers_db:get(event)

    if not trigger or not trigger:isValid() then
        trigger = Trigger.new()
        UnitEvent.__triggers_db:add(event, trigger)
    end

    if event:isOrigin() then
        for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
            trigger:addPlayerUnitEvent(event.__event_obj, Player(i))
        end
    end

    return trigger
end

---@return Unit
function UnitEvent.GetLevelingUnit()
    return Unit.__db:get(GetLevelingUnit())
end

---@return Unit
function UnitEvent.GetLearningUnit()
    return Unit.__db:get(GetLearningUnit())
end

---@return Unit
function UnitEvent.GetRevivableUnit()
    return Unit.__db:get(GetRevivableUnit())
end

---@return Unit
function UnitEvent.GetRevivingUnit()
    return Unit.__db:get(GetRevivingUnit())
end

---@return Unit
function UnitEvent.GetAttacker()
    return Unit.__db:get(GetAttacker())
end

---@return Unit
function UnitEvent.GetRescuer()
    return Unit.__db:get(GetRescuer())
end

---@return Unit
function UnitEvent.GetDyingUnit()
    return Unit.__db:get(GetDyingUnit())
end

---@return Unit
function UnitEvent.GetKillingUnit()
    return Unit.__db:get(GetKillingUnit())
end

---@return Unit
function UnitEvent.GetDecayingUnit()
    return Unit.__db:get(GetDecayingUnit())
end

---@return Unit
function UnitEvent.GetConstructingStructure()
    return Unit.__db:get(GetConstructingStructure())
end

---@return Unit
function UnitEvent.GetCancelledStructure()
    return Unit.__db:get(GetCancelledStructure())
end
---@return Unit
function UnitEvent.GetConstructedStructure()
    return Unit.__db:get(GetConstructedStructure())
end

---@return Unit
function UnitEvent.GetResearchingUnit()
    return Unit.__db:get(GetResearchingUnit())
end

---@return Unit
function UnitEvent.GetTrainedUnit()
    return Unit.__db:get(GetTrainedUnit())
end

---@return Unit
function UnitEvent.GetDetectedUnit()
    return Unit.__db:get(GetDetectedUnit())
end

---@return Unit
function UnitEvent.GetSummoningUnit()
    return Unit.__db:get(GetSummoningUnit())
end

---@return Unit
function UnitEvent.GetSummonedUnit()
    return Unit.__db:get(GetSummonedUnit())
end

---@return Unit
function UnitEvent.GetTransportUnit()
    return Unit.__db:get(GetTransportUnit())
end

---@return Unit
function UnitEvent.GetLoadedUnit()
    return Unit.__db:get(GetLoadedUnit())
end

---@return Unit
function UnitEvent.GetSellingUnit()
    return Unit.__db:get(GetSellingUnit())
end

---@return Unit
function UnitEvent.GetSoldUnit()
    return Unit.__db:get(GetSoldUnit())
end

---@return Unit
function UnitEvent.GetBuyingUnit()
    return Unit.__db:get(GetBuyingUnit())
end

---@return Unit
function UnitEvent.GetChangingUnit()
    return Unit.__db:get(GetChangingUnit())
end

---@return Unit
function UnitEvent.GetManipulatingUnit()
    return Unit.__db:get(GetManipulatingUnit())
end

---@return Unit
function UnitEvent.GetOrderedUnit()
    return Unit.__db:get(GetOrderedUnit())
end

---@return Unit
function UnitEvent.GetOrderTargetUnit()
    return Unit.__db:get(GetOrderTargetUnit())
end

---@return Unit
function UnitEvent.GetSpellAbilityUnit()
    return Unit.__db:get(GetSpellAbilityUnit())
end

---@return Unit
function UnitEvent.GetSpellTargetUnit()
    return Unit.__db:get(GetSpellTargetUnit())
end

---@return Unit
function UnitEvent.GetTriggerUnit()
    return Unit.__db:get(GetTriggerUnit())
end

---@return Unit
function UnitEvent.GetEventDamageSource()
    return Unit.__db:get(GetEventDamageSource())
end

---@return Unit
function UnitEvent.GetEventTarget()
    return Unit.__db:get(GetEventTargetUnit())
end

---@return Unit
function UnitEvent.GetEventDamageTarget()
    return Unit.__db:get(BlzGetEventDamageTarget())
end

return UnitEvent