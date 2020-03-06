--=========
-- Include
--=========

local Class = require('Utils.Class.Class')
local Log = require('Utils.Log')

---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeObject = Class.new('WeObject')
---@class WeObject
local public = WeObject.public
---@class WeObjectClass
local static = WeObject.static
---@type WeObjectClass
local override = WeObject.override
local private = {}

--========
-- Static
--========

---@param id number | string
---@param base_id number | string
---@param name string
---@param child_instance WeObject | nil
---@return WeObject
function override.new(id, base_id, name, child_instance)
    local instance = child_instance or Class.allocate(WeObject)
    private.newData(instance, id, base_id, name)

    return instance
end

--========
-- Public
--========

---@return string
function public:getId()
    return private[self].id
end

---@return string
function public:getBaseId()
    return private[self].base_id
end

---@return string
function public:getName()
    return private[self].name
end

---@param field WeField
---@param data any
function public:setField(field, data)
    local priv = private[self]
    if not field then
        Log.error(self, 'field does not exist.', 2)
    end

    if field:isValid(data) then
        priv.fields[field] = data
    end
end

---@param field WeField
---@return any
function public:getField(field)
    return private[self].fields[field]
end

---@return table<WeField,any>
function public:getAllChanges()
    local priv = private[self]

    local copy = {}
    for field, data in pairs(priv.fields) do
        copy[field] = data
    end

    return copy
end

---@return table
function public:toRuntime()
    local priv = private[self]

    local res = {}
    for field, data in pairs(priv.fields) do
        res[field:getName()] = data
    end
    res.id = priv.id
    res.base_id = priv.base_id
    res.name = priv.name
    return res
end

---@return string
function public:printChanges()
    local priv = private[self]

    local str_changes = ''
    for field, data in pairs(priv.fields) do
        local q = ''
        if type(data) == 'string' then
            q = '\"'
        end
        str_changes = str_changes..string.format('\t%s = %s%s%s\n', field:getName(), q, tostring(data), q)
    end
    return str_changes
end

---@return string
function public:serialize()
    local priv = private[self]

    local fields_serial = {}
    for field, data in pairs(priv.fields) do
        local field_bytes = field:serialize(data)
        table.insert(fields_serial, 1, field_bytes..private.field_serial_end)
    end

    local res = priv.base_id .. priv.id .. WeUtils.int2byte(#fields_serial)
    for i = 1, #fields_serial do
        res = res..fields_serial[i]
    end
    return res
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.field_serial_end = '\0\0\0\0'

---@param self WeObject
---@param id number | string
---@param base_id number | string
---@param name string
function private.newData(self, id, base_id, name)
    local priv = {
        id = WeUtils.ID2str(id),
        base_id = WeUtils.ID2str(base_id),
        name = name,
        fields = {}
    }
    private[self] = priv
end

---@param self WeObject
function private.freeData(self)
    private[self] = nil
end

return WeObject.static