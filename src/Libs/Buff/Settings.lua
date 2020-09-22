--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

--========
-- Module
--========

---@class BuffSettings
local BuffSettings = {}

BuffSettings.TimerPeriod = 0.05

BuffSettings.ShieldPriority = -1 -- Parameter damage event priority based

return BuffSettings