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
local DamageEvent = require(path..'Event') or error('')
DamageLibAPI.addAction = DamageEvent.addAction or error('')
DamageLibAPI.removeAction = DamageEvent.removeAction or error('')
---@type DamageFunctions
local DamageFunctions = require(path..'Functions') or error('')
DamageLibAPI.dealAtk = DamageFunctions.dealAtk or error('')
DamageLibAPI.dealPhys = DamageFunctions.dealPhys or error('')
DamageLibAPI.dealMagic = DamageFunctions.dealMagic or error('')
DamageLibAPI.dealChaos = DamageFunctions.dealChaos or error('')
---@type DamageSettings
local Settings = require(path..'Settings')
DamageLibAPI.Atk = Settings.Atk
DamageLibAPI.Magic = Settings.Magic
DamageLibAPI.Phys = Settings.Phys
DamageLibAPI.Chaos = Settings.Chaos

Lib.finish()

return DamageLibAPI