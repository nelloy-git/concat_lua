local DataBase = require('utils.DataBase')
local PlayerUtils = require('baseClasses.PlayerUtils.PlayerUtilsData')
local Trigger = require('baseClasses.Trigger')

local __db = DataBase.new("userdata", "Trigger")

---Returns trigger for any unit event.
---@param event playerevent
---@return Trigger
function PlayerUtils.getTrigger(event)
    local trigger = __db:get(event)
    if not trigger then
        trigger = Trigger.new()
        for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
            trigger:addPlayerEvent(event, Player(i))
        end
        __db:add(event, trigger)
    end
    return trigger
end

function PlayerUtils.getKeyTrigger(key)
    local trigger = __db:get(key)
    if not trigger then
        trigger = Trigger.new()
        for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
            trigger:addPlayerKeyEvent(Player(i), key, 0, true)
            trigger:addPlayerKeyEvent(Player(i), key, 0, false)
            trigger:addPlayerKeyEvent(Player(i), key, 1, true)
            trigger:addPlayerKeyEvent(Player(i), key, 1, false)
            trigger:addPlayerKeyEvent(Player(i), key, 2, true)
            trigger:addPlayerKeyEvent(Player(i), key, 2, false)
            trigger:addPlayerKeyEvent(Player(i), key, 4, true)
            trigger:addPlayerKeyEvent(Player(i), key, 4, false)
        end
        __db:add(key, trigger)
    end
    return trigger
end