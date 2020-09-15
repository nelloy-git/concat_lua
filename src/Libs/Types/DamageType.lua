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

---@class DamageTypeModule
local Module = {}

Module.Enum = {
    ---@type damagetype
    UNKNOWN = DAMAGE_TYPE_UNKNOWN or getEnum(),
    ---@type damagetype
    NORMAL = DAMAGE_TYPE_NORMAL or getEnum(),
    ---@type damagetype
    ENHANCED = DAMAGE_TYPE_ENHANCED or getEnum(),
    ---@type damagetype
    FIRE = DAMAGE_TYPE_FIRE or getEnum(),
    ---@type damagetype
    COLD = DAMAGE_TYPE_COLD or getEnum(),
    ---@type damagetype
    LIGHTNING = DAMAGE_TYPE_LIGHTNING or getEnum(),
    ---@type damagetype
    POISON = DAMAGE_TYPE_POISON or getEnum(),
    ---@type damagetype
    DISEASE = DAMAGE_TYPE_DISEASE or getEnum(),
    ---@type damagetype
    DIVINE = DAMAGE_TYPE_DIVINE or getEnum(),
    ---@type damagetype
    MAGIC = DAMAGE_TYPE_MAGIC or getEnum(),
    ---@type damagetype
    SONIC = DAMAGE_TYPE_SONIC or getEnum(),
    ---@type damagetype
    ACID = DAMAGE_TYPE_ACID or getEnum(),
    ---@type damagetype
    FORCE = DAMAGE_TYPE_FORCE or getEnum(),
    ---@type damagetype
    DEATH = DAMAGE_TYPE_DEATH or getEnum(),
    ---@type damagetype
    MIND = DAMAGE_TYPE_MIND or getEnum(),
    ---@type damagetype
    PLANT = DAMAGE_TYPE_PLANT or getEnum(),
    ---@type damagetype
    DEFENSIVE = DAMAGE_TYPE_DEFENSIVE or getEnum(),
    ---@type damagetype
    DEMOLITION = DAMAGE_TYPE_DEMOLITION or getEnum(),
    ---@type damagetype
    SLOW_POISON = DAMAGE_TYPE_SLOW_POISON or getEnum(),
    ---@type damagetype
    SPIRIT_LINK = DAMAGE_TYPE_SPIRIT_LINK or getEnum(),
    ---@type damagetype
    SHADOW_STRIKE = DAMAGE_TYPE_SHADOW_STRIKE or getEnum(),
    ---@type damagetype
    UNIVERSAL = DAMAGE_TYPE_UNIVERSAL or getEnum(),
}

local dmg_type2str = {
    [Module.Enum.UNKNOWN] = 'UNKNOWN',
    [Module.Enum.NORMAL] = 'NORMAL',
    [Module.Enum.ENHANCED] = 'ENHANCED',
    [Module.Enum.FIRE] = 'FIRE',
    [Module.Enum.COLD] = 'COLD',
    [Module.Enum.LIGHTNING] = 'LIGHTNING',
    [Module.Enum.POISON] = 'POISON',
    [Module.Enum.DISEASE] = 'DISEASE',
    [Module.Enum.DIVINE] = 'DIVINE',
    [Module.Enum.MAGIC] = 'MAGIC',
    [Module.Enum.SONIC] = 'SONIC',
    [Module.Enum.ACID] = 'ACID',
    [Module.Enum.FORCE] = 'FORCE',
    [Module.Enum.DEATH] = 'DEATH',
    [Module.Enum.MIND] = 'MIND',
    [Module.Enum.PLANT] = 'PLANT',
    [Module.Enum.DEFENSIVE] = 'DEFENSIVE',
    [Module.Enum.DEMOLITION] = 'DEMOLITION',
    [Module.Enum.SLOW_POISON] = 'SLOW_POISON',
    [Module.Enum.SPIRIT_LINK] = 'SPIRIT_LINK',
    [Module.Enum.SHADOW_STRIKE] = 'SHADOW_STRIKE',
    [Module.Enum.UNIVERSAL] = 'UNIVERSAL',
}

---@param val any
---@return boolean
function Module.isDamageType(val)
    if not dmg_type2str[val] then
        return false
    end
    return true
end

---@param dmg_type damagetype
---@return string
function Module.toStr(dmg_type)
    local res = dmg_type2str[dmg_type]
    if res == nil then
        Log:err('variable \'dmg_type\' is not of type damagetype', 3)
    end
    return res
end

return Module