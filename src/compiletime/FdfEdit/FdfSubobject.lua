--=========
-- Include
--=========

local Class = require('Utils.Class')
local Log = require('utils.Log')
local FdfObject = require('compiletime.FdfEdit.FdfObject')

---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfSubobject = Class.newClass('FdfSubobject', FdfObject)
---@class FdfSubobject : FdfObject
local public = FdfSubobject.public
---@class FdfSubobjectClass : FdfObjectClass
local static = FdfSubobject.static
local override = FdfSubobject.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_name string
---@param child_data FdfSubobject | nil
---@return FdfSubobject
function override.new(name, base_name, child_data)
    local instance = Class.newInstanceData(FdfSubobject, child_data)
    instance = FdfObject.new(name, base_name, instance)

    return instance
end

--========
-- Public
--========

---@return string
function public:serialize()
    local res = string.format("%s \"%s\" {\n", self:getBaseName(), self:getName())
    local fields, values = self:getFields()
    for i = 1, #fields do
        res = res.."    "..fields[i]:serialize(values[i])..'\n'
    end
    return res.."}"
end

---@return table
function public:toRuntime()
    return {
        name = self:getName(),
        base_name = self:getBaseName()
    }
end

function public:free()
    private.free(self)
    FdfObject.public.free(self)
end

return FdfSubobject