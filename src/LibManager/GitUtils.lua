---@class LibManagerGitUtils
local GitUtils = {}

local sep = package.config:sub(1,1)
local root_dir = GetSrc()

---@param path string
function GitUtils.mkdir(path)
    os.execute('mkdir '..path)
end

---@param path string
---@param url string
function GitUtils.updateRepo(path, url)
    local found = GitUtils.readFile('.gitmodules'):find(url, 1, true)

    if found then
        os.execute('cd '..path..'&&'..
                   'git submodule update')
    else
        os.execute('cd '..path..'&&'..
                   'git submodule add '..url)
    end
end

---@param path string
function GitUtils.pull(path)
    os.execute('cd '..path..'&&'..
               'git pull')
end

---@param path string
---@return boolean
function GitUtils.fileExists(path)
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
---@return boolean
function GitUtils.isDir(path)
    return GitUtils.fileExists(path.."/")
end

---@param path string
---@return string[]
function GitUtils.scanDir(path)
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
---@return string[]
function GitUtils.isRepo(path)
    local files = GitUtils.scanDir(path)
    for i = 1, #files do
        if files[i] == '.git' then
            return true
        end
    end
    return false
end

---@param path string
---@return string
function GitUtils.readFile(path)
    local f = io.open(path)
    local str = f:read("*a")
    f:close()
    return str
end

---@param data string
---@param path string
function GitUtils.writeFile(data, path)
    local f = io.open(path, "w")
    f:write(data)
    f:close()
end

---@param path string
---@return string
function GitUtils.getRepoUrl(path)
    local tmp = path..sep..'tmp.txt'

    GitUtils.writeFile('', tmp)
    os.execute('cd '..path..'&&'..
               'git config --get remote.origin.url > tmp.txt')
    local res = GitUtils.readFile(path..sep..'tmp.txt')
    res = res:gsub('%s+', '')
    os.execute((sep == '/' and 'rm ' or 'del ')..tmp)
    return res
end

return GitUtils