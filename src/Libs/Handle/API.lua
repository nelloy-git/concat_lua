---@class HandleLib
local HandleLibAPI = {}
Lib.start('HandleLib', {
    Binary = Lib.load(LibList.BinaryLib) or error(''),
    Class = Lib.load(LibList.ClassLib) or error(''),
    Types = Lib.load(LibList.TypesLib) or error(''),
    Utils = Lib.load(LibList.UtilsLib) or error('')
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type AbilityClass
HandleLibAPI.Ability = require(path..'Types.Ability') or error('')
---@type DestructableClass
HandleLibAPI.Destructable = require(path..'Types.Destructable') or error('')
---@type DummyAbilityClass
HandleLibAPI.DummyAbility = require(path..'Types.DummyAbility') or error('')
---@type EffectClass
HandleLibAPI.Effect = require(path..'Types.Effect') or error('')
---@type FrameClass
HandleLibAPI.Frame = require(path..'Types.Frame') or error('')
---@type ItemClass
HandleLibAPI.Item = require(path..'Types.Item') or error('')
---@type ProjectileClass
HandleLibAPI.Projectile = require(path..'Preset.Projectile') or error('')
---@type SmartTimerClass
HandleLibAPI.SmartTimer = require(path..'Types.SmartTimer') or error('')
---@type TextTagClass
HandleLibAPI.TextTag = require(path..'Types.TextTag') or error('')
---@type TimerClass
HandleLibAPI.Timer = require(path..'Types.Timer') or error('')
---@type TimedObjClass
HandleLibAPI.TimedObj = require(path..'TimedObj') or error('')
---@type TriggerClass
HandleLibAPI.Trigger = require(path..'Types.Trigger') or error('')
---@type UnitClass
HandleLibAPI.Unit = require(path..'Types.Unit') or error('')
---@type WorldBarClass
HandleLibAPI.WorldBar = require(path..'Preset.WorldBar') or error('')

Lib.finish()

return HandleLibAPI