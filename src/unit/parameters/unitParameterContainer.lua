---@type UnitParameter
local UnitParameter = require('unit.parameters.unitParameter')
---@type UnitApplyParameter
--local ApplyParam = require('unit.parameters.unitApplyParameter')
---@type UnitMathParameter
local MathParam = require('unit.parameters.unitMathParameter')

---@class UnitParameterContainer
local ParameterContainer = {}
local ParameterContainer_meta = {__index = ParameterContainer}

---Create new ParameterContainer.
---@param unit Unit
---@return UnitParameterContainer
function ParameterContainer.new(unit)
    ---@type UnitParameterContainer
    local parameter_container = {
        owner = unit,

        attack = UnitParameter.new(unit, 1, ApplyParam.attack, MathParam.linear),
        attackSpeed = UnitParameter.new(unit, 2, ApplyParam.attackSpeed, MathParam.inverseLinear),
        armor = UnitParameter.new(unit, 0, ApplyParam.armor, MathParam.linear),

        spellPower = UnitParameter.new(unit, 0, ApplyParam.spellPower, MathParam.linear),
        castSpeed = UnitParameter.new(unit, 0, ApplyParam.castSpeed, MathParam.inversePercent, 25),
        resistance = UnitParameter.new(unit, 0, ApplyParam.resistance, MathParam.percent, 90),

        health = UnitParameter.new(unit, 100, ApplyParam.health, MathParam.linear),
        regeneration = UnitParameter.new(unit, 0, ApplyParam.regeneration, MathParam.linear),
        mana = UnitParameter.new(unit, 100, ApplyParam.mana, MathParam.linear),
        recovery = UnitParameter.new(unit, 0, ApplyParam.recovery, MathParam.linear),

        critChance = UnitParameter.new(unit, 0, ApplyParam.critChance, MathParam.percent, 100),
        critPower = UnitParameter.new(unit, 1, ApplyParam.critPower, MathParam.linear),
        dodge = UnitParameter.new(unit, 0, ApplyParam.dodgeChance, MathParam.percent, 75),
        cooldown = UnitParameter.new(unit, 0, ApplyParam.cooldown, MathParam.percent, 75),
    }
    setmetatable(parameter_container, ParameterContainer_meta)

    -- Add hero stats
    local string_id = ID2str(unit:getId())
    local first = string_id:sub(1, 1)
    if first == string.upper(first) then
        parameter_container.strength = UnitParameter.new(unit, 1, ApplyParam.strength, MathParam.linear)
        parameter_container.agility = UnitParameter.new(unit, 1, ApplyParam.agility, MathParam.linear)
        parameter_container.intelligence = UnitParameter.new(unit, 1, ApplyParam.intelligence, MathParam.linear)
    end

    return parameter_container
end

---Function adds attack damage to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addAttack(base, mult, bonus) self.attack:add(base, mult, bonus) end

---Function returns base, mult, bonus and result values of attack damage.
---@return number, number, number, number
function ParameterContainer:getAttack() return self.attack:get() end

---Function sets attacks per second.
---@param base number
function ParameterContainer:setAttacksPerSec(base) _, mult, bonus, _ = self.attackSpeed:get() self.attackSpeed:set(base, mult, bonus) end

---Function adds attack speed modifier. (-0.15 = -15%)
---@param mult number
function ParameterContainer:addAttackSpeed(mult) self.attackSpeed:add(0, mult, 0) end

---Function returns attacks per second, attack speed modifier and result attacks per second. (modifier: -0.15 = -15%)
---@return number, number, number
function ParameterContainer:getAttackSpeed() base, mult, _, res = self.attackSpeed:get() return base, mult, res end

---Function adds armor to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addArmor(base, mult, bonus) self.armor:add(base, mult, bonus) end

---Function returns base, mult, bonus and result armor.
---@return number, number, number, number
function ParameterContainer:getArmor() return self.armor:get() end

---Function adds spell power to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addSpellPower(base, mult, bonus) self.spellPower:add(base, mult, bonus) end

---Function returns base, mult, bonus and result spell power.
---@return number, number, number, number
function ParameterContainer:getSpellPower() return self.spellPower:get() end

---Function adds cast speed to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addCastSpeed(base, mult, bonus) self.castSpeed:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) cast speed.
---@return number, number, number, number
function ParameterContainer:getCastSpeed() return self.castSpeed:get() end

---Function adds resistance to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addResistance(base, mult, bonus) self.resistance:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) resistance.
---@return number, number, number, number
function ParameterContainer:getResistance() return self.resistance:get() end

---Function adds health to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addHealth(base, mult, bonus) self.health:add(base, mult, bonus) end

---Function returns base, mult, bonus and result health.
---@return number, number, number, number
function ParameterContainer:getHealth() return self.health:get() end

---Function adds regeneration to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addRegeneration(base, mult, bonus) self.regeneration:add(base, mult, bonus) end

---Function returns base, mult, bonus and result regeneration.
---@return number. number, number, number
function ParameterContainer:getRegeneration() return self.regeneration:get() end

---Function adds mana to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addMana(base, mult, bonus) self.mana:add(base, mult, bonus) end

---Function returns base, mult, bonus and result mana
---@return number, number, number, number
function ParameterContainer:getMana() return self.mana:get() end

---Function adds recovery to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addRecovery(base, mult, bonus) self.recovery:add(base, mult, bonus) end

---Function returns base, mult, bonus and result recovery.
---@return number, number, number, number
function ParameterContainer:getRecovery() return self.recovery:get() end

---Function adds critical strike chance to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addCritChance(base, mult, bonus) self.critChance:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) critical chance.
---@return number, number, number, number 
function ParameterContainer:getCritChance() return self.critChance:get() end

---Function adds critical strike power to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addCritPower(base, mult, bonus) self.critPower:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) critical power.
---@return number, number, number, number
function ParameterContainer:getCritPower() return self.critPower:get() end

---Function adds dodge chance to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addDodgeChance(base, mult, bonus) self.dodge:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) dodge.
---@return number, number, number, number
function ParameterContainer:getDodgeChance() return self.dodge:get() end

---Function adds cooldown modifier to unit.
---@param base number
---@param mult number
---@param bonus number
function ParameterContainer:addCooldown(base, mult, bonus) self.cooldown:add(base, mult, bonus) end

---Function returns base, mult, bonus and result(%) cooldown.
---@return number, number, number, number
function ParameterContainer:getCooldown() return self.cooldown:get() end

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