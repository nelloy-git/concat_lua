--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type TriggerClass
local Trigger = require('Utils.Trigger')
---@type UnitInventoryBagClass
local UnitInventoryBag = require('Unit.Inventory.Bag')
---@type ItemAPI
local ItemAPI = require('Item.API')
local Item = ItemAPI.Item
---@type UnitAPI
local UnitAPI = require('Unit.API')
local Unit = UnitAPI.Unit
---@type InterfaceAPI
local InterfaceAPI = require('Interface.API')

--==============
-- Pick up item
--==============

local PickUpItem = {}

function PickUpItem.callback()
    local item = Item.getInstance(GetManipulatedItem())
    local unit = Unit.getInstance(GetManipulatingUnit())

    -- Destroy current item model.
    local item_model = item:getModel()
    local item_type = item_model:getType()
    local item_x = item_model:getX()
    local item_y = item_model:getY()
    item_model:destroy()
    item:setModel(nil)

    -- Restore model if unit does not have bag.
    if not unit.Bag then
        item = Item.ItemModel.new(item_type, item_x, item_y)
        item:placeModel(item_x, item_y)
        return
    end

    -- Restore model if unit does not have empty slots.
    local empty_pos = unit.Bag:getEmpty()
    if not empty_pos then
        item = Item.ItemModel.new(item_type, item_x, item_y)
        item:placeModel(item_x, item_y)
        return
    end

    -- Add item to bag. Update UI if bag is showing.
    unit.Bag:set(item, empty_pos)
    if unit.Bag == InterfaceAPI.Bag:getLoadedBag() then
        InterfaceAPI.Bag:loadBag(unit.Bag)
    end
end

if not IsCompiletime() then
    PickUpItem.trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        PickUpItem.trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_PICKUP_ITEM, Player(i))
    end
    PickUpItem.trigger:addAction(PickUpItem.callback)
end

--============
-- Equip item
--============

