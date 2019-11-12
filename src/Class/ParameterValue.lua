--=========
-- Include
--=========

---@type ParameterType
local ParaameterType = require('ParameterType')

--=======
-- Class
--=======

---@type ParameterValueClass
local ParameterValue = newClass('ParameterValue')

---@class ParameterValue
local public = ParameterValue.public
---@class ParameterValueClass
local static = ParameterValue.static
---@type table
local override = ParameterValue.override
---@type table(ParameterValue, table)
local private = {}


--=========
-- Methods
--=========

---@param parameter_type ParameterType
---@param instance_data table | nil
---@return ParameterValue
function static.new(parameter_type, instance_data)
    local instance = instance_data or newInstanceData(ParameterValue)
    local priv = {
        param_type = parameter_type,
        base = 0,
        mult = 0,
        additive = 0
    }
    private[instance] = priv

    return instance
end

---@return number
function public:getBase()
    local priv = private[self]
    return priv.base
end

---@return number
function public:getMult()
    local priv = private[self]
    return priv.mult
end

---@return number
function public:getAdditive()
    local priv = private[self]
    return priv.additive
end

return ParameterValue