--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local FdfObject = Class.new('FdfObject')
---@class FdfObject
local public = FdfObject.public
---@class FdfObjectClass
local static = FdfObject.static
---@type FdfObjectClass
local override = FdfObject.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_name string
---@param child_instance FdfObject | nil
---@return FdfObject
function static.new(name, base_name, child_instance)
    local instance = child_instance or Class.allocate(FdfObject)
    private.newData(instance, name, base_name)

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
function public:getBaseName()
    return private[self].base_name
end

---@param field FdfField
---@param value any
function public:setField(field, value)
    local priv = private[self]

    if field:checkType(value) then
        local pos = #priv.fields + 1
        table.insert(priv.fields, #priv.fields + 1, field)
        priv.values[pos] = value
    else
        local msg = string.format("check data failed. Field change ignored. Got: %s need: %s.\n%s",
                                  type(value), field:getType(), WeUtils.getErrorPos())
        Log(Log.Wrn, FdfObject, msg)
    end
end

function public:getFields()
    local priv = private[self]
    return priv.fields, priv.values
end

---@return string
function public:serialize()
    local priv = private[self]

    local res = string.format("Frame \"%s\" \"%s\" {\n", priv.base_name, priv.name)
    for i = 1, #priv.fields do
        local field_serial = '    '..string.gsub(priv.fields[i]:serialize(priv.values[i]), '\n', '\n    ')
        res = res..field_serial..'\n'
    end
    return res.."}\n"
end

---@return table
function public:toRuntime()
    local priv = private[self]

    local res = {
        name = priv.name,
        base_name = priv.base_name,
        fields = {},
    }

    for i = 1, #priv.fields do
        if priv.values[i] == nil then
            res.fields[priv.fields[i]:getName()] = 'nil'

        elseif Class.type(priv.values[i], FdfObject) then
            res.fields[priv.fields[i]:getName()] = priv.values[i]:toRuntime()

        elseif Class.type(priv.values[i], 'table') then
            local list = {}
            res.fields[priv.fields[i]:getName()] = list
            for j = 1, #priv.values[i] do
                list[priv.values[i][j]:getName()] = priv.values[i][j]:toRuntime()
            end

        else
            res.fields[priv.fields[i]:getName()] = priv.values[i]
        end
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

---@param self FdfObject
---@return FdfObjectPrivate
function private.newData(self, name, base_name)
    ---@class FdfObjectPrivate
    local priv = {
        base_name = base_name,
        name = name,
        fields = {},
        values = {}
    }
    private[self] = priv
    return priv
end

---@param self FdfObject
function private.freeData(self)
    private[self] = nil
end

return static