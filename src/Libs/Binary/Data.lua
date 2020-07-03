--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger

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
    checkType(id, 'number', 'id')
    checkType(base_id, 'number', 'base_id')
    if name then checkType(name, 'string', 'name') end
    if child_instance then checkType(child_instance, BinaryData, 'child_instance') end

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
    checkType(value_id, 'string', 'value_id')
    checkType(value, value_type, 'value')

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
                private.value_to_bytes[value_type](value)

        changes_count = changes_count + 1
    end

    -- Adds header
    bytes = private.id2bytes(priv.base_id)..     -- Base (parent's) id
            private.id2bytes(priv.id)..          -- New id
            private.int2bytes(changes_count)..    -- Changes count
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

function private.id2bytes(id)
    local bytes = ''
    for i = 0, 3 do
        bytes = string.char(id >> (8 * i) & 0xFF)..bytes
    end
    return bytes
end

---@param data integer
---@return string
function private.int2bytes(data)
    local bytes = ''
    for i = 0, 3 do
        bytes = bytes..string.char(data >> (8 * i) & 0xFF)
    end
    return bytes
end

local function grab_byte(v)
      return math.floor(v / 256), string.char(math.floor(v) % 256)
end

local log2 = math.log(2)
local frexp = math.frexp or function(x)
	if x == 0 then return 0, 0 end
	local e = math.floor(math.log(math.abs(x)) / log2 + 1)
	return x / 2 ^ e, e
end

---@param data number
---@return string
function private.float2bytes(data)
    local sign = 0
    if data < 0 then
      sign = 1
      data = -data
    end
    local mantissa, exponent = frexp(data)
    if data == 0 then
       mantissa = 0
       exponent = 0
    else
       mantissa = (mantissa * 2 - 1) * 8388608 -- math.ldexp(0.5, 24)
       exponent = exponent + 126
    end
    local v, byte = "" -- convert to bytes
    data, byte = grab_byte(mantissa)
    v = v..byte -- 7:0
    data, byte = grab_byte(data)
    v = v..byte -- 15:8
    data, byte = grab_byte(exponent * 128 + data)
    v = v..byte -- 23:16
    data, byte = grab_byte(sign * 128 + data)
    v = v..byte -- 31:24
    return v
end

---@param data string
---@return string
function private.str2bytes(data)
    return data .. '\0'
end

private.type_to_bytes = {
    bool = private.int2bytes(0),
    int = private.int2bytes(0),
    real = private.int2bytes(1),
    unreal = private.int2bytes(2),
    string = private.int2bytes(3),
}

private.value_to_bytes = {
    bool = private.int2bytes,
    int = private.int2bytes,
    real = private.float2bytes,
    unreal = private.float2bytes,
    string = private.str2bytes,
}

return BinaryData.static