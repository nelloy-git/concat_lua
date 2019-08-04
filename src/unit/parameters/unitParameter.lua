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
    self.apply_param_func(self.owner_struct.unit_obj, val)
end

return UnitParameter