--=========
-- Include
--=========


local Class = require('Utils.Class.API')

local fmt = string.format

--=======
-- Class
--=======

local UnitInventoryBag = Class.new('UnitInventoryBag')
---@class UnitInventoryBag
local public = UnitInventoryBag.public
---@class UnitInventoryBagClass
local static = UnitInventoryBag.static
---@type UnitInventoryBagClass
local override = UnitInventoryBag.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child_instance UnitInventoryBag | nil
---@return UnitInventoryBag
function override.new(owner, child_instance)
    local instance = child_instance or Class.allocate(UnitInventoryBag)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@param pos number
---@param item Item
---@return Item | nil
function public:set(pos, item)
    local priv = private.data[self]
    if pos < 1 or pos > priv.size then
        Log.error(self, fmt('wrong bag slot. Bag size: %d. Got pos = %d.',
                  priv.size, pos), 2)
    end

    priv.slot[pos] = item
end

--- Returns out of size items.
---@param size number
---@return Item[]
function public:setSize(size)
    local priv = private.data[self]
    priv.size = size

    local list = {}
    for i = size + 1, priv.size do
        table.insert(list, priv.slot[i])
        priv.slot[i] = nil
    end

    return list
end

---@param pos number
---@return Item | nil
function public:get(pos)
    local priv = private.data[self]
    if pos < 1 or pos > priv.size then
        Log.error(self, fmt('wrong bag slot. Bag size: %d. Got pos = %d.',
                  priv.size, pos), 2)
    end

    return priv.slot[pos]
end

---@return number
function public:getSize()
    return private.data[self].size
end

---@return number | nil
function public:getEmpty()
    local priv = private.data[self]

    for i = 1, priv.size do
        if not priv.slot[i] then
            return i
        end
    end
end

---@param item Item
---@return number | nil
function public:find(item)
    local priv = private.data[self]
    for i = 1, priv.size do
        if item == priv.slot[i] then
            return i
        end
    end
end

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owner2bag = setmetatable({}, {__mode = 'kv'})

---@param self UnitInventoryBag
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        size = 0,
        slot = {},
    }
    private.data[self] = priv
    private.owner2bag[owner] = self
end

return static