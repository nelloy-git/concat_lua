--==========
-- Includes
--==========

--=======
-- Class
--=======

---@class Item
local Item = newClass('Item')
local Item_meta = newMeta(Item)
Item.__creation_funcs = {}
Item.__removal_funcs = {}

function Item.new()
    local item = {}
    setmetatable(item, Item_meta)

    for i = 1, #Item.__creation_funcs do
        runFuncInDebug(Item.__creation_funcs[i], item)
    end

    return item
end

function Item:destroy()
    for i = 1, #Item.__removal_funcs do
        runFuncInDebug(Item.__removal_funcs[i], self)
    end
end

---@param func fun(item:Item):boolean
function Item.addCreationFunction(func)
    table.insert(Item.__creation_funcs, #Item.__creation_funcs + 1, func)
end

---@param func fun(item:Item):boolean
function Item.addRemovalFunction(func)
    table.insert(Item.__removal_funcs, #Item.__removal_funcs + 1, func)
end

return Item