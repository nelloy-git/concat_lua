local WeEditFile = {}

local WeFile = {}

local utils = require('compiletime_modules.we_object_editing.utils')

function WeEditFile.read(path)
    local f = assert(io.open(path, "rb"))
    local t = f:read("*all")
    f:close()
    local we_file = {
        path = path,
        content = t
    }
    setmetatable(we_file, {__index = WeFile})
    return we_file
end

function WeFile:write(path)
    local f = assert(io.open(path, "w"))
    local t = f:write(self.content)
    f:close()
end

function WeFile:getChangesCount()
    return utils.byte2int(self.content:sub(9, 12))
end


function WeFile:setChangesCount(count)
    self.content = self.content:sub(1, 8) .. utils.int2byte(count) .. self.content:sub(13)
end

function WeFile:add(we_obj)
    bytes = we_obj:serialize()
    self:setChangesCount(self:getChangesCount() + 1)
    self.content = self.content .. bytes
    if Debug then
        print('Created object with id: '.. we_obj.id .. ' (', utils.byte2hex(we_obj.id, 5), ') based on ' .. we_obj.base_id .. ' (', utils.byte2hex(we_obj.base_id, 5), ')')
    else
        print('Created object with id: '.. we_obj.id .. ' based on ' .. we_obj.base_id)
    end
end

return WeEditFile