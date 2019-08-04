---@class UnitMathParameter
local UnitMathParameter = {}

local val_for_half_cap = 300

---@alias UnitMathParameterFunc fun(base:number, mult:number, bonus:number, cap:number):number

---@type UnitMathParameterFunc
UnitMathParameter.linear = function(base, mult, bonus)
    return base * mult + bonus
end

---@type UnitMathParameterFunc
UnitMathParameter.inverseLinear = function(base, mult, bonus)
    return base / mult - bonus
end

---@type UnitMathParameterFunc
UnitMathParameter.percent = function(base, mult, bonus, param_cap)
    local val = base * mult + bonus
    local k = val / (val + val_for_half_cap)
    return k * param_cap
end

---@type UnitMathParameterFunc
UnitMathParameter.inversePercent = function(base, mult, bonus, param_cap)
    local val = base * mult + bonus
    local k = val / (val + val_for_half_cap)
    return 100 - k * (100 - param_cap)
end

return UnitMathParameter