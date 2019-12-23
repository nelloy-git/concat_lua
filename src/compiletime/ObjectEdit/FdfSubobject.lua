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

---@type FdfSubobjectClass
local FdfSubobject = newClass('FdfSubobject')

---@class FdfSubobject
local public = FdfSubobject.public
---@class FdfSubobjectClass
local static = FdfSubobject.static
---@type table
local override = FdfSubobject.override
---@type table(FdfSubobject, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfSubobject
function static.new(base_name, name, instance_data)
    local instance = instance_data or newInstanceData(FdfSubobject)
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

function public:setField(field, value)
    local priv = private.get(self)

    if field:checkType(value) then
        local pos = #priv.fields + 1
        table.insert(priv.fields, #priv.fields + 1, field)
        priv.values[pos] = value
    else
        local msg = string.format("check data failed. Field change ignored.\n%s",
                                  WeUtils.getErrorPos())
        Log(Log.Warn, getClassName(FdfSubobject), msg)
    end
end

function public:serialize()
    local priv = private.get(self)

    local res = string.format("    %s \"%s\" {\n", priv.base_name, priv.name)
    for i = 1, #priv.fields do
        res = res.."        "..priv.fields[i]:serialize(priv.values[i])..'\n'
    end
    return res.."}\n"
end

--=========
-- Private
--=========

local private_data = {}
---@param self FdfSubobject
---@return FdfSubobjectPrivate
function private.new(self, base_name, name)
    ---@class FdfSubobjectPrivate
    local priv = {
        base_name = base_name,
        name = name,
        fields = {},
        values = {}
    }
    private_data[self] = priv
    return priv
end

---@param self FdfSubobject
---@return FdfSubobjectPrivate
function private.get(self)
    return private_data[self]
end

---@param self FdfSubobject
function private.free(self)
    private_data[self] = nil
end

return FdfSubobject