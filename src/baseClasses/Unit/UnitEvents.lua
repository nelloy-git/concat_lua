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
        trigger = __db:get(event)
    else
        trigger = __custom_db:get(event)
    end

    if not trigger then
        trigger = Trigger.new()
        --Debug('AZAZAZA '..type(event))
        if type(event) == 'userdata' then
            __db:add(event, trigger)
            for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
                trigger:addPlayerUnitEvent(event, Player(i))
            end
        else
            __custom_db:add(event, trigger)
        end
    end
    return trigger
end