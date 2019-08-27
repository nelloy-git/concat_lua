---@type Trigger
local Trigger = require('utils.trigger.Trigger')

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
    PlayerEvent.__triggers["LocalPlayerMouseMove"]:addEvent_Player("MouseMove", GetLocalPlayer())
    --PlayerEvent.__triggers["LocalPlayerMouseMove"]:addEvent_PlayerMouseMove(GetLocalPlayer())

    initialized = true
end

---@param event UnitEventName
function PlayerEvent.getTrigger(event)
    if not initialized then PlayerEvent.init() end
    return PlayerEvent.__triggers[event]
end

return PlayerEvent