---@class LibManagerFileUtils
local LibManagerFileUtils = {}

local sep = package.config:sub(1,1)

---@param path string
---@return boolean
function LibManagerFileUtils.isExist(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
       if code == 13 then
          -- Permission denied, but it exists
          return true
       end
    end
    return ok, err
end

---@param path string
function LibManagerFileUtils.makeDir(path)
    os.execute('mkdir '..path)
end

---@param path string
---@return string[]
function LibManagerFileUtils.scanDir(path)
    local pfile
    if sep == '/' then
        pfile = io.popen('ls -a "'..path..'"')
    else
        pfile = io.popen('dir '..path..' /b/a')
    end

    local list = {}
    for filename in pfile:lines() do
        table.insert(list, filename)
    end
    pfile:close()
    return list
end

---@param path string
function LibManagerFileUtils.isDir(path)
    return LibManagerFileUtils.isExist(path..sep)
end

function LibManagerFileUtils.removeDir(path)
    if sep == '/' then
        -- Linux
        os.execute('rm -rf '..path)
    else
        -- Windows
        os.execute('cd '..path..'&&'..
                   'del /F/S/Q *.* > NUL')
        os.execute('rmdir /Q/S '..path)
    end
end

---@param path string
---@return string
function LibManagerFileUtils.getFileDir(path)
    return path:sub(1, path:match('^.*()'..sep))
end

---@param path string
---@return string
function LibManagerFileUtils.readFile(path)
    local f = io.open(path)
    local str = f:read("*a")
    f:close()
    return str
end

---@param data string
---@param path string
function LibManagerFileUtils.writeFile(data, path)
    local f = io.open(path, "w")
    f:write(data)
    f:close()
end

---@param data string
---@param path string
function LibManagerFileUtils.appendFile(data, path)
    local f = io.open(path, "a+")
    f:write(data)
    f:close()
end

return LibManagerFileUtils