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
---@type SmartTimerClass
local SmartTimer = require('Timer.SmartTimer')
---@type AbilityAPI
--local AbilityAPI = require('Ability.API')
--local getActiveCasts = AbilityAPI.getActiveCasts

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

    -- Restore model if unit does not have empty slots.
    local empty_pos = unit:getBag():getEmpty()
    if not empty_pos then
        item = Item.ItemModel.new(item_type, item_x, item_y)
        item:placeModel(item_x, item_y)
        return
    end

    -- Add item to bag. Update UI if bag is showing.
    unit:getBag():set(item, empty_pos)

    if unit == InterfaceAPI.getTarget() then
        InterfaceAPI.Inventory:load(unit)
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

local PressedItemSlot = {}

---@param player player
---@param unit Unit
---@param item Item
---@param mouse_button mousebuttontype
function PressedItemSlot.callback(player, unit, item, mouse_button)
    if player ~= unit:getOwner() then
        return
    end

    if mouse_button == MOUSE_BUTTON_TYPE_RIGHT then
        local bag = unit:getBag()
        local equip = unit:getEquipment()

        local bag_pos = bag:find(item)
        local item_type = item:getType()
        -- Is in bag
        if bag_pos ~= nil then
            PressedItemSlot.equipItem(unit, item, bag_pos, item_type)
        -- Is in equipment
        elseif equip:get(item_type) == item then
            PressedItemSlot.unequipItem(unit, item, item_type)
        end

        PressedItemSlot.updateInterface(unit)
    end
end

---@param unit Unit
---@param item Item
---@param bag_pos number
---@param item_type ItemTypeEnum
function PressedItemSlot.equipItem(unit, item, bag_pos, item_type)
    local equiped = unit:getEquipment():get(item_type)
    unit:getEquipment():unequip(item_type)
    unit:getEquipment():equip(item)

    unit:getBag():set(equiped, bag_pos)
end

---@param unit Unit
---@param item Item
---@param item_type ItemTypeEnum
function PressedItemSlot.unequipItem(unit, item, item_type)
    local empty_pos = unit:getBag():getEmpty()
    if not empty_pos then
        return
    end

    unit:getEquipment():unequip(item_type)
    unit:getBag():set(item, empty_pos)
end

---@param unit Unit
function PressedItemSlot.updateInterface(unit)
    if unit == InterfaceAPI.getTarget() then
        InterfaceAPI.Inventory:load(unit)
    end
end

InterfaceAPI.addItemSlotSyncAction(PressedItemSlot.callback)