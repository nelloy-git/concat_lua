---@class Player
local Player = {}

local local_player = nil
local local_player_index = -1
local players_array = {}

function Player.init()
    local_player = GetLocalPlayer()
    local_player_index = player2index(local_player)
    for i = 0, bj_MAX_PLAYER_SLOTS do
        table.insert(players_array, Player(i))
    end
end

function Player.getLocalPlayerIndex()
    return local_player_index
end

---Function forces player push button.
---@param index integer
---@param key string
function Player.forceUIKey(index, key)
    if players_array[index] == local_player then
        ForceUIKey(players_array[index], key)
    end
end

return Player