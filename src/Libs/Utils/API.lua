---@class UtilsLib
local UtilsLibAPI = {}
local lib_modename = Compiletime(Lib.getModname())
Lib.start(lib_modename)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.ClassLib),
}

--=====
-- API
--=====

---@type ActionClass
UtilsLibAPI.Action = require(lib_modename..'.Action')
---@type ActionListClass
UtilsLibAPI.ActionList = require(lib_modename..'.ActionList')
---@type DataSyncClass
UtilsLibAPI.DataSync = require(lib_modename..'.DataSync')
UtilsLibAPI.DataSync.Init()
---@type UtilsFunctions
UtilsLibAPI.Functions = require(lib_modename..'.Functions')
---@type LoggerClass
UtilsLibAPI.Logger = require(lib_modename..'.Logger')
UtilsLibAPI.DefaultLogger = UtilsLibAPI.Logger.getDefault()

--=========
-- Handles
--=========

UtilsLibAPI.Handle = {}
---@type HandleClass
UtilsLibAPI.Handle.Base = require(lib_modename..'.Handle.Handle')

---@type AbilityClass
UtilsLibAPI.Handle.Ability = require(lib_modename..'.Handle.Ability')
---@type DestructableClass
UtilsLibAPI.Handle.Destructable = require(lib_modename..'.Handle.Destructable')
---@type FrameClass
UtilsLibAPI.Handle.Frame = require(lib_modename..'.Handle.Frame')
---@type ItemClass
UtilsLibAPI.Handle.Item = require(lib_modename..'.Handle.Item')
---@type SmartTimerClass
UtilsLibAPI.Handle.SmartTimer = require(lib_modename..'.Handle.SmartTimer')
---@type TextTagClass
UtilsLibAPI.Handle.TextTag = require(lib_modename..'.Handle.TextTag')
---@type TimerClass
UtilsLibAPI.Handle.Timer = require(lib_modename..'.Handle.Timer')
---@type TriggerClass
UtilsLibAPI.Handle.Trigger = require(lib_modename..'.Handle.Trigger')
---@type UnitClass
UtilsLibAPI.Handle.Unit = require(lib_modename..'.Handle.Unit')

--==================
-- Compiletime only
--==================

local _ = Compiletime(function() UtilsLibAPI.Icon = require(lib_modename..'.Icon') end)

Lib.finish()

return UtilsLibAPI