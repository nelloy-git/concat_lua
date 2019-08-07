---@type Trigger
local Trigger = require('trigger.trigger')

---@class UnitEvent
local UnitEvent = {}

function UnitEvent.init()
    ---@type Trigger
    UnitEvent.death_trigger = Trigger.new()
    UnitEvent.death_trigger:addEvent_AnyUnitDeath()
    print('UnitEvent initialized')
end

return UnitEvent