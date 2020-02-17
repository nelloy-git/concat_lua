--=========
-- Include
--=========

---@type UnitInventoryBagClass
local Bag = require('Unit.Inventory.Bag')
---@type UnitInventoryEquipmentClass
local Equipment = require('Unit.Inventory.Equipment')

--=============
--     API
--=============

---@class InventoryAPI
local InventoryAPI = {}

InventoryAPI.Bag = Bag
InventoryAPI.Equipment = Equipment

return InventoryAPI