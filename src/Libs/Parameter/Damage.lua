--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type DamageLib
local DamageLib = lib_dep.Damage
local addDamageAction = DamageLib.addAction
local damageUnit = DamageLib.damageUnit
---@type TypesLib
local TypeLib = lib_dep.Types or error('')
local DamageType = TypeLib.DamageTypeEnum or error('')

---@type ParameterDefines
local Defines = require(lib_path..'Defines') or error('')
---@type ParameterSettings
local Settings = require(lib_path..'Settings')
---@type ParameterContainerUnitClass
local UnitContainer = require(lib_path..'Container.Unit')

--========
-- Module
--========

---@class ParameterDamage
local ParameterDamage = {}

---@param dmg number
---@param target Unit
---@param damager Unit
function ParameterDamage.dealPAtk(dmg, target, damager)
    damageUnit(dmg, Settings.PAtk, target, damager, WEAPON_TYPE_WHOKNOWS)
end

---@param dmg number
---@param target Unit
---@param damager Unit
function ParameterDamage.dealMAtk(dmg, target, damager)
    damageUnit(dmg, Settings.MAtk, target, damager, WEAPON_TYPE_WHOKNOWS)
end

---@param dmg number
---@param target Unit
---@param damager Unit
function ParameterDamage.dealPSpl(dmg, target, damager)
    damageUnit(dmg, Settings.PSpl, target, damager, WEAPON_TYPE_WHOKNOWS)
end

---@param dmg number
---@param target Unit
---@param damager Unit
function ParameterDamage.dealMSpl(dmg, target, damager)
    damageUnit(dmg, Settings.MSpl, target, damager, WEAPON_TYPE_WHOKNOWS)
end

---@type DamageEventCallback
local function damageEventCallback(dmg, dmg_type, target, damager)
    local damager_params = UnitContainer.get(damager)
    local target_params = UnitContainer.get(target)
    if not target_params or not damager_params then return dmg end

    -- Add magic damage to attacks
    if dmg_type == Settings.PAtk then
        local m_atk = damager_params:getResult(Defines.MagicalDamage)
        local m_dmg = m_atk * (1 + Settings.MAtkDispersion * (math.random() - 0.5))
        damageUnit(m_dmg, Settings.MAtk, true, target, damager, WEAPON_TYPE_WHOKNOWS)
    end

    local reduc = 0
    local def = 0
    if dmg_type == Settings.PAtk or dmg_type == Settings.PSpl then
        reduc = target_params:getResult(Defines.PhysicalDamageReduction)
        def = target_params:getResult(Defines.Defence)
    elseif dmg_type == Settings.PAtk or dmg_type == Settings.PSpl then
        reduc = target_params:getResult(Defines.MagicalDamageReduction)
        def = target_params:getResult(Defines.Resistance)
    end
    dmg = dmg * (1 - reduc) - def

    dmg = dmg > 0 and dmg or 0
    return dmg
end

addDamageAction(Settings.PAtk, Settings.DamageEventPriority, damageEventCallback)
addDamageAction(Settings.MAtk, Settings.DamageEventPriority, damageEventCallback)
addDamageAction(Settings.PSpl, Settings.DamageEventPriority, damageEventCallback)
addDamageAction(Settings.MSpl, Settings.DamageEventPriority, damageEventCallback)

return ParameterDamage