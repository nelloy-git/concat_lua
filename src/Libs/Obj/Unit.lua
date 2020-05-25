--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type Obj
local Obj = require(__TimerLib..'Obj')

--=======
-- Class
--=======

local UnitObj = Class.new('UnitObj', Obj)
---@class UnitObj : Obj
local public = UnitObj.public
---@class UnitObjClass : ObjClass
local static = UnitObj.static
---@type UnitObjClass
local override = UnitObj.override
local private = {}

--=========
-- Static
--=========

---@param player player
---@param unit_id number
---@param x number
---@param y number
---@param face number
---@param child_instance UnitObj | nil
---@return UnitObj
function override.new(player, unit_id, x, y, face, child_instance)
    local instance = child_instance or Class.allocate(UnitObj)

    local obj = CreateUnit(player, unit_id, x, y, face)
    instance = Obj.new(obj, RemoveUnit, instance)

    return instance
end

return static