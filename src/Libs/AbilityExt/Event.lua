--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList
local getEnum = UtilsLib.getEnum

--========
-- Module
--========

---@class AbilityExtEventModule
local Event = {}

---@alias AbilityExtEvent number
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

local actions = {}
for _, event in pairs(Event.Enum) do
    actions[event] = ActionList.new(Event)
end

---@param callback AbilityExtEventCallback
function Event.addAction(event, callback)
    -- TODO type check
    actions[event]:add(callback)
end

---@param event any
---@param abil any
function Event.run(event, abil)
    actions[event]:run(event, abil)
end

return Event