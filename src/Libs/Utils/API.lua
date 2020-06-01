---@class UtilsLib
local UtilsLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

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
UtilsLibAPI.Logger = require(modname..'.Logger')
UtilsLibAPI.DefaultLogger = UtilsLibAPI.Logger.getDefault()
---@type ObjClass
UtilsLibAPI.Obj = require(modname..'.Obj')
---@type ActionClass
UtilsLibAPI.Action = require(modname..'.Action')
---@type UtilsFunctions
UtilsLibAPI.Functions = require(modname..'.Functions')

-- Compiletime only
local _ = Compiletime(function() UtilsLibAPI.Icon = require(modname..'.Icon') end)

Lib.finish()

return UtilsLibAPI