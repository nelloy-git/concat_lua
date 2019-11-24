--=========
-- Include
--=========

---@type WeUtils
local WeUtils = require('compiletime.ObjectEdit.WeUtils')

--=======
-- Class
--=======

---@type WeObjectFileClass
local WeObjectFile = newClass('WeObjectFile')

---@class WeObjectFile
local public = WeObjectFile.public
---@class WeObjectFileClass
local static = WeObjectFile.static
---@type table
local override = WeObjectFile.override
---@type table(WeObjectFile, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return WeObjectFile
function static.new(src_path, dst_path, instance_data)
    local instance = instance_data or newInstanceData(WeObjectFile)
    local priv = {
        src_path = src_path,
        dst_path = dst_path,
        objects = {}
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

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
        Debug(string.format('Created object %s with id: \'%s\' based on \'%s\'', obj:getName(), obj:getId(), obj:getBaseId()))
    end

    local f = assert(io.open(priv.dst_path, "w"))
    f:write(content)
    f:close()
end

---@param path string
---@return string
function private.newContent(path)
    return string.char(2)..string.char(0)..string.char(0)..string.char(0)..  -- file version
           string.char(0)..string.char(0)..string.char(0)..string.char(0)..  -- object tables
           string.char(0)..string.char(0)..string.char(0)..string.char(0)    -- changes count
end

return WeObjectFile