---@class UtilsLib
local UtilsLibAPI = {}
Lib.start('UtilsLib', {
    Class = Lib.load(LibList.ClassLib) or error('')
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type ActionClass
UtilsLibAPI.Action = require(path..'Action') or error('')
---@type ActionListClass
UtilsLibAPI.ActionList = require(path..'ActionList') or error('')
---@type UtilsFunctions
local Functions = require(path..'Functions') or error('')
UtilsLibAPI.isType = Functions.checkType or error('')
UtilsLibAPI.isTypeErr = Functions.isTypeErr or error('')
UtilsLibAPI.getEnum = Functions.getUniqueNumber or error('')
UtilsLibAPI.pairsByKeys = Functions.pairsByKeys or error('')
---@type StringCommand
UtilsLibAPI.StringCommand = require(path..'StringCommand') or error('')
---@type UtilsSettings
local Settings = require(path..'Settings') or error('')
UtilsLibAPI.isDebug = Settings.isDebug
UtilsLibAPI.Log = Settings.default_logger

Lib.finish()

return UtilsLibAPI