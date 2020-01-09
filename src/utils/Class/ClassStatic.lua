local Log = require('utils.Log')
local ClassParent = require('utils.Class.ClassParent')
local ClassName = require('utils.Class.ClassName')

local ClassStatic = {}

local statics = {}

local function static_newindex(self, key, value, class)
    print('new static:'..tostring(value))
    local parents = ClassParent.get(class)
    for i = 1, #parents do
        local parent_static = statics[parents[i]]
        if rawget(parent_static, key) then
            rawset(parent_static, key, value)
            return
        end
    end
    rawset(self, key, value)
end

local function static_index(self, key, class)
    local parents = ClassParent.get(class)
    for i = 1, #parents do
        local parent_static = statics[parents[i]]
        local parent_value = rawget(parent_static, key)
        if parent_value then
            return parent_value
        end
    end
end

function ClassStatic.new(class)
    statics[class] = {}
    setmetatable(statics[class], {
        __newindex = function(self, key, value) static_newindex(self, key, value, class) end,
        __index = function(self, key) return static_index(self, key, class) end
    })
    return statics[class]
end

function ClassStatic.get(class)
    return statics[class]
end


function ClassStatic.newOverride(class)
    local override = {}
    setmetatable(override, {
        __index = function(self, key) return rawget(statics[class], key) end,
        __newindex = function(self, key, value) rawset(statics[class], key, value) end,
    })
    return override
end

return ClassStatic