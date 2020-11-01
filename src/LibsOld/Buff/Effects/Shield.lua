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
local WorldBar = HandleLib.WorldBar or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type BuffSettings
local Settings = require(lib_path..'Settings') or error('')

--========
-- Module
--========

---@class BuffEffectShield
local BuffEffectShield = {}

local curShield = {}
local maxShield = {}
local barShield = {}

---@param value number
---@param target Unit
function BuffEffectShield.add(value, target)
    isTypeErr(value, 'number', 'value')
    isTypeErr(target, Unit, 'target')

    local new_max = (maxShield[target] or 0) + value
    new_max = new_max <= 0 and 0 or new_max

    local new_cur = (curShield[target] or 0) + ((value > 0) and value or 0)
    new_cur = new_cur > new_max and new_max or new_cur

    local bar = barShield[target]
    if new_cur > 0 and new_max > 0 then
        bar = bar or WorldBar.new(target)
        bar:setScale(0.85)
        bar:setHeight(170)
        bar:setColor(0.3, 0.9, 0.9, 1)
        bar:setValue(new_cur, new_max)
    else
        if bar then bar:destroy() end
        bar = nil
    end

    curShield[target] = (new_cur > 0) and new_cur or nil
    maxShield[target] = (new_max > 0) and new_max or nil
    barShield[target] = bar
end

---@param target Unit
---@return number
function BuffEffectShield.get(target)
    return curShield[target] or 0
end

---@param target Unit
---@return number
function BuffEffectShield.getMax(target)
    return maxShield[target] or 0
end

---@type DamageEventCallback
local damageEvent = function(dmg, dmg_type, target, src)
    local cur = curShield[target]
    if not cur then return dmg end

    cur = cur - dmg
    if cur <= 0 then
        -- Shield has been broken.
        if barShield[target] then barShield[target]:destroy() end

        curShield[target] = nil
        maxShield[target] = nil
        barShield[target] = nil

        return -cur
    else
        barShield[target]:setValue(cur, maxShield[target])
        curShield[target] = cur

        return 0
    end
end

DamageLib.addAction(DamageLib.Atk, Settings.ShieldPriority, damageEvent)
DamageLib.addAction(DamageLib.Phys, Settings.ShieldPriority, damageEvent)
DamageLib.addAction(DamageLib.Magic, Settings.ShieldPriority, damageEvent)

return BuffEffectShield