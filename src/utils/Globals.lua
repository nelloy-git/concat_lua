---@type Settings
local Settings = require('utils.Settings')
---@class Class
Class = require('utils.middleclass')

local Globals = {}
local original_type = _G.type

local initialized = false
function Globals.init()
    if initialized then return nil end

    ---@type Vec2
    Vec2 = require('utils.math.Vec2')
    ---@type Vec3
    Vec3 = require('utils.math.Vec3')

    local Timer = require('utils.timer.Timer')
    ---@type Timer
    glTimer = Timer.new(Settings.Timer.glTimer_period)

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

---Function prints data to local player in debug mode.
function Debug(...)
    if is_compiletime then
        print(...)
    elseif Settings.debug then
        local s = ''
        for i = 1, select('#', ...) do
            local v = select(i, ...)
            local t = original_type(v)
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

---@return string
function type(val)
    -- Default type()
    local lua_type = original_type(val)
    if lua_type ~= 'table' or not val.class then return lua_type end
    -- Class type
    return tostring(val)
end

local cl = Class('class')
local ins = cl()

print(ins)

return Globals