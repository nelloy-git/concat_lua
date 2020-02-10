--=========
-- Include
--=========

---@type UnitInventoryBagClass
local Bag = require('Class.Unit.Inventory.Bag')
---@type UnitInvetoryEventClass
local Event = require('Class.Unit.Inventory.Event')

--=============
--     API
--=============

---@class InventoryAPI
local InventoryApi = {}

InventoryApi.newBag = Bag.new
InventoryApi.getBag = Bag.getByOwner

return InventoryApi