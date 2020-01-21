--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

--=======
-- Class
--=======

local DataBase = Class.new('DataBase')
---@class DataBase
local public = DataBase.public
---@class DataBaseClass
local static = DataBase.static
---@type DataBaseClass
local override = DataBase.override
local private = {}

--========
-- Static
--========

---@param key_type string
---@param value_type string
---@param child_instance DataBase | nil
---@return DataBase
function static.new(key_type, value_type, child_instance)
    local instance = child_instance or Class.allocate(DataBase)
    private.newData(instance, key_type, value_type)

    return instance
end

--========
-- Public
--========

---@param key any
---@param value any
---@return boolean
function public:set(key, value)
    local priv = private[self]

    if not private.isValidKeyType(self, key) then
        return false
    end
    if not private.isValidValueType(self, value) then
        return false
    end

    priv.data[key] = value
    return true
end

---@return any
function public:get(key)
    local priv = private[self]
    if not private.isValidKeyType(self, key) then
        return false
    end
    return priv.data[key]
end

---@return boolean
function public:remove(key)
    local priv = private[self]
    if not private.isValidKeyType(self, key) then
        return false
    end
    priv.data[key] = nil
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

---@param self DataBase
---@param key any
---@return boolean
function private.isValidKeyType(self, key)
    local priv = private[self]
    if not Class.type(key, priv.key_type) then
        local msg = string.format("wrong key type. Got: %s Avaliable: %s", tostring(key), tostring(priv.key_type))
        Log.error(DataBase, msg, 3)
        return false
    end
    return true
end

---@param self DataBase
---@param value any
---@return boolean
function private.isValidValueType(self, value)
    local priv = private[self]
    if not Class.type(value, priv.value_type) then
        local msg = string.format("wrong value type. Got: %s Avaliable: %s", tostring(value), tostring(priv.value_type))
        Log.error(DataBase, msg, 3)
        return false
    end
    return true
end

---@param instance DataBase
---@param key_type string
---@param value_type string
function private.newData(instance, key_type, value_type)
    local priv = {
        data = {},
        key_type = key_type,
        value_type = value_type
    }
    private[instance] = priv
end

---@param self DataBase
function private.freeData(self)
    private[self] = nil
end

return static