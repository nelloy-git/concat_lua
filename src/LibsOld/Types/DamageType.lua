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

---@class  DamageType2
local DamageType2 = {}

DamageType2.Enum = {
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
    [DamageType2.Enum.UNKNOWN] = 'UNKNOWN',
    [DamageType2.Enum.NORMAL] = 'NORMAL',
    [DamageType2.Enum.ENHANCED] = 'ENHANCED',
    [DamageType2.Enum.FIRE] = 'FIRE',
    [DamageType2.Enum.COLD] = 'COLD',
    [DamageType2.Enum.LIGHTNING] = 'LIGHTNING',
    [DamageType2.Enum.POISON] = 'POISON',
    [DamageType2.Enum.DISEASE] = 'DISEASE',
    [DamageType2.Enum.DIVINE] = 'DIVINE',
    [DamageType2.Enum.MAGIC] = 'MAGIC',
    [DamageType2.Enum.SONIC] = 'SONIC',
    [DamageType2.Enum.ACID] = 'ACID',
    [DamageType2.Enum.FORCE] = 'FORCE',
    [DamageType2.Enum.DEATH] = 'DEATH',
    [DamageType2.Enum.MIND] = 'MIND',
    [DamageType2.Enum.PLANT] = 'PLANT',
    [DamageType2.Enum.DEFENSIVE] = 'DEFENSIVE',
    [DamageType2.Enum.DEMOLITION] = 'DEMOLITION',
    [DamageType2.Enum.SLOW_POISON] = 'SLOW_POISON',
    [DamageType2.Enum.SPIRIT_LINK] = 'SPIRIT_LINK',
    [DamageType2.Enum.SHADOW_STRIKE] = 'SHADOW_STRIKE',
    [DamageType2.Enum.UNIVERSAL] = 'UNIVERSAL',
}

---@param val any
---@return boolean
function DamageType2.isDamageType(val)
    if not dmg_type2str[val] then
        return false
    end
    return true
end

---@param dmg_type damagetype
---@return string
function DamageType2.toStr(dmg_type)
    local res = dmg_type2str[dmg_type]
    if res == nil then
        Log:err('variable \'dmg_type\' is not of type damagetype', 3)
    end
    return res
end

return DamageType2