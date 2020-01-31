local ClassName = require('utils.Class.Name')
local ClassParent = require('utils.Class.Parent')
local ClassPublic = require('utils.Class.Public')
local ClassUtils = require('utils.Class.Utils')

local ClassInstance = {}

local instance2class = {}
setmetatable(instance2class, {__mode = 'kv'})

local rawget = rawget
local rawset = rawset
local fmt = string.format
local deepcopy = ClassUtils.deepcopy

local instance_metatable
instance_metatable = {
    __index = function(self, key)
        error(fmt('%s: public field \'%s\' does not exist.', self, key), 2)
    end,

    __newindex = function(self, key, value)
        error(fmt('%s: public field \'%s\' does not exist.', self, key), 2)
    end,

    __tostring = function(self)
        setmetatable(self, nil)
        local def = tostring(self)
        setmetatable(self, instance_metatable)
        local class = instance2class[self]
        return ClassName.getName(class)..'_'..string.sub(def, 10)
    end,
}

---@param class Class
---@return Instance
function ClassInstance.allocate(class)
    ---@class Instance
    local instance = {}
    local parents = ClassParent.getList(class)

    for i = 1, #parents do
        local cur = parents[#parents + 1 - i]
        local cur_public = ClassPublic.get(cur)
        local copy = deepcopy(cur_public)
        for k,v in pairs(copy) do
            instance[k] = v
        end
    end

    local copy = deepcopy(ClassPublic.get(class))
    for k,v in pairs(copy) do
        instance[k] = v
    end

    setmetatable(instance, instance_metatable)
    instance2class[instance] = class
    return instance
end

function ClassInstance.getClass(instance)
    return instance2class[instance]
end

function ClassInstance.isInstance(instance)
    if instance2class[instance] then
        return true
    end
    return false
end

return ClassInstance