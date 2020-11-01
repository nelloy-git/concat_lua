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

---@class AttackType
local AttackType = {}

AttackType.Enum = {
    ---@type attacktype
    NORMAL = ATTACK_TYPE_NORMAL or getEnum(),
    ---@type attacktype
    MELEE = ATTACK_TYPE_MELEE or getEnum(),
    ---@type attacktype
    PIERCE = ATTACK_TYPE_PIERCE or getEnum(),
    ---@type attacktype
    SIEGE = ATTACK_TYPE_SIEGE or getEnum(),
    ---@type attacktype
    MAGIC = ATTACK_TYPE_MAGIC or getEnum(),
    ---@type attacktype
    CHAOS = ATTACK_TYPE_CHAOS or getEnum(),
    ---@type attacktype
    HERO = ATTACK_TYPE_HERO or getEnum(),
}

local atk_type2str = {
    [AttackType.Enum.NORMAL] = 'NORMAL',
    [AttackType.Enum.MELEE] = 'MELEE',
    [AttackType.Enum.PIERCE] = 'PIERCE',
    [AttackType.Enum.SIEGE] = 'SIEGE',
    [AttackType.Enum.MAGIC] = 'MAGIC',
    [AttackType.Enum.CHAOS] = 'CHAOS',
    [AttackType.Enum.HERO] = 'HERO'
}

---@param val any
---@return boolean
function AttackType.isAttackType(val)
    if not atk_type2str[val] then
        return false
    end
    return true
end

---@param atk_type attacktype
---@return string
function AttackType.toStr(atk_type)
    local res = atk_type2str[atk_type]
    if res == nil then
        Log:err('variable \'atk_type\' is not of type attacktype', 3)
    end
    return res
end

return AttackType