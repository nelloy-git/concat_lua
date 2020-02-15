--=========
-- Include
--=========

---@type UnitInventoryBagClass
local Bag = require('Unit.Inventory.Bag')
---@type UnitInventoryEquipmentClass
local Equipment = require('Unit.Inventory.Equipment')
---@type UnitInvetoryEventClass
local Event = require('Unit.Inventory.Event')

--=============
--     API
--=============

---@class InventoryAPI
local InventoryAPI = {}

InventoryAPI.newBag = Bag.new
InventoryAPI.getBag = Bag.getInstance

return InventoryAPI