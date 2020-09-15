--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type UtilsLib
local UtilsLib = lib_deplsLib
local TextTag = UtilsLib.Handle.TextTag

---@type DamageDefines
local Defines = require(lib_path..'.Defines')
local DamageType = Defines.DamageType

--========
-- Module
--========

---@class DamageShowText
local DamageShowText = {}

DamageShowText.Colors = {}
DamageShowText.Colors[DamageType.PhysicalAttack] = {red = 220, green = 30, blue = 30, alpha = 200}
DamageShowText.Colors[DamageType.PhysicalSpell] = {red = 220, green = 30, blue = 30, alpha = 200}
DamageShowText.Colors[DamageType.MagicalAttack] = {red = 30, green = 30, blue = 220, alpha = 200}
DamageShowText.Colors[DamageType.MagicalSpell] = {red = 30, green = 30, blue = 220, alpha = 200}
DamageShowText.Colors[DamageType.ChaosAttack] = {red = 220, green = 220, blue = 220, alpha = 200}
DamageShowText.Colors[DamageType.ChaosSpell] = {red = 220, green = 220, blue = 220, alpha = 200}

DamageShowText.Height = {}
DamageShowText.Height[DamageType.PhysicalAttack] = 0
DamageShowText.Height[DamageType.PhysicalSpell] = 0
DamageShowText.Height[DamageType.MagicalAttack] = 40
DamageShowText.Height[DamageType.MagicalSpell] = 40
DamageShowText.Height[DamageType.ChaosAttack] = 80
DamageShowText.Height[DamageType.ChaosSpell] = 80

---@type DamageEventCallback
DamageShowText.DamageEvent = function(dmg, dmg_type, target, damager)
    if dmg < 1 then return dmg end

    local idmg, _ = math.modf(dmg)
    local sdmg = tostring(idmg)
    local color = DamageShowText.Colors[dmg_type]
    local height = DamageShowText.Height[dmg_type]
    TextTag.newTimedForUnit(sdmg, 0.0023 * 10,
                            color.red, color.green, color.blue, color.alpha,
                            target, height,
                            0.03, 0.03, 1)
    return dmg
end

return DamageShowText