--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type DamageLib
local DamageLib = lib_dep.Damage or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type BuffSettings
local Settings = require(lib_path..'Settings')

--========
-- Module
--========

---@class BuffEffectShield
local BuffEffectShield = {}

local active = {}
local max = {}

---@param value number
---@param target Unit
function BuffEffectShield.add(value, target)
    isTypeErr(value, 'number', 'value')
    isTypeErr(target, Unit, 'target')

    active[target] = (active[target] or 0) + value
    max[target] = (max[target] or 0) + value
end

---@param target Unit
---@return number
function BuffEffectShield.get(target)
    return active[target] or 0
end

---@param target Unit
---@return number
function BuffEffectShield.getMax(target)
    return max[target] or 0
end

---@type DamageEventCallback
local damageEvent = function(dmg, dmg_type, target, src)
    local cur = active[target]
    if not cur then return dmg end

    if cur >= dmg then
        active[target] = active[target] - dmg
        dmg = 0
    else
        active[target] = nil
        dmg = dmg - cur
    end

    return dmg
end

DamageLib.addAction(DamageLib.Atk, Settings.ShieldPriority, damageEvent)
DamageLib.addAction(DamageLib.Phys, Settings.ShieldPriority, damageEvent)
DamageLib.addAction(DamageLib.Magic, Settings.ShieldPriority, damageEvent)

return BuffEffectShield