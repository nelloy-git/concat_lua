--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type ParameterAPI
local ParamAPI = require('Parameter.API')
local ValueType = ParamAPI.ValueType
local ValueList = ParamAPI.ValueList

local fmt = string.format

--=======
-- Class
--=======

local ItemParameters = Class.new('ItemParameters', ValueList)
---@class ItemParameters : ParameterValueList
local public = ItemParameters.public
---@class ItemParametersClass : ParameterValueListClass
local static = ItemParameters.static
---@type ItemParametersClass
local override = ItemParameters.override
local private = {}

--========
-- Static
--========

---@return ItemParameters
function override.new()
    local instance = Class.allocate(ItemParameters)
    instance = ValueList.new(instance)

    return instance
end

--========
-- Public
--========

function public:toString()
    local priv = private.data[self]

    local str = ''
    local list = priv.value
    for param, value in pairs(list) do
        local base = value:get(ValueType.BASE)
        local mult = value:get(ValueType.MULT)
        local addi = value:get(ValueType.ADDIT)
        if base ~= 0 or mult ~= 0 or addi ~= 0 then
            str = str..fmt(private.parameter_line, ParamAPI.getFullName(param), base, 100 * mult, addi)..'\n'
        end
    end

    if str:len() > 1 then
        return str:sub(1, str:len() - 1)
    else
        return ''
    end
end

--=========
-- Private
--=========

private.parameter_line = '%s: %d / %d%% / %d'

return static