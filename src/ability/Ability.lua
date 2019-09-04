---@type DataBase
local DataBase = require('utils.DataBase')

---@class Ability
local Ability = {
    __type = 'AbilityClass',
    __ui_db = DataBase.new('number', 'Ability'),
    __db = DataBase.new('number', 'Ability'),
}
local Ability_meta = {
    __type = 'Ability',
    __index = Ability
}

---@param self Ability
---@return string
function Ability_meta.__tostring(self)
    local str = string.format('%s %s (%s) with callbacks: ',self.__type, self.__name, ID2str(self.__id))
    local callbacks = ''
    if self:getCallback("startTargeting") then callbacks = callbacks ..',startTargeting' end
    if self:getCallback("targeting") then callbacks = callbacks ..',targeting' end
    if self:getCallback("cancelTargeting") then callbacks = callbacks ..',cancelTargeting' end
    if self:getCallback("start") then callbacks = callbacks ..',start' end
    if self:getCallback("casting") then callbacks = callbacks ..',casting' end
    if self:getCallback("cancel") then callbacks = callbacks ..',cancel' end
    if self:getCallback("interrupt") then callbacks = callbacks ..',interrupt' end
    if self:getCallback("finish") then callbacks = callbacks ..',finish' end
    callbacks = callbacks:sub(2)
    return str..callbacks
end

---@alias AbilityCallback fun(data:SpellData):boolean

---Create new Ability instance.
---@param id string|number
---@param ui_id string|number
---@param hotkey string
---@return Ability
function Ability.new(id, ui_id, hotkey)
    ---@type Ability
    local ability = {
        __id = ID(id),
        __ui_id = ID(ui_id),
        __hotkey = hotkey,

        __callbacks = {},
        __casting_time_func = nil,
    }
    setmetatable(ability, Ability_meta)
    Ability.__db:add(ID(id), ability)
    Ability.__ui_db:add(ID(ui_id), ability)

    Debug(ID2str(ability.__id), ID2str(ability.__ui_id))

    return ability
end

---Compiletime only
---@param src ChannelCompiletimeData
---@return number
function Ability.generateDummyAbility(src)
    local WeObjEdit = require('compiletime.objEdit.objEdit')
    local Channel = WeObjEdit.Preset.Channel

    ---@type ChannelCompiletimeData
    local ability = Channel.new(src)
    ability:setField('Name', src['Name']..'_Targeting')
    ability:setField('TooltipNormal', src['Name']..'_Targeting')
    ability:setField('Options', Channel.option.is_visible)
    ability:setField('TargetType', 'none')
    return ability:generate()
end

---@return number
function Ability:getId()
    return self.__id
end

---@return number
function Ability:getUI_Id()
    return self.__ui_id
end

function Ability:getHotkey()
    return self.__hotkey
end

---@param id number
---@return Ability
function Ability.get(id)
    local ability = Ability.__db:get(id)
    if not ability then
        ability = Ability.__ui_db:get(id)
    end
    return ability
end

---@param callback AbilityCallback
---@param callback_type AbilityEventName
function Ability:setCallback(callback, callback_type)
    self.__callbacks[callback_type] = callback
end

---@param callback_type AbilityEventName
---@return AbilityCallback
function Ability:getCallback(callback_type)
    return self.__callbacks[callback_type]
end

---@param callback_type AbilityEventName
---@param cast_data SpellData
---@return boolean
function Ability:runCallback(callback_type, cast_data)
    if type(self.__callbacks[callback_type]) == 'function' then
        return self.__callbacks[callback_type](cast_data)
    else
        return true
    end
end

---@alias AbilityFlag string
---| '"CanBeCanceled"'
---| '"CancelWithAnyOrder"'

---@param flag boolean
---@param flag_name AbilityFlag
function Ability:setFlag(flag, flag_name)
    self.__flag[flag_name] = flag
end

---@param flag_name AbilityFlag
---@return boolean
function Ability:getFlag(flag_name)
    return self.__flag[flag_name]
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
---@param player player
function Ability:setTooltip(tooltip, lvl, player)
    if player == nil then
        BlzSetAbilityTooltip(self.__ui_id, tooltip, lvl)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityTooltip(self.__ui_id, tooltip, lvl)
    end
end

---Function changes ability extended tooltip for player. (nil for all players)
---@param ext_tooltip string
---@param lvl integer
---@param player player
function Ability:setExtendedTooltip(ext_tooltip, lvl, player)
    if player == nil then
        BlzSetAbilityExtendedTooltip(self.__ui_id, ext_tooltip, lvl)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityExtendedTooltip(self.__ui_id, ext_tooltip, lvl)
    end
end

---Function changes ability icon for player. (nil for all players)
---@param icon_path string
---@param player player
function Ability:setIcon(icon_path, player)
    if player == nil then
        BlzSetAbilityIcon(self.__ui_id, icon_path)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityIcon(self.__ui_id, icon_path)
    end
end

---Function moves ability button to position. (nil for all players)
---@param x integer
---@param y integer
---@param player player
function Ability:setPosition(x, y, player)
    if player == nil then
        BlzSetAbilityPosX(self.__ui_id, x)
        BlzSetAbilityPosY(self.__ui_id, y)
    elseif player == GetLocalPlayer() then
        BlzSetAbilityPosX(self.__ui_id, x)
        BlzSetAbilityPosY(self.__ui_id, y)
    end
end

return Ability