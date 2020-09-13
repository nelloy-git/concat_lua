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

---@class TargetTypeModule
local TargetTypeModule = {}

TargetTypeModule.Enum = {
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
    [TargetTypeModule.Enum.AIR] = 'air',
    [TargetTypeModule.Enum.ALIVE] = 'alive',
    [TargetTypeModule.Enum.ALLIES] = 'allies',
    [TargetTypeModule.Enum.ANCIENT] = 'ancient',
    [TargetTypeModule.Enum.DEAD] = 'dead',
    [TargetTypeModule.Enum.DEBRIS] = 'debris',
    [TargetTypeModule.Enum.DECORATION] = 'decoration',
    [TargetTypeModule.Enum.ENEMIES] = 'enemies',
    [TargetTypeModule.Enum.FRIEND] = 'friend',
    [TargetTypeModule.Enum.GROUND] = 'ground',
    [TargetTypeModule.Enum.HERO] = 'hero',
    [TargetTypeModule.Enum.INVULNERABLE] = 'invulnerable',
    [TargetTypeModule.Enum.ITEM] = 'item',
    [TargetTypeModule.Enum.MECHANICAL] = 'mechanical',
    [TargetTypeModule.Enum.NEUTRAL] = 'neutral',
    [TargetTypeModule.Enum.NONANCIENT] = 'nonancient',
    [TargetTypeModule.Enum.NONE] = 'none',
    [TargetTypeModule.Enum.NONHERO] = 'nonhero',
    [TargetTypeModule.Enum.NONSAPPER] = 'nonsapper',
    [TargetTypeModule.Enum.NOTSELF] = 'notself',
    [TargetTypeModule.Enum.ORGANIC] = 'organic',
    [TargetTypeModule.Enum.PLAYER] = 'player',
    [TargetTypeModule.Enum.PLAYERUNITS] = 'playerunits',
    [TargetTypeModule.Enum.SAPPER] = 'sapper',
    [TargetTypeModule.Enum.SELF] = 'self',
    [TargetTypeModule.Enum.STRUCTURE] = 'structure',
    [TargetTypeModule.Enum.TERRAIN] = 'terrain',
    [TargetTypeModule.Enum.TREE] = 'tree',
    [TargetTypeModule.Enum.VULNERABLE] = 'vulnerable',
    [TargetTypeModule.Enum.WALL] = 'wall',
}

---@param val any
---@return boolean
function TargetTypeModule.isTargetType(val)
    if target_type2str[val] then
        return true
    end
    return false
end

---@param target_type targettype
function TargetTypeModule.toStr(target_type)
    local res = target_type2str[target_type]
    if res == nil then
        Log:err('variable \'target_type\' is not of type targettype', 3)
    end
    return res
end

return TargetTypeModule