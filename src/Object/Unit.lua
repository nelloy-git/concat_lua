--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type Object
local Object = require('Object')

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

---@param child_instance UnitObj | nil
---@return UnitObj
function static.new(child_instance)
    local instance = child_instance or Class.allocate(UnitObj)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:getObj()
    return private.data[self].obj
end

function public:destroy()
    private.destroy(private.data[self])
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self UnitObj
function private.newData(self, id, unit_id, x, y, face)
    local priv = {
        obj = CreateUnit(id, unit_id, x, y, face)
    }
    private.data[self] = setmetatable(priv, private.metadata)
end

function private.destroy(priv)
    if priv.obj then
        RemoveUnit(priv.obj)
    end
    priv.obj = nil
end

private.metatable = {
    __gc = private.destroy
}

return static