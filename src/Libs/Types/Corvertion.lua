--=========
-- Include
--=========

local lib_modname = Lib.current().modname
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local isTypeErr = Functions.isTypeErr
local getEnum = Functions.getUniqueNumber
---@type LoggerClass
local Logger = require(lib_modname..'.Logger')
local Log = Logger.getDefault()
---@type table<string, targettype>
local TargetType = require(lib_modname..'.Type.TargetType')

--========
-- Module
--========

---@class UtilsTypesConvertion
local TypesConvertion = {}

local target_type2str = {
    [TargetType.AIR] = 'air',
    [TargetType.ALIVE] = 'alive',
    [TargetType.ALLIES] = 'allies',
    [TargetType.ANCIENT] = 'ancient',
    [TargetType.DEAD] = 'dead',
    [TargetType.DEBRIS] = 'debris',
    [TargetType.DECORATION] = 'decoration',
    [TargetType.ENEMIES] = 'enemies',
    [TargetType.FRIEND] = 'friend',
    [TargetType.GROUND] = 'ground',
    [TargetType.HERO] = 'hero',
    [TargetType.INVULNERABLE] = 'invulnerable',
    [TargetType.ITEM] = 'item',
    [TargetType.MECHANICAL] = 'mechanical',
    [TargetType.NEUTRAL] = 'neutral',
    [TargetType.NONANCIENT] = 'nonancient',
    [TargetType.NONE] = 'none',
    [TargetType.NONHERO] = 'nonhero',
    [TargetType.NONSAPPER] = 'nonsapper',
    [TargetType.NOTSELF] = 'notself',
    [TargetType.ORGANIC] = 'organic',
    [TargetType.PLAYER] = 'player',
    [TargetType.PLAYERUNITS] = 'playerunits',
    [TargetType.SAPPER] = 'sapper',
    [TargetType.SELF] = 'self',
    [TargetType.STRUCTURE] = 'structure',
    [TargetType.TERRAIN] = 'terrain',
    [TargetType.TREE] = 'tree',
    [TargetType.VULNERABLE] = 'vulnerable',
    [TargetType.WALL] = 'wall',
}

function TypesConvertion.TargetTypetoStr(target_type)
    local res = target_type2str[target_type]
    if res == nil then
        Log:err('variable \'target_type\' is not of type targettype', 3)
    end
    return res
end

return TypesConvertion