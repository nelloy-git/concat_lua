--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

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

---@param size number
---@param child_instance UnitInventoryBag | nil
---@return UnitInventoryBag
function static.new(owner, size, child_instance)
    local instance = child_instance or Class.allocate(UnitInventoryBag)
    private.newData(instance, owner, size)

    return instance
end

---@param owner unit
---@return UnitInventoryBag
function static.getByOwner(owner)
    return private.owner2bag[owner]
end

--========
-- Public
--========

---@param item Item
---@param pos number
---@return Item | nil
function public:set(item, pos)
    local priv = private.data[self]
    if pos < 1 or pos > priv.size then
        Log.error(self, fmt('wrong bag slot. Bag size: %d. Got pos = %d.',
                  priv.size, pos), 2)
    end

    local prev = priv.slot[pos]
    priv.slot[pos] = item
    return prev
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
    return
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owner2bag = setmetatable({}, {__mode = 'kv'})

---@param self UnitInventoryBag
function private.newData(self, owner, size)
    local priv = {
        owner = owner,
        size = size,

        slot = {},
    }
    private.data[self] = priv
    private.owner2bag[owner] = self
end

return static