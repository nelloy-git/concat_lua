local PlayerUtils = {
    __db = {}
}

local local_player

local initialized = false
function PlayerUtils.init()
    if initialized then return nil end

    local_player = GetLocalPlayer()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        PlayerUtils.__db[i] = Player(i)
    end

    initialized = true
end

---@param id number
---@return player
function PlayerUtils.get(id)
    return PlayerUtils.__db[id]
end

function PlayerUtils.getLocal()
    return local_player
end

return PlayerUtils