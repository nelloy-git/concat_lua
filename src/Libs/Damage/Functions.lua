--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type TypesLib
local TypeLib = lib_dep.Types or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type DamageSettings
local Settings = require(lib_path..'Settings')

--========
-- Module
--========

---@class DamageFunctions
local DamageFunctions = {}

---@param dmg number
---@param dmg_type damagetype
---@param is_attack boolean
---@param targ Unit
---@param src Unit
---@param sound weapontype
function DamageFunctions.damageUnit(dmg, dmg_type, is_attack, targ, src, sound)
    isTypeErr(dmg, 'number', 'dmg')
    isTypeErr(dmg_type, 'damagetype', 'dmg_type')
    isTypeErr(targ, Unit, 'targ')
    isTypeErr(src, Unit, 'src')
    isTypeErr(sound, 'weapontype', 'sound')

    UnitDamageTarget(src:getData(), targ:getData(),
                     dmg, is_attack, false, ATTACK_TYPE_CHAOS, dmg_type, sound)
end

---@param dmg number
---@param targ Unit
---@param src Unit
function DamageFunctions.dealAtk(dmg, targ, src)
    DamageFunctions.damageUnit(dmg, Settings.Atk, true, targ, src, WEAPON_TYPE_WHOKNOWS)
end

---@param dmg number
---@param targ Unit
---@param src Unit
function DamageFunctions.dealPhys(dmg, targ, src)
    DamageFunctions.damageUnit(dmg, Settings.Phys, false, targ, src, WEAPON_TYPE_WHOKNOWS)
end

---@param dmg number
---@param targ Unit
---@param src Unit
function DamageFunctions.dealMagic(dmg, targ, src)
    DamageFunctions.damageUnit(dmg, Settings.Magic, false, targ, src, WEAPON_TYPE_WHOKNOWS)
end

---@param dmg number
---@param targ Unit
---@param src Unit
function DamageFunctions.dealChaos(dmg, targ, src)
    DamageFunctions.damageUnit(dmg, Settings.Chaos, false, targ, src, WEAPON_TYPE_WHOKNOWS)
end

return DamageFunctions