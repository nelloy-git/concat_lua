local Settings = require('utils.Settings')

require('utils.Class')

local Globals = {}
---@alias callback fun():any

local initialized = false
function Globals.init()
    if initialized then return nil end

    ---@type Vec2
    --Vec2 = require('utils.math.Vec2')
    ---@type Vec3
    --Vec3 = require('utils.math.Vec3')

    ---@type BetterTimer
    --local Timer = require('class.Timer.BetterTimer')
    
    --glTimer = Timer:new()

    initialized = true
end

---@param func fun
function runFuncInDebug(func, ...)
    if Settings.debug then 
        local success, result = pcall(func, ...)
        if success then
            return result
        else
            Debug(result)
            return nil
        end
    else
        return func(...)
    end
end

---Converts integer or string id to integer.
---@param id integer|string
---@return integer|nil
function ID(id)
    if type(id) == 'string' then
        return string.unpack(">I4", id)
    elseif type(id) == 'number' and math.fmod(id, 1) == 0 then
        return id
    end
    print('Wrong id format')
    return nil
end

---Converts integer id to string id.
---@param id integer
---@return string
function ID2str(id)
    if type(id) == 'number' or type(id) == 'integer' then
        return string.pack(">I4", id)
    end
    return id
end

---If val < min returns min. If val > max returns max.
---@param val number
---@param min number
---@param max number
---@return number
function torange(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end

---Function prints data to local player in debug mode.
function Debug(...)
    if is_compiletime then
        print(...)
    elseif Settings.debug then
        local s = ''
        for i = 1, select('#', ...) do
            local v = select(i, ...)
            local t = type(v)
            if t == 'nil' then
                v = 'nil'
            elseif t == 'userdata' then
                v = 'userdata'
            elseif t == 'string' then
                v = v
            elseif t == 'integer' or t == 'number' then
                v = tostring(v)
            elseif t == 'table' or t == 'function' then
                v = tostring(v)
            else
                v = ''
            end

            s = s..' '..v
        end

        DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, '[Debug]: '..s)
    end
end

---@param orig any
---@param copies any
---@return any
function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
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

return Globals