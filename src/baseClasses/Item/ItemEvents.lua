---@type Item
local Item = require('baseClasses.Item.ItemData')
---@type Unit
local Unit = require('baseClasses.Unit.Unit')
---@type Trigger
local Trigger = require('baseClasses.Trigger')

local ItemEvents = {}

-- ============
--  Predefined
-- ============
local drop_item
local pickup_item
local use_item
local sell_item
local pawn_item

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