local Log = require('utils.Log')

local ClassName = require('utils.Class.ClassName')
local ClassParent = require('utils.Class.ClassParent')
local ClassStatic = require('utils.Class.ClassStatic')
local ClassPublic = require('utils.Class.ClassPublic')
local ClassInstance = require('utils.Class.ClassInstance')

---@class Class
Class = {}
local rawget = rawget
local rawset = rawset
local fmt = string.format

local function class_index(self, key)
    local msg = 'static, override, public, protected are allowed only.'
    if IsCompiletime() then
        local info = debug.getinfo(2, 'lS')
        msg = msg..fmt(' %s:%d', info.source, info.currentline)
    end
    Log(Log.Err, self, msg)
    error(tostring(self)..': '..msg)
    return nil
end

local class_metatable = {
    __index = class_index,
    __newindex = class_index,
    __tostring = ClassName.getName
}

---@param name string
---@return any
local function new(name, ...)
    local class = {}
    setmetatable(class, class_metatable)

    ClassName.register(class, name)
    ClassParent.register(class, ...)

    rawset(class, 'static', ClassStatic.new(class))
    rawset(class, 'override', ClassStatic.newOverride(class))
    rawset(class, 'public', ClassPublic.new(class))

    return class
end

---@type fun(name:string, vararg:any):any
Class.new = new
---@type fun(class:any):any
Class.allocate = ClassInstance.allocate
---@type fun(instance:any)
Class.free = ClassInstance.free
---@type fun(class:any):boolean
Class.isClass = ClassName.isClass
---@type fun(instance:any):boolean
Class.isInstance = ClassInstance.isInstance
---@type fun(instance:any):any
Class.getClass = ClassInstance.getClass
---@type fun(child_class:any, parent_class:any):boolean
Class.isChild = ClassParent.isChild

---@param static any
---@return any
---@overload fun(class:any):any
function Class.getPublic(static)
    local class = ClassStatic.getClass(static) or static
    return class.public
end

local type = type
---@param value1 any
---@param value2 any
---@return boolean
---@overload fun(value:any):string
---@overload fun(child_class:any, parent_class:any):boolean
---@overload fun(child_instance:any, parent_class:any):boolean
---@overload fun(child_instance:any, parent_instance:any):boolean
function Class.type(value1, value2)
    if not value2 then
        return type(value1)
    end

    local is_class1 = Class.isClass(value1)
    local is_class2 = Class.isClass(value2)
    local is_instance1 = Class.isInstance(value1)
    local is_instance2 = Class.isInstance(value2)

    --Log(Log.Msg, is_class1, is_class2, is_instance1, is_instance2)
    if not (is_class1 or is_class2 or is_instance1 or is_instance2) then
        return type(value1) == value2
    end

    local class1 = value1
    local class2 = value2
    
    if is_instance1 then
        class1 = Class.getClass(value1)
    end

    if is_instance2 then
        class2 = Class.getClass(value2)
    end

    return Class.isChild(class1, class2)
end

return Class