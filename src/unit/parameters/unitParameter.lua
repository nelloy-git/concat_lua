---@class UnitParameter
local UnitParameter = {}
local UnitParameter_meta = {
    __index = UnitParameter
}

---Create new parameter for unit.
---@param unit_obj UnitObject
---@param base number
---@param apply_param_func function
---@param math_func function
---@param max_val number|nil
---@return UnitParameter
function UnitParameter.new(unit_obj, base, apply_param_func, math_func, max_val)
    ---@type UnitParameter
    local container = {
        __unit_obj = unit_obj,
        __base = base,
        __bonus = 0,
        __mult = 1,
        __res = math_func(base, mult, bonus, max_val),
        __cap = max_val,
        __apply_param_func = apply_param_func,
        __math_func = math_func
    }
    setmetatable(container, UnitParameter_meta)
    container:update()
    return container
end

---Recomend use in tests only. Function set parameter of unit.
---@param base number
---@param mult number
---@param bonus number
---@return nil
function UnitParameter:set(base, mult, bonus)
    self.__base = base
    self.__mult = mult
    self.__bonus = bonus
    self:update()
end

---Function adds parameter of unit
---@param base number
---@param mult number
---@param bonus number
---@return nil
function UnitParameter:add(base, mult, bonus)
    self.__base = self.__base + base
    self.__mult = self.__mult + mult
    self.__bonus = self.__bonus + bonus
    self:update()
end

---@param base number
---@return nil
function UnitParameter:addBase(base)
    self.__base = self.__base + base
    self:update()
end

---Function returns base, mult, bonus and result values of parameter.
---@return number, number, number, number
function UnitParameter:getAll()
    return self.__base, self.__mult, self.__bonus, self.__math_func(self.__base, self.__mult, self.__bonus, self.__cap)
end

---@return number
function UnitParameter:getBase()
    return self.__base
end

---@return number
function UnitParameter:getBonus()
    return self.__bonus
end

---@return number
function UnitParameter:getMult()
    return self.__mult
end

---@return number
function UnitParameter:getResult()
    return self.__res
end

---Function updates parameter state.
---@return nil
function UnitParameter:update()
    self.__res = self.__math_func(self.__base, self.__mult, self.__bonus, self.__cap)
    self.__apply_param_func(self.__unit_obj, self.__res)
end

return UnitParameter