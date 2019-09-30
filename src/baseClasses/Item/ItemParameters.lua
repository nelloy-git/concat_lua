---@class ItemParameters
local ItemParameters = {
    __type = 'ItemParametersClass'
}

local ItemParameters_meta = {
    __type = 'ItemParameters',
    __index = ItemParameters
}

---@return ItemParameters
function ItemParameters.new()
    local item_parameters = {
        __data = {}
    }

    return item_parameters
end

function ItemParameters:addParameter(parameter, base, multiplicator, bonus)
    local parameter_data = {
        parameter = parameter,
        base = base,
        multiplicator = multiplicator,
        bonus = bonus
    }
    table.insert(self.__data, #self.__data, parameter_data)
end

function ItemParameters:count()
    return #self.__data
end

function ItemParameters:get(num)
    return self.__data[num]
end

function ItemParameters:getString()
    local s = ''
    for i = 1, #self.__data do
        local data = self.__data[i]
        s = s..string.format('%s: %.1f %.1f %.1f\n', data.parameter, data.base, data.multiplicator, data.bonus)
    end
    return string.sub(s, 1, s:len() - 1)
end

return ItemParameters