---@type DataBase
local DataBase = require('utils.DataBase')

---@class Ability
local Ability = {
    __type = 'AbilityClass',
    __dummy_db = DataBase.new('number', 'Ability'),
    __db = DataBase.new('number', 'Ability'),
}
local Ability_meta = {
    __type = 'Ability',
    __index = Ability
}

---@param self Ability
---@return string
function Ability_meta.__tostring(self)
    return string.format('%s %s (%s)',self.__type, self.__name, ID2str(self.__id))
end

---Create new Ability instance.
---@param id string|number
---@param hotkey string
---@return Ability
function Ability.new(id, hotkey)
    ---@type Ability
    local ability = {
        __id = ID(id),
        __hotkey = hotkey,
        ---@type table<AbilityEventName, AbilityCallback>
        __callbacks = {}
    }
    setmetatable(ability, Ability_meta)
    Ability.__db:add(ID(id), ability)

    return ability
end

---@param id string|number
function Ability:setDummyAbility(id)
    self.__dummy_id = ID(id)
    Ability.__dummy_db:add(ID(id), self)
end

---Compiletime only
---@param src ChannelCompiletimeData
---@return number
function Ability.generateDummyAbility(src)
    local WeObjEdit = require('compiletime.objEdit.objEdit')
    local Channel = WeObjEdit.Preset.Channel

    ---@type ChannelCompiletimeData
    local ability = Channel.new(src)
    ability:setField('Name', src['Name'])
    ability:setField('TooltipNormal', src['TooltipNormal'])
    ability:setField('Options', Channel.option.is_visible)
    ability:setField('TargetType', 'none')
    ability:setField('Cooldown', 0.1) -- Ability event need at least 0.05 sec cooldown
    return ability:generate()
end

---@return number
function Ability:getId()
    return self.__id
end

---@return number
function Ability:getDummyId()
    return self.__dummy_id
end

function Ability:getHotkey()
    return self.__hotkey
end

---@param unit unit
function Ability:giveToUnit(unit)
    UnitAddAbility(unit, self.__id)
    if self.__dummy_id then
        UnitAddAbility(unit, self.__dummy_id)
        SetPlayerAbilityAvailable(GetOwningPlayer(unit), self.__id, false)
    end
end

---@param id number
---@return Ability
function Ability.get(id)
    local ability = Ability.__db:get(id)
    if not ability then
        ability = Ability.__dummy_db:get(id)
    end
    return ability
end

---@return Ability
function Ability.GetSpellAbility()
    return Ability.get(GetSpellAbilityId())
end

return Ability