---@class DamageLib
local DamageLibAPI = {}
Lib.start('Damage', {
    Handle = Lib.load(LibList.HandleLib) or error(''),
    Types = Lib.load(LibList.TypesLib) or error(''),
    Utils = Lib.load(LibList.UtilsLib) or error('')
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type DamageEvent
local DamageEvent = require(path..'Event')
DamageLibAPI.addAction = DamageEvent.addAction
DamageLibAPI.removeAction = DamageEvent.removeAction
---@type DamageFunctions
local DamageFunctions = require(path..'Functions')
DamageLibAPI.damageUnit = DamageFunctions.damageUnit

Lib.finish()

return DamageLibAPI