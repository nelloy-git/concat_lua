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
---@type ParameterAPI
local ParameterAPI = require('Parameter.API')
local ParamType = ParameterAPI.ParamType
local ValueType = ParameterAPI.ValueType

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
    if unit.Bag == InterfaceAPI.Bag:getLoaded() then
        InterfaceAPI.Bag:load(unit.Bag)
    end
end

if not IsCompiletime() then
    PickUpItem.trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        PickUpItem.trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_PICKUP_ITEM, Player(i))
    end
    PickUpItem.trigger:addAction(PickUpItem.callback)
end

--===================
-- Item slot pressed
--===================

local PressBagSlot = {}

---@param player player
---@param unit Unit
---@param item Item
---@param mouse_button mousebuttontype
function PressBagSlot.callback(player, unit, item, mouse_button)
    if player ~= unit:getOwner() then
        return
    end

    if mouse_button == MOUSE_BUTTON_TYPE_RIGHT then
        local bag = unit.Bag
        local equip = unit.Equipment

        local bag_pos = bag:find(item)
        local item_type = item:getType()
        -- Is in bag
        if bag_pos ~= nil then
            PressBagSlot.equipItem(unit, item, bag_pos)
        -- Is in equipment
        elseif equip:get(item_type) == item then
            PressBagSlot.unequipItem(unit, item, item_type)
        end

        if bag == InterfaceAPI.Bag:getLoaded() then
            InterfaceAPI.Bag:load(bag)
        end

        if equip == InterfaceAPI.Equipment:getLoaded() then
            InterfaceAPI.Equipment:load(equip)
        end
    end
end

---@param unit Unit
---@param item Item
---@param bag_pos number
function PressBagSlot.equipItem(unit, item, bag_pos)
    local equiped = unit.Equipment:get(item:getType())
    unit.Bag:set(equiped, bag_pos)
    unit.Equipment:equip(item)
end

---@param unit Unit
---@param item Item
---@param item_type ItemTypeEnum
function PressBagSlot.unequipItem(unit, item, item_type)
    local empty_pos = unit.Bag:getEmpty()
    if not empty_pos then
        return
    end

    unit.Equipment:unequip(item_type)
    unit.Bag:set(item, empty_pos)
end

InterfaceAPI.addItemSlotSyncAction(PressBagSlot.callback)
