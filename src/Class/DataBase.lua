--=======
-- Class
--=======

---@type DataBaseClass
local DataBase = newClass('DataBase')

---@class DataBase
local public = DataBase.public
---@class DataBaseClass
local static = DataBase.static
---@type table
local override = DataBase.override
---@type table(DataBase, table)
local private = {}

local wrong_key_type_error_fmt = "%s error: wrong key type.\nNeed: %s Got: %s"
local wrong_value_type_error_fmt = "%s error: wrong value type.\nNeed: %s Got: %s"

--=========
-- Methods
--=========

---@param key_type string
---@param val_type string
---@param instance_data table | nil
---@return DataBase
function static.new(key_type, val_type, instance_data)
    ---@type DataBase
    local instance = instance_data or newInstanceData(DataBase)
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
        Debug(string.format(wrong_key_type_error_fmt, getClassName(DataBase), priv.key_type, type(key)))
        return false
    end
    return true
end

local function isValidValueType(self, value)
    local priv = private[self]
    print(type(value))
    print(priv.value_type)
    if not isType(value, priv.value_type) then
        Debug(string.format(wrong_value_type_error_fmt, getClassName(DataBase), priv.value_type, type(value)))
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

return DataBase