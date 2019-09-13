local Ability = require('baseClasses.Ability.AbilityData')

---@param name string
function Ability:setName(name)
    self.__name = name
end

---@return string
function Ability:getName()
    return self.__name
end

---Function changes ability tooltip for player. (nil for all players)
---@param tooltip string
---@param lvl integer
---@param player player
function Ability:setTooltip(tooltip, lvl, player)
    local id = self.__dummy_id
    if not id then id = self.__id end

    if player == nil then
        BlzSetAbilityTooltip(id, tooltip, lvl)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityTooltip(id, tooltip, lvl)
    end
end

---Function changes ability extended tooltip for player. (nil for all players)
---@param ext_tooltip string
---@param lvl integer
---@param player player
function Ability:setExtendedTooltip(ext_tooltip, player, lvl)
    local id = self.__dummy_id
    if not id then id = self.__id end

    if player == nil then
        BlzSetAbilityExtendedTooltip(id, ext_tooltip, lvl)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityExtendedTooltip(id, ext_tooltip, lvl)
    end
end

---Function changes ability icon for player. (nil for all players)
---@param icon_path string
---@param player player
function Ability:setIcon(icon_path, player)
    local id = self.__dummy_id
    if not id then id = self.__id end

    if player == nil then
        BlzSetAbilityIcon(id, icon_path)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityIcon(id, icon_path)
    end
end

---Function moves ability button to position. (nil for all players)
---@param x integer
---@param y integer
---@param player player
function Ability:setPosition(x, y, player)
    local id = self.__dummy_id
    if not id then id = self.__id end

    if player == nil then
        BlzSetAbilityPosX(id, x)
        BlzSetAbilityPosY(id, y)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityPosX(id, x)
        BlzSetAbilityPosY(id, y)
    end
end

---@param unit unit
function Ability:showDummyButton(unit)
    if self.__dummy_id then
        local owner = GetOwningPlayer(unit)
        SetPlayerAbilityAvailable(owner, self.__id, false)
        SetPlayerAbilityAvailable(owner, self.__dummy_id, true)
    end
end

---@param unit unit
function Ability:showMainButton(unit)
    if self.__dummy_id then
        local owner = GetOwningPlayer(unit)
        SetPlayerAbilityAvailable(owner, self.__dummy_id, false)
        SetPlayerAbilityAvailable(owner, self.__id, true)
    end
end