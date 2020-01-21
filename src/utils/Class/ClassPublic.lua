local ClassParent = require('utils.Class.ClassParent')
local ClassStatic = require('utils.Class.ClassStatic')
local ClassUtils = require('utils.Class.ClassUtils')

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
}

function ClassPublic.register(class)
    local public = {}
    setmetatable(public, public_meta)

    local parents = ClassParent.get(class)
    for i = 1, #parents do
        local cur_parent = parents[#parents + 1 - i]
        local cur_public = class2public[cur_parent]
        local copy = deepcopy(cur_public)
        for k,v in pairs(copy) do
            public[k] = v
        end
    end

    class2public[class] = public
    public2class[public] = class
    return public
end

function ClassPublic.get(class)
    class = ClassStatic.getClass(class) or class
    return class2public[class]
end

return ClassPublic