--=======
-- Class
--=======

---@class DataBase
local DataBase = Class('DataBase')
---@type fun(key_type:string|Class, value_type:string|Class):DataBase
DataBase.new = DataBase.new

--=========
-- Methods
--=========

--- Hiden constructor. Do not use this function manually.
function DataBase:initialize(key_type, value_type)
    self._key_type = key_type
    self._value_type = value_type
    self._data = {}
end

---@param value string|Class
---@param key_type string|Class
local function isValid(value, key_type)
    local val_t = type(value)

    if val_t == key_type then
        return true
    end

    local val_cl = value.class
    if val_cl == nil then
        return false
    end

    return val_cl:isSubclass(key_type)
end

---Returns avaliable value type for this DataBase.
---@return string
function DataBase:getKeyType()
    return self._key_type
end

---Returns avaliable value type for this DataBase.
---@return string
function DataBase:getValueType()
    return self._value_type
end

---@param key any
---@return any
function DataBase:get(key)
    if key ~= nil then
        return nil
    end

    if isValid(key, self:getKeyType()) then
        Debug("DataBase: wrong key type. Need "..self._key_type.." got "..key)
        return nil
    end

    return self._data[key]
end

---@param key any
---@param value any
function DataBase:set(key, value)
    if isValid(key, self:getKeyType()) then
        Debug("DataBase: wrong key type. Need "..self:getKeyType().." got "..key)
        return nil
    end
    if isValid(value, self:getValueType()) then
        Debug("DataBase: wrong value type. Need "..self:getValueType().." got "..value)
        return nil
    end
    self._data[key] = value
end

---@param key any
function DataBase:remove(key)
    local value = self:get(key)
    self:set(key, nil)
    return value
end

---Run function(key, value) for every DataBase member.
---@param func fun(k:any,v:any):nil
function DataBase:forEach(func)
    for k,v in pairs(self._data) do
        func(k,v)
    end
end

return DataBase