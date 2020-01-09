local Log = require('utils.Log')

local ClassName = require('utils.Class.ClassName')
local ClassParent = require('utils.Class.ClassParent')
local ClassStatic = require('utils.Class.ClassStatic')

local Class = {}

local function class_index(self, key)
    Log(Log.Err, 'Class', 'static, override, public, protected are allowed only.')
    return nil
end

local class_metatable = {
    __index = class_index,
    __newindex = class_index,
}

function Class.new(name, ...)
    ---@class Class
    local class = {}
    setmetatable(class, class_metatable)

    ClassName.register(class, name)
    ClassParent.register(class, ...)

    ---@class ClassStatic
    rawset(class, 'static', ClassStatic.new(class))
    rawset(class, 'override', ClassStatic.newOverride(class))

    return class
end

function Class.override(class, key, value)
    ClassStatic.override(class, key, value)
end

return Class