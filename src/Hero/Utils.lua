--=========
-- Include
--=========

---@type AbilityLib
local AbilityLib = require(LibList.AbilityExtLib) or error('')
local AbilEvent = AbilityLib.Event
local AbilType = AbilityLib.Type
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamType = ParamLib.ParamType or error('')

--========
-- Module
--========

---@class HeroUtils
local HeroUtils = {}

local scale_colors = {
    [ParamType.PATK] = 'FFFFA0A0',
    [ParamType.MATK] = 'FFA0A0FF'
}
---@param text string
---@param param ParameterType
---@return string
function HeroUtils.colorScale(text, param)
    local color = scale_colors[param] or 'FFFFFFFF'
    return '|c'..color..text..'|r'
end

return HeroUtils