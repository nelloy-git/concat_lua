---@class WeObject : table
local WeObject = {}

function WeObject.new(id, base_id, we_type)
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
    for i = 1, #self.changes do
        if self.changes.id == we_field.id then
            table.remove(self.changes, i)
        end
    end
    table.insert(self.changes, we_field)
end

function WeObject:serialize()
    local utils = require(CurrentLib..'.utils')
    local serial = self.base_id .. self.id .. utils.int2byte(#(self.changes))
    for _, field in pairs(self.changes) do
        serial = serial .. field:serialize() .. '\0\0\0\0'
    end
    return serial
end


return WeObject