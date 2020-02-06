--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ParameterData
local Data = require('Parameter.TypeData')
local Param = Data.Type

--=======
-- Class
--=======

local ParameterValue = Class.new('ParameterValue')

---@class ParameterValue
local public = ParameterValue.public
---@class ParameterValueClass
local static = ParameterValue.static
---@type ParameterValueClass
local override = ParameterValue.override
local private = {}


--========
-- Static
--========

---@return ParameterValue
function static.new()
    local instance = Class.allocate(ParameterValue)
    private.newData(instance)

    return instance
end


--========
-- Public
--========

---@param value number
function public:setBase(value)
    local priv = private.data[self]
    priv.result_ready = false
    priv.base = value
end

---@param value number
function public:setAdditive(value)
    local priv = private.data[self]
    priv.result_ready = false
    priv.additive = value
end

---@param value number
function public:setMult(value)
    local priv = private.data[self]
    priv.result_ready = false
    priv.mult = value
end

---@return number
function public:getBase()
    local priv = private.data[self]
    return private.data[self].base
end

---@return number
function public:getMult()
    local priv = private.data[self]
    return priv.mult
end

---@return number
function public:getAdditive()
    local priv = private.data[self]
    return priv.additive
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ParameterValue
function private.newData(self)
    local priv = {
        base = 0,
        mult = 1,
        additive = 0,
    }
    private.data[self] = priv
end

---@param instance ParameterValue
function private.freeData(instance)
    private[instance] = nil
end

return static