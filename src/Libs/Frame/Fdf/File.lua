--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')
local pairsByKeys = UtilsLib.pairsByKeys or error('')

--=======
-- Class
--=======

local FdfFile = Class.new('FdfFile')
---@class FdfFile
local public = FdfFile.public
---@class FdfFileClass
local static = FdfFile.static
---@type FdfFileClass
local override = FdfFile.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfFile | nil
---@return FdfFile
function override.new(name, child)
    isTypeErr(name, 'string', 'name')
    if child then isTypeErr(child, FdfFile, 'child') end

    local instance = child or Class.allocate(FdfFile)
    private.newData(instance, name)

    return instance
end

---@param filename string
---@return FdfFile
function static.init(filename)
    local file = static.new(filename)

    if IsCompiletime() then
        -- Clear previous files
        if private.isFileExists(private.full_dst_path) then
            local home = os.getenv('HOME')
            if not home then --Windows
                os.execute('del /q '..private.full_dst_path..'*')
                os.execute('for /d %x in ('..private.full_dst_path..'*) do @rd /s /q \"%x\"')
            else
                os.execute('rm -r '..private.full_dst_path)
            end
        end

        CompileFinal(function() file:save() end)
    else
        if not BlzLoadTOCFile(private.dst_path..filename..'.toc') then
            Log:err('Can not load '..private.dst_path..filename..'.toc')
        end
    end

    return file
end

--========
-- Public
--========

---@param fdf_frame FdfBase
function public:add(fdf_frame)
    private.data[self].frames[fdf_frame] = true
end

---@param fdf_frame FdfBase
function public:remove(fdf_frame)
    private.data[self].frames[fdf_frame] = nil
end

--- Compiletime only.
function public:save()
    if not IsCompiletime() then
        Log:err('It is compiletime only funcion', 2)
    end

    local priv = private.data[self]

    local log_msg = 'Created new FdfFile \''..priv.name..'\' containing:\n'
    local text = ''
    local sort_func = function(k1, k2) return k1:getName() < k2:getName() end
    for frame, _ in pairsByKeys(priv.frames, sort_func) do
        log_msg = log_msg..'    '..frame:getName()..'\n'
        text = text..frame:serialize()..'\n'
    end

    local dir = private.full_dst_path
    if not private.isFileExists(dir) then
        os.execute('mkdir '..dir)
    end

    local fdf = assert(io.open(private.full_dst_path..priv.name..'.fdf', "w"))
    fdf:write(text)
    fdf:close()

    local toc = assert(io.open(private.full_dst_path..priv.name..'.toc', "w"))
    toc:write(private.dst_path..priv.name..".fdf\n\n\n")
    toc:close()

    Log:msg(log_msg)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

local sep = Compiletime(package.config:sub(1,1))
if not IsCompiletime() then sep = '\\' end
private.dst_path = 'war3mapImported'..sep..'GeneratedFdfFiles'..sep
if IsCompiletime() then
    private.full_dst_path = GetDstDir()..sep..private.dst_path
end

---@param self FdfFile
---@param name string
function private.newData(self, name)
    ---@class FdfFilePrivate
    local priv = {
        name = name,
        frames = {}
    }
    private.data[self] = setmetatable(priv, private.metatable)
end

---@param path string
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

return static