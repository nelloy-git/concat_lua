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
            os.execute('cd '..path..'&&'..
                       'git submodule update -q &&'..
                       'git submodule init')

        else
            -- Windows
            os.execute('cd '..path..'&&'..
                       'git submodule update -q > NUL &&'..
                       'git submodule init')
        end
    else
        if sep == '/' then
            -- Linux
            os.execute('cd '..path..'&&'..
                       'git submodule add -q '..url..' &&'..
                       'git submodule init')
        else
            -- Windows
            os.execute('cd '..path..'&&'..
                       'git submodule add -q '..url..' > NUL &&'..
                       'git submodule init')
        end
    end
    os.execute('git add .gitmodules')
end

function GitUtils.removeRepo(path)
    if not GitUtils.isRepo(path) then
        error('LibManager: can not remove '..path..'. It is not a git repo.', 2)
    end

    local git_path = path:gsub('\\', '/')

    -- Remove from .gitsubmodules
    local gitmodule = FileUtils.readFile('.gitmodules')
    local module_start = gitmodule:find('[submodule \"'..git_path..'\"]', 1, true)
    if module_start then
        local module_end = gitmodule:find('[submodule', module_start + 1, true) or #gitmodule
        gitmodule = gitmodule:sub(1, module_start - 1)..gitmodule:sub(module_end)

        local n
        while true do
            gitmodule, n = gitmodule:gsub("(\r?\n)%s*\r?\n", "%1")
            if n == 0 then break end
        end
        FileUtils.writeFile(gitmodule, '.gitmodules')
        os.execute('git add .gitmodules')
    end

    -- Remove from .git/config
    local config = FileUtils.readFile('.git'..sep..'config')
    local config_start = config:find('[submodule \"'..git_path..'\"]', 1, true)
    if config_start then
        local config_end = config:find('[submodule', config_start + 1, true) or #config
        config = config:sub(1, config_start - 1)..config:sub(config_end)
        FileUtils.writeFile(config, '.git'..sep..'config')
    end

    -- Remove cached
    os.execute('git rm --cached '..path..(sep == '/' and ' > /dev/null' or ' > NUL'))

    -- Remove from project
    if FileUtils.isDir(path) then
        FileUtils.removeDir(path)
    end

    -- Remove from .git/modules/
    if FileUtils.isDir('.git'..sep..'modules'..sep..path) then
        FileUtils.removeDir('.git'..sep..'modules'..sep..path)
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