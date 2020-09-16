Lib = {}

require('Libs.LibList')

local lib_list = {}
local Stack = {
    ---@type table<integer, string>
    paths = {},
    ---@type table<integer, any>
    deps = {}
}
-- Created in compiletime.
local all_paths = {}
CompiletimeFinalToRuntime(function()
    all_paths = Compiletime(all_paths)
end)

---@param lib_name string
---@return string
local function getModname(lib_name)
    if not IsCompiletime() then
        local path = all_paths[lib_name]
        if not path then
            error('Lib \''..lib_name..'\' was not created in compiletime.', 2)
        end
        return path
    end

    local sep = package.config:sub(1,1)
    local path = debug.getinfo(3, "S").source:sub(2)
    path = path:gsub(GetSrcDir(), '')
    path = path:gsub(sep, '.')
    path = path:gsub('.lua', '')

    local pos = path:reverse():find('%.') - 1
    pos = path:len() - pos
    path = path:sub(1, pos - 1)

    all_paths[lib_name] = path
    return path
end

function Lib.start(name, depencies)
    if type(name) ~= 'string' then error('Library name must be string', 2) end
    if lib_list[name] then error('Library with name \''..name..'\' already exists', 2) end

    local path = getModname(name)
    if not path then error('Can not get library path.', 2) end

    -- Check depencies
    if depencies == nil then depencies = {} end
    for k, v in pairs(depencies) do
        if type(k) ~= 'string' then
            error('Depencies table keys must be strings.', 2)
        end
    end

    lib_list[name] = true
    table.insert(Stack.paths, path)
    table.insert(Stack.deps, depencies)

    if IsCompiletime() then
        print('Using '..name..' ('..debug.getinfo(2, "S").source:sub(2)..')')
    end
end

---@param path string
function Lib.load(path)
    return require(path)
end

---@return string
function Lib.curPath()
    return Stack.paths[#Stack.paths]..'.'
end

---@return any
function Lib.curDepencies()
    return Stack.deps[#Stack.deps]
end

function Lib.finish()
    table.remove(Stack.paths)
    table.remove(Stack.deps)
    return
end

return Lib