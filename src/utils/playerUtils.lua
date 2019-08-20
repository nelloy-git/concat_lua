---@class PlayerUtils
local PlayerUtils = {}

local local_player = nil
if not is_compiletime then
    local_player = GetLocalPlayer()
end

---Function forces player press button.
---@param key string
---@return nil
function PlayerUtils.forceUIKey(player, key)
    if player == local_player then
        key = string.upper(key)
        ForceUIKey(key)
    end
end

return PlayerUtils