--=========
-- Include
--=========

local GitUtils
if not IsGame() then
    ---@type LibManagerFileUtils
    FileUtils = fake_require('LibManager.FileUtils')
    ---@type LibManagerGitUtils
    GitUtils = fake_require('LibManager.GitUtils')
end

--=========
-- Package
--=========

---@class LibManager
local LibManager = {}

local root
local repos = {}
local apis = {}
local used = {}

local sep
if IsGame() then
    sep = '\\'
else
    sep = package.config:sub(1,1)
end

BuildFinal(function()
    if not IsGame() then
        local used_apis = {}
        local used_repos = {}
        for name, url in pairs(repos) do
            if used[name] then
                used_repos[name] = repos[name]
                used_apis[name] = apis[name]
            else
                GitUtils.removeRepo(root..sep..name)
            end
        end
        repos = used_repos

        apis = used_apis
    end
    repos = Macro(repos)
    apis = Macro(apis)
end)

--- Initialize LibManager.
---@param libs_path string
function LibManager.init(libs_path)
    root = GetSrc()..sep..libs_path
    if IsGame() then
        return
    end

    if not FileUtils.isDir(root) then
        FileUtils.mkdir(root)
    end
    LibManager.updateRepos()
end

function LibManager.updateRepos()
    if IsGame() then
        return
    end

    local files = FileUtils.scanDir(root)
    for i = 1, #files do
        local cur = root..sep..files[i]
        if FileUtils.isDir(cur) and
           GitUtils.isRepo(cur) then
            repos[files[i]] = GitUtils.getRepoUrl(cur)
            apis[files[i]] = cur:sub(#GetSrc() + 2):gsub(sep, '.')..'.API'
        end
    end
end

local function findName(url)
    local found
    for name, repo_url in pairs(repos) do
        if url == repo_url then
            found = name
            break
        end
    end
    return found
end

function LibManager.load(url)
    local found = findName(url)
    if not found then
        print('Downloading '..url)
        GitUtils.updateRepo(root, url)
        LibManager.updateRepos()
    end
    found = findName(url)
    used[found] = true

    return apis[found]
end

local stack = {}
local depencies = {}
-- Override require
local real_require = _G.require
function require(package)
    if #stack > 0 then
        package = stack[#stack]..'.'..package
    end

    return real_require(package)
end

function LibManager.startLib(name)
    if not IsGame() then
        if not FileUtils.isDir(root..sep..name) then
            error('LibManager: library name must hame same name as repo name.', 2)
        end
    end

    table.insert(stack, root:sub(#GetSrc() + 2)..'.'..name)
    table.insert(depencies, {})
end

function LibManager.getCurLib()
    return stack[#stack]
end

function LibManager.addDepency(name, url)
    depencies[#depencies][name] = LibManager.load(url)
end

function LibManager.getDepency(name)
    local depency = depencies[#depencies][name]
    if not depency then
        error('LibManager: can not find depency', 2)
    end
    return real_require(depency)
end

function LibManager.endLib()
    table.remove(stack, #stack)
    table.remove(depencies, #depencies)
end

return LibManager