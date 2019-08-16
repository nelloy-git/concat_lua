---@type Trigger
local Trigger = require('trigger.trigger')
---@type Player
local Player = require('player.player')

---@class PlayerEvent
local PlayerEvent = {}

function PlayerEvent.init()
    ---@type Trigger
    PlayerEvent.localPlayer_mouseMove = Trigger.new()
    PlayerEvent.localPlayer_mouseMove:addEvent_PlayerMouseMove(Player.)
    print('PlayerEvent initialized')
end

return PlayerEvent