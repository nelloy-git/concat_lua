---@class DamageLib
local DamageLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.ClassLib),
    UtilsLib = require(LibList.UtilsLib),
}

--=====
-- API
--=====

---@type DamageDefines
local Defines = require(modname..'.Defines')
DamageLibAPI.DamageType = Defines.DamageType
---@type DamageEvent
local DamageEvent = require(modname..'.Event')
DamageEvent.Init()
DamageLibAPI.CallbackPriority = DamageEvent.CallbackPriority
DamageLibAPI.addCallback = DamageEvent.addAction
DamageLibAPI.removeCallback = DamageEvent.removeAction
DamageLibAPI.damageUnit = DamageEvent.damageUnit
---@type DamageShowText
local DamageShowText = require(modname..'.ShowText')

for _, dmg_type in pairs(Defines.DamageType) do
    DamageEvent.addAction(DamageShowText.DamageEvent,
                          dmg_type, DamageEvent.CallbackPriority.Lowest)
end

Lib.finish()

return DamageLibAPI