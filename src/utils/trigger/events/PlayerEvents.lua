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
    PlayerEvent.__triggers["LocalPlayerMouseDown"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerMouseDown"]:addEvent_Player("MouseDown", GetLocalPlayer())

    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerEscDown"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerEscDown"]:addEvent_Keyboard("KeyDown", GetLocalPlayer(), OSKEY_ESCAPE)


    initialized = true
end

---@param event UnitEventName
function PlayerEvent.getTrigger(event)
    if not initialized then PlayerEvent.init() end
    return PlayerEvent.__triggers[event]
end

return PlayerEvent