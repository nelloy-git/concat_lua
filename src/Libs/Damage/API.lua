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

Lib.finish()

return DamageLibAPI