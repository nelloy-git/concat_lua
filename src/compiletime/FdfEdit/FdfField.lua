--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

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
local override = FdfField.override
local private = {}

--=========
-- Static
--=========

---@alias FdfSerializeDataFunction fun(field:FdfField, data:any):string

static.SERIAL_DATA = {
    EMPTY = private.serialize_Empty,
    STRING = private.serialize_String,
    NUMBER = private.serialize_Number,
    LIST = private.serialize_List,
    LIST_WITH_QUOTES = private.serialize_ListWithQuotes,
    SUBOBJECT = private.serialize_Subobject,
    SUBOBJECT_LIST = private.serialize_SubobjectList
}

---@param name string
---@param val_type any
---@param serialize_func any
---@param child_data FdfField | nil
---@return FdfField
function static.new(name, val_type, serialize_func, child_data)
    if not serialize_func then
        local msg = string.format('serialize function can not be \"nil\"\n%s',
                                   WeUtils.getErrorPos())
        Log(Log.Err, FdfField, msg)
        return nil
    end

    local instance = child_data or Class.allocate(FdfField, child_data)
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
    return isType(value, private[self].val_type)
end

---@param value any
---@return string
function public:serialize(value)
    local priv = private[self]
    if isType(value, priv.val_type) then
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
    Class.freeInstanceData(self)
end

--=========
-- Private
--=========

local fmt = string.format

---@param self FdfField
---@param data nil
function private.serialize_Empty(self, data)
    return private[self].name..','
end

---@param self FdfField
---@param data string
function private.serialize_String(self, data)
    return fmt('%s \"%s\",', private[self].name, data)
end

---@param self FdfField
---@param data number
function private.serialize_Number(self, data)
    return fmt('%s %f,', private[self].name, data)
end

---@param self FdfField
---@param data number[]
function private.serialize_List(self, data)
    local list = private[self].name
    for i = 1, #data do
        list = list..' '..tostring(data[i])
    end
    return list..','
end

---@param self FdfField
---@param data table<number,string|number>
function private.serialize_ListWithQuotes(self, data)
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
end

---@param self FdfField
---@param data FdfSubobject
function private.serialize_Subobject(self, data)
    return data:serialize()
end

---@param self FdfField
---@param data FdfSubobject[]
function private.serialize_SubobjectList(self, data)
    local res = data[1]:serialize()..',\n'
    for i = 2, #data do
        res = res..'    '..data[i]:serialize()..',\n'
    end
    return res
end

---@param self FdfField
---@param name string
---@param val_type string
---@param serialize_func FdfSerializeDataFunction
function private.newData(self, name, val_type, serialize_func)
    local priv = {
        name = name,
        val_type = val_type,
        serialize_func = serialize_func
    }
    private[self] = priv

    return priv
end

---@param self FdfField
function private.freeData(self)
    private[self] = nil
end

static.SERIAL_DATA = {
    EMPTY = private.serialize_Empty,
    STRING = private.serialize_String,
    NUMBER = private.serialize_Number,
    LIST = private.serialize_List,
    LIST_WITH_QUOTES = private.serialize_ListWithQuotes,
    SUBOBJECT = private.serialize_Subobject,
    SUBOBJECT_LIST = private.serialize_SubobjectList
}

return FdfField