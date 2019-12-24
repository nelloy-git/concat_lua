--=========
-- Include
--=========

local fmt = string.format

---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

---@type FdfFieldClass
local FdfField = newClass('FdfField')

---@class FdfField
local public = FdfField.public
---@class FdfFieldClass
local static = FdfField.static
---@type table
local override = FdfField.override
---@type table(FdfField, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfField
function static.new(name, val_type, serialize_func, instance_data)
    local instance = instance_data or newInstanceData(FdfField)
    local priv = private.new(instance, name, val_type, serialize_func)

    return instance
end

function static.serialize_NoArgs(self, _)
    return private.get(self).name..','
end

function static.serialize_String(self, str)
    return fmt('%s \"%s\",', private.get(self).name, str)
end

function static.serialize_Number(self, value)
    return fmt('%s %f,', private.get(self).name, value)
end

function static.serialize_List(self, list_table)
    local list = private.get(self).name
    for i = 1, #list_table do
        list = list..' '..tostring(list_table[i])
    end
    return list..','
end

function static.serialize_ListWithQuotes(self, list_table)
    local list = private.get(self).name
    for i = 1, #list_table do
        if type(list_table[i]) == 'string' then
            list = list..' \"'..tostring(list_table[i])..'\"'
        else
            list = list..' '..tostring(list_table[i])
        end
        list = list..','
    end
    return list
end

function static.serialize_Subobject(self, subobject)
    return subobject:serialize()
end

function static.serialize_SubobjectList(self, subobjects)
    local res = subobjects[1]:serialize()..',\n'
    for i = 2, #subobjects do
        res = res..'    '..subobjects[i]:serialize()..',\n'
    end
    return res
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

---@return string
function public:getName()
    return private.get(self).name
end

---@return string
function public:getType()
    return private.get(self).val_type
end

---@param value string
---@return boolean
function public:checkType(value)
    return isType(value, private.get(self).val_type)
end

---@param value any
---@return string
function public:serialize(value)
    if type(value) == private.get(self).val_type then
        return private.get(self).serialize_func(self, value)
    else
        local msg = string.format('wrong value type for field %s.', private.get(self).name)
        Log(Log.Err, getClassName(FdfField), msg)
        return nil
    end
end

--=========
-- Private
--=========

local private_data = {}
---@param self FdfField
---@param name string
---@param val_type string
---@param serialize_func fun
---@return FdfFieldPrivate
function private.new(self, name, val_type, serialize_func)

    if not serialize_func then
        local msg = string.format('serialize function can not be \"nil\"\n%s',
                                   WeUtils.getErrorPos())
        Log(Log.Err, getClassName(FdfField), msg)
        return nil
    end

    ---@class FdfFieldPrivate
    local priv = {
        name = name,
        val_type = val_type,
        serialize_func = serialize_func
    }
    private_data[self] = priv
    return priv
end

---@param self FdfField
---@return FdfFieldPrivate
function private.get(self)
    return private_data[self]
end

---@param self FdfField
function private.free(self)
    private_data[self] = nil
end

return FdfField