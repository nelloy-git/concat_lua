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

local ParameterItem = Class.new('ParameterItem')
---@class ParameterItem
local public = ParameterItem.public
---@class ParameterItemClass
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

private.data = setmetatable({}, {__mode = 'k'})

private.parameter_line = '%s: %d / %d%% / %d'

---@param self ParameterItem
function private.newData(self)
    local priv = {
        value = {}
    }
    private.data[self] = priv

    for _, cur_param in pairs(Param) do
        priv.value[cur_param] = ParamValue.new()
        priv.value[cur_param]:set(ValueType.BASE, 0)
        priv.value[cur_param]:set(ValueType.MULT, 0)
        priv.value[cur_param]:set(ValueType.ADDIT, 0)
    end
end

return static