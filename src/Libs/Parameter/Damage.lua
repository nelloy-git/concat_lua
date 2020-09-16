--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type DamageLib
local DamageLib = lib_dep.Damage or error('')
local addDamageAction = DamageLib.addAction or error('')
local dealMagic = DamageLib.dealMagic or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Log = UtilsLib.Log or error('')

---@type ParameterDefines
local Defines = require(lib_path..'Defines') or error('')
---@type ParameterContainerUnit
local ParamUnit = require(lib_path..'Container.Unit') or error('')
---@type DamageSettings
local Settings = require(lib_path..'Settings') or error('')

--========
-- Module
--========

---@class ParameterDamageEvent
local ParameterDamageEvent = {}

---@type DamageEventCallback
local function damageAction(dmg, dmg_type, target, src)
    local p_targ = ParamUnit.get(target)
    local p_src = ParamUnit.get(src)
    if not p_targ or not p_targ then
        Log:wrn('Target or damager does not have linked '..tostring(ParamUnit)..' class.')
        return dmg
    end

    -- Add magic damage to attacks
    if dmg_type == DamageLib.Atk then
        local m_atk = p_src:getResult(Defines.MagicalDamage)
        local m_dmg = m_atk * (1 + Settings.MAtkDispersion * (math.random() - 0.5))
        dealMagic(m_dmg, target, src)
    end

    local reduc = 0
    local def = 0
    if dmg_type == DamageLib.Atk or dmg_type == DamageLib.Phys then
        reduc = p_targ:getResult(Defines.PhysicalDamageReduction)
        def = p_targ:getResult(Defines.Defence)
    elseif dmg_type == DamageLib.Magic then
        reduc = p_targ:getResult(Defines.MagicalDamageReduction)
        def = p_targ:getResult(Defines.Resistance)
    end
    dmg = dmg * (1 - reduc) - def

    dmg = dmg > 0 and dmg or 0
    return dmg
end
addDamageAction(DamageLib.Atk, Settings.DamageEventPriority, damageAction)
addDamageAction(DamageLib.Magic, Settings.DamageEventPriority, damageAction)
addDamageAction(DamageLib.Phys, Settings.DamageEventPriority, damageAction)
addDamageAction(DamageLib.Chaos, Settings.DamageEventPriority, damageAction)

return ParameterDamageEvent