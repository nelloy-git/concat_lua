--=======
-- Class
--=======

---@type any
local DataBase = Class.newClass('DataBase')

---@class DataBase
local public = DataBase.public
---@class DataBaseClass
local static = DataBase.static
---@type table
local override = DataBase.override
---@type table(DataBase, table)
local private = {}

--=========
-- Methods
--=========

---@param key_type string
---@param val_type string
---@param instance_data table | nil
---@return DataBase
function static.new(key_type, val_type, instance_data)
    ---@type DataBase
    local instance = instance_data or Class.newInstanceData(DataBase)
    local priv = {
        data = {},
        key_type = key_type,
        value_type = val_type
    }
    private[instance] = priv

    return instance
end

local function isValidKeyType(self, key)
    local priv = private[self]
    if not isType(key, priv.key_type) then
        Log(Log.Err, getClassName(DataBase), string.format("wrong key type. Got: %s Avaliable: %s", type(key), priv.key_type))
        return false
    end
    return true
end

local function isValidValueType(self, value)
    local priv = private[self]
    if not isType(value, priv.value_type) then
        Log(Log.Err, getClassName(DataBase), string.format("wrong value type. Got: %s Avaliable: %s", type(value), priv.key_type))
        return false
    end
    return true
end

function public:set(key, value)
    local priv = private[self]

    if not isValidKeyType(self, key) then
        return nil
    end
    if not isValidValueType(self, value) then
        return nil
    end

    priv.data[key] = value
end

function public:get(key)
    local priv = private[self]
    if not isValidKeyType(self, key) then
        return nil
    end
    return priv.data[key]
end

---@return boolean
function public:remove(key)
    local priv = private[self]
    if not isValidKeyType(self, key) then
        return false
    end
    priv.data[key] = nil
end

return DataBase