local ClassName = require('utils.Class.ClassName')
local ClassUtils = require('utils.Class.ClassUtils')

local ClassInstance = {}

local instance_class = {}

local rawget = rawget
local rawset = rawset
local fmt = string.format
local deepcopy = ClassUtils.deepcopy

local function instance_tostring(instance)
    local temp = getmetatable(instance)
    setmetatable(instance, nil)
    local def = tostring(instance)
    local class = instance_class[instance]
    local res = ClassName.getName(class)..'_'..string.sub(def, 10, #def)
    setmetatable(instance, temp)
    return res
end

local function instance_index(instance, key)
    local value = rawget(instance, key)
    if value then
        return value
    end
    error(fmt('%s: public field \'%s\' does not exist.', instance, key), 2)
end

local function instance_newindex(instance, key, value)
    local cur_value = rawget(instance, key)
    if cur_value then
        rawset(instance, key, value)
        return
    end
    error(fmt('%s: public field \'%s\' does not exist.', instance, key), 2)
end

local instance_metatable = {
    __tostring = instance_tostring,
    __index = instance_index,
    __newindex = instance_newindex
}

function ClassInstance.allocate(class)
    local instance = deepcopy(class.public)
    setmetatable(instance, instance_metatable)

    instance_class[instance] = class
    return instance
end

function ClassInstance.free(instance)
    if not instance_class[instance] then
        error(tostring(instance)..' is not instance of class.', 2)
        Log(Log.Wrn, instance, msg)
        return
    end

    instance_class[instance] = nil
    setmetatable(instance, nil)
end

function ClassInstance.getClass(instance)
    return instance_class[instance]
end

function ClassInstance.isInstance(instance)
    if instance_class[instance] then
        return true
    end
    return false
end

return ClassInstance