local log_all_changes = false

--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

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

---@param src_path string
---@param dst_path string
---@param child_instance WeFile | nil
---@return WeFile
function static.new(src_path, dst_path, child_instance)
    local instance = child_instance or Class.allocate(WeFile)
    private.newData(instance, src_path, dst_path)

    AddCompileFinal(function() instance:free() end)

    return instance
end

--========
-- Public
--========

---@param obj WeObject
function public:addObject(obj)
    local priv = private[self]
    table.insert(priv.objects, 1, obj)
end

function public:update()
    local priv = private[self]

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

        local msg = string.format('сreated %s \"%s\" with id \'%s\' based on \'%s\'%s',
                                   obj, obj:getName(), obj:getId(), obj:getBaseId(), str_changes)
        Log(Log.Msg, WeFile, msg)
    end

    local f = assert(io.open(priv.dst_path, "w"))
    f:write(content)
    f:close()
end

function public:free()
    self:update()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

---@param self WeFile
function private.newData(self, src, dst)
    local priv = {
        src_path = src,
        dst_path = dst,
        objects = {}
    }
    private[self] = priv
end

---@param self WeFile
function private.freeData(self)
    private[self] = nil
end

---@param path string
---@return string
function private.newContent(path)
    return string.char(2)..string.char(0)..string.char(0)..string.char(0)..  -- file version
           string.char(0)..string.char(0)..string.char(0)..string.char(0)..  -- object tables
           string.char(0)..string.char(0)..string.char(0)..string.char(0)    -- changes count
end

return WeFile.static