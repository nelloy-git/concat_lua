local Log = require('utils.Log')

local ClassName = require('utils.Class.ClassName')
local ClassParent = require('utils.Class.ClassParent')
local ClassStatic = require('utils.Class.ClassStatic')
local ClassPublic = require('utils.Class.ClassPublic')
local ClassProtected = require('utils.Class.ClassProtected')
local ClassInstance = require('utils.Class.ClassInstance')

local ClassPackage
if IsCompiletime() then
    ClassPackage = require('utils.Class.ClassPackage')
end

local Class = {}

local function class_index(self, key)
    Log(Log.Err, 'Class', 'static, override, public, protected are allowed only.')
    return nil
end

local class_metatable = {
    __index = class_index,
    __newindex = class_index,
    __tostring = ClassName.get
    
}

function Class.new(name, ...)
    ---@class Class
    local class = {}
    setmetatable(class, class_metatable)

    ClassName.register(class, name)
    ClassParent.register(class, ...)

    if IsCompiletime() then
        ClassPackage.register(name)
    end

    ---@class ClassStatic
    rawset(class, 'static', ClassStatic.new(class))
    rawset(class, 'override', ClassStatic.newOverride(class))
    rawset(class, 'public', ClassPublic.new(class))
    rawset(class, 'protected', ClassProtected.new(class))

    return class
end

Class.allocate = ClassInstance.allocate

if IsCompiletime() then
    Class.getPackage = ClassPackage.getPackage
end

return Class