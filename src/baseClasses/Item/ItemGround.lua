local DataBase = require('utils.DataBase')

---@class ItemGround
local ItemGround = newClass("ItemGround")
local ItemGround_meta = newMeta(ItemGround)
ItemGround.__db = DataBase.new('userdata', 'ItemGround')

---@param id string|number
---@param x number
---@param y number
---return ItemGround
function ItemGround.new(id, x, y)
    local obj = CreateItem(ID(id), x, y)
    local item_ground = {
        __item_obj = obj
    }
    setmetatable(item_ground, ItemGround_meta)
    ItemGround.__db:add(item_ground.__item_obj, item_ground)

    return item_ground
end

function ItemGround:destroy()
    ItemGround.__db:remove(self.__item_obj)
    RemoveItem(self.__item_obj)
    self.__item_obj = nil
end

return ItemGround