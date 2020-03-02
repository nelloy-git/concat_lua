--=========
-- Include
--=========

---@type UnitInventoryBagClass
local Bag = require('Unit.Inventory.Bag')
---@type UnitInventoryBagClass
local Belt = require('Unit.Inventory.Belt')
---@type UnitInventoryEquipmentClass
local Equipment = require('Unit.Inventory.Equipment')
---@type UnitInventoryAbilitiesClass
local Abilities = require('Unit.Inventory.Abilities')

--=============
--     API
--=============

---@class InventoryAPI
local InventoryAPI = {}

InventoryAPI.Bag = Bag
InventoryAPI.Belt = Belt
InventoryAPI.Equipment = Equipment
InventoryAPI.Abilities = Abilities

return InventoryAPI