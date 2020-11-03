---@type LibManagerFileUtils
local FileUtils = fake_require('LibManager.FileUtils')

---@class LibManagerGitUtils
local GitUtils = {}

local sep = package.config:sub(1,1)

---@param path string
---@param url string
function GitUtils.updateRepo(path, url)
    local found = FileUtils.readFile('.gitmodules'):find(url, 1, true)

    if found then
        if sep == '/' then
            -- Linux
        else
            -- Windows
            os.execute('cd '..path..'&&'..
                       'git submodule update > NUL')
        end
    else
        if sep == '/' then
            -- Linux
        else
            -- Windows
            os.execute('cd '..path..'&&'..
                       'git submodule add '..url..' > NUL')
        end
        --os.execute('cd '..path..'&&'..
        --           'git submodule add '..url)
    end
    os.execute('git add .gitmodules')
end

function GitUtils.removeRepo(path)
    if not GitUtils.isRepo(path) then
        error('LibManager: can not remove '..path..'. It is not a git repo.', 2)
    end
    path = path:gsub('\\', '/')

    -- Remove from .gitsubmodules
    local gitmodule = FileUtils.readFile('.gitmodules')
    local module_start = gitmodule:find('[submodule \"'..path..'\"]', 1, true)
    local module_end = gitmodule:find('[submodule', module_start + 1, true) or #gitmodule
    gitmodule = gitmodule:sub(1, module_start - 1)..gitmodule:sub(module_end)
    FileUtils.writeFile(gitmodule, '.gitmodules')

    -- Remove from .git/confog
    local config = FileUtils.readFile('.git'..sep..'config')
    local config_start = config:find('[submodule \"'..path..'\"]', 1, true)
    local config_end = config:find('[submodule', config_start + 1, true) or #config
    config = config:sub(1, config_start - 1)..config:sub(config_end)
    FileUtils.writeFile(config, '.git'..sep..'config')

    path = path:gsub('/', sep)

    if sep == '/' then
        -- Linux
    else
        -- Windows
        os.execute('git add .gitmodules')
        os.execute('git rm --cached '..path..' > NUL')
        os.execute('cd '..path..'&&'..
                   'del /F/S/Q *.* > NUL')
        os.execute('rmdir /Q/S '..path..' > NUL')

        os.execute('cd '..'.git'..sep..'modules'..sep..path..'&&'..
                   'del /F/S/Q *.* > NUL')
                   os.execute('rmdir /Q/S '..'.git'..sep..'modules'..sep..path)
    end
end

---@param path string
function GitUtils.pull(path)
    os.execute('cd '..path..'&&'..
               'git pull')
end

---@param path string
---@return boolean
function GitUtils.isRepo(path)
    local files = FileUtils.scanDir(path)
    for i = 1, #files do
        if files[i] == '.git' then
            return true
        end
    end
    return false
end

---@param path string
---@return string
function GitUtils.getRepoUrl(path)
    local tmp = path..sep..'tmp.txt'

    FileUtils.writeFile('', tmp)
    os.execute('cd '..path..'&&'..
               'git config --get remote.origin.url > tmp.txt')
    local res = FileUtils.readFile(path..sep..'tmp.txt')
    res = res:gsub('%s+', '')
    os.execute((sep == '/' and 'rm ' or 'del ')..tmp)
    return res
end

return GitUtils