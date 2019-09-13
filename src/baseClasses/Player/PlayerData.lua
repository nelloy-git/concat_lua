local DataBase= require('utils.DataBase')

local Player = {
    __db = {}
}

local local_player

local initialized = false
function Player.init()
    if initialized then return nil end

    local_player = GetLocalPlayer()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        Player.__db[i] = Player(i)
    end

    initialized = true
end

---@param id number
---@return player
function Player.get(id)
    return Player.__db[id]
end

function Player.getLocal()
    return local_player
end

return Player