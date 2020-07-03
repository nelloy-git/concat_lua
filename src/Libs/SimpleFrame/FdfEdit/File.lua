--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger
---@type FdfFrame
local FdfFrame = 0 -- in init() require(lib_modname..'.FdfEdit.Frame')

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
---@param child_instance FdfFile | nil
---@return FdfFile
function override.new(name, child_instance)
    checkType(name, 'string', 'name')
    if child_instance then checkType(child_instance, FdfFile, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfFile)
    private.newData(instance, name)

    return instance
end

---@param static_filename string
function static.init(static_filename)
    FdfFrame = require(lib_modname..'.FdfEdit.Frame')
    private.static_file = static.new(static_filename)

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

        CompileFinal(function() private.static_file:save() end)
    else
        if not BlzLoadTOCFile(private.dst_path..static_filename..'.toc') then
            Log:err('Can not load '..private.dst_path..static_filename..'.toc')
        end
    end
end

function static.getDefault()
    return private.static_file
end

--========
-- Public
--========

---@param fdf_frame FdfFrame
function public:add(fdf_frame)
    private.data[self].frames[fdf_frame] = true
end

---@param fdf_frame FdfFrame
function public:remove(fdf_frame)
    private.data[self].frames[fdf_frame] = nil
end

--- Compiletime only.
function public:save()
    if not IsCompiletime() then
        Log:err('It is compiletime only funcion', 2)
    end

    local priv = private.data[self]

    local log_msg = 'Created new FdfFile \''..priv.name..'\' containg:\n'
    local text = ''
    for frame, _ in pairs(priv.frames) do
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
if not IsCompiletime() then sep = '\\\\' end
private.dst_path = 'GeneratedFdfFiles'..sep
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