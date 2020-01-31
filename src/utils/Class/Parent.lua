local ClassName = require('utils.Class.Name')

---@type any
local ClassParent = {}

local fmt = string.format

local class2parents_list = {}
setmetatable(class2parents_list, {__mode = 'kv'})
local class2parents = {}
setmetatable(class2parents, {__mode = 'kv'})

local function isInList(elem, list)
    for i = 1, #list do
        if elem == list[i] then 
            return true
        end
    end
    return false
end

local ClassStatic
---@param class Class
function ClassParent.register(class, ...)
    ClassStatic = ClassStatic or require('utils.Class.Static')
    local vararg = {...}

    local parents_list = {}
    for i = 1, #vararg do
        vararg[i] = ClassStatic.getClass(vararg[i]) or vararg[i]
        if not ClassName.isClass(vararg[i]) then
            error(fmt('%d-th parent is not class', i), 3)
        end

        if not isInList(vararg[i], parents_list) then
            table.insert(parents_list, vararg[i])
        end

        local vararg_parents = class2parents_list[vararg[i]]
        for j = 1, #vararg_parents do
            if not isInList(vararg_parents[j], parents_list) then
                table.insert(parents_list, vararg_parents[j])
            end
        end
    end

    local parents = {}
    for i = 1, #parents_list do
        parents[parents_list[i]] = true
    end

    class2parents_list[class] = parents_list
    class2parents[class] = parents
end

---@param class Class
---@return Class[]
function ClassParent.getList(class)
    return class2parents_list[class]
end

---@param child Class
---@param parent Class
---@return boolean
function ClassParent.isChild(child, parent)
    return class2parents[child][parent] or false
end

return ClassParent