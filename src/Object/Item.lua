--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type Object
local Object = require('Object.Object')

local ID = ID

--=======
-- Class
--=======

local ItemObj = Class.new('ItemObj', Object)
---@class ItemObj : Object
local public = ItemObj.public
---@class ItemObjClass : ObjectClass
local static = ItemObj.static
---@type ItemObjClass
local override = ItemObj.override
local private = {}

--=========
-- Static
--=========

---@param id number | string
---@param x number
---@param y number
---@param child_instance ItemObj | nil
---@return ItemObj
function override.new(id, x, y, child_instance)
    local instance = child_instance or Class.allocate(ItemObj)

    local obj = CreateItem(ID(id), x, y)
    instance = Object.new(obj, RemoveItem, instance)

    return instance
end

return static