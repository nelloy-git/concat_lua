local ClassName = require('utils.Class.Name')
local ClassParent = require('utils.Class.Parent')
local ClassStatic = require('utils.Class.Static')
local ClassOverride = require('utils.Class.Override')
local ClassPublic = require('utils.Class.Public')
local ClassInstance = require('utils.Class.Instance')

local ClassDeclare = {}

local rawset = rawset
local fmt = string.format
local type = type

local class_metatable = {
    __index = function(self, key)
        error('static, override, public are allowed only.', 2)
    end,

    __newindex = function(self, key)
        error('static, override, public are allowed only.', 2)
    end,

    __tostring = ClassName.getName
}

---@param name string
---@return Class
function ClassDeclare.register(name, ...)
    if type(name) ~= 'string' then
        error('class name can be string only.', 2)
    end

    ---@class Class
    local class = {}
    ClassName.register(class, name)
    ClassParent.register(class, ...)
    class.static = ClassStatic.register(class)
    class.public = ClassPublic.register(class)
    class.override = ClassOverride.register(class)

    setmetatable(class, class_metatable)
    return class
end

function ClassDeclare.type(value1, value2)
    if not value2 then
        return type(value1)
    end

    local is_class1 = ClassName.isClass(value1)
    local is_class2 = ClassName.isClass(value2)
    local is_instance1 = ClassInstance.isInstance(value1)
    local is_instance2 = ClassInstance.isInstance(value2)

    --print(value1, value2)
    --print(is_class1, is_class2, is_instance1, is_instance2)
    if not (is_class1 or is_class2 or is_instance1 or is_instance2) then
        return type(value1) == value2
    end

    if (is_class1 or is_instance1) ~= (is_class2 or is_instance2) then
        return false
    end

    local class1 = ClassStatic.getClass(value1) or value1
    local class2 = ClassStatic.getClass(value2) or value2

    if is_instance1 then
        class1 = ClassInstance.getClass(value1)
    end

    if is_instance2 then
        class2 = ClassInstance.getClass(value2)
    end

    --print(class1, class2)
    return ClassParent.isChild(class1, class2)
end


return ClassDeclare