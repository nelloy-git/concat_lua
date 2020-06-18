--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType

---@type ParameterClass
local Parameter = require(lib_modname..'.Parameter')
--endregion

--=======
-- Class
--=======

local ParameterValue = Class.new('ParameterValue')
--region Class
---@class ParameterValue
local public = ParameterValue.public
---@class ParameterValueClass
local static = ParameterValue.static
---@type ParameterValueClass
local override = ParameterValue.override
local private = {}
--endregion

--========
-- Static
--========

---@param param Parameter
---@return ParameterValue
function override.new(param)
    checkType(param, Parameter, 'param')

    local instance = Class.allocate(ParameterValue)
    private.newData(instance, param)

    return instance
end

--========
-- Public
--========

---@return Parameter
function public:getParameter()
    return private.data[self].param
end

---@param value number
function public:addBase(value)
    local priv = private.data[self]
    priv.base = priv.base + value
    priv.is_res_ready = false
end

---@param value number
function public:addMult(value)
    local priv = private.data[self]
    priv.mult = priv.mult + value
    priv.is_res_ready = false
end

---@param value number
function public:addAddit(value)
    local priv = private.data[self]
    priv.addit = priv.addit + value
    priv.is_res_ready = false
end

---@return number
function public:getBase()
    return private.data[self].base
end

---@return number
function public:getMult()
    return private.data[self].mult
end

---@return number
function public:getAddit()
    return private.data[self].addit
end

---@return number
function public:getResult()
    local priv = private.data[self]

    if not priv.is_res_ready then
        priv.res = priv.base * priv.mult + priv.addit
        priv.is_res_ready = true
    end

    return priv.res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ParameterValue
---@param param Parameter
function private.newData(self, param)
    local priv = {
        param = param,
        base = param:getDefault(),
        mult = 1,
        addit = 0,
        res = param:getDefault(),
        is_res_ready = true,
    }

    private.data[self] = priv
end

return static