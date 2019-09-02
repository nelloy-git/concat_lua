---@type Settings
local Settings = require('utils.Settings')

local UnitMathParameter = {}

local half_cap = Settings.UnitParameters.value_to_get_half_cap_for_percent_value

---@param base number
---@param multiplicator number
---@param bonus number
---@return number
function UnitMathParameter.linear(base, multiplicator, bonus)
    return base * multiplicator + bonus
end

---@param base number
---@param multiplicator number
---@param bonus number
---@return number
function UnitMathParameter.inverseLinear(base, multiplicator, bonus)
    return base / multiplicator - bonus
end

---@param base number
---@param multiplicator number
---@param bonus number
---@param param_cap number
---@return number
function UnitMathParameter.percent(base, multiplicator, bonus, param_cap)
    local val = base * multiplicator + bonus
    local k = val / (val + half_cap)
    return k * param_cap
end

---@param base number
---@param multiplicator number
---@param bonus number
---@param param_cap number
---@return number
function UnitMathParameter.inversePercent(base, multiplicator, bonus, param_cap)
    local val = base * multiplicator + bonus
    local k = val / (val + half_cap)
    return 100 - k * (100 - param_cap)
end

return UnitMathParameter