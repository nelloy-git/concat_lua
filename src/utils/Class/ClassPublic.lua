local ClassParent = require('utils.Class.ClassParent')
local ClassUtils = require('utils.Class.ClassUtils')

local ClassPublic = {}

local rawget = rawget
local rawset = rawset
local fmt = string.format
local deepcopy = ClassUtils.deepcopy

local publics = {}
local NIL = '__RESERVED__'

function ClassPublic.new(class)
    publics[class] = {}

    local parents = ClassParent.get(class)
    for i = 1, #parents do
        local cur_parent = parents[#parents + 1 - i]
        local cur_parent_public = publics[cur_parent]
        local copy = deepcopy(cur_parent_public)
        for k,v in pairs(copy) do
            publics[class][k] = v
        end
    end

    setmetatable(publics[class], {
        __newindex = function(self, key, value)
            if value == nil then
                value = NIL
            end
            rawset(self, key, value)
        end,
    })

    return publics[class]
end

function ClassPublic.get(class)
    return publics[class]
end

return ClassPublic