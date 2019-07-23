local WeFile = {
    units = nil,
    abilities = nil
}

local utils = require(CurrentLib..'.utils')

local function weType2file(we_type)
    if we_type == 'unit' then return 'war3map.w3u' end
    if we_type == 'ability' then return 'war3map.w3a' end
end

local function readFile(path)
    local path = path

    local t = nil
    local f = io.open(path, "rb")
    if f then
        t = f:read("*all")
        f:close()
    else
        t = string.char(2)..string.char(0)..string.char(0)..string.char(0)..  -- file version
            string.char(0)..string.char(0)..string.char(0)..string.char(0)..  -- object tables
            string.char(0)..string.char(0)..string.char(0)..string.char(0)    -- changes count
    end
    return t
end

function WeFile.readFromSrc(we_type)
    local separator = package.config:sub(1,1)
    local path = src_dir .. separator .. weType2file(we_type)
    local we_file = {
        we_type = we_type,
        content = readFile(path),
        objects = {}
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

function WeFile:applyChanges()
    for i = 1, #self.objects do
        local we_obj = self.objects[i]
        local bytes = we_obj:serialize()
        self:setChangesCount(self:getChangesCount() + 1)
        self.content = self.content .. bytes
        if Debug then
            print(string.format('Created %s with id: \'%s\' (%s) based on \'%s\' (%s)', we_obj.we_type, we_obj.id, utils.byte2hex(we_obj.id, 5), we_obj.base_id, utils.byte2hex(we_obj.base_id, 5)))
        else
            print(string.format('Created %s with id: \'%s\' based on \'%s\'', we_obj.we_type, we_obj.id, we_obj.base_id))
        end
    end
end

function WeFile:add(we_obj)
    if we_obj.we_type ~= self.we_type then
        print('Warning: can not add object of type', we_obj.we_type, 'to file of type', self.we_type)
        print(utils.getErrorPos())
        return false
    end
    table.insert(self.objects, 1, we_obj)
    return true
end

function WeFile.init()
    WeFile.abilities = WeFile.readFromSrc('ability')
    WeFile.units = WeFile.readFromSrc('unit')
end

function WeFile.close()
    WeFile.abilities:applyChanges()
    WeFile.units:applyChanges()
end

return WeFile