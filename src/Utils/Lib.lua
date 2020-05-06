local Lib = {}

initialized = {}

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