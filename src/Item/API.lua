--=========
-- Include
--=========

---@type ItemClass
local Item = require('Item.Item')
---@type ItemModelClass
local ItemModel = require('Item.Model')

--=============
--     API
--=============

---@class ItemAPI
local ItemAPI = {}

-- Enums
ItemAPI.ItemType = Item.Type

-- Classes
ItemAPI.Item = Item
ItemAPI.ItemModel = ItemModel

-- Utils
ItemAPI.isTypeEquipable = Item.isTypeEquipable
ItemAPI.getTypeIcon = Item.getTypeIcon

return ItemAPI