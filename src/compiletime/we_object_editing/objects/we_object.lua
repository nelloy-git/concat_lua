local WeObject = {}

local utils = require('compiletime.we_object_editing.utils')


function WeObject.new(id, base_id, we_type)
    if type(id) == 'number' then
        id = utils.int2lend(id)
    end

    if type(base_id) == 'number' then
        base_id = utils.int2lend(id)
    end

    if id:len() > 4 or base_id:len() > 4 then
        print('Warning: can not create object ' .. id .. ' based on ' .. base_id)
        print(utils.getErrorPos())
        return nil
    end

    local obj = {
        id = id,
        base_id = base_id,
        we_type = we_type,
        changes = {}
    }
    setmetatable(obj, {__index = WeObject})
    return obj
end

function WeObject:addField(we_field)
    if self.we_type ~= self.we_type then
        print('Warning: can not add modification',
               self.id, '(class ' .. self.type .. ') to object',
               self.id, '(class ' .. self.type .. ')')
        print(utils.getErrorPos())
        return false
    end
    table.insert(self.changes, we_field)
    return true
end

function WeObject:serialize()
    local serial = self.base_id .. self.id .. utils.int2byte(#(self.changes))
    for k, v in pairs(self.changes) do
        serial = serial .. v.id .. v.var_type .. v.data .. '\0\0\0\0'
    end
    return serial
end


return WeObject