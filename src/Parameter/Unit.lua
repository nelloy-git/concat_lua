--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ParameterData
local Data = require('Parameter.Data')
local Param = Data.Type
local ParamMath = Data.Math
local ParamDefault = Data.DefaultValue
---@type ParameterValueClass
local ParamValue = require('Parameter.Value')
local ValueType = ParamValue.ValueType
---@type fun(unit:unit, param:ParameterTypeEnum, value:number)
local ParameterUnitApply = require('Parameter.UnitApply')

--=======
-- Class
--=======

local ParameterUnit = Class.new('ParameterUnit')
---@class ParameterUnit
local public = ParameterUnit.public
---@class ParameterUnitClass
local static = ParameterUnit.static
---@type ParameterUnitClass
local override = ParameterUnit.override
local private = {}

--========
-- Static
--========

---@param owner unit
---@return ParameterUnit
function static.new(owner)
    local instance = Class.allocate(ParameterUnit)
    private.newData(instance, owner)

    return instance
end

---@param owner unit
---@return ParameterUnit
function static.get(owner)
    return private.db[owner]
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
    private.update(self, param)
end

---@param param ParameterTypeEnum
---@param value_type ParameterValueTypeEnum
---@param value number
function public:add(param, value_type, value)
    if not Data.isParamType(param) then
        Log.error(self, 'unknown parameter type.', 2)
    end
    private.data[self].value[param]:add(value_type, value)
    private.update(self, param)
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

---@param param ParameterTypeEnum
---@return number
function public:getResult(param)
    return private.data[self].result[param]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.db = setmetatable({},{__mode = 'kv'})

---@param self ParameterUnit
---@param param ParameterTypeEnum
function private.update(self, param)
    local priv = private.data[self]
    local value = priv.value[param]

    --local old_val = priv.result[param]
    priv.result[param] = ParamMath[param](value:get(ValueType.BASE),
                                          value:get(ValueType.MULT),
                                          value:get(ValueType.ADDIT))

    ParameterUnitApply(priv.owner, param, priv.result[param])
end

---@param self ParameterUnit
---@param owner unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        value = {},
        result = {}
    }

    private.data[self] = setmetatable(priv, private.metatable)
    private.db[owner] = self

    for _, cur_param in pairs(Param) do
        priv.value[cur_param] = ParamValue.new()
        priv.value[cur_param]:set(ValueType.BASE, ParamDefault[cur_param])
        private.update(self, cur_param)
    end
end

private.metatable = {
    __gc = function(priv) end
}

return static