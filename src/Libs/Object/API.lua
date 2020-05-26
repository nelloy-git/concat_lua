---@class ObjectLib
local ObjectLib = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.Class),
    UtilsLib = require(LibList.Utils)
}

--=====
-- API
--=====

---@type SimpleTimerClass
ObjectLib.SimpleTimer = require(modname..'.SimpleTimer')
---@type SmartTimerClass
ObjectLib.SmartTimer = require(modname..'.SmartTimer')
---@type TriggerClass
ObjectLib.Trigger = require(modname..'.Trigger')
---@type UnitClass
ObjectLib.Unit = require(modname..'.Unit')

Lib.finish()

return ObjectLib