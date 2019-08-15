---@type Trigger
local Trigger = require('trigger.trigger')

---@class UnitEvent
local UnitEvent = {}

function UnitEvent.init()
    ---@type Trigger
    UnitEvent.die = Trigger.new()
    UnitEvent.die:addEvent_AnyUnitDeath()
    print('UnitEvent initialized')
end

return UnitEvent