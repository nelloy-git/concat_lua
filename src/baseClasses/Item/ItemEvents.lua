---@type DataBase
local DataBase = require('utils.DataBase')
---@type Item
local Item = require('baseClasses.Item.ItemData')
---@type Trigger
local Trigger = require('baseClasses.Trigger')

local __db = DataBase.new("userdata", "Trigger")
local __custom_db = DataBase.new("string", "Trigger")

---Returns trigger for any unit event.
---@param event pla
---@return Trigger
function Item.getTrigger(event)
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

function ItemEvents.init()
    local any_unit_drop_item = Unit.getTrigger(EVENT_PLAYER_UNIT_DROP_ITEM)
    any_unit_drop_item:addAction(drop_item)

    local any_unit_pickup_item = Unit.getTrigger(EVENT_PLAYER_UNIT_PICKUP_ITEM)
    any_unit_pickup_item:addAction(pickup_item)

    local any_unit_use_item = Unit.getTrigger(EVENT_PLAYER_UNIT_USE_ITEM)
    any_unit_use_item:addAction(use_item)

    local any_unit_sell_item = Unit.getTrigger(EVENT_PLAYER_UNIT_SELL_ITEM)
    any_unit_sell_item:addAction(sell_item)

    local any_unit_pawn_item = Unit.getTrigger(EVENT_PLAYER_UNIT_PAWN_ITEM)
    any_unit_pawn_item:addAction(pawn_item)
end

drop_item = function()
end

pickup_item = function()
end

use_item = function()
end

sell_item = function()
end

pawn_item = function()
end

return ItemEvents