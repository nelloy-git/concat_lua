---@type UnitParameter
local UnitParameter = require('unitParameter.UnitParameter')
---@type DataBase
local DataBase = require('utils.DataBase')

local ApplyParam = require('unitParameter.applyFunc')
local MathParam = require('unitParameter.mathFunc')

---@class UnitParameterContainer
local ParameterContainer = {
    __type = 'ParameterContainerClass'
}
local ParameterContainer_meta = {
    __type = 'ParameterContainer',
    __index = ParameterContainer
}

local ParameterContainerDB = DataBase.new('userdata', 'ParameterContainer')

---Create new ParameterContainer.
---@param unit unit
---@return UnitParameterContainer
function ParameterContainer.new(unit)
    ---@type UnitParameterContainer
    local container = {}
    setmetatable(container, ParameterContainer_meta)
    ParameterContainerDB:add(unit, container)

    -- Add hero stats
    local string_id = ID2str(GetUnitTypeId(unit))
    local first = string_id:sub(1, 1)
    if first == string.upper(first) then
        container.__strength = UnitParameter.new(unit, 1, ApplyParam.strength, MathParam.linear)
        container.__agility = UnitParameter.new(unit, 1, ApplyParam.agility, MathParam.linear)
        container.__intelligence = UnitParameter.new(unit, 1, ApplyParam.intelligence, MathParam.linear)
    end

    -- Add hero stats
    container.__attack = UnitParameter.new(unit, 1, ApplyParam.attack, MathParam.linear)
    container.__attackSpeed = UnitParameter.new(unit, 2, ApplyParam.attackSpeed, MathParam.inverseLinear)
    container.__armor = UnitParameter.new(unit, 0, ApplyParam.armor, MathParam.linear)

    container.__spellPower = UnitParameter.new(unit, 0, ApplyParam.spellPower, MathParam.linear)
    container.__castSpeed = UnitParameter.new(unit, 0, ApplyParam.castSpeed, MathParam.inversePercent, 25)
    container.__resistance = UnitParameter.new(unit, 0, ApplyParam.resistance, MathParam.percent, 90)

    container.__health = UnitParameter.new(unit, 100, ApplyParam.health, MathParam.linear)
    container.__regeneration = UnitParameter.new(unit, 0, ApplyParam.regeneration, MathParam.linear)
    container.__mana = UnitParameter.new(unit, 100, ApplyParam.mana, MathParam.linear)
    container.__recovery = UnitParameter.new(unit, 0, ApplyParam.recovery, MathParam.linear)

    container.__criticalChance = UnitParameter.new(unit, 0, ApplyParam.criticalChance, MathParam.percent, 100)
    container.__criticalPower = UnitParameter.new(unit, 1, ApplyParam.criticalPower, MathParam.linear)
    container.__dodge = UnitParameter.new(unit, 0, ApplyParam.dodgeChance, MathParam.percent, 75)
    container.__cooldown = UnitParameter.new(unit, 0, ApplyParam.cooldown, MathParam.percent, 75)

    return container
end

---@param unit unit
---@return UnitParameterContainer
function ParameterContainer.get(unit)
    return ParameterContainerDB:get(unit)
end

---Function adds attack damage to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addAttack(base, multiplicator, bonus) self.__attack:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result values of attack damage.
---@return number, number, number, number
function ParameterContainer:getAttack() return self.__attack:get() end

---Function sets attacks per second.
---@param base number
function ParameterContainer:setAttacksPerSec(base) local _, multiplicator, bonus, _ = self.__attackSpeed:get() self.__attackSpeed:set(base, multiplicator, bonus) end

---Function adds attack speed modifier. (-0.15 = -15%)
---@param multiplicator number
function ParameterContainer:addAttackSpeed(multiplicator) self.__attackSpeed:add(0, multiplicator, 0) end

---Function returns attacks per second, attack speed modifier and result attacks per second. (modifier: -0.15 = -15%)
---@return number, number, number
function ParameterContainer:getAttackSpeed() local base, multiplicator, _, res = self.__attackSpeed:get() return base, multiplicator, res end

---Function adds armor to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addArmor(base, multiplicator, bonus) self.__armor:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result armor.
---@return number, number, number, number
function ParameterContainer:getArmor() return self.__armor:get() end

---Function adds spell power to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addSpellPower(base, multiplicator, bonus) self.__spellPower:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result spell power.
---@return number, number, number, number
function ParameterContainer:getSpellPower() return self.__spellPower:get() end

---Function adds cast speed to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addCastSpeed(base, multiplicator, bonus) self.__castSpeed:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result(%) cast speed.
---@return number, number, number, number
function ParameterContainer:getCastSpeed() return self.__castSpeed:get() end

---Function adds resistance to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addResistance(base, multiplicator, bonus) self.__resistance:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result(%) resistance.
---@return number, number, number, number
function ParameterContainer:getResistance() return self.__resistance:get() end

---Function adds health to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addHealth(base, multiplicator, bonus) self.__health:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result health.
---@return number, number, number, number
function ParameterContainer:getHealth() return self.__health:get() end

---Function adds regeneration to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addRegeneration(base, multiplicator, bonus) self.__regeneration:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result regeneration.
---@return number, number, number, number
function ParameterContainer:getRegeneration() return self.__regeneration:get() end

---Function adds mana to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addMana(base, multiplicator, bonus) self.__mana:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result mana
---@return number, number, number, number
function ParameterContainer:getMana() return self.__mana:get() end

---Function adds recovery to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addRecovery(base, multiplicator, bonus) self.__recovery:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result recovery.
---@return number, number, number, number
function ParameterContainer:getRecovery() return self.__recovery:get() end

---Function adds critical strike chance to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addCriticalChance(base, multiplicator, bonus) self.__criticalChance:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result(%) critical chance.
---@return number, number, number, number 
function ParameterContainer:getCriticalChance() return self.__criticalChance:get() end

---Function adds critical strike power to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addCriticalPower(base, multiplicator, bonus) self.__criticalPower:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result(%) critical power.
---@return number, number, number, number
function ParameterContainer:getCriticalPower() return self.__criticalPower:get() end

---Function adds dodge chance to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addDodgeChance(base, multiplicator, bonus) self.__dodge:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result(%) dodge.
---@return number, number, number, number
function ParameterContainer:getDodgeChance() return self.__dodge:get() end

---Function adds cooldown modifier to unit.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addCooldown(base, multiplicator, bonus) self.__cooldown:add(base, multiplicator, bonus) end

---Function returns base, multiplicator, bonus and result(%) cooldown.
---@return number, number, number, number
function ParameterContainer:getCooldown() return self.__cooldown:get() end

---Function adds strength to hero.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addStrength(base, multiplicator, bonus) if self.strength ~= nil then self.strength:add(base, multiplicator, bonus) end end

---Function returns base, multiplicator, bonus and result strength.
---@return number, number, number, number
function ParameterContainer:getStrength() if self.strength ~= nil then return self.strength:get() else return 0, 0, 0, 0 end end

---Function adds agility to hero.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addAgility(base, multiplicator, bonus) if self.agility ~= nil then self.agility:add(base, multiplicator, bonus) end end

---Function returns base, multiplicator, bonus and result agility.
---@return number, number, number, number
function ParameterContainer:getAgility() if self.agility ~= nil then return self.agility:get() else return 0, 0, 0, 0 end end

---Function adds intelligence to hero.
---@param base number
---@param multiplicator number
---@param bonus number
function ParameterContainer:addIntelligence(base, multiplicator, bonus) if self.intelligence ~= nil then self.intelligence:add(base, multiplicator, bonus) end end

---Function returns base, multiplicator, bonus and result intelligence.
---@return number, number, number, number
function ParameterContainer:getIntelligence() if self.intelligence ~= nil then return self.intelligence:get() else return 0, 0, 0, 0 end end

return ParameterContainer