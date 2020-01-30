local ClassParent = require('utils.Class.ClassParent')

local ClassStatic = {}

local rawget = rawget
local rawset = rawset
local fmt = string.format

local class2static = {}
local static2class = {}

local log_level = 1
local static_meta = {
    __index = function(self, key)
        log_level = log_level + 1
        local class = static2class[self]
        local parents = ClassParent.get(class)
        for i = 1, #parents do
            local cur = class2static[parents[i]]
            local value = cur[key]
            if value then
                log_level = log_level - 1
                return value
            end
        end
        error(fmt(tostring(self)..': static field \'%s\' does not exist.', key), log_level)
    end,

    __newindex = function(self, key, value)
        local class = static2class[self]
        local parents = ClassParent.get(class)
        for i = 1, #parents do
            local cur = class2static[parents[i]]
            if rawget(cur, key) then
                rawset(cur, key, value)
                return
            end
        end
        rawset(self, key, value)
    end,

    __tostring = function(self)
        return tostring(static2class[self])
    end
}

function ClassStatic.register(class)
    local static = {}
    setmetatable(static, static_meta)

    class2static[class] = static
    static2class[static] = class
    return class2static[class]
end

function ClassStatic.getStatic(class)
    return class2static[class]
end

function ClassStatic.getClass(static)
    return static2class[static]
end

return ClassStatic