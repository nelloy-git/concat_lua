---@class UtilsLib
local UtilsLibAPI = {}
__UtilsLib = Compiletime(Lib.getSelf())

---@type LoggerClass
UtilsLibAPI.Logger = require(__UtilsLib..'Logger')
UtilsLibAPI.DefaultLogger = UtilsLibAPI.Logger.getDefault()
---@type ObjClass
UtilsLibAPI.Obj = require(__UtilsLib..'Obj')
---@type ActionClass
UtilsLibAPI.Action = require(__UtilsLib..'Action')
---@type UtilsFunctions
UtilsLibAPI.Functions = require(__UtilsLib..'Functions')

-- Compiletime only
Compiletime(function() UtilsLibAPI.Icon = require(__UtilsLib..'Icon') end)

__UtilsLib = nil
return UtilsLibAPI