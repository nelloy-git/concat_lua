--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

--=======
-- Class
--=======

local DataBase = Class.new('DataBase')
---@class DataBase
local public = DataBase.public
---@class DataBaseClass
local static = DataBase.static
local override = DataBase.override
local private = {}

--========
-- Static
--========

---@param key_type string
---@param value_type string
---@param child_data DataBase | nil
---@return DataBase
function static.new(key_type, value_type, child_data)
    local instance = child_data or Class.allocate(DataBase, child_data)
    private.newData(instance, key_type, value_type)

    return instance
end

--========
-- Public
--========

---@param key any
---@param value any
function public:set(key, value)
    local priv = private[self]

    if not private.isValidKeyType(self, key) then
        return nil
    end
    if not private.isValidValueType(self, value) then
        return nil
    end

    priv.data[key] = value
end

---@return any
function public:get(key)
    local priv = private[self]
    if not private.isValidKeyType(self, key) then
        return nil
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
    Class.freeInstanceData(self)
end

--=========
-- Private
--=========

---@param self DataBase
---@param key any
---@return boolean
function private.isValidKeyType(self, key)
    local priv = private[self]
    if not isType(key, priv.key_type) then
        local msg = string.format("wrong key type. Got: %s Avaliable: %s", type(key), priv.key_type)
        Log(Log.Err, DataBase, msg)
        return false
    end
    return true
end

---@param self DataBase
---@param value any
---@return boolean
function private.isValidValueType(self, value)
    local priv = private[self]
    if not isType(value, priv.value_type) then
        local msg = string.format("wrong value type. Got: %s Avaliable: %s", type(value), priv.value_type)
        Log(Log.Err, DataBase, msg)
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
        key_type = Class.getClassName() or key_type,
        value_type = Class.getClassName() or value_type
    }
    private[instance] = priv
end

---@param self DataBase
function private.freeData(self)
    private[self] = nil
end

return DataBase