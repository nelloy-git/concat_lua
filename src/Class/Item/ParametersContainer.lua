--==========
-- Includes
--==========

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Item
local Item = require('Include.ParameterValues')
---@type ParameterValues
local ParameterValues = require('Include.ParameterValues')

--========
-- Module
--========

__item_to_container = DataBase.new('Item', 'table')

function newContainer(item)
    local container = {
        __item = item,
        __parameters = {}
    }
    __item_to_container:add(item, container)

    return container
end

Item.addCreationFunction(function(item) newContainer(item) end)
Item.addRemovalFunction(function(item) __item_to_container:remove(item) end)

---@param param_type ParameterType
---@param base number
---@param mult number
---@param bonus number
function Item:addParameter(param_type, base, mult, bonus)
    local values = ParameterValues.new(param_type, base, mult, bonus)
    table.insert(self.__parameters, #self.__parameters + 1, values)
end

---@return number
function Item:countParameters()
    local values = __item_to_container:get(self)
    return #values.__parameters
end

---@param pos ParameterValues
function Item:getParameterValues(pos)
    local values = __item_to_container:get(self)
    return self.__parameters[pos]
end

function Item:removeParameter(pos)
    local values = __item_to_container:get(self)
    if pos > 0 and pos <= #self.__parameters then
        table.remove(self.__parameters, pos)
    end
end