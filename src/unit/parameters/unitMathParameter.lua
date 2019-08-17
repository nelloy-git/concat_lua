---@type Settings
local Settings = require('utils.settings')

---@class UnitMathParameter
local UnitMathParameter = {}

local half_cap = Settings.UnitParameters.value_to_get_half_cap_for_percent_value

---@param base number
---@param mult number
---@param bonus number
---@return number
function UnitMathParameter.linear(base, mult, bonus)
    return base * mult + bonus
end

---@param base number
---@param mult number
---@param bonus number
---@return number
function UnitMathParameter.inverseLinear(base, mult, bonus)
    return base / mult - bonus
end

---@param base number
---@param mult number
---@param bonus number
---@param param_cap number
---@return number
function UnitMathParameter.percent(base, mult, bonus, param_cap)
    local val = base * mult + bonus
    local k = val / (val + half_cap)
    return k * param_cap
end

---@param base number
---@param mult number
---@param bonus number
---@param param_cap number
---@return number
function UnitMathParameter.inversePercent(base, mult, bonus, param_cap)
    local val = base * mult + bonus
    local k = val / (val + half_cap)
    return 100 - k * (100 - param_cap)
end

return UnitMathParameter