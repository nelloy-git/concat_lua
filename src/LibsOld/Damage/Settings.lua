--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type TypesLib
local TypeLib = lib_dep.Types or error('')
local DamageType = TypeLib.DamageTypeEnum or error('')

--========
-- Module
--========

---@class DamageSettings
local DamageSettings = {}

DamageSettings.Atk = DamageType.NORMAL or error('')
DamageSettings.Phys = DamageType.FORCE or error('')
DamageSettings.Magic = DamageType.ENHANCED or error('')
DamageSettings.Chaos = DamageType.UNIVERSAL or error('')

return DamageSettings