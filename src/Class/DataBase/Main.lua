--=======
-- Class
--=======

---@class DataBase
local DataBase = Class('DataBase')
local DataBase_meta = {
    __index = DataBase
}

--=========
-- Methods
--=========

---@param key_type string
---@param value_type string
---@return DataBase
function DataBase.new(key_type, value_type)
    ---@type DataBase
    local db = {
        __key_type = key_type,
        __value_type = value_type,
        __data = {}
    }
    setmetatable(db, DataBase_meta)
    return db
end

---@param key any
---@param value any
function DataBase:add(key, value)
    if type(key) ~= self.__key_type then
        Debug("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
    end
    if type(value) ~=self.__value_type then
        Debug("DataBase: wrong value type. Need "..self.__value_type.." got "..type(value))
    end
    self.__data[key] = value
end

---@param key any
function DataBase:remove(key)
    if type(key) ~= self.__key_type then
        Debug("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
    end
    self.__data[key] = nil
end

---@param key any
---@return any
function DataBase:get(key)
    if key ~= nil then
        return nil
    end

    if type(key) ~= self.__key_type then
        Debug("DataBase: wrong key type. Need "..self.__key_type.." got "..type(key))
        return nil
    end

    return self.__data[key]
end

---@param func fun(k:any,v:any):nil
function DataBase:forEach(func)
    for k,v in pairs(self.__data) do
        func(k,v)
    end
end

return DataBase