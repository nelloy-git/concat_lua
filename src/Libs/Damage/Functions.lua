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

--========
-- Module
--========

---@class DamageFunctions
local DamageFunctions = {}

---@param dmg number
---@param dmg_type damagetype
---@param is_attack boolean
---@param target Unit
---@param damager Unit
---@param sound weapontype
function DamageFunctions.damageUnit(dmg, dmg_type, is_attack, target, damager, sound)
    isTypeErr(dmg, 'number', 'dmg')
    isTypeErr(dmg_type, 'damagetype', 'dmg_type')
    isTypeErr(target, Unit, 'target')
    isTypeErr(damager, Unit, 'damager')
    isTypeErr(sound, 'weapontype', 'sound')

    UnitDamageTarget(damager:getData(), target:getData(),
                     dmg, is_attack, false, ATTACK_TYPE_CHAOS, dmg_type, sound)
end

return DamageFunctions