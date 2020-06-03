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

---@type DestructableClass
UtilsLibAPI.Destructable = require(lib_modname..'.Handle.Destructable')
---@type ItemClass
UtilsLibAPI.Item = require(lib_modname..'.Handle.Item')
---@type SmartTimerClass
UtilsLibAPI.SmartTimer = require(lib_modname..'.Handle.SmartTimer')
---@type TimerClass
UtilsLibAPI.Timer = require(lib_modname..'.Handle.Timer')
---@type TriggerClass
UtilsLibAPI.Trigger = require(lib_modname..'.Handle.Trigger')
---@type UnitClass
UtilsLibAPI.Unit = require(lib_modname..'.Handle.Unit')

--==================
-- Compiletime only
--==================

local _ = Compiletime(function() UtilsLibAPI.Icon = require(lib_modname..'.Icon') end)

Lib.finish()

return UtilsLibAPI