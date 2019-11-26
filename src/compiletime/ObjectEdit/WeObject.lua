--=========
-- Include
--=========

require('utils.Globals')
---@type WeUtils
local WeUtils = require('compiletime.ObjectEdit.WeUtils')

--=======
-- Class
--=======

---@type WeObjectClass
local WeObject = newClass('WeObject')

---@class WeObject
local public = WeObject.public
---@class WeObjectClass
local static = WeObject.static
---@type table
local override = WeObject.override
---@type table(WeObject, table)
local private = {}

private.field_serial_end = '\0\0\0\0'

--=========
-- Methods
--=========

---@param id number | string
---@param base_id number | string
---@param name string
---@param instance_data table | nil
---@return WeObject
function static.new(id, base_id, name, instance_data)
    local instance = instance_data or newInstanceData(WeObject)
    local priv = {
        id = ID2str(id),
        base_id = ID2str(base_id),
        name = name,
        fields = {}
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

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
    if field:checkData(data) then
        priv.fields[field] = data
    end
end

---@param field WeField
---@return any
function public:getField(field)
    local priv = private[self]
    return priv.fields[field]
end

---@return table(WeField,any)
function public:getAllChanges()
    local priv = private[self]

    local copy = {}
    for k,v in pairs(priv.fields) do
        copy[k] = v
    end

    return copy
end

function public:toRuntime()
    local priv = private[self]

    local t = {}
    for k,v in pairs(priv.fields) do
        t[k:getName()] = v
    end
    t.id = priv.id
    t.base_id = priv.base_id
    return t
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

return WeObject