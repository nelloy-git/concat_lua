--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local Class = Lib.current().depencies.Class

---@type LoggerClass
local Logger = require(lib_modname..'.Logger')
local Log = Logger.getDefault()
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkType = Functions.checkType

--=======
-- Class
--=======

local Obj = Class.new('Object')
---@class Obj
local public = Obj.public
---@class ObjClass
local static = Obj.static
---@type ObjClass
local override = Obj.override
local private = {}

--=========
-- Static
--=========

--- Creates Obj instance and link it to the raw obj.
---@param obj any
---@param child_instance Obj | nil
---@return Obj
function override.new(obj, destructor, child_instance)
    checkType(destructor, 'function', 'destructor')

    if child_instance then
        checkType(child_instance, Obj, 'child_instance')
    else
        Log:err('Can not create instance of abstract class.', 2)
    end

    if private.db[obj] then
        Log:err('Any entity can have only one connected Obj instance.', 2)
    end

    local instance = child_instance
    private.newData(instance, obj, destructor)

    return instance
end

--- Returns Obj instance linked to the raw object.
---@param obj any
---@return any
function static.getInstance(obj)
    return private.db[obj]
end

--========
-- Public
--========

--- Returns raw object.
---@return any
function public:getObj()
    return private.data[self].obj
end

--- Destroy raw object
function public:destroy()
    local priv = private.data[self]
    private.db[priv.obj] = nil
    private.data[self] = nil
    if priv.obj then
        priv.destructor(priv.obj)
    end
    priv.obj = nil
    priv.destructor = nil
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.db = setmetatable({}, {__mode = 'kv'})

---@param self Obj
---@param obj any
function private.newData(self, obj, destructor)
    local priv = {
        obj = obj,
        destructor = destructor
    }
    private.data[self] = priv
    private.db[obj] = self
end

return static