local ClassName = {}

local class2name = {}
setmetatable(class2name, {__mode = 'kv'})
local name2class = {}
setmetatable(name2class, {__mode = 'kv'})

---@param class Class
---@param name string
function ClassName.register(class, name)
    if name2class[name] then
        error('Class name must be unique.', 3)
    end

    class2name[class] = name
    name2class[name] = class
end

---@param class Class
---@return string
function ClassName.getName(class)
    return class2name[class]
end

---@param name string
---@return Class
function ClassName.getClass(name)
    return name2class[name]
end

---@param any any
---@return boolean
function ClassName.isClass(any)
    if class2name[any] then
        return true
    end
    return false
end

return ClassName