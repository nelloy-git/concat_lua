--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

--========
-- Module
--========

---@class HandleSettings
local HandleSettings = {}

HandleSettings.TimedObjPeriod = 0.05
HandleSettings.WorldBarPeriod = 0.03

HandleSettings.DummyAbilityPoolSize = 30

return HandleSettings