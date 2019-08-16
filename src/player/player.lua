---@type PlayerDB
local PlayerDB = require('player.playerDB')
local PlayerIndexDB = {}

__replaced_class = {
    Player = Player
}
---@class Player
local Player = {}
local Player_meta = {
    __index = Player,
}

---@return Player|nil
function Player_meta.__call(index)
    if type(index) ~= 'integer' then return nil end
    return PlayerIndexDB[index]
end

---@param self Player
---@return string
function Player_meta.__tostring(self)
    return string.format("Player_%d", self:getIndex())
end

---@param index integer
---@return Player
local function newPlayer(index)
    ---@type Player
    local player = {
        index = index,
        player_obj = __replaced_class.Player(index)
    }
    setmetatable(player, Player_meta)
    PlayerDB.add(player.player_obj, player)
    PlayerIndexDB[index] = player

    return player
end

---@type Player
local local_player = nil

---@return nil
function Player.init()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        newPlayer(i)
    end
    local_player = PlayerDB.get(GetLocalPlayer())
end

---@return userdata
function Player:get()
    return self.player_obj
end

---@return integer
function Player:getIndex()
    return PlayerDB.index
end

---Function forces player press button.
---@param key string
---@return nil
function Player:forceUIKey(key)
    if self == local_player then
        key = string.upper(key)
        ForceUIKey(key)
    end
end

return Player