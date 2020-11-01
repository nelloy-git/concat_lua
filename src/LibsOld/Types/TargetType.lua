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

---@alias targettype number

---@class TargetType
local TargetType = {}

TargetType.Enum = {
    ---@type targettype
    AIR = getEnum(),
    ---@type targettype
    ALIVE = getEnum(),
    ---@type targettype
    ALLIES = getEnum(),
    ---@type targettype
    ANCIENT = getEnum(),
    ---@type targettype
    DEAD = getEnum(),
    ---@type targettype
    DEBRIS = getEnum(),
    ---@type targettype
    DECORATION = getEnum(),
    ---@type targettype
    ENEMIES = getEnum(),
    ---@type targettype
    FRIEND = getEnum(),
    ---@type targettype
    GROUND = getEnum(),
    ---@type targettype
    HERO = getEnum(),
    ---@type targettype
    INVULNERABLE = getEnum(),
    ---@type targettype
    ITEM = getEnum(),
    ---@type targettype
    MECHANICAL = getEnum(),
    ---@type targettype
    NEUTRAL = getEnum(),
    ---@type targettype
    NONANCIENT = getEnum(),
    ---@type targettype
    NONE = getEnum(),
    ---@type targettype
    NONHERO = getEnum(),
    ---@type targettype
    NONSAPPER = getEnum(),
    ---@type targettype
    NOTSELF = getEnum(),
    ---@type targettype
    ORGANIC = getEnum(),
    ---@type targettype
    PLAYER = getEnum(),
    ---@type targettype
    PLAYERUNITS = getEnum(),
    ---@type targettype
    SAPPER = getEnum(),
    ---@type targettype
    SELF = getEnum(),
    ---@type targettype
    STRUCTURE = getEnum(),
    ---@type targettype
    TERRAIN = getEnum(),
    ---@type targettype
    TREE = getEnum(),
    ---@type targettype
    VULNERABLE = getEnum(),
    ---@type targettype
    WALL = getEnum()
}

local target_type2str = {
    [TargetType.Enum.AIR] = 'AIR',
    [TargetType.Enum.ALIVE] = 'ALIVE',
    [TargetType.Enum.ALLIES] = 'ALLIES',
    [TargetType.Enum.ANCIENT] = 'ANCIENT',
    [TargetType.Enum.DEAD] = 'DEAD',
    [TargetType.Enum.DEBRIS] = 'DEBRIS',
    [TargetType.Enum.DECORATION] = 'DECORATION',
    [TargetType.Enum.ENEMIES] = 'ENEMIES',
    [TargetType.Enum.FRIEND] = 'FRIEND',
    [TargetType.Enum.GROUND] = 'GROUND',
    [TargetType.Enum.HERO] = 'HERO',
    [TargetType.Enum.INVULNERABLE] = 'INVULNERABLE',
    [TargetType.Enum.ITEM] = 'ITEM',
    [TargetType.Enum.MECHANICAL] = 'MECHANICAL',
    [TargetType.Enum.NEUTRAL] = 'NEUTRAL',
    [TargetType.Enum.NONANCIENT] = 'NONANCIENT',
    [TargetType.Enum.NONE] = 'NONE',
    [TargetType.Enum.NONHERO] = 'NONHERO',
    [TargetType.Enum.NONSAPPER] = 'NONSAPPER',
    [TargetType.Enum.NOTSELF] = 'NOTSELF',
    [TargetType.Enum.ORGANIC] = 'ORGANIC',
    [TargetType.Enum.PLAYER] = 'PLAYER',
    [TargetType.Enum.PLAYERUNITS] = 'PLAYERUNITS',
    [TargetType.Enum.SAPPER] = 'SAPPER',
    [TargetType.Enum.SELF] = 'SELF',
    [TargetType.Enum.STRUCTURE] = 'STRUCTURE',
    [TargetType.Enum.TERRAIN] = 'TERRAIN',
    [TargetType.Enum.TREE] = 'TREE',
    [TargetType.Enum.VULNERABLE] = 'VULNERABLE',
    [TargetType.Enum.WALL] = 'WALL',
}

---@param val any
---@return boolean
function TargetType.isTargetType(val)
    if target_type2str[val] then
        return true
    end
    return false
end

---@param target_type targettype
function TargetType.toStr(target_type)
    local res = target_type2str[target_type]
    if res == nil then
        Log:err('variable \'target_type\' is not of type targettype', 3)
    end
    return res
end

return TargetType