local Ability = require('baseClasses.Ability.AbilityData')

---Function changes ability tooltip for player. (nil for all players)
---@param name string
---@param player player
function Ability:setName(name, player)
    self.__name = name
    if not is_compiletime then
        if player == nil then
            BlzSetAbilityTooltip(self.__id, name, 1)
        elseif player == GetLocalPlayer() then
            BlzSetAbilityTooltip(self.__id, name, 1)
        end
    end
end

---@return string
function Ability:getName()
    return self.__name or "Noname"
end

---Function changes ability extended tooltip for player. (nil for all players)
---@param tooltip_func fun(unit:Unit):string
function Ability:setTooltipFunc(tooltip_func)
    self.__tooltip_func = tooltip_func
end

---@param unit Unit
function Ability:updateTooltipForOwner(unit)
    if unit:getOwner() ~= GetLocalPlayer() then return nil end

    local tooltip
    if type(self.__tooltip_func) ~= 'function' then
        tooltip = 'No tooltip'
    else
        tooltip = self.__tooltip_func(unit)
    end

    BlzSetAbilityExtendedTooltip(self.__id, tooltip, 0)
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