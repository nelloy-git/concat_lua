---@type AbilityDB
local AbilityDB = require('ability.AbilityDB')

require('ability.AbilityEvent')

---@class Ability
local Ability = {}
local Ability_meta = {
    __index = Ability
}

---@param self Ability
---@return string
function Ability_meta.__tostring(self)
    local str = string.format('Ability %s (%s) with callbacks: ', self:getName(), ID2str(self:getId()))
    local callbacks = ''
    if self:getCallback("start") then callbacks = callbacks ..',start' end
    if self:getCallback("casting") then callbacks = callbacks ..',casting' end
    if self:getCallback("interrupt") then callbacks = callbacks ..',interrupt' end
    if self:getCallback("finish") then callbacks = callbacks ..',finish' end
    callbacks = callbacks:sub(2)
    return str..callbacks
end

---@alias AbilityCallback fun(data:SpellData):boolean

---Create new Ability instance.
---@param id string|integer
---@return Ability
function Ability.new(id)
    id = ID(id)
    local ability = {
        __id = id,
        __callback = {},
        __casting_time_func = nil,
        __flag = {}
    }
    setmetatable(ability, Ability_meta)
    AbilityDB.add(id, ability)
    return ability
end

---@return integer
function Ability:getId()
    return self.__id
end

---@param callback AbilityCallback
---@param callback_type AbilityEventName
---@return nil
function Ability:setCallback(callback, callback_type)
    self.__callback[callback_type] = callback
end

---@param callback_type AbilityEventName
---@return AbilityCallback
function Ability:getCallback(callback_type)
    return self.__callback[callback_type]
end

---@param callback_type AbilityEventName
---@param cast_data SpellData
---@return boolean
function Ability:runCallback(callback_type, cast_data)
    if type(self.__callback[callback_type]) == 'function' then
        return self.__callback[callback_type](cast_data)
    end
    return true
end

---@alias AbilityWhileCastingFlag string
---| '"MoveInterrupt"'
---| '"DamagedInterrupt"'
---| '"AttackInterrupt"'
---| '"CastingInterrupt"'

---@param flag boolean
function Ability:setCanMoveWhileCasting(flag)
    self._can_move = flag
end

---@return boolean
function Ability:getCanMoveWhileCasting()
    return self._can_move
end

---Set ability casting time.
---@param func AbilityCallback
function Ability:setCastingTimeFunction(func)
    self.__casting_time_func = func
end

---@param data SpellData
---@return number
function Ability:getCastingTime(data)
    if type(self.__casting_time_func) == 'function' then
        return self.__casting_time_func(data)
    end
    return 0
end

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
---@param wc3_player wc3_Player
function Ability:setTooltip(tooltip, lvl, wc3_player)
    if wc3_player == nil then
        BlzSetAbilityTooltip(self.__id, tooltip, lvl)
    elseif wc3_player == GetLocalPlayer() then
        BlzSetAbilityTooltip(self.__id, tooltip, lvl)
    end
end

---Function changes ability extended tooltip for player. (nil for all players)
---@param ext_tooltip string
---@param lvl integer
---@param wc3_player wc3_Player
function Ability:setExtendedTooltip(ext_tooltip, lvl, wc3_player)
    if wc3_player == nil then
        BlzSetAbilityExtendedTooltip(self.__id, ext_tooltip, lvl)
    elseif wc3_player == GetLocalPlayer() then
        BlzSetAbilityExtendedTooltip(self.__id, ext_tooltip, lvl)
    end
end

---Function changes ability icon for player. (nil for all players)
---@param icon_path string
---@param wc3_player wc3_Player
function Ability:setIcon(icon_path, wc3_player)
    if wc3_player == nil then
        BlzSetAbilityIcon(self.__id, icon_path)
    elseif wc3_player == GetLocalPlayer() then
        BlzSetAbilityIcon(self.__id, icon_path)
    end
end

---Function moves ability button to position. (nil for all players)
---@param x integer
---@param y integer
---@param wc3_player wc3_Player
function Ability:setPosition(x, y, wc3_player)
    if wc3_player == nil then
        BlzSetAbilityPosX(self.__id, x)
        BlzSetAbilityPosY(self.__id, y)
    elseif wc3_player == GetLocalPlayer() then
        BlzSetAbilityPosX(self.__id, x)
        BlzSetAbilityPosY(self.__id, y)
    end
end

return Ability