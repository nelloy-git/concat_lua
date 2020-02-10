--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

--=======
-- Class
--=======

local Object = Class.new('Object')
---@class Object
local public = Object.public
---@class ObjectClass
local static = Object.static
---@type ObjectClass
local override = Object.override
local private = {}

--=========
-- Static
--=========

---@param obj any
---@param child_instance Object | nil
---@return Object
function static.new(obj, destructor, child_instance)
    if not child_instance then
        Log.error(Object, 'can not create instance of abstract class.', 2)
    end

    local instance = child_instance
    private.newData(instance, obj, destructor)

    return instance
end

---@param obj any
---@return any
function static.getInstance(obj)
    return private.db[obj]
end

--========
-- Public
--========

---@return any
function public:getObj()
    return private.data[self].obj
end

function public:destroy()
    local priv = private.data[self]
    private.db[priv.obj] = nil
    private.data[self] = nil
    if priv.obj then
        priv.destructor(priv.obj)
    end
    priv.obj = nil
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.db = setmetatable({}, {__mode = 'kv'})

---@param self Object
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