local DataBase = require('utils.DataBase')
local Unit = require('baseClasses.Unit.UnitData')
local Trigger = require('baseClasses.Trigger')

local __db = DataBase.new("userdata", "Trigger")

---Returns trigger for any unit event.
---@param event playerunitevent
---@return Trigger
function Unit.getTrigger(event)
    local trigger = __db:get(event)
    if not trigger then
        trigger = Trigger.new()
        for i = 0, bj_MAX_PLAYERS - 1 do
            trigger:addPlayerUnitEvent(event, Player(i))
        end
        __db:add(event, trigger)
    end
    return trigger
end