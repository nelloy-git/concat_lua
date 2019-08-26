---@type Trigger
local Trigger = require('trigger.Trigger')

---@class PlayerEvent
local PlayerEvent = {
    __triggers = {}
}

---@alias PlayerEventName string
---| '"LocalPlayerMouseMove"'

local initialized = false
function PlayerEvent.init()
    if initialized then return nil end

    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerMouseMove"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerMouseMove"]:addEvent_PlayerMouseMove(GetLocalPlayer())
    ---@type Trigger

    initialized = true
end

---@param event UnitEventName
function PlayerEvent.getTrigger(event)
    if not initialized then PlayerEvent.init() end
    return PlayerEvent.__triggers[event]
end

return PlayerEvent