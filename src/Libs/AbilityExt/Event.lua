--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local getEnum = UtilsLib.getEnum

--========
-- Module
--========

---@class AbilityExtEventModule
local Event = {}

---@alias AbilityExtTargetingEvent number
---@table <string, AbilityExtTargetingEvent>
Event.TargetingEnum = {
    ---@type AbilityExtTargetingEvent
    START = getEnum(),
    ---@type AbilityExtTargetingEvent
    CANCEL = getEnum(),
    ---@type AbilityExtTargetingEvent
    FINISH = getEnum(),
}

---@alias AbilityExtCastingEvent number
---@table <string, AbilityExtCastingEvent>
Event.CastingEnum = {
    ---@type AbilityExtCastingEvent
    START = getEnum(),
    ---@type AbilityExtCastingEvent
    LOOP = getEnum(),
    ---@type AbilityExtCastingEvent
    CANCEL = getEnum(),
    ---@type AbilityExtCastingEvent
    INTERRUPT = getEnum(),
    ---@type AbilityExtCastingEvent
    FINISH = getEnum(),
}

return Event