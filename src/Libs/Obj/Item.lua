--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Obj
local Obj = require(__TimerLib..'Obj')

--=======
-- Class
--=======

local ItemObj = Class.new('ItemObj', Obj)
---@class ItemObj : Obj
local public = ItemObj.public
---@class ItemObjClass : ObjClass
local static = ItemObj.static
---@type ItemObjClass
local override = ItemObj.override
local private = {}

--=========
-- Static
--=========

---@param id number
---@param x number
---@param y number
---@param child_instance ItemObj | nil
---@return ItemObj
function override.new(id, x, y, child_instance)
    local instance = child_instance or Class.allocate(ItemObj)

    local obj = CreateItem(id, x, y)
    instance = Obj.new(obj, RemoveItem, instance)

    return instance
end

return static