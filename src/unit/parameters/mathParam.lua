local MathParam = {}

local val_for_half_cap = 300

function MathParam.linear(base, mult, bonus, _)
    return base * mult + bonus
end

function MathParam.inverseLinear(base, mult, bonus, _)
    return base / mult - bonus
end

function MathParam.percent(base, mult, bonus, param_cap)
    local val = base * mult + bonus
    local k = val / (val + val_for_half_cap)
    return k * param_cap
end

function MathParam.inversePercent(base, mult, bonus, param_cap)
    local val = base * mult + bonus
    local k = val / (val + val_for_half_cap)
    return 100 - k * param_cap
end

return MathParam