---@type Trigger
local Trigger = require('trigger.trigger')

---@class UnitEvent
local UnitEvent = {
    __triggers = {}
}

local initialized = false

function UnitEvent.init()
    if initialized then return nil end
    ---@type Trigger
    UnitEvent.__triggers["AnyUnitDie"] = Trigger.new()
    UnitEvent.__triggers["AnyUnitDie"]:addEvent_AnyUnitDeath()
    initialized = true
end

---@alias UnitEventName string
---| '"AnyUnitDie"'

---@param name UnitEventName
function UnitEvent.getTrigger(name)
    if not initialized then UnitEvent.init() end
    return UnitEvent.__triggers[name]
end

return UnitEvent