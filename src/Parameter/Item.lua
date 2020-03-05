--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ParameterData
local Data = require('Parameter.Data')
local Param = Data.Type
---@type ParameterValueListClass
local ValueList = require('Parameter.ValueList')
local ValueListPublic = Class.getPublic(ValueList)
---@type ParameterValueClass
local ParamValue = require('Parameter.Value')
local ValueType = ParamValue.ValuePos

local fmt = string.format

--=======
-- Class
--=======

local ParameterItem = Class.new('ParameterItem', ValueList)
---@class ParameterItem : ParameterValueList
local public = ParameterItem.public
---@class ParameterItemClass : ParameterValueListClass
local static = ParameterItem.static
---@type ParameterItemClass
local override = ParameterItem.override
local private = {}

--========
-- Static
--========

---@return ParameterItem
function static.new()
    local instance = Class.allocate(ParameterItem)
    instance = ValueList.new(instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:toString()
    local priv = private.data[self]

    local str = ''
    local list = priv.value
    for param, value in pairs(list) do
        local base = value:get(ValueType.BASE)
        local mult = value:get(ValueType.MULT)
        local addi = value:get(ValueType.ADDIT)
        if base ~= 0 or mult ~= 0 or addi ~= 0 then
            str = str..fmt(private.parameter_line, Data.getFullName(param), base, 100 * mult, addi)..'\n'
        end
    end

    if str:len() > 1 then
        return str:sub(1, str:len() - 1)
    else
        return ''
    end
end

--=========
-- Private
--=========

private.parameter_line = '%s: %d / %d%% / %d'

---@param self ParameterItem
function private.newData(self)
    for _, param_type in pairs(Param) do
        self:set(param_type, ValueType.BASE, 0)
        self:set(param_type, ValueType.MULT, 0)
        self:set(param_type, ValueType.ADDIT, 0)
    end
end

return static