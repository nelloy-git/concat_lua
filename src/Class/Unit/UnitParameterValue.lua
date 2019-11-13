--=========
-- Include
--=========

---@type ParameterType
local ParameterType = require('ParameterType')
---@type ParameterValue
local ParameterValue = require('ParameterValue')
---@type ParameterType
local UnitParameterType = require('UnitParameterType')

--=======
-- Class
--=======

---@type UnitParameterValueClass
local UnitParameterValue = newClass('UnitUnitParameterValue', ParameterValue)

---@class UnitParameterValue
local public = UnitParameterValue.public
---@class UnitParameterValueClass
local static = UnitParameterValue.static
---@type table
local override = UnitParameterValue.override
---@type table(UnitParameterValue, table)
local private = {}


--=========
-- Methods
--=========

---@param owner unit
---@param unit_parameter_type UnitParameterType
---@param instance_data table | nil
---@return UnitParameterValue
function static.new(owner, unit_parameter_type, instance_data)
    local instance = instance_data or newInstanceData(UnitParameterValue)
    instance = ParameterValue.new(instance)
    local priv = {
        owner = owner,
        param_type = unit_parameter_type,
        result = 0
    }
    private[instance] = priv

    return instance
end

---@param value number
function public:setBase(value)
    ParameterValue.public.setBase(self, value)
    private.applyParameter(self)
end

---@param value number
function public:setMult(value)
    ParameterValue.public.setMult(self, value)
    private.applyParameter(self)
end

---@param value number
function public:setAdditive(value)
    ParameterValue.public.setAdditive(self, value)
    private.applyParameter(self)
end

---@return number
function public:getResult()
    local priv = private[self]
    return priv.result
end

---@param self UnitParameterValue
function private.applyParameter(self)
    local priv = private[self]
    priv.result = priv.param_type:math(self)
    priv.param_type:apply(priv.result, priv.owner)
end

return UnitParameterValue