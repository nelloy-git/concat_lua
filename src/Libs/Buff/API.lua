---@class BuffLib
local BuffLibAPI = {}
Lib.start('Buff', {
    Class = Lib.load(LibList.ClassLib) or error(''),
    Damage = Lib.load(LibList.DamageLib) or error(''),
    Handle = Lib.load(LibList.HandleLib) or error(''),
    Parameter = Lib.load(LibList.ParameterLib) or error(''),
    Types = Lib.load(LibList.TypesLib) or error(''),
    Utils = Lib.load(LibList.UtilsLib) or error('')
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type BuffContainerClass
BuffLibAPI.Container = require(path..'.Container') or error('')
---@type BuffTypeClass
BuffLibAPI.Type = require(path..'.Type') or error('')
---@type BuffType
--BuffLibAPI.TestType = require(path..'.TestType') or error('')

---@type BuffEffectShield
local Shield = require(path..'Effects.Shield') or error('')
BuffLibAPI.addShield = Shield.add
BuffLibAPI.getShield = Shield.get
BuffLibAPI.getMaxShield = Shield.getMax

Lib.finish()

return BuffLibAPI