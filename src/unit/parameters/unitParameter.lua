---@type UnitApplyParameter
local ApplyParam = require('unit.parameters.unitApplyParameter')
---@type UnitMathParameter
local MathParam = require('unit.parameters.unitMathParameter')
---@type Utils
local utils = require('utils.utils')

---@class UnitParameter
local UnitParameter = {}

---Create new parameter for unit.
---@param owner_struct Unit
---@param base number
---@param apply_param_func UnitApplyParameterFunc
---@param math_func UnitMathParameterFunc
---@param max_val number
---@return UnitParameter
function UnitParameter.new(owner_struct, base, apply_param_func, math_func, max_val)
    local container = {
        owner_struct = owner_struct,
        base = base,
        bonus = 0,
        mult = 1,
        cap = max_val,
        apply_param_func = apply_param_func,
        math_func = math_func
    }
    setmetatable(container, {__index = UnitParameter})
    container:update()
    return container
end

---@param unit Unit
---@return table
function UnitParameter.addContainer(unit)
    if unit.parameters ~= nil then
        print('UnitParameter: can not add second parameter container to unit.')
        print(utils.getErrorPos())
        return nil
    end

    ---@type table<string,UnitParameter>
    local parameters = {
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

    -- Add hero stats
    if unit.id:sub(1,1) == string.upper(unit.id:sub(1,1)) then
        parameters.strength = UnitParameter.new(unit, 0, ApplyParam.strength, MathParam.linear)
        parameters.agility = UnitParameter.new(unit, 0, ApplyParam.agility, MathParam.linear)
        parameters.intelligence = UnitParameter.new(unit, 0, ApplyParam.intelligence, MathParam.linear)
    end

    unit.parameters = parameters
end

---Recomend use in tests only. Function set parameter of unit.
---@param base number
---@param mult number
---@param bonus number
function UnitParameter:set(base, mult, bonus)
    self.base = base
    self.mult = mult
    self.bonus = bonus
    self:update()
end

---Function adds parameter of unit
---@param base number
---@param mult number
---@param bonus number
function UnitParameter:add(base, mult, bonus)
    self.base = self.base + base
    self.mult = self.mult + mult
    self.bonus = self.bonus + bonus
    self:update()
end

---Function returns base, mult, bonus and result values of parameter.
---@return number, number, number, number
function UnitParameter:get()
    return self.base, self.mult, self.bonus, self.math_func(self.base, self.mult, self.bonus, self.cap)
end

---Function updates parameter state.
function UnitParameter:update()
    local val = self.math_func(self.base, self.mult, self.bonus, self.cap)
    self.apply_param_func(self.owner_struct.unit, val)
end

return UnitParameter