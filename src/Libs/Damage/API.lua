---@class DamageLib
local DamageLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.Class),
    UtilsLib = require(LibList.Utils),
}

--=====
-- API
--=====

---@type DamageEvent
local DamageEvent = require(modname..'.Event')
DamageEvent.Init()
DamageLibAPI.DamageType = DamageEvent.DamageType
DamageLibAPI.addCallback = DamageEvent.addCallback
DamageLibAPI.removeCallback = DamageEvent.removeCallback
DamageLibAPI.damageUnit = DamageEvent.damageUnit
---@type DamageShowText
local DamageShowText = require(modname..'.ShowText')

Lib.finish()

return DamageLibAPI