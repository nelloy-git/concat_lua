--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Log = UtilsLib.Log or error('')

---@type ParameterValueTypeModule
local ValueTypeModule = require(lib_path..'ValueType') or error('')
local getDefault = ValueTypeModule.getDefault or error('')
local isValueType = ValueTypeModule.isValueType or error('')
local ValueType = ValueTypeModule.Enum or error('')
local ValueRes = ValueTypeModule.getResult or error('')

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
function override.new()
    local instance = Class.allocate(ParameterValue)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param val_type ParameterValueType
---@param val number
function public:add(val_type, val)
    if not isValueType(val_type) then Log:err('variable \'val_type\' is not of type ValueType.', 2) end
    local priv = private.data[self]

    priv.list[val_type] = priv.list[val_type] + val
    priv.res = ValueRes(priv.list)

    return priv.res
end

---@param val_type ParameterValueType
---@return number
function public:get(val_type)
    if not isValueType(val_type) then Log:err('variable \'val_type\' is not of type ValueType.', 2) end
    return private.data[self].list[val_type]
end

---@return number
function public:getResult()
    return private.data[self].res
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ParameterValue
function private.newData(self)
    local priv = {
        list = {},
        res = 1,
    }

    for _, val_type in pairs(ValueType) do
        priv.list[val_type] = getDefault(val_type)
    end

    private.data[self] = priv
end

return static