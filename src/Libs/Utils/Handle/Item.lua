--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkType = Functions.checkType


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
---@param child_instance Item | nil
---@return Item
function override.new(id, x, y, child_instance)
    checkType(id, 'number', 'Item_id')
    checkType(x, 'number', 'x')
    checkType(y, 'number', 'y')
    if child_instance then
        checkType(child_instance, Item, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Item)
    instance = Handle.new(CreateItem(id, x, y), RemoveItem, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetItemX(self:getHandleData())
end

---@return number
function public:getY()
    return GetItemY(self:getHandleData())
end

---@param x number
function public:setX(x)
    SetItemPosition(self:getHandleData(), x, GetItemY(self:getHandleData()))
end

---@param y number
function public:setY(y)
    SetItemPosition(self:getHandleData(), GetItemX(self:getHandleData()), y)
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