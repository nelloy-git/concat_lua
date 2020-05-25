--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type UtilsLib
local UtilsLib = require(Lib.Utils)
local checkType = UtilsLib.Functions.checkType

---@type ParameterClass
local Parameter = require(__ParameterLib..'Parameter')
---@type ParameterDefines
local Defines = require(__ParameterLib..'Defines')
---@type ParameterValueClass
local Value = require(__ParameterLib..'Value')

--=======
-- Class
--=======

local ParameterValueList = Class.new('ParameterValuesList')
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

---@return ParameterValueList
function override.new()
    local instance = Class.allocate(ParameterValueList)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param param Parameter
---@param value number
function public:addBase(param, value)
    checkType(param, Parameter, 'param')

    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    param_value:addBase(value)
end

---@param param Parameter
---@param value number
function public:addMult(param, value)
    checkType(param, Parameter, 'param')

    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    param_value:addMult(value)
end

---@param param Parameter
---@param value number
function public:addAddit(param, value)
    checkType(param, Parameter, 'param')

    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    param_value:addAddit(value)
end

---@param param Parameter
---@return number
function public:getBase(param)
    checkType(param, Parameter, 'param')

    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    return param_value:getBase()
end

---@param param Parameter
---@return number
function public:getMult(param)
    checkType(param, Parameter, 'param')

    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    return param_value:getMult()
end

---@param param Parameter
---@return number
function public:getAddit(param)
    checkType(param, Parameter, 'param')

    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    return param_value:getAddit()
end

---@param param Parameter
---@return number
function public:getResult(param)
    checkType(param, Parameter, 'param')

    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    return param_value:getResult()
end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ParameterValueList
function private.newData(self)
    local priv = {
        values = {}
    }
    private.data[self] = priv

    for i = 1, #Defines.AllParameters do
        local param = Defines.AllParameters[i]
        priv.values[param] = Value.new(param)
    end
end

return static