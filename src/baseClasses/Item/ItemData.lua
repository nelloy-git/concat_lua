local DataBase = require('utils.DataBase')

---@class Item
local Item, Item_meta = newClass("ItemClass")
Item.__db = DataBase.new('userdata', 'Item')

---@param self Item
---@return string
function Item_meta.__tostring(self)
    return string.format('Item %s (%s) at %s',
                         self:getName(), ID2str(self:getId()), self:getPos())
end

---@param id string|integer
---@param x number
---@param y number
---@return Item
function Item.new(id, x, y)
    ---@type Item
    local item = {
        __item_ground = CreateItem(ID(id), x, y)
    }
    setmetatable(item, Item_meta)
    Item.__db:add(item.__item_obj, item)

    return item
end

---@return boolean
function Item:isOnGround()
    if not self.__item_ground then
        return false
    end
    return true
end

---@return nil
function Item:destroy()
    Item.__db:remove(self.__item_obj)
    RemoveItem(self.__item_obj)
    self.__item_obj = nil
end

---@return integer
function Item:getId()
    return self.__id
end


---@return Item
function Item.GetSoldItem() return Item.__db:get(GetSoldItem()) end
---@return Item
function Item.GetManipulatedItem() return Item.__db:get(GetManipulatedItem()) end
---@return Item
function Item.GetOrderTargetItem() return Item.__db:get(GetOrderTargetItem()) end
---@return Item
function Item.GetSpellTargetItem() return Item.__db:get(GetSpellTargetItem()) end

return Item