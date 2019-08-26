---@type UnitParameter
local UnitParameter = require('unitParameter.UnitParameter')
---@type UnitParameterContainerDB
local UnitParameterContainerDB = require('unitParameter.UnitParameterContainerDB')

local ApplyParam = require('unitParameter.applyFunc')
local MathParam = require('unitParameter.mathFunc')

---@class UnitParameterContainer
local ParameterContainer = {}
local ParameterContainer_meta = {__index = ParameterContainer}

---Create new ParameterContainer.
---@param wc3_unit wc3_Unit
---@return UnitParameterContainer
function ParameterContainer.new(wc3_unit)
    ---@type UnitParameterContainer
    local container = {}
    setmetatable(container, ParameterContainer_meta)
    UnitParameterContainerDB.add(wc3_unit)

    -- Add hero stats
    local string_id = ID2str(GetUnitTypeId(wc3_unit))
    local first = string_id:sub(1, 1)
    if first == string.upper(first) then
        container.__strength = UnitParameter.new(wc3_unit, 1, ApplyParam.strength, MathParam.linear)
        container.__agility = UnitParameter.new(wc3_unit, 1, ApplyParam.agility, MathParam.linear)
        container.__intelligence = UnitParameter.new(wc3_unit, 1, ApplyParam.intelligence, MathParam.linear)
    end

    -- Add hero stats
    container.__attack = UnitParameter.new(wc3_unit, 1, ApplyParam.attack, MathParam.linear)
    container.__attackSpeed = UnitParameter.new(wc3_unit, 2, ApplyParam.attackSpeed, MathParam.inverseLinear)
    container.__armor = UnitParameter.new(wc3_unit, 0, ApplyParam.armor, MathParam.linear)

    container.__spellPower = UnitParameter.new(wc3_unit, 0, ApplyParam.spellPower, MathParam.linear)
    container.__castSpeed = UnitParameter.new(wc3_unit, 0, ApplyParam.castSpeed, MathParam.inversePercent, 25)
    container.__resistance = UnitParameter.new(wc3_unit, 0, ApplyParam.resistance, MathParam.percent, 90)

    container.__health = UnitParameter.new(wc3_unit, 100, ApplyParam.health, MathParam.linear)
    container.__regeneration = UnitParameter.new(wc3_unit, 0, ApplyParam.regeneration, MathParam.linear)
    container.__mana = UnitParameter.new(wc3_unit, 100, ApplyParam.mana, MathParam.linear)
    container.__recovery = UnitParameter.new(wc3_unit, 0, ApplyParam.recovery, MathParam.linear)

    container.__critChance = UnitParameter.new(wc3_unit, 0, ApplyParam.critChance, MathParam.percent, 100)
    container.__critPower = UnitParameter.new(wc3_unit, 1, ApplyParam.critPower, MathParam.linear)
    container.__dodge = UnitParameter.new(wc3_unit, 0, ApplyParam.dodgeChance, MathParam.percent, 75)
    container.__cooldown = UnitParameter.new(wc3_unit, 0, ApplyParam.cooldown, MathParam.percent, 75)

    return container
end

---@param wc3_unit wc3_Unit
---@return UnitParameterContainer
function ParameterContainer.get(wc3_unit)
    return UnitParameterContainerDB.get(wc3_unit)
end

---Function adds attack damage to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addAttack(base, mult, bonus) self.__attack:add(base, mult, bonus) end

---Function returns base, mult, bonus and result values of attack damage.
---@return number, number, number, number
function ParameterContainer:getAttack() return self.__attack:get() end

---Function sets attacks per second.
---@param base number
function ParameterContainer:setAttacksPerSec(base) _, mult, bonus, _ = self.__attackSpeed:get() self.__attackSpeed:set(base, mult, bonus) end

---Function adds attack speed modifier. (-0.15 = -15%)
---@param mult number
function ParameterContainer:addAttackSpeed(mult) self.__attackSpeed:add(0, mult, 0) end

---Function returns attacks per second, attack speed modifier and result attacks per second. (modifier: -0.15 = -15%)
---@return number, number, number
function ParameterContainer:getAttackSpeed() base, mult, _, res = self.__attackSpeed:get() return base, mult, res end

---Function adds armor to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addArmor(base, mult, bonus) self.__armor:add(base, mult, bonus) end

---Function returns base, mult, bonus and result armor.
---@return number, number, number, number
function ParameterContainer:getArmor() return self.__armor:get() end

---Function adds spell power to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addSpellPower(base, mult, bonus) self.__spellPower:add(base, mult, bonus) end

---Function returns base, mult, bonus and result spell power.
---@return number, number, number, number
function ParameterContainer:getSpellPower() return self.__spellPower:get() end

---Function adds cast speed to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addCastSpeed(base, mult, bonus) self.__castSpeed:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) cast speed.
---@return number, number, number, number
function ParameterContainer:getCastSpeed() return self.__castSpeed:get() end

---Function adds resistance to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addResistance(base, mult, bonus) self.__resistance:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) resistance.
---@return number, number, number, number
function ParameterContainer:getResistance() return self.__resistance:get() end

---Function adds health to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addHealth(base, mult, bonus) self.__health:add(base, mult, bonus) end

---Function returns base, mult, bonus and result health.
---@return number, number, number, number
function ParameterContainer:getHealth() return self.__health:get() end

---Function adds regeneration to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addRegeneration(base, mult, bonus) self.__regeneration:add(base, mult, bonus) end

---Function returns base, mult, bonus and result regeneration.
---@return number. number, number, number
function ParameterContainer:getRegeneration() return self.__regeneration:get() end

---Function adds mana to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addMana(base, mult, bonus) self.__mana:add(base, mult, bonus) end

---Function returns base, mult, bonus and result mana
---@return number, number, number, number
function ParameterContainer:getMana() return self.__mana:get() end

---Function adds recovery to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addRecovery(base, mult, bonus) self.__recovery:add(base, mult, bonus) end

---Function returns base, mult, bonus and result recovery.
---@return number, number, number, number
function ParameterContainer:getRecovery() return self.__recovery:get() end

---Function adds critical strike chance to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addCritChance(base, mult, bonus) self.__critChance:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) critical chance.
---@return number, number, number, number 
function ParameterContainer:getCritChance() return self.__critChance:get() end

---Function adds critical strike power to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addCritPower(base, mult, bonus) self.__critPower:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) critical power.
---@return number, number, number, number
function ParameterContainer:getCritPower() return self.__critPower:get() end

---Function adds dodge chance to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addDodgeChance(base, mult, bonus) self.__dodge:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) dodge.
---@return number, number, number, number
function ParameterContainer:getDodgeChance() return self.__dodge:get() end

---Function adds cooldown modifier to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addCooldown(base, mult, bonus) self.__cooldown:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) cooldown.
---@return number, number, number, number
function ParameterContainer:getCooldown() return self.__cooldown:get() end

---Function adds strength to hero.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addStrength(base, mult, bonus) if self.strength ~= nil then self.strength:add(base, mult, bonus) end end

---Function returns base, mult, bonus and result strength.
---@return number, number, number, number
function ParameterContainer:getStrength() if self.strength ~= nil then return self.strength:get() else return 0, 0, 0, 0 end end

---Function adds agility to hero.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addAgility(base, mult, bonus) if self.agility ~= nil then self.agility:add(base, mult, bonus) end end

---Function returns base, mult, bonus and result agility.
---@return number, number, number, number
function ParameterContainer:getAgility() if self.agility ~= nil then return self.agility:get() else return 0, 0, 0, 0 end end

---Function adds intelligence to hero.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addIntelligence(base, mult, bonus) if self.intelligence ~= nil then self.intelligence:add(base, mult, bonus) end end

---Function returns base, mult, bonus and result intelligence.
---@return number, number, number, number
function ParameterContainer:getIntelligence() if self.intelligence ~= nil then return self.intelligence:get() else return 0, 0, 0, 0 end end

return ParameterContainer