local ClassParent = {}

local class2parents = {}

function ClassParent.register(class, ...)
    class2parents[class] = {...}
end

function ClassParent.get(class)
    return class2parents[class]
end

function ClassParent.isChild(child, parent)
    if child == parent then
        return true
    end

    local parents = class2parents[child]
    if not parents then
        error(tostring(child)..' is not class', 2)
        return
    end
    if not class2parents[parent] then
        error(tostring(parent)..' is not class', 2)
        return
    end

    for i = 1, #parents do
        if parent == parents[i] then
            return true
        end
    end
    return false
end

return ClassParent