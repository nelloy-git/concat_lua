--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')

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

---@param child_instance table | nil
---@return ParameterValue
function static.new(child_instance)
    local instance = child_instance or Class.allocate(ParameterValue)
    private.newData(instance)

    return instance
end


--========
-- Public
--========

---@return number
function public:getBase()
    local priv = private[self]
    return priv.base
end

---@param value number
function public:setBase(value)
    local priv = private[self]
    priv.result_ready = false
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
    priv.result_ready = false
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
    priv.result_ready = false
    priv.additive = value
end

function public:free()
    private.freeData(self)
end

--=========
-- Private
--=========

---@param instance ParameterValue
function private.newData(instance)
    local priv = {
        base = 0,
        mult = 1,
        additive = 0,
    }
    private[instance] = priv
end

---@param instance ParameterValue
function private.freeData(instance)
    private[instance] = nil
end

return static