local WeFile = {}

local utils = require('compiletime.objEdit.utils')

local function weType2file(we_type)
    if we_type == 'unit' then return 'war3map.w3u' end
    if we_type == 'ability' then return 'war3map.w3a' end
end

function WeFile.readFromSrc(we_type)
    local separator = package.config:sub(1,1)
    local path = src_dir .. separator .. weType2file(we_type)

    local t = string.char(2)..string.char(0)..string.char(0)..string.char(0)..  -- file version
              string.char(0)..string.char(0)..string.char(0)..string.char(0)..  -- object tables
              string.char(0)..string.char(0)..string.char(0)..string.char(0)    -- changes count
    local f = io.open(path, "rb")
    if f then
        t = f:read("*all")
        f:close()
    end
    local we_file = {
        we_type = we_type,
        content = t
    }
    setmetatable(we_file, {__index = WeFile})
    return we_file
end

function WeFile:writeToDst()
    local separator = package.config:sub(1,1)
    local path = dst_dir .. separator .. weType2file(self.we_type)

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
    if we_obj.we_type ~= self.we_type then
        print('Warning: can not add object of type', we_obj.we_type, 'to file of type', self.we_type)
        print(utils.getErrorPos())
        return false
    end
    local bytes = we_obj:serialize()
    self:setChangesCount(self:getChangesCount() + 1)
    self.content = self.content .. bytes
    if Debug then
        print(string.format('Created object with id: \'%s\' (%s) based on \'%s\' (%s)', we_obj.id, utils.byte2hex(we_obj.id, 5), we_obj.base_id, utils.byte2hex(we_obj.base_id, 5)))
    else
        print('Created object with id: '.. we_obj.id .. ' based on ' .. we_obj.base_id)
    end
    return true
end

return WeFile