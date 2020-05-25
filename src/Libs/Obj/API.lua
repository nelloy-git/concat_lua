---@class ObjLib
local ObjLibAPI = {}
__TimerLib = Compiletime(Lib.getSelf())

---@type ObjClass
ObjLibAPI.Object = require(__TimerLib..'Obj')

---@type FrameObjClass
ObjLibAPI.Frame = require(__TimerLib..'Frame')
---@type ItemObjClass
ObjLibAPI.Item = require(__TimerLib..'Item')
---@type TimerObjClass
ObjLibAPI.Timer = require(__TimerLib..'Timer')
---@type TriggerObjClass
ObjLibAPI.Trigger = require(__TimerLib..'Trigger')
---@type UnitObjClass
ObjLibAPI.Unit = require(__TimerLib..'Unit')


__TimerLib = nil
return ObjLibAPI