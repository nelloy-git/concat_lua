local ClassName = require('utils.Class.ClassName')
local ClassStatic = require('utils.Class.ClassStatic')

local ClassParent = {}

local class_parents = {}

function ClassParent.register(class, ...)
    local full_parents = {}
    local parents = {...}
    for i = 1, #parents do
        local cur = parents[i]

        if ClassStatic.getClass(cur) then
            cur = ClassStatic.getClass(cur)
        end

        if not ClassName.isClass(cur) then
            if ClassName.isClass(class) then
                error(ClassName.getName(class)..': classes can have class parents only.', 3)
            else
                error('classes can have class parents only.', 3)
            end
        end
        table.insert(full_parents, #full_parents + 1, cur)
        local cur_parents = class_parents[cur]
        for j = 1, #cur_parents do
            local added = false
            for k = 1, #full_parents do
                if full_parents[k] == cur_parents[j] then
                    added = true
                    break
                end
            end
            if not added then
                table.insert(full_parents, #full_parents + 1, cur_parents[j])
            end
        end
    end
    class_parents[class] = full_parents
end

function ClassParent.get(class)
    return class_parents[class]
end

function ClassParent.isChild(child, parent)
    if child == parent then
        return true
    end

    local parents = class_parents[child]
    if not parents then
        error(tostring(child)..' is not class', 2)
        return
    end
    if not class_parents[parent] then
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