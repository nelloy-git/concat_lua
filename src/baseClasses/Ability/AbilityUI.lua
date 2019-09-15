local Ability = require('baseClasses.Ability.AbilityData')

---@param name string
function Ability:setName(name)
    self.__name = name
end

---@return string
function Ability:getName()
    return self.__name or "Noname"
end

---Function changes ability tooltip for player. (nil for all players)
---@param tooltip string
---@param lvl integer
---@param player player
function Ability:setTooltip(tooltip, lvl, player)
    if player == nil then
        BlzSetAbilityTooltip(self.__id, tooltip, lvl)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityTooltip(self.__id, tooltip, lvl)
    end
end

---Function changes ability extended tooltip for player. (nil for all players)
---@param ext_tooltip string
---@param lvl integer
---@param player player
function Ability:setExtendedTooltip(ext_tooltip, player, lvl)
    if player == nil then
        BlzSetAbilityExtendedTooltip(self.__id, ext_tooltip, lvl)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityExtendedTooltip(self.__id, ext_tooltip, lvl)
    end
end

---Function changes ability icon for player. (nil for all players)
---@param icon_path string
---@param player player
function Ability:setIcon(icon_path, player)
    if player == nil then
        BlzSetAbilityIcon(self.__id, icon_path)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityIcon(self.__id, icon_path)
    end
end

---Function moves ability button to position. (nil for all players)
---@param x integer
---@param y integer
---@param player player
function Ability:setPosition(x, y, player)
    if player == nil then
        BlzSetAbilityPosX(self.__id, x)
        BlzSetAbilityPosY(self.__id, y)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityPosX(self.__id, x)
        BlzSetAbilityPosY(self.__id, y)
    end
end