local Lib = {}

initialized = {}

---@param api_modname string
---@return any
function Lib.load(api_modname)
    local API = require(api_modname)
    if not initialized[api_modname] then
        API.init()
        initialized[api_modname] = true
    end
    return API
end

local sep = package.config:sub(1,1)
function Lib.getSelf()
    ---@type string
    local path = debug.getinfo(2, "S").source:sub(2)
    print(path, GetSrcDir())
    local modname = path:gsub(GetSrcDir(), '')
    modname = modname:gsub(sep, '.')
    modname = modname:gsub('.lua', '')

    local pos = modname:reverse():find('%.') - 1
    pos = modname:len() - pos

    modname = modname:sub(1, pos)
    return modname
end

return Lib