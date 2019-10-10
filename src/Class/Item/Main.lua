--==========
-- Includes
--==========

--=======
-- Class
--=======

---@class Item
local Item = newClass('Item')
local Item_meta = newMeta(Item)

function Item.new()
    local item = {}
    setmetatable(item, Item_meta)

    return item
end

return Item