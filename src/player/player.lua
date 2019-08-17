---@type PlayerDB
local PlayerDB = require('player.playerDB')
local PlayerIndexDB = {}

__replaced_class = {
    Player = Player
}
---@class Player
Player = {}
local Player_meta = {
    __index = Player
}
setmetatable(Player, Player_meta)

---@param index integer
---@return Player|nil
function Player_meta.__call(_, index)
    if type(index) ~= 'number' then return nil end
    return PlayerIndexDB[math.floor(index)]
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

---@return Player
function Player.getLocal()
    return local_player
end

---@return userdata
function Player:get()
    return self.player_obj
end

---@return integer
function Player:getIndex()
    return self.index
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

local __replaced_functions = {
    GetOwningPlayer = GetOwningPlayer
}

---@param unit Unit
---@return Player
function GetOwningPlayer(unit)
    local player_obj = __replaced_functions.GetOwningPlayer(unit.unit_obj)
    return PlayerDB.get(player_obj)
end

return Player