local ClassName = require('utils.Class.ClassName')

local ClassParent = {}

local class_parents = {}

function ClassParent.register(class, ...)
    local full_parents = {}
    local parents = {...}
    for i = 1, #parents do
        local cur = parents[i]
        if not ClassName.isClass(cur) then
            error(ClassName.getName(class)..': classes can have class parents only.')
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
    local str = ClassName.getName(class)..': '
    for i = 1, #full_parents do
        str = str..ClassName.getName(full_parents[i])..', '
    end
    print(str)
    class_parents[class] = full_parents
end

function ClassParent.get(class)
    return class_parents[class]
end

return ClassParent