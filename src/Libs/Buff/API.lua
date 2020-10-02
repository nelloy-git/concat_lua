---@class BuffLib
local BuffLibAPI = {}
Lib.start('Buff', {
    Binary = Lib.load(LibList.BinaryLib) or error(''),
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
BuffLibAPI.Container = require(path..'Container') or error('')
---@type BuffTypeClass
BuffLibAPI.Type = require(path..'Type') or error('')

---@type BuffClass
local Buff = require(path..'Buff') or error('')
BuffLibAPI.getBuffLoopPeriod = Buff.getPeriod

---@type BuffEffectShield
local Shield = require(path..'Effects.Shield') or error('')
BuffLibAPI.addShield = Shield.add
BuffLibAPI.getShield = Shield.get
BuffLibAPI.getMaxShield = Shield.getMax

Lib.finish()

return BuffLibAPI