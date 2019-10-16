--==========
-- Includes
--==========

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Item
local Item = require('Class.Item.Main')
---@type Settings
local Settings = require('utils.Settings')

--========
-- Module
--========

local base_id = compiletime(function()
    local weObj = require('compiletime.objEdit.objEdit')
    local id = weObj.Utils.nextItemId()
    local we_item = weObj.Item.Item.new(id, Settings.Item.CompiletimeBaseId)
end)

local __wc3_to_Item = DataBase.new('userdata', 'Item')
local __Item_to_wc3 = DataBase.new('Item', 'userdata')

---@param item Item
---@param x number
---@param y number
function Item:createObject(item, x, y)
    local model = CreateItem(Settings.Item.CompiletimeBaseId, x, y)

    __wc3_to_Item:add(model, self)
    __Item_to_wc3:add(self, model)
end

function Item:destroyObject()
    local model = __Item_to_wc3:get(self)
    if not model then return nil end
    __wc3_to_Item:remove(model)
    __Item_to_wc3:remove(self)
    RemoveItem(model)
end

Item.addRemovalFunction(Item.destroyObject)

function Item:setModel(path)
    local model = __Item_to_wc3:get(self)
    if not model then return nil end
    BlzSetItemStringField(model, ITEM_SF_MODEL_USED, path)
end

---@return Item
function Item:getSold()
    return __wc3_to_Item:get(GetSoldItem())
end

---@return Item
function Item:GetSpellTarget()
    return __wc3_to_Item:get(GetSpellTargetItem())
end

---@return Item
function Item:GetOrderTarget()
    return __wc3_to_Item:get(GetOrderTargetItem())
end

---@return Item
function Item:GetManipulatedTarget()
    return __wc3_to_Item:get(GetManipulatedItem())
end