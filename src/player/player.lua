---@class Players
local Players = {}

local local_player = nil
local local_player_index = -1
local players_array = {}

function Players.init()
    local_player = GetLocalPlayer()
    local_player_index = player2index(local_player)
    for i = 1, bj_MAX_PLAYER_SLOTS do
        players_array[i] = Player(i - 1)
    end
end

function Players.getLocalPlayerIndex()
    return local_player_index
end

---Function forces player push button.
---@param index integer
---@param key string
function Players.forceUIKey(index, key)
    print(index, local_player_index)
    if index == local_player_index then
        ForceUIKey(key)
        print('Pressed')
    end
end

return Players