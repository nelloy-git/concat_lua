local ClassName = require('utils.Class.ClassName')
local ClassParent = require('utils.Class.ClassParent')

local ClassStatic = {}
local rawget = rawget
local rawset = rawset
local fmt = string.format

local class2static = {}
local static2class = {}

local function static_tostring(self)
    local class = static2class[self]
    return tostring(class)
end

local function static_newindex(self, key, value)
    local class = static2class[self]
    ClassParent = ClassParent or require('utils.Class.ClassParent')
    local parents = ClassParent.get(class)
    for i = 1, #parents do
        local parent_static = class2static[parents[i]]
        if rawget(parent_static, key) then
            rawset(parent_static, key, value)
            return
        end
    end
    rawset(self, key, value)
end

local function static_index(self, key)
    local class = static2class[self]
    ClassParent = ClassParent or require('utils.Class.ClassParent')
    local parents = ClassParent.get(class)
    for i = 1, #parents do
        local parent_static = class2static[parents[i]]
        local parent_value = rawget(parent_static, key)
        if parent_value then
            return parent_value
        end
    end
end

function ClassStatic.new(class)
    class2static[class] = {}
    static2class[class2static[class]] = class
    setmetatable(class2static[class], {
        __newindex = static_newindex,
        __index = static_index,
        __tostring = static_tostring
    })
    return class2static[class]
end

function ClassStatic.getStatic(class)
    return class2static[class]
end

function ClassStatic.getClass(static)
    return static2class[static]
end

local override2class = {}

function override_index(override, key)
    local class = override2class[override]
    rawget(class2static[class], key)
end

function override_newindex(override, key, value)
    local class = override2class[override]
    rawset(class2static[class], key, value)
end

function ClassStatic.newOverride(class)
    local override = {}
    override2class[override] = class
    setmetatable(override, {
        __index = override_index,
        __newindex = override_newindex,
    })
    return override
end

return ClassStatic