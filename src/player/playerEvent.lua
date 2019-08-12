---@type Trigger
local Trigger = require('trigger.trigger')
---@type Player
local Player = require('player.player')

---@class PlayerEvent
local PlayerEvent = {}

function PlayerEvent.init()
    ---@type Trigger
    PlayerEvent.local_mouse_move = Trigger.new()
    PlayerEvent.local_mouse_move:addEvent_PlayerMouseMove(Player.getLocalPlayerIndex())
    print('PlayerEvent initialized')
end

return PlayerEvent