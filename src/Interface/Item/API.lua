--=========
-- Include
--=========

---@type InterfaceItemBagClass
local Bag = require('Interface.Item.Bag')
---@type InterfaceItemEventClass
local Event = require('Interface.Item.Event')

--=============
--     API
--=============

---@class InterfaceItemAPI
local InterfaceItemAPI = {}

InterfaceItemAPI.newBag = Bag.new

InterfaceItemAPI.setOnBagItemPressedCallback = Event.setPressedBagSlotCallback

return InterfaceItemAPI