--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')

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
    return private.data[self].name
end

---@return string
function public:getBaseName()
    return private.data[self].base_name
end

---@param field FdfField
---@param value any
function public:setField(field, value)
    local priv = private.data[self]

    if not field:checkType(value) then
        local msg = string.format("check data failed. Field change ignored. Got: %s need: %s.\n%s",
                                  type(value), field:getType(), WeUtils.getErrorPos())
        Log.error(FdfObject, msg, 2)
    end

    priv.field[field] = value
end

---@return any
function public:getField(field)
    return private.data[self].field[field]
end

function public:getAllFields()
    return private.data[self].field
end

---@return string
function public:serialize()
    local priv = private.data[self]

    local res = string.format("Frame \"%s\" \"%s\" {\n", priv.base_name, priv.name)
    for field, value in pairs(priv.field) do
        local field_serial = '    '..string.gsub(field:serialize(value), '\n', '\n    ')
        res = res..field_serial..'\n'
    end
    return res.."}\n"
end

---@return table
function public:toRuntime()
    local priv = private.data[self]

    local res = {
        name = priv.name,
        base_name = priv.base_name,
        field = {},
    }

    for field, value in pairs(priv.field) do
        if value == nil then
            res.field[field:getName()] = 'nil'

        elseif Class.type(value, FdfObject) then
            res.field[field:getName()] = value:toRuntime()

        elseif Class.type(value, 'table') then
            local list = {}
            res.field[field:getName()] = list
            for j = 1, #value do
                list[value[j]:getName()] = value[j]:toRuntime()
            end

        else
            res.field[field:getName()] = value
        end
    end

    return res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FdfObject
---@return FdfObjectPrivate
function private.newData(self, name, base_name)
    ---@class FdfObjectPrivate
    local priv = {
        base_name = base_name,
        name = name,
        field = {}
    }
    private.data[self] = priv
end

return static