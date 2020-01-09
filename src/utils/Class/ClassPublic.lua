local Log = require('utils.Log')
local ClassParent = require('utils.Class.ClassParent')
local ClassName = require('utils.Class.ClassName')

local ClassPublic = {}

local publics = {}
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