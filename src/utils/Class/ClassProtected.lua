local Log = require('utils.Log')
local ClassParent = require('utils.Class.ClassParent')
local ClassName = require('utils.Class.ClassName')

local ClassProtected = {}

local protecteds = {}
local NIL = '__RESERVED__'

---@param orig any
---@param copies any
---@return any
local function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = _G.type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            setmetatable(copy, deepcopy(getmetatable(orig), copies))
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
            end
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function ClassProtected.new(class)
    protecteds[class] = {}

    local parents = ClassParent.get(class)
    for i = 1, #parents do
        local cur_parent = parents[#parents + 1 - i]
        local cur_parent_protected = protecteds[cur_parent]
        local copy = deepcopy(cur_parent_protected)
        for k,v in pairs(copy) do
            protecteds[class][k] = v
        end
    end

    setmetatable(protecteds[class], {
        __newindex = function(self, key, value)
            if value == nil then
                value = NIL
            end
            rawset(self, key, value)
        end,
    })

    return protecteds[class]
end

function ClassProtected.get(class)
    return protecteds[class]
end

return ClassProtected