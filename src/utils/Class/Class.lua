local Log = require('utils.Log')

local ClassName = require('utils.Class.ClassName')
local ClassParent = require('utils.Class.ClassParent')
local ClassStatic = require('utils.Class.ClassStatic')
local ClassPublic = require('utils.Class.ClassPublic')
local ClassInstance = require('utils.Class.ClassInstance')

Class = {}
local rawget = rawget
local rawset = rawset
local fmt = string.format

local function class_index(self, key)
    Log(Log.Err, self, 'static, override, public, protected are allowed only.')
    error(tostring(self)..': static, override, public, protected are allowed only.')
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

Class.new = new
Class.allocate = ClassInstance.allocate
Class.free = ClassInstance.free
Class.getClass = ClassInstance.getClass
Class.isChild = ClassParent.isChild

return Class