---@class MathParameter
local MathParameter = {}

local val_for_half_cap = 300

---@param base number
---@param mult number
---@param bonus number
---@return number
function MathParameter.linear(base, mult, bonus)
    return base * mult + bonus
end

---@param base number
---@param mult number
---@param bonus number
---@return number
function MathParameter.inverseLinear(base, mult, bonus)
    return base / mult - bonus
end

---@param base number
---@param mult number
---@param bonus number
---@param param_cap number
---@return number
function MathParameter.percent(base, mult, bonus, param_cap)
    local val = base * mult + bonus
    local k = val / (val + val_for_half_cap)
    return k * param_cap
end

---@param base number
---@param mult number
---@param bonus number
---@param param_cap number
---@return number
function MathParameter.inversePercent(base, mult, bonus, param_cap)
    local val = base * mult + bonus
    local k = val / (val + val_for_half_cap)
    return 100 - k * param_cap
end

return MathParameter