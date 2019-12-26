--=========
-- Include
--=========

local Class = require('Utils.Class')

---@type FdfFieldClass
local FdfField = require('compiletime.ObjectEdit.FdfField')
---@type FdfFieldClass
local FdfObject = require('compiletime.ObjectEdit.FdfObject')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local FdfSubobject = Class.newClass('FdfSubobject', FdfObject)

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
function override.new(base_name, name, instance_data)
    local instance = instance_data or Class.newInstanceData(FdfSubobject)
    instance = FdfObject.new(base_name, name, instance)
    private.new(instance, base_name, name)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    FdfObject.public.free(self)
end

function public:serialize()
    local priv = private.get(self)

    local res = string.format("%s \"%s\" {\n", self:getBaseName(), self:getName())
    local fields, values = self:getFields()
    for i = 1, #fields do
        res = res.."        "..fields[i]:serialize(values[i])..'\n'
    end
    return res.."    }"
end

---@return FdfObjectRuntime
function public:toRuntime()
    return {
        name = self:getName(),
        base_name = self:getBaseName()
    }
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