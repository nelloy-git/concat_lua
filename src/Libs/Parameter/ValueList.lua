--=========
-- Include
--=========

--region Include
local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class
---@type UtilsLib
local UtilsLib = lib_dep.UtilsLib
local isTypeErr = UtilsLib.isTypeErr

---@type ParameterClass
local Parameter = require(lib_path..'.Parameter')
---@type ParameterDefines
local Defines = require(lib_path..'.Defines')
---@type ParameterValueClass
local Value = require(lib_path..'.Value')
--endregion

--=======
-- Class
--=======

local ParameterValueList = Class.new('ParameterValuesList')
--region Class
---@class ParameterValueList
local public = ParameterValueList.public
---@class ParameterValueListClass
local static = ParameterValueList.static
---@type ParameterValueListClass
local override = ParameterValueList.override
local private = {}
--endregion

--========
-- Static
--========

---@return ParameterValueList
function override.new(child)
    if child then
        isTypeErr(child, ParameterValueList, 'child')
    end

    local instance = child or Class.allocate(ParameterValueList)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param param Parameter
---@param value number
function public:addBase(param, value)
    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    param_value:addBase(value)
end

---@param param Parameter
---@param value number
function public:addMult(param, value)
    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    param_value:addMult(value)
end

---@param param Parameter
---@param value number
function public:addAddit(param, value)
    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    param_value:addAddit(value)
end

---@param param Parameter
---@return number
function public:getBase(param)
    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    return param_value:getBase()
end

---@param param Parameter
---@return number
function public:getMult(param)
    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    return param_value:getMult()
end

---@param param Parameter
---@return number
function public:getAddit(param)
    ---@type ParameterValue
    local param_value = private.data[self].values[param]
    return param_value:getAddit()
end

---@param param Parameter
---@return number
function public:getResult(param)
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