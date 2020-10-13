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

---@alias AbilityExtEvent number
---@table <string, AbilityExtEvent>
Event.Enum = {
    ---@type AbilityExtEvent
    CASTING_START = getEnum(),
    ---@type AbilityExtEvent
    CASTING_LOOP = getEnum(),
    ---@type AbilityExtEvent
    CASTING_CANCEL = getEnum(),
    ---@type AbilityExtEvent
    CASTING_INTERRUPT = getEnum(),
    ---@type AbilityExtEvent
    CASTING_FINISH = getEnum(),

    ---@type AbilityExtEvent
    COOLDOWN_LOOP = getEnum(),
    ---@type AbilityExtEvent
    CHARGES_CHANGED = getEnum(),

    ---@type AbilityExtEvent
    ERROR_ALREADY_CASTING = getEnum(),
    ---@type AbilityExtEvent
    ERROR_NO_CHARGES = getEnum(),
}

return Event