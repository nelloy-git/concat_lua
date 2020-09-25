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

---@class ParameterTypeModule
local ParameterType = {}

---@alias ParameterType number
---@type table<string, ParameterType>
ParameterType.Enum = {
    ---@type ParameterType
    PATK = getEnum(),
    ---@type ParameterType
    PSPD = getEnum(),
    ---@type ParameterType
    PDEF = getEnum(),
    ---@type ParameterType
    PRES = getEnum(),
    ---@type ParameterType
    MATK = getEnum(),
    ---@type ParameterType
    MSPD = getEnum(),
    ---@type ParameterType
    MDEF = getEnum(),
    ---@type ParameterType
    MRES = getEnum(),
    ---@type ParameterType
    CRIT = getEnum(),
    ---@type ParameterType
    LIFE = getEnum(),
    ---@type ParameterType
    REGE = getEnum(),
    ---@type ParameterType
    MANA = getEnum(),
    ---@type ParameterType
    RECO = getEnum(),
    ---@type ParameterType
    MOVE = getEnum(),
}

local min_values = {
    [ParameterType.Enum.PATK] = 0,
    [ParameterType.Enum.PSPD] = 0,
    [ParameterType.Enum.PDEF] = 0,
    [ParameterType.Enum.PRES] = -1,
    [ParameterType.Enum.MATK] = 0,
    [ParameterType.Enum.MSPD] = 0,
    [ParameterType.Enum.MDEF] = 0,
    [ParameterType.Enum.MRES] = -1,
    [ParameterType.Enum.CRIT] = 0,
    [ParameterType.Enum.LIFE] = 10,
    [ParameterType.Enum.REGE] = 0,
    [ParameterType.Enum.MANA] = 10,
    [ParameterType.Enum.RECO] = 0,
    [ParameterType.Enum.MOVE] = 0,
}

---@param param ParameterType
function ParameterType.getMin(param)
    local min = min_values[param]
    if not min then
        Log:err('Unknown ParameterType.', 2)
    end
    return min
end

local def_max = 10^10
local max_values = {
    [ParameterType.Enum.PATK] = def_max,
    [ParameterType.Enum.PSPD] = def_max,
    [ParameterType.Enum.PDEF] = def_max,
    [ParameterType.Enum.PRES] = 1,
    [ParameterType.Enum.MATK] = def_max,
    [ParameterType.Enum.MSPD] = def_max,
    [ParameterType.Enum.MDEF] = def_max,
    [ParameterType.Enum.MRES] = 1,
    [ParameterType.Enum.CRIT] = 1,
    [ParameterType.Enum.LIFE] = def_max,
    [ParameterType.Enum.REGE] = def_max,
    [ParameterType.Enum.MANA] = def_max,
    [ParameterType.Enum.RECO] = def_max,
    [ParameterType.Enum.MOVE] = 500,
}

---@param param ParameterType
function ParameterType.getMax(param)
    local max = max_values[param]
    if not max then
        Log:err('Unknown ParameterType.', 2)
    end
    return max
end

local to_str = {
    [ParameterType.Enum.PATK] = 'PATK',
    [ParameterType.Enum.PSPD] = 'PSPD',
    [ParameterType.Enum.PDEF] = 'PDEF',
    [ParameterType.Enum.PRES] = 'PRES',
    [ParameterType.Enum.MATK] = 'MATK',
    [ParameterType.Enum.MSPD] = 'MSPD',
    [ParameterType.Enum.MDEF] = 'MDEF',
    [ParameterType.Enum.MRES] = 'MRES',
    [ParameterType.Enum.CRIT] = 'CRIT',
    [ParameterType.Enum.LIFE] = 'LIFE',
    [ParameterType.Enum.REGE] = 'REGE',
    [ParameterType.Enum.MANA] = 'MANA',
    [ParameterType.Enum.RECO] = 'RECO',
    [ParameterType.Enum.MOVE] = 'MOVE',
}

---@param param ParameterType
function ParameterType.toStr(param)
    local str = to_str[param]
    if not str then
        Log:err('Unknown ParameterType.', 2)
    end
    return str
end

return ParameterType