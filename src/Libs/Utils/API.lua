---@class UtilsLib
local UtilsLibAPI = {}
local lib_modname = Compiletime(Lib.getModname())
Lib.start(lib_modname)

--===========
-- Depencies
--===========


Lib.current().depencies = {
    Class = require(LibList.Class),
}

--=====
-- API
--=====

---@type ActionClass
UtilsLibAPI.Action = require(lib_modname..'.Action')
---@type CompiletimeDataClass
UtilsLibAPI.CompiletimeData = require(lib_modname..'.CompiletimeData')
---@type UtilsFunctions
UtilsLibAPI.Functions = require(lib_modname..'.Functions')
---@type LoggerClass
UtilsLibAPI.Logger = require(lib_modname..'.Logger')
UtilsLibAPI.DefaultLogger = UtilsLibAPI.Logger.getDefault()

--=========
-- Handles
--=========

UtilsLibAPI.Handle = {}
---@type HandleClass
UtilsLibAPI.Handle.Base = require(lib_modname..'.Handle.Handle')
---@type DestructableClass
UtilsLibAPI.Handle.Destructable = require(lib_modname..'.Handle.Destructable')
---@type FrameClass
UtilsLibAPI.Handle.Frame = require(lib_modname..'.Handle.Frame')
---@type ItemClass
UtilsLibAPI.Handle.Item = require(lib_modname..'.Handle.Item')
---@type SmartTimerClass
UtilsLibAPI.Handle.SmartTimer = require(lib_modname..'.Handle.SmartTimer')
---@type TimerClass
UtilsLibAPI.Handle.Timer = require(lib_modname..'.Handle.Timer')
---@type TriggerClass
UtilsLibAPI.Handle.Trigger = require(lib_modname..'.Handle.Trigger')
---@type UnitClass
UtilsLibAPI.Handle.Unit = require(lib_modname..'.Handle.Unit')

--==================
-- Compiletime only
--==================

local _ = Compiletime(function() UtilsLibAPI.Icon = require(lib_modname..'.Icon') end)

Lib.finish()

return UtilsLibAPI