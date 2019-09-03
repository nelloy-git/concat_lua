---@type Trigger
local Trigger = require('utils.trigger.Trigger')

---@class PlayerEvent
local PlayerEvent = {
    __triggers = {}
}

---@alias PlayerEventName string
---| '"LocalPlayerMouseMove"'
---| '"LocalPlayerKeyPressed"'

local initialized = false
function PlayerEvent.init()
    if initialized then return nil end

    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerMouseMove"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerMouseMove"]:addEvent_Player("MouseMove", GetLocalPlayer())

    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerKeyPressed"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerKeyPressed"]:addEvent_Player("Key", GetLocalPlayer())

    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerKeyDown"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerKeyDown"]:addEvent_Player("KeyDown", GetLocalPlayer())

    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerKeyUp"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerKeyUp"]:addEvent_Player("KeyUp", GetLocalPlayer())

    initialized = true
end

---@param event UnitEventName
function PlayerEvent.getTrigger(event)
    if not initialized then PlayerEvent.init() end
    return PlayerEvent.__triggers[event]
end

return PlayerEvent