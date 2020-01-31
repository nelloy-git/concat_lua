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

return ClassDeclare