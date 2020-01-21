local ClassName = {}

local class2name = {}
local name2class = {}

function ClassName.register(class, name)
    if name2class[name] then
        error('Class', 'name must be unique.', 3)
    end

    class2name[class] = name
    name2class[name] = class
end

function ClassName.getName(class)
    return class2name[class]
end

function ClassName.getClass(name)
    return name2class[name]
end

function ClassName.isClass(any)
    if class2name[any] then
        return true
    end
    return false
end

return ClassName