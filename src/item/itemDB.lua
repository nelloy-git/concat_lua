---@class ItemDB
local ItemDB = {}

---@param item_obj userdata
---@param item Item
---@return nil
function ItemDB.add(item_obj, item)
    ItemDB[item_obj] = item
end

---@param item_obj userdata
---@return nil
function ItemDB.rm(item_obj)
    ItemDB[item_obj] = nil
end

---@param item_obj userdata
---@return Item
function ItemDB.get(item_obj)
    return ItemDB[item_obj]
end

return ItemDB