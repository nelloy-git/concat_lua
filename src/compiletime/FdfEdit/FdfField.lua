--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local FdfField = Class.new('FdfField')
---@class FdfField
local public = FdfField.public
---@class FdfFieldClass
local static = FdfField.static
---@type FdfFieldClass
local override = FdfField.override
local private = {}

--=========
-- Static
--=========

---@alias FdfSerializeDataFunction fun(field:FdfField, data:any):string
---@type table<string, FdfSerializeDataFunction>
static.SerialFunc = {
    EMPTY = 1,
    STRING = 2,
    NUMBER = 3,
    LIST = 4,
    LIST_WITH_COMMAS = 5,
    LIST_WITH_QUOTES = 6,
    SUBOBJECT = 7,
    SUBOBJECT_LIST = 8
}

---@param name string
---@param val_type string
---@param serialize_func FdfSerializeDataFunction
---@param child_instance FdfField | nil
---@return FdfField
function override.new(name, val_type, serialize_func, child_instance)
    local instance = child_instance or Class.allocate(FdfField)
    private.newData(instance, name, val_type, serialize_func)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private[self].name
end

---@return string
function public:getType()
    return private[self].val_type
end

---@param value string
---@return boolean
function public:checkType(value)
    return Class.type(value, private[self].val_type)
end

---@param value any
---@return string
function public:serialize(value)
    local priv = private[self]
    if Class.type(value, priv.val_type) then
        return priv.serialize_func(self, value)
    else
        local msg = string.format('wrong value type for field %s.',
                                   priv.name)
        Log(Log.Err, FdfField, msg)
        return nil
    end
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

local fmt = string.format
private.serialize = {
    [static.SerialFunc.EMPTY] = function(self, data)
        return private[self].name..','
    end,

    [static.SerialFunc.STRING] = function(self, data)
        return fmt('%s \"%s\",', private[self].name, data)
    end,

    [static.SerialFunc.NUMBER] = function(self, data)
        return fmt('%s %f,', private[self].name, data)
    end,

    [static.SerialFunc.LIST] = function(self, data)
        local list = private[self].name
        for i = 1, #data do
            list = list..' '..tostring(data[i])
        end
        return list..','
    end,

    [static.SerialFunc.LIST_WITH_COMMAS] = function(self, data)
        local list = private[self].name..' '..tostring(data[1])
        for i = 2, #data do
            list = list..', '..tostring(data[i])
        end
        return list..','
    end,

    [static.SerialFunc.LIST_WITH_QUOTES] = function(self, data)
        local list = private[self].name
        for i = 1, #data do
            if type(data[i]) == 'string' then
                list = list..' \"'..tostring(data[i])..'\"'
            else
                list = list..' '..tostring(data[i])
            end
            list = list..','
        end
        return list
    end,

    [static.SerialFunc.SUBOBJECT] = function(self, data)
        return data:serialize()
    end,

    [static.SerialFunc.SUBOBJECT_LIST] = function(self, data)
        local res = ''
        for i = 1, #data do
            res = res..data[i]:serialize()..'\n'
        end
        return res:sub(1, res:len() - 1)
    end
}

---@param func any
---@return boolean
function private.isSerialFunc(func)
    for k, v in pairs(static.SerialFunc) do
        if func == v then
            return true
        end
    end
    return false
end

---@param self FdfField
---@param name string
---@param val_type string
---@param serialize_func FdfSerializeDataFunction
function private.newData(self, name, val_type, serialize_func)
    if not private.isSerialFunc(serialize_func) then
        Log.error(FdfField, 'wrong serial function.', 3)
    end

    local priv = {
        name = name,
        val_type = val_type,
        serialize_func = private.serialize[serialize_func]
    }
    private[self] = priv

    return priv
end

---@param self FdfField
function private.freeData(self)
    private[self] = nil
end

return static