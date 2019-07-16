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
    setmetatable(we_file, {index = WeFile})
    return we_file
end


function WeFile:getChangesCount()
    return utils.lend2int(self.content:sub(9, 12))
end

function WeFile:setChangesCount(count)
    self.content = self.content:sub(1, 8) .. utils.int2lend(count) .. self.content:sub(13)
end


--function we_object_instance:serialize()
--    local changes_count = ReadFile.getChangesCount(file)
--    file = ReadFile.setChangesCount(changes_count + 1, file)
--    file = file .. obj.id .. obj.base_id .. ReadFile.int2lend(#(obj.changes))
--    if Debug then
--        print('Created object with id: '.. obj.id .. ' (', ReadFile.to_hex(obj.id, 5), ') based on ' .. obj.base_id .. ' (', ReadFile.to_hex(obj.base_id, 5), ')')
--    else
--        print('Created object with id: '.. obj.id .. ' based on ' .. obj.base_id)
--    end
--    return file
--end

return WeEditFile