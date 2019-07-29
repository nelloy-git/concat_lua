local Parameter = {}

function Parameter.new(owner_struct, base, apply_param_func, math_func, max_val)
    local container = {
        owner_struct = owner_struct,
        base = base,
        bonus = 0,
        mult = 1,
        cap = max_val,
        apply_param_func = apply_param_func,
        math_func = math_func
    }
    setmetatable(container, {__index = Parameter})
    container:update()
    return container
end

function Parameter:set(base, mult, bonus)
    self.base = base
    self.mult = mult
    self.bonus = bonus
    self:update()
end

function Parameter:add(base, mult, bonus)
    self.base = self.base + base
    self.mult = self.mult + mult
    self.bonus = self.bonus + bonus
    self:update()
end

function Parameter:get()
    return self.base, self.mult, self.bonus, self.math_func(self.base, self.mult, self.bonus, self.cap)
end

function Parameter:update()
    local val = self.math_func(self.base, self.mult, self.bonus, self.cap)
    self.apply_param_func(self.owner_struct.unit, val)
end

return Parameter