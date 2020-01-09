local Log = require('utils.Log')

local ClassName = require('utils.Class.ClassName')

local ClassPackage
if IsCompiletime() then
    ClassPackage = require('utils.Class.ClassPackage')
end

local ClassInstance = {}

local instance_class = {}
local protected_data = {}
local private_data = {}
local sep = package.config:sub(1,1)
local fmt = string.format

local function getErrorPos(instance)
    if IsCompiletime() then
        local info = debug.getinfo(3, 'lS')
        local package = info.source:sub(4, #info.source - 4):gsub(sep, '.')
        return package..': '..tostring(info.currentline)
    end
end

local function isInClassFile(instance)
    local class = instance_class[instance]
    local info = debug.getinfo(3, 'S')
    local package = info.source:sub(4, #info.source - 4):gsub(sep, '.')
    if package == ClassPackage.getPackage(ClassName.getName(class)) then
        return true
    end
    return false
end

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

local function instance_index(instance, key)
    local value = rawget(instance, key)
    if value then
        return value
    end

    --- Found in protected.
    value = protected_data[instance][key]
    if value then
        if isInClassFile(instance) then
            return value
        end
        local msg = fmt('protected is not available in this file. %s', getErrorPos(instance))
        Log(Log.Err, 'Instance', msg)
        return
    end
    --- Found in private.
    value = private_data[instance][key]
    if value then
        if isInClassFile(instance) then
            return value
        end
        local msg = fmt('private is not available in this file. %s', getErrorPos(instance))
        Log(Log.Err, 'Instance', msg)
        return
    end

    local msg = fmt('field %s not found. %s', key, getErrorPos(instance))
    Log(Log.Err, 'Instance', msg)
end

local function instance_newindex(instance, key, value)
    local cur_value = rawget(instance, key)
    if cur_value then
        rawset(instance, key, value)
        return
    end

    if key == 'protected' then
        return protected_data[instance]
    end

    if key == 'private' then
        return private_data[instance]
    end

    --- Found in protected.
    cur_value = protected_data[instance][key]
    if cur_value then
        if isInClassFile(instance) then
            protected_data[instance][key] = value
            return
        end
        local msg = fmt('protected is not available in this file. %s', getErrorPos(instance))
        Log(Log.Err, 'Instance', msg)
        return
    end

    --- Found in private
    cur_value = private_data[instance][key]
    if cur_value then
        if isInClassFile(instance) then
            private_data[instance][key] = value
            return
        end
        local msg = fmt('private is not available in this file. %s', getErrorPos(instance))
        Log(Log.Err, 'Instance', msg)
        return
    end

    local msg = fmt('field %s not found. %s', key, getErrorPos(instance))
    Log(Log.Err, 'Instance', msg)
end

local instance_metatable = {
    __index = instance_index,
    __newindex = instance_newindex
}

function ClassInstance.allocate(class)
    local instance = deepcopy(class.public)
    setmetatable(instance, instance_metatable)

    protected_data[instance] = deepcopy(class.protected)
    private_data[instance] = {}

    instance_class[instance] = class
    return instance
end

function ClassInstance.getClass(instance)
    return instance_class[instance]
end

return ClassInstance