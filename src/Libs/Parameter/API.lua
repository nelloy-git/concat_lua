---@class ParameterLib
local ParameterLibAPI = {}
Lib.start('ParameterLib', {
    Asset = Lib.load(LibList.AssetLib) or error(''),
    Class = Lib.load(LibList.ClassLib) or error(''),
    Damage = Lib.load(LibList.DamageLib) or error(''),
    Handle = Lib.load(LibList.HandleLib) or error(''),
    Types = Lib.load(LibList.TypesLib) or error(''),
    Utils = Lib.load(LibList.UtilsLib) or error(''),
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type ParameterTypeModule
local ParameterTypeModule = require(path..'Type') or error('')
ParameterLibAPI.ParamType = ParameterTypeModule.Enum or error('')
ParameterLibAPI.paramToStr = ParameterTypeModule.toStr or error('')
ParameterLibAPI.paramToColor = ParameterTypeModule.toColor or error('')
---@type ParameterValueTypeModule
local ParameterValueTypeModule = require(path..'ValueType') or error('')
ParameterLibAPI.ValueType = ParameterValueTypeModule.Enum

---@type ParameterContainerClass
ParameterLibAPI.Container = require(path..'Container') or error('')
---@type ParameterContainerUnitClass
ParameterLibAPI.UnitContainer = require(path..'Container.Unit') or error('')

---@type ParameterDamageEvent
local DamageEvent = require(path..'Damage')

Lib.finish()

return ParameterLibAPI