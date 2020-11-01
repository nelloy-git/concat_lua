--=========
-- Include
--=========

local GitUtils
if not IsGame() then
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

local sep
if IsGame() then
    sep = '\\'
else
    sep = package.config:sub(1,1)
end

function LibManager.init(libs_path)
    if IsGame() then
        return
    end

    root = GetSrc()..sep..libs_path

    if not GitUtils.isDir(root) then
        GitUtils.mkdir(root)
    end
    LibManager.updateRepos()
end

function LibManager.updateRepos()
    if IsGame() then
        return
    end

    local files = GitUtils.scanDir(root)
    for i = 1, #files do
        local cur = root..sep..files[i]
        if GitUtils.isDir(cur) and
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
        GitUtils.clone(root, url)
        LibManager.updateRepos()
    end
    found = findName(url)

    return apis[found]
end

local stack = {}
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
        if not GitUtils.isDir(root..sep..name) then
            error('LibManager: library name must hame same name as repo name.', 2)
        end
    end

    table.insert(stack, root:sub(#GetSrc() + 2)..'.'..name)
end

function LibManager.endLib()
    table.remove(stack, #stack)
end

return LibManager