--=========
-- Include
--=========

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

---@param instance_data table | nil
---@return ParameterValue
function static.new(instance_data)
    local instance = instance_data or newInstanceData(ParameterValue)
    local priv = {
        base = 0,
        mult = 0,
        additive = 0,
    }
    private[instance] = priv

    return instance
end

---@return number
function public:getBase()
    local priv = private[self]
    return priv.base
end

---@param value number
function public:setBase(value)
    local priv = private[self]
    priv.base = value
end

---@return number
function public:getMult()
    local priv = private[self]
    return priv.mult
end

---@param value number
function public:setMult(value)
    local priv = private[self]
    priv.mult = value
end

---@return number
function public:getAdditive()
    local priv = private[self]
    return priv.additive
end

---@param value number
function public:setAdditive(value)
    local priv = private[self]
    priv.additive = value
end

return ParameterValue