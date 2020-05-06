--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Object
local Object = require('Object.Object')

local ID = ID

--=======
-- Class
--=======

local UnitObj = Class.new('UnitObj', Object)
---@class UnitObj : Object
local public = UnitObj.public
---@class UnitObjClass : ObjectClass
local static = UnitObj.static
---@type UnitObjClass
local override = UnitObj.override
local private = {}

--=========
-- Static
--=========

---@param player player
---@param unit_id number | string
---@param x number
---@param y number
---@param face number
---@param child_instance UnitObj | nil
---@return UnitObj
function override.new(player, unit_id, x, y, face, child_instance)
    local instance = child_instance or Class.allocate(UnitObj)

    local obj = CreateUnit(player, ID(unit_id), x, y, face)
    instance = Object.new(obj, RemoveUnit, instance)

    return instance
end

return static