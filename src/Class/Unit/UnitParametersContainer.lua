--=========
-- Include
--=========

---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')
---@type ParameterValueClass
local ParameterValue = require('Class.ParameterValue')

--=======
-- Class
--=======

---@type UnitParametersContainerClass
local UnitParametersContainer = newClass('UnitParametersContainer')

---@class UnitParametersContainerClass
local static = UnitParametersContainer.static
    static.new = 'function'
---@class UnitParametersContainer
local public = UnitParametersContainer.public
---@type table
local override = UnitParametersContainer.override
---@type table(UnitParametersContainer, table)
local private = {}

--=========
-- Methods
--=========

---@param owner unit
---@param instance_data table | nil
---@return UnitParametersContainer
function static.new(owner, instance_data)
    local instance = instance_data or newInstanceData(UnitParametersContainer)
    local priv = private.createPriv(owner)
    private[instance] = priv

    return instance
end

---@param param ParameterType
---@return number
function public:getResult(param)
    local priv = private[self]
    return priv.results[param]
end

---@return number
function public:getBase(param)
    local priv = private[self]
    return priv.values[param]:getBase()
end

---@param param ParameterType
---@param value number
function public:setBase(param, value)
    private[self].values[param]:setBase(value)
    private.update(self, param)
end

function public:addBase(param, value)
    self:setBase(param, self:getBase(param) + value)
end

---@return number
function public:getMult(param)
    local priv = private[self]
    return priv.values[param]:getMult()
end

---@param param ParameterType
---@param value number
function public:setMult(param, value)
    private[self].values[param]:setMult(value)
    private.update(self, param)
end

function public:addMult(param, value)
    self:setMult(param, self:getMult(param) + value)
end

---@return number
function public:getAdditive(param)
    local priv = private[self]
    return priv.values[param]:getAdditive()
end

---@param param ParameterType
---@param value number
function public:setAdditive(param, value)
    private[self].values[param]:setAdditive(value)
    private.update(self, param)
end

function public:addAdditive(param, value)
    self:setAdditive(param, self:getAdditive(param) + value)
end

---@return table
function private.createPriv(owner)
    local params = ParameterType.getList()
    local results = {}
    local values = {}
    for i = 1, #params do
        results[params[i]] = 0
        values[params[i]] = ParameterValue.new()
    end
    return {owner = owner, results = results, values = values}
end

---@param self UnitParametersContainer
---@param param ParameterType
function private.update(self, param)
    local priv = private[self]

    local values = priv.values[param]
    local old_val = priv.results[param]
    local new_val = param:math(values:getBase(), values:getMult(), values:getAdditive())

    priv.results[param] = new_val
    param:apply(priv.owner, old_val, new_val)
end

return UnitParametersContainer