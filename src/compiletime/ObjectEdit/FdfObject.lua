--=========
-- Include
--=========

local Class = require('Utils.Class')

---@type FdfFieldClass
local FdfField = require('compiletime.ObjectEdit.FdfField')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local FdfObject = Class.newClass('FdfObject')

---@class FdfObject
local public = FdfObject.public
---@class FdfObjectClass
local static = FdfObject.static
---@type table
local override = FdfObject.override
---@type table(FdfObject, table)
local private = {}

--=========
-- Static
--=========

---@param base_name string
---@param name string
---@param instance_data table | nil
---@return FdfObject
function static.new(base_name, name, instance_data)
    local instance = instance_data or Class.newInstanceData(FdfObject)
    local priv = private.new(instance, base_name, name)

    return instance
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
function public:getBaseName()
    return private.get(self).base_name
end

function public:setField(field, value)
    local priv = private.get(self)

    if field:checkType(value) then
        local pos = #priv.fields + 1
        table.insert(priv.fields, #priv.fields + 1, field)
        priv.values[pos] = value
    else
        local msg = string.format("check data failed. Field change ignored. Got: %s need: %s.\n%s",
                                  type(value), field:getType(), WeUtils.getErrorPos())
        Log(Log.Warn, getClassName(FdfObject), msg)
    end
end

function public:getFields()
    local priv = private.get(self)
    return priv.fields, priv.values
end

function public:serialize()
    local priv = private.get(self)

    local res = string.format("Frame \"%s\" \"%s\" {\n", priv.base_name, priv.name)
    for i = 1, #priv.fields do
        res = res.."    "..priv.fields[i]:serialize(priv.values[i])..'\n'
    end
    return res.."}\n"
end

---@return FdfObjectRuntime
function public:toRuntime()
    local priv = private.get(self)

    ---@class FdfObjectRuntime
    local res = {
        name = priv.name,
        base_name = priv.base_name,
        fields = {},
    }

    for i = 1, #priv.fields do
        if priv.values[i] == nil then
            res.fields[priv.fields[i]:getName()] = 'nil'
        elseif isType(priv.values[i], FdfObject) then
            res.fields[priv.fields[i]:getName()] = priv.values[i]:toRuntime()
        else
            res.fields[priv.fields[i]:getName()] = priv.values[i]
        end
    end

    return res
end

--=========
-- Private
--=========

local private_data = {}
---@param self FdfObject
---@return FdfObjectPrivate
function private.new(self, base_name, name)
    ---@class FdfObjectPrivate
    local priv = {
        base_name = base_name,
        name = name,
        fields = {},
        values = {}
    }
    private_data[self] = priv
    return priv
end

---@param self FdfObject
---@return FdfObjectPrivate
function private.get(self)
    return private_data[self]
end

---@param self FdfObject
function private.free(self)
    private_data[self] = nil
end

return FdfObject