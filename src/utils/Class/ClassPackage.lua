local ClassPackage = {}

local name2package = {}
local package2name = {}
local sep = Compiletime(package.config:sub(1,1))

function ClassPackage.register(name)
    local info = debug.getinfo(3, 'S')
    name2package[name] = info.source:sub(4, #info.source - 4):gsub(sep, '.')
    package2name[name2package[name]] = name
end

function ClassPackage.getName(package)
    return package2name[package]
end

function ClassPackage.getPackage(name)
    return name2package[name]
end

return ClassPackage