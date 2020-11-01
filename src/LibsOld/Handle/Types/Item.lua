--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

--=======
-- Class
--=======

local Item = Class.new('Item', Handle)
---@class Item : Handle
local public = Item.public
---@class ItemClass : HandleClass
local static = Item.static
---@type ItemClass
local override = Item.override
local private = {}

--=========
-- Static
--=========

---@param id number
---@param x number
---@param y number
---@param child Item | nil
---@return Item
function override.new(id, x, y, child)
    isTypeErr(id, 'number', 'Item_id')
    isTypeErr(x, 'number', 'x')
    isTypeErr(y, 'number', 'y')
    if child then
        isTypeErr(child, Item, 'child')
    end

    local instance = child or Class.allocate(Item)
    instance = Handle.new(CreateItem(id, x, y), RemoveItem, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetItemX(self:getData())
end

---@return number
function public:getY()
    return GetItemY(self:getData())
end

---@param x number
function public:setX(x)
    SetItemPosition(self:getData(), x, GetItemY(self:getData()))
end

---@param y number
function public:setY(y)
    SetItemPosition(self:getData(), GetItemX(self:getData()), y)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Item
function private.newData(self)
    local priv = {
    }
    private.data[self] = priv
end

return static