--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local getEnum = UtilsLib.getEnum
local Log = UtilsLib.Log or error('')

--========
-- Module
--========

---@alias parametertype number

---@class ParameterType
local ParameterType = {}

ParameterType.Enum = {
    ---@type parametertype
    PDMG = getEnum(),
    ---@type parametertype
    PDEF = getEnum(),
    ---@type parametertype
    PRES = getEnum(),
    ---@type parametertype
    MDMG = getEnum(),
    ---@type parametertype
    MDEF = getEnum(),
    ---@type parametertype
    MRES = getEnum(),
    ---@type parametertype
    ASPD = getEnum(),
    ---@type parametertype
    CDR = getEnum(),
    ---@type parametertype
    CRES = getEnum(),
    ---@type parametertype
    DODGE = getEnum(),
    ---@type parametertype
    CRCH = getEnum(),
    ---@type parametertype
    CRDMG = getEnum(),
    ---@type parametertype
    LIFE = getEnum(),
    ---@type parametertype
    REGEN = getEnum(),
    ---@type parametertype
    Mana = getEnum(),
    ---@type parametertype
    RECOV = getEnum(),
    ---@type parametertype
    MSPD = getEnum(),
}

local parameter_type2str = {
    [ParameterType.Enum.PDMG] = 'PDMG',
    [ParameterType.Enum.PDEF] = 'PDEF',
    [ParameterType.Enum.PRES] = 'PRES',
    [ParameterType.Enum.MDMG] = 'MDMG',
    [ParameterType.Enum.MDEF] = 'MDEF',
    [ParameterType.Enum.MRES] = 'MRES',
    [ParameterType.Enum.ASPD] = 'ASPD',
    [ParameterType.Enum.CDR] = 'CDR',
    [ParameterType.Enum.CRES] = 'CRES',
    [ParameterType.Enum.DODGE] = 'DODGE',
    [ParameterType.Enum.CRCH] = 'CRCH',
    [ParameterType.Enum.CRDMG] = 'CRDMG',
    [ParameterType.Enum.LIFE] = 'LIFE',
    [ParameterType.Enum.REGEN] = 'REGEN',
    [ParameterType.Enum.MANA] = 'MANA',
    [ParameterType.Enum.RECOV] = 'RECOV',
    [ParameterType.Enum.MSPD] = 'MSPD',
}

---@param val any
---@return boolean
function ParameterType.isParameterType(val)
    if not parameter_type2str[val] then
        return false
    end
    return true
end

---@param atk_type attacktype
---@return string
function ParameterType.toStr(atk_type)
    local res = parameter_type2str[atk_type]
    if res == nil then
        Log:err('variable \'atk_type\' is not of type parametertype', 3)
    end
    return res
end

return ParameterType