---@type Trigger
local Trigger = require('trigger.Trigger')

---@class UnitEvent
local UnitEvent = {
    __triggers = {}
}

local initialized = false
function UnitEvent.init()
    if initialized then return nil end
    
    ---@type Trigger
    UnitEvent.__triggers["AnyUnitDie"] = Trigger.new()
    UnitEvent.__triggers["AnyUnitDie"]:addEvent_AnyUnit("Death")
    ---@type Trigger
    UnitEvent.__triggers["AnyUnitStartChannelAbility"] = Trigger.new()
    UnitEvent.__triggers["AnyUnitStartChannelAbility"]:addEvent_AnyUnit("SpellChannel")
    ---@type Trigger
    UnitEvent.__triggers["AnyUnitIssuedAnyOrder"] = Trigger.new()
    UnitEvent.__triggers["AnyUnitIssuedAnyOrder"]:addEvent_AnyUnit("IssuedOrder")
    UnitEvent.__triggers["AnyUnitIssuedAnyOrder"]:addEvent_AnyUnit("IssuedOrderTarget")
    UnitEvent.__triggers["AnyUnitIssuedAnyOrder"]:addEvent_AnyUnit("IssuedOrderUnitTarget")
    UnitEvent.__triggers["AnyUnitIssuedAnyOrder"]:addEvent_AnyUnit("IssuedOrderPointTarget")
    ---@type Trigger
    UnitEvent.__triggers["AnyUnitSelected"] = Trigger.new()
    UnitEvent.__triggers["AnyUnitSelected"]:addEvent_AnyUnit("Selected")
    ---@type Trigger
    UnitEvent.__triggers["AnyUnitDeselected"] = Trigger.new()
    UnitEvent.__triggers["AnyUnitDeselected"]:addEvent_AnyUnit("Deselected")

    initialized = true
end

---@alias UnitEventName string
---| '"AnyUnitDie"'
---| '"AnyUnitIssuedAnyOrder"'
---| '"AnyUnitStartChannelAbility"'
---| '"AnyUnitSelected"'
---| '"AnyUnitDeselected"'

---@param name UnitEventName
function UnitEvent.getTrigger(name)
    if not initialized then UnitEvent.init() end
    return UnitEvent.__triggers[name]
end

return UnitEvent