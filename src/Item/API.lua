--=========
-- Include
--=========

---@type ItemClass
local Item = require('Item.Item')
---@type ItemModelClass
local ItemModel = require('Item.Model')
---@type ItemModelTypeClass
local ItemModelType = require('Item.ModelType')

--=============
--     API
--=============

---@class ItemAPI
local ItemAPI = {}

ItemAPI.ItemModelTypeEnum = ItemModelType.ItemType

ItemAPI.newItem = Item.new
ItemAPI.getItem = Item.getInstance
ItemAPI.newItemModel = ItemModel.new
ItemAPI.newItemModelType = ItemModelType.new

return ItemAPI