---@type Trigger
local Trigger = require('trigger.trigger')
---@type Player
local Player = require('player.player')

---@class PlayerEvent
local PlayerEvent = {
    __triggers = {}
}

local initialized = false
function PlayerEvent.init()
    if initialized then return nil end
    Player.init()
    ---@type Trigger
    PlayerEvent.__triggers["LocalPlayerMouseMove"] = Trigger.new()
    PlayerEvent.__triggers["LocalPlayerMouseMove"]:addEvent_PlayerMouseMove(Player.getLocal())
    initialized = true
end

---@alias PlayerEventName string
---| '"LocalPlayerMouseMove"'

---@param name UnitEventName
function PlayerEvent.getTrigger(name)
    if not initialized then PlayerEvent.init() end
    return PlayerEvent.__triggers[name]
end

return PlayerEvent