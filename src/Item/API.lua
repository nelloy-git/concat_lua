--=========
-- Include
--=========

---@type ItemClass
local Item = require('Item.Item')

--=============
--     API
--=============

---@class ItemAPI
local ItemAPI = {}

ItemAPI.newItem = Item.new

return ItemAPI