local ClassName = require('utils.Class.ClassName')
local ClassParent = require('utils.Class.ClassParent')
local ClassStatic = require('utils.Class.ClassStatic')
local ClassOverride = require('utils.Class.ClassOverride')
local ClassPublic = require('utils.Class.ClassPublic')
local ClassInstance = require('utils.Class.ClassInstance')

local ClassDeclare = {}

local rawset = rawset
local fmt = string.format
local type = type

local class_metatable = {
    __index = function(self, key)
        error('static, override, public, protected are allowed only.', 2)
    end,

    __newindex = function(self, key)
        error('static, override, public, protected are allowed only.', 2)
    end,

    __tostring = ClassName.getName
}

function ClassDeclare.register(name, ...)
    if type(name) ~= 'string' then
        error('name can be string only.', 2)
    end
    -- Check are parents classes.
    local parents = {...}
    for i = 1, #parents do
        parents[i] = ClassStatic.getClass(parents[i]) or parents[i]
        if not ClassName.isClass(parents[i]) then
            error(fmt('argument #%d is not class.', i + 1), 2)
        end
    end

    local class = {}
    setmetatable(class, class_metatable)

    ClassName.register(class, name)
    ClassParent.register(class, table.unpack(parents))

    rawset(class, 'static', ClassStatic.register(class))
    rawset(class, 'override', ClassOverride.register(class))
    rawset(class, 'public', ClassPublic.register(class))

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

    return ClassParent.isChild(class1, class2)
end

return ClassDeclare