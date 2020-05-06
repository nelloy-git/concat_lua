local ClassParent = require(__ClassLib..'Parent')
local ClassStatic = require(__ClassLib..'Static')
local ClassUtils = require(__ClassLib..'Utils')

---@class ClassPublic
local ClassPublic = {}

local rawset = rawset
local deepcopy = ClassUtils.deepcopy

local class2public = {}
local public2class = {}

local NIL = '__RESERVED__'

local public_meta = {
    __newindex = function(self, key, value)
        if value == nil then
            value = NIL
        end
        rawset(self, key, value)
    end,

    __tostring = function(self)
        return tostring(public2class[self])
    end
}

---@param class table
---@return table
function ClassPublic.register(class)
    local public = {}
    setmetatable(public, public_meta)

    class2public[class] = public
    public2class[public] = class
    return public
end

---@param class table
---@return table
function ClassPublic.get(class)
    class = ClassStatic.getClass(class) or class
    return class2public[class]
end

return ClassPublic