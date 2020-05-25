Lib = {}

Lib.Class = 'Libs.Class.API'
Lib.Utils = 'Libs.Utils.API'
Lib.Object = 'Libs.Object.API'
Lib.Parameter = 'Libs.Parameter.API'

function Lib.getSelf()
    local sep = '\\'
    if IsCompiletime() then
        sep = package.config:sub(1,1)
    end

    ---@type string
    local path = debug.getinfo(2, "S").source:sub(2)

    local modname = path:gsub(GetSrcDir(), '')
    modname = modname:gsub(sep, '.')
    modname = modname:gsub('.lua', '')

    --print(modname)
    local pos = modname:reverse():find('%.') - 1
    pos = modname:len() - pos

    modname = modname:sub(1, pos)
    return modname
end

return Lib