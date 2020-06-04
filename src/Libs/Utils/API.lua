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

---@type LoggerClass
UtilsLibAPI.Logger = require(lib_modname..'.Logger')
UtilsLibAPI.DefaultLogger = UtilsLibAPI.Logger.getDefault()
---@type ActionClass
UtilsLibAPI.Action = require(lib_modname..'.Action')
---@type UtilsFunctions
UtilsLibAPI.Functions = require(lib_modname..'.Functions')

--=========
-- Handles
--=========

UtilsLibAPI.Handle = {}
---@type DestructableClass
UtilsLibAPI.Handle.Destructable = require(lib_modname..'.Handle.Destructable')
---@type SimpleFrameClass
UtilsLibAPI.Handle.SimpleFrame = require(lib_modname..'.Handle.SimpleFrame')
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