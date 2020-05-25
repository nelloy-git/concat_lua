---@class ObjectLib
local ObjectLib = {}
__ObjectLib = Compiletime(Lib.getSelf())

---@type SimpleTimerClass
ObjectLib.SimpleTimer = require(__ObjectLib..'SimpleTimer')
---@type SmartTimerClass
ObjectLib.SmartTimer = require(__ObjectLib..'SmartTimer')
---@type TriggerClass
ObjectLib.Trigger = require(__ObjectLib..'Trigger')

__ObjectLib = nil
return ObjectLib