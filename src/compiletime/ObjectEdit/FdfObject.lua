--=========
-- Include
--=========

---@type FdfFieldClass
local FdfField = require('compiletime.ObjectEdit.FdfField')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

---@type FdfObjectClass
local FdfObject = newClass('FdfObject')

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

---@param instance_data table | nil
---@return FdfObject
function static.new(base_name, name, instance_data)
    local instance = instance_data or newInstanceData(FdfObject)
    local priv = private.new(instance, base_name, name)

    return instance
end

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil')

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

function public:setField(field, value)
    local priv = private.get(self)

    if field:checkType(value) then
        local pos = #priv.fields + 1
        table.insert(priv.fields, #priv.fields + 1, field)
        priv.values[pos] = value
    else
        local msg = string.format("check data failed. Field change ignored.\n%s",
                                  WeUtils.getErrorPos())
        Log(Log.Warn, getClassName(FdfObject), msg)
    end
end

function public:serialize()
    local priv = private.get(self)

    local res = string.format("Frame \"%s\" \"%s\" {\n", priv.base_name, priv.name)
    for i = 1, #priv.fields do
        res = res.."    "..priv.fields[i]:getName()
        local v = priv.values[i]
        if type(v) == 'nil' then
            res = res..","
        elseif type(v) == 'string' then
            res = res.." \""..v.."\","
        elseif type(v) == 'table' then
            local has_string = false
            for j = 1, #v do
                if type(v[j]) == 'string' then
                    has_string = true
                    break
                end
            end

            local list = tostring(v[1])
            if type(v[1]) == 'string' then
                list = '\"'..list..'\"'
                if has_string then
                    list = list..','
                end
            end
            for j = 2, #v do
                if type(v[j]) == 'string' then
                    list = list..' \"'..tostring(v[j])..'\"'
                else
                    list = list..' '..tostring(v[j])
                end
                if has_string and j < #v then
                    list = list..','
                end
            end
            res = res..' '..list..','
        else
            res = res.." "..tostring(v)..","
        end
        res = res.."\n"
    end
    return res.."}\n"
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

function private.toFdfValue(value)
    if type(value) == 'string' then
        return '\"'..tostring(value)..'\"'
    end
    return tostring(value)
end

return FdfObject