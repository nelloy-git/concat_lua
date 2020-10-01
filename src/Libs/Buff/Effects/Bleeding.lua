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

---@type ShieldBarClass
local ShieldBar = require(lib_path..'Effects.ShieldBar') or error('')
---@type BuffSettings
local Settings = require(lib_path..'Settings') or error('')

--========
-- Module
--========

---@class Bleeding
local Bleeding = {}

local active = {}
local max = {}
local bar = {}

---@param value number
---@param target Unit
function Bleeding.add(value, target)
    isTypeErr(value, 'number', 'value')
    isTypeErr(target, Unit, 'target')

    if value > 0 then
        local max_val = math.max((max[target] or 0) + value, 0)
        local val = math.max((active[target] or 0) + value, 0)

        if not bar[target] then bar[target] = ShieldBar.new(target) end
        bar[target]:updateValue(val, max_val)

        active[target] = val
        max[target] = max_val
    else
        local old_val = active[target] or 0
        local old_max = max[target] or 0

        local new_max = math.max(old_max + value, 0)
        local new_val = math.max(old_val + value, 0)

        active[target] = new_val > new_max and new_max or new_val
        max[target] = new_max

        if new_max <= 0 and bar[target] then
            bar[target]:destroy()
            bar[target] = nil
        else
            bar[target]:updateValue(new_val, new_max)
        end
    end
end

---@param target Unit
---@return number
function Bleeding.get(target)
    return active[target] or 0
end

---@param target Unit
---@return number
function Bleeding.getMax(target)
    return max[target] or 0
end

---@type DamageEventCallback
local damageEvent = function(dmg, dmg_type, target, src)
    local cur = active[target]
    if not cur then return dmg end

    if cur >= dmg then
        active[target] = cur - dmg
        if bar[target] then bar[target]:updateValue(active[target], max[target]) end
        dmg = 0
    else
        active[target] = nil
        max[target] = nil
        if bar[target] then bar[target]:destroy() end
        bar[target] = nil
        dmg = dmg - cur
    end

    return dmg
end

DamageLib.addAction(DamageLib.Atk, Settings.ShieldPriority, damageEvent)
DamageLib.addAction(DamageLib.Phys, Settings.ShieldPriority, damageEvent)
DamageLib.addAction(DamageLib.Magic, Settings.ShieldPriority, damageEvent)

return Bleeding