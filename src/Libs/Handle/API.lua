---@class HandleLib
local HandleLibAPI = {}
Lib.start('HandleLib', {
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
---@type FrameClass
HandleLibAPI.Frame = require(path..'Types.Frame') or error('')
---@type ItemClass
HandleLibAPI.Item = require(path..'Types.Item') or error('')
---@type SmartTimerClass
HandleLibAPI.SmartTimer = require(path..'Types.SmartTimer') or error('')
---@type TextTagClass
HandleLibAPI.TextTag = require(path..'Types.TextTag') or error('')
---@type TimerClass
HandleLibAPI.Timer = require(path..'Types.Timer') or error('')
---@type TriggerClass
HandleLibAPI.Trigger = require(path..'Types.Trigger') or error('')
---@type UnitClass
HandleLibAPI.Unit = require(path..'Types.Unit') or error('')

Lib.finish()

return HandleLibAPI