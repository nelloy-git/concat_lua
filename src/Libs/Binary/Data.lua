--=========
-- Include
--=========

local lib_modename = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

---@type BinaryUtils
local BinaryUtils = require(lib_modename..'.Utils')

--=======
-- Class
--=======

local BinaryData = Class.new('BinaryData')
---@class BinaryData
local public = BinaryData.public
---@class BinaryDataClass
local static = BinaryData.static
---@type BinaryDataClass
local override = BinaryData.override
local private = {}

--========
-- Static
--========

---@param id number
---@param base_id number
---@param name string | nil
---@param child_instance BinaryData | nil
---@return BinaryData
function override.new(id, base_id, name, child_instance)
    checkTypeErr(id, 'number', 'id')
    checkTypeErr(base_id, 'number', 'base_id')
    if name then checkTypeErr(name, 'string', 'name') end
    if child_instance then checkTypeErr(child_instance, BinaryData, 'child_instance') end

    local instance = child_instance or Class.allocate(BinaryData)
    private.newData(instance, id, base_id, name)

    return instance
end

--========
-- Public
--========

---@return string
function public:getId()
    return private.data[self].id
end

---@return string
function public:getBaseId()
    return private.data[self].base_id
end

---@return string
function public:getName()
    return private.data[self].name
end

---@param value_id string
---@param value_type string | 'bool' | 'int' | 'real' | 'unreal' | 'string'
---@param value any
function public:setValue(value_id, value_type, value)
    if not (value_type == 'bool' or
       value_type == 'int' or
       value_type == 'real' or
       value_type == 'unreal' or
       value_type == 'string') then
        Log:err('Unavailable \'value_type\'. Got '..value_type, 2)
    end
    checkTypeErr(value_id, 'string', 'value_id')
    checkTypeErr(value, value_type, 'value')

    local priv = private.data[self]
    priv.values[value_id] = {value_type = value_type, value = value}
end

---@return string
function public:serialize()
    local priv = private.data[self]

    local bytes = ''
    local changes_count = 0
    for value_id, value_data in pairs(priv.values) do
        local value_type = value_data.value_type
        local value = value_data.value
        bytes = bytes..
                value_id..
                private.type_to_bytes[value_type]..
                private.value_to_bytes[value_type](value)..
                '\0\0\0\0'

        changes_count = changes_count + 1
    end

    -- Adds header
    bytes = BinaryUtils.id2byte(priv.base_id)..     -- Base (parent's) id
            BinaryUtils.id2byte(priv.id)..          -- New id
            BinaryUtils.int2byte(changes_count)..    -- Changes count
            bytes

    return bytes
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.field_serial_end = '\0\0\0\0'

---@param self BinaryData
---@param id number | string
---@param base_id number | string
---@param name string
function private.newData(self, id, base_id, name)
    local priv = {
        id = id,
        base_id = base_id,
        name = name,
        values = {}
    }
    private.data[self] = priv
end

private.type_to_bytes = {
    bool = BinaryUtils.int2byte(0),
    int = BinaryUtils.int2byte(0),
    real = BinaryUtils.int2byte(1),
    unreal = BinaryUtils.int2byte(2),
    string = BinaryUtils.int2byte(3),
}

private.value_to_bytes = {
    bool = BinaryUtils.int2byte,
    int = BinaryUtils.int2byte,
    real = BinaryUtils.float2byte,
    unreal = BinaryUtils.float2byte,
    string = BinaryUtils.str2byte,
}

return BinaryData.static