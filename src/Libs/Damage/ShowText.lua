--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local TextTag = UtilsLib.Handle.TextTag
local Action = UtilsLib.Action
local Unit = UtilsLib.Handle.Unit

---@type DamageEvent
local DamageEvent = require(lib_modname..'.Event')
local DamageType = DamageEvent.DamageType
--endregion

--========
-- Module
--========

---@class DamageShowText
local DamageShowText = {}

DamageShowText.Colors[DamageType.Physical] = {red = 220, green = 30, blue = 30, alpha = 200}
DamageShowText.Colors[DamageType.Magical] = {red = 30, green = 30, blue = 220, alpha = 200}
DamageShowText.Colors[DamageType.True] = {red = 220, green = 220, blue = 220, alpha = 200}

function DamageShowText.DamageEvent(dmg, dmg_type, target, damager)
    TextTag.newTimedForUnit(dmg)
    return dmg
end