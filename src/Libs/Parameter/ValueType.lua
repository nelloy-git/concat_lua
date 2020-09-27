--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local UtilsLib = lib_dep.Utils or error('')
local getEnum = UtilsLib.getEnum or error('')
local Log = UtilsLib.Log

--========
-- Module
--========

---@class ParameterValueTypeModule
local ValueType = {}

---@alias ParameterValueType number
ValueType.Enum = {
    ---@type ParameterValueType
    BASE = getEnum(),
    ---@type ParameterValueType
    MULT = getEnum(),
    ---@type ParameterValueType
    ADDIT = getEnum(),
}

---@param var any
---@return boolean
function ValueType.isValueType(var)
    for k, v in pairs(ValueType.Enum) do
        if var == v then
            return true
        end
    end
    return false
end

---@param list table<ParameterValueType, number>
---@return number
function ValueType.getResult(list)
    local base = list[ValueType.Enum.BASE]
    local mult = list[ValueType.Enum.MULT]
    local addit = list[ValueType.Enum.ADDIT]
    return base * mult + addit
end

local default = {
    [ValueType.Enum.BASE] = 0,
    [ValueType.Enum.MULT] = 1,
    [ValueType.Enum.ADDIT] = 0,
}

---@param val_type ParameterValueType
function ValueType.getDefault(val_type)
    local def = default[val_type]
    if not def then
        Log:err('Unknown ParameterValueType', 2)
    end
    return def
end

return ValueType