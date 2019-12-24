--=========
-- Include
--=========

--=======
-- Class
--=======

---@type FdfFileClass
local FdfFile = newClass('FdfFile')

---@class FdfFile
local public = FdfFile.public
---@class FdfFileClass
local static = FdfFile.static
---@type table
local override = FdfFile.override
---@type table(FdfFile, table)
local private = {}

--=========
-- Static
--=========

---@param name string
---@param instance_data table | nil
---@return FdfFile
function static.new(name, instance_data)
    local instance = instance_data or newInstanceData(FdfFile)
    local priv = private.new(instance, name)

    addCompiletimeFinalize(function() private.save(instance) end)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

function public:addObject(obj)
    local priv = private.get(self)
    table.insert(priv.objects, #priv.objects + 1, obj)
end

---@return FdfFileRuntime
function public:toRuntime()
    local priv = private.get(self)

    ---@class FdfFileRuntime
    local res = {}
    res.fdf = string.gsub(private.dst_path..priv.name..'.fdf', '\\', '\\\\')
    res.toc = string.gsub(private.dst_path..priv.name..'.toc', '\\', '\\\\')
    for i = 1, #priv.objects do
        res[priv.objects[i]:getName()] = priv.objects[i]:getBaseName()
    end
    return res
end

--=========
-- Private
--=========

local sep = package.config:sub(1,1)
private.dst_path = 'war3mapImported'..sep..'GeneratedFdfFiles'..sep
private.full_dst_path = _G._dst_dir..sep..private.dst_path

local private_data = {}
---@param self FdfFile
---@return FdfFilePrivate
function private.new(self, name)
    ---@class FdfFilePrivate
    local priv = {
        name = name,
        objects = {}
    }
    private_data[self] = priv
    return priv
end

---@param self FdfFile
---@return FdfFilePrivate
function private.get(self)
    return private_data[self]
end

---@param self FdfFile
function private.free(self)
    private_data[self] = nil
end

function private.save(self)
    local priv = private.get(self)

    local log_msg = string.format("created new %sfdf file.", priv.name)
    local content = ""

    for i = 1, #priv.objects do
        local obj = priv.objects[i]
        local obj_string = obj:serialize().."\n\n"
        content = content..obj_string

        log_msg = log_msg..string.format('\n\tadded %s object.', obj:getName())
    end
    Log(Log.Msg, getClassName(FdfFile), log_msg)

    local dir = private.full_dst_path
    if not private.isFileExists(dir) then
        os.execute('mkdir '..dir)
    end

    local fdf = assert(io.open(private.full_dst_path..priv.name..'.fdf', "w"))
    fdf:write(content)
    fdf:close()

    local toc = assert(io.open(private.full_dst_path..priv.name..'.toc', "w"))
    toc:write(private.dst_path..priv.name..".fdf\n")
    toc.close()
end

function private.isFileExists(path)
    local ok, _, code = os.rename(path, path)
    if not ok then
       if code == 13 then
          -- Permission denied, but it exists
          return true
       end
    end
    return ok
end

if private.isFileExists(private.full_dst_path) then
    local home = os.getenv('HOME')
    if not home then --Windows
        os.execute('del /q '..private.full_dst_path..'*')
        os.execute('for /d %x in ('..private.full_dst_path..'*) do @rd /s /q \"%x\"')
    else
        os.execute('rm -r '..private.full_dst_path)
    end
end

return FdfFile