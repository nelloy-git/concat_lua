--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error()
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type ParameterTypeModule
local ParameterTypeModule = require(lib_path..'Type') or error('')
local isParameterType = ParameterTypeModule.isParameterType or error('')
local ParameterType = ParameterTypeModule.Enum or error('')
---@type ParameterValueClass
local Value = require(lib_path..'Value') or error('')
---@type ParameterValueTypeModule
local ValueTypeModule = require(lib_path..'ValueType') or error('')
local isValueType = ValueTypeModule.isValueType or error('')

--=======
-- Class
--=======

local ParameterContainer = Class.new('ParameterContainer')
---@class ParameterContainer
local public = ParameterContainer.public
---@class ParameterContainerClass
local static = ParameterContainer.static
---@type ParameterContainerClass
local override = ParameterContainer.override
local private = {}

--========
-- Static
--========

---@return ParameterContainer
function override.new(child)
    if child then isTypeErr(child, ParameterContainer, 'child') end

    local instance = child or Class.allocate(ParameterContainer)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param param ParameterType
---@param val_type ParameterValueType
---@param val number
---@return number
function public:add(param, val_type, val)
    if not isParameterType(param) then Log:err('variable \'param\' is not of type ParameterType.', 2) end
    if not isValueType(val_type) then Log:err('variable \'val_type\' is not of type ValueType.', 2) end
    local priv = private.data[self]

    local res = priv.values[param]:add(val_type, val)
    local min = ParameterTypeModule.getMin(param)
    local max = ParameterTypeModule.getMax(param)

    res = res < min and min or res
    res = res > max and max or res

    priv.actions:run(self, param)

    return res
end

---@param param ParameterType
---@param val_type ParameterValueType
---@return number
function public:get(param, val_type)
    if not isParameterType(param) then Log:err('variable \'param\' is not of type ParameterType.', 2) end
    if not isValueType(val_type) then Log:err('variable \'val_type\' is not of type ValueType.', 2) end
    return private.data[self].values[param]:get(val_type)
end

---@param param ParameterType
---@return number
function public:getResult(param)
    if not isParameterType(param) then Log:err('variable \'param\' is not of type ParameterType.', 2) end
    local priv = private.data[self]

    local res = priv.values[param]:getResult()
    local min = ParameterTypeModule.getMin(param)
    local max = ParameterTypeModule.getMax(param)

    res = res < min and min or res
    res = res > max and max or res

    return res
end

---@alias ParameterChangedCallback fun(container:ParameterContainer, param:ParameterType)

---@param callback ParameterChangedCallback
---@return Action
function public:addChangedAction(callback)
    return private.data[self].actions:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    return private.data[self].actions:remove(action)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ParameterContainer
function private.newData(self)
    local priv = {
        values = {},
        actions = ActionList.new(self)
    }
    private.data[self] = priv

    for _, param in pairs(ParameterType) do
        priv.values[param] = Value.new()
    end
end

return static