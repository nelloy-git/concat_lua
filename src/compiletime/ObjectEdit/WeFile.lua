local log_all_changes = false

--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeFile = Class.new('WeFile')
---@class WeFile
local public = WeFile.public
---@class WeFileClass
local static = WeFile.static
---@type WeFileClass
local override = WeFile.override
local private = {}

--========
-- Static
--========

---@param path string
---@param child_instance WeFile | nil
---@return WeFile
function override.new(path, child_instance)
    local instance = child_instance or Class.allocate(WeFile)
    private.newData(instance, path)

    return instance
end

--========
-- Public
--========

---@param obj WeObject
function public:addObject(obj)
    table.insert(private.data[self].objects, 1, obj)
end

function public:save()
    local priv = private.data[self]
    private.saveData(priv)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self WeFile
---@param path string
function private.newData(self, path)
    local priv = {
        path = path,
        objects = {}
    }
    private.data[self] = setmetatable(priv, private.metadata)
end

---@param path string
---@return string
function private.newContent(path)
    local char = string.char
    return char(2)..char(0)..char(0)..char(0)..  -- file version
           char(0)..char(0)..char(0)..char(0)..  -- object tables
           char(0)..char(0)..char(0)..char(0)    -- changes count
end

function private.saveData(priv)
    local content = private.newContent(priv.src_path)
    content = content:sub(1, 8)..WeUtils.int2byte(#priv.objects)..content:sub(13)

    for i = 1, #priv.objects do
        local obj = priv.objects[i]
        local bytes = obj:serialize()

        content = content..bytes
        local str_changes = ''
        if log_all_changes then
            str_changes = '\n'..obj:printChanges()
        end

        local msg = string.format('created %s \"%s\" with id \'%s\' based on \'%s\'%s',
                                   obj, obj:getName(), obj:getId(), obj:getBaseId(), str_changes)
        Log(Log.Msg, msg)
    end

    local f = assert(io.open(priv.dst_path, "w"))
    f:write(content)
    f:close()
end

private.metadata = {
    __gc = private.saveData
}

return WeFile.static