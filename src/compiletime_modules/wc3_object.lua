local EditObjects = {}

local ReadFile = require('compiletime_modules.file_reader')

function EditObjects.createObject(id, base_id)
    local obj = {
        id = id,
        base_id = base_id,
        changes = {}
    }
    return obj
end

function EditObjects.addModification(obj, modification_id, value)
    if type(value) == 'string' then
        value = value .. string.char(0)
    if type(value) == 'number' then
        value = ReadFile.int2lend(value)

    obj.changes[modification_id] = value
end

function EditObjects.writeObject(obj, file)
    local changes_count = ReadFile.getChangesCount(file)
    file = ReadFile.setChangesCount(changes_count + 1, file)
    file = file .. obj.id .. obj.base_id .. ReadFile.int2lend(#(obj.changes))
    print('Created object with id: '.. obj.base_id .. ' (', ReadFile.to_hex(obj.id, 5), ')')
    return file
end


return EditObjects