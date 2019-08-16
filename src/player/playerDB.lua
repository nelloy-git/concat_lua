---@class PlayerDB
local PlayerDB = {}

---@param player_obj userdata
---@param player Player
---@return nil
function PlayerDB.add(player_obj, player)
    PlayerDB[player_obj] = player
end

---@param player_obj userdata
---@return nil
function PlayerDB.rm(player_obj)
    PlayerDB[player_obj] = nil
end

---@param player_obj userdata
---@return Player
function PlayerDB.get(player_obj)
    return PlayerDB[player_obj]
end

return PlayerDB