--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ParameterData
local Data = require('Parameter.Data')
local Param = Data.Type
---@type ParameterValueClass
local ParamValue = require('Parameter.Value')
local ValueType = ParamValue.ValuePos

local fmt = string.format

--=======
-- Class
--=======

local ParameterValueList = Class.new('ParameterValueList')
---@class ParameterValueList
local public = ParameterValueList.public
---@class ParameterValueListClass
local static = ParameterValueList.static
---@type ParameterValueListClass
local override = ParameterValueList.override
local private = {}

--========
-- Static
--========

---@param child_instance ParameterValueList | nil
---@return ParameterValueList
function static.new(child_instance)
    if child_instance and not Class.type(child_instance, ParameterValueList) then
        Log.error(ParameterValueList, '\"child_instance\" must be ParameterValueList or nil', 2)
    end

    local instance = Class.allocate(ParameterValueList)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param param ParameterTypeEnum
---@param value_type ParameterValueTypeEnum
---@param value number
function public:set(param, value_type, value)
    if not Data.isParamType(param) then
        Log.error(self, 'unknown parameter type.', 2)
    end
    private.data[self].value[param]:set(value_type, value)
end

---@param param ParameterTypeEnum
---@param value_type ParameterValueTypeEnum
---@param value number
function public:add(param, value_type, value)
    if not Data.isParamType(param) then
        Log.error(self, 'unknown parameter type.', 2)
    end
    private.data[self].value[param]:add(value_type, value)
end

---@param param ParameterTypeEnum
---@param value_type ParameterValueTypeEnum
---@return number
function public:get(param, value_type)
    if not Data.isParamType(param) then
        Log.error(self, 'unknown parameter type.', 2)
    end
    return private.data[self].value[param]:get(value_type)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ParameterValueList
function private.newData(self)
    local priv = {
        value = {}
    }
    private.data[self] = priv

    for _, param_type in pairs(Param) do
        local value = ParamValue.new()
        value:set(ValueType.BASE, 0)
        value:set(ValueType.MULT, 0)
        value:set(ValueType.ADDIT, 0)

        priv.value[param_type] = value
    end
end

return static