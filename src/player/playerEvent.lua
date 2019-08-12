---@type Trigger
local Trigger = require('trigger.trigger')
---@type Players
local Players = require('player.player')

---@class PlayerEvent
local PlayerEvent = {}

function PlayerEvent.init()
    ---@type Trigger
    PlayerEvent.local_mouse_move = Trigger.new()
    PlayerEvent.local_mouse_move:addEvent_PlayerMouseMove(Players.getLocalPlayerIndex())
    print('PlayerEvent initialized')
end

return PlayerEvent