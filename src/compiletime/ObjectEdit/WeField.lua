--=========
-- Include
--=========

local Class = require('Utils.Class')
local Log = require('utils.Log')

---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeField = Class.newClass('WeField')
---@class WeField
local public = WeField.public
---@class WeFieldClass
local static = WeField.static
local override = WeField.override
local private = {}

--========
-- Static
--========

---@alias WeFieldTestDataFunc fun(field:WeField, data:any):boolean
---@alias WeFieldDataType string | "'bool'" | "'int'" | "'real'" | "'unreal'" | "'string'"

---@type WeFieldDataType[]
static.DataType = {
    bool = 'bool',
    int = 'int',
    real = 'real',
    unreal = 'unreal',
    string = 'string'
}

---@param field_id string | number
---@param data_type WeFieldDataType
---@param name string
---@param test_data_func WeFieldTestDataFunc | nil
---@param child_data WeField | nil
---@return WeField
function static.new(field_id, data_type, name, test_data_func, child_data)
    local instance = Class.newInstanceData(WeField, child_data)
    private.newData(instance, field_id, data_type, name, test_data_func)

    return instance
end

---@param field WeField
---@param data any
---@param list string[]
---@return boolean
function static.compareWithList(field, data, list)
    for i = 1, #list do
        if data == list[i] then
            return true
        end
    end

    msg = string.format('wrong data. Got: \"%s\"". Available: %s.\n%s',
                         data, private.getPossibleValues(list), WeUtils.getErrorPos())
    Log(Log.Warn, field:getName(), msg)
    return false
end

---@param data_type WeFieldDataType
---@return string
function static.type2bytes(data_type)
    return private.type_to_bytes[data_type]
end

---@param data boolean|number|string
---@param data_type WeFieldDataType
---@return string|nil
function static.data2bytes(data, data_type)
    if data_type == 'bool' then
        if data_type then
            data = 1
        else
            data = 0
        end
    end
    return private.data_to_bytes_func[data_type](data)
end

--========
-- Public
--========

---@return string
function public:getId()
    local priv = private[self]
    return priv.field_id
end

---@return WeFieldDataType
function public:getDataType()
    local priv = private[self]
    return priv.data_type
end

---@return string
function public:getName()
    local priv = private[self]
    return priv.name
end

---@return string
function public:serialize(data)
    local priv = private[self]

    local data_type_bytes = static.type2bytes(priv.data_type)
    local data_bytes = static.data2bytes(data, priv.data_type)

    return priv.field_id..data_type_bytes..data_bytes
end

---@return boolean
function public:isValid(data)
    local priv = private[self]
    if priv.test_data_func then
        return private.checkType(self, data) and priv.test_data_func(self, data)
    else
        return private.checkType(self, data)
    end
end

function public:free()
   private.freeData(self)
   Class.freeInstanceData(self)
end

--=========
-- Private
--=========

function private.checkType(self, data)
    local data_type = private[self].data_type
    local res = false
    if data_type == 'string' and type(data) == 'string' then
        res = true
    end
    if data_type == 'int' and type(data) == 'number' and data % 1 == 0 then
        res = true
    end
    if data_type == 'bool' and type(data) == 'boolean' then
        res = true
    end
    if (data_type == 'real' or data_type == 'unreal') and type(data) == 'number' then
        res = true
    end

    if not res then
        local msg = string.format('Wrong data type. Got %s. Need %s.',
                                   type(data), data_type)
        Log(Log.Warn, self:getName(), msg)
    end
    return res
end

---@param list string[]
---@return string
function private.getPossibleValues(list)
    local msg = list[1]
    for i = 2, #list do
        msg = msg..', \"'..list[i]..'\"'
    end
    return msg
end

---@param data_type WeFieldDataType
---@return boolean
function private.isDataType(data_type)
    for _, availble_type in pairs(static.DataType) do
        if data_type == availble_type then
            return true
        end
    end
    return false
end

private.type_to_bytes = {
    bool = WeUtils.int2byte(0),
    int = WeUtils.int2byte(0),
    real = WeUtils.int2byte(1),
    unreal = WeUtils.int2byte(2),
    string = WeUtils.int2byte(3),
}

private.data_to_bytes_func = {
    bool = WeUtils.int2byte,
    int = WeUtils.int2byte,
    real = WeUtils.float2byte,
    unreal = WeUtils.float2byte,
    string = WeUtils.str2byte,
}

---@param self WeField
---@param field_id number | string
---@param data_type WeFieldDataType
---@param name string
---@param test_data_func any
function private.newData(self, field_id, data_type, name, test_data_func)
    local priv = {
        field_id = WeUtils.ID2str(field_id),
        data_type = data_type,
        name = name,
        test_data_func = test_data_func
    }
    private[self] = priv
end

---@param self WeField
function private.freeData(self)
    private[self] = nil
end

return WeField