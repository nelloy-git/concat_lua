---@type Settings
local Settings = require('utils.Settings')

local Globals = {}


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


local compiletime_print = print
---Function prints data to local player in debug mode.
function Debug(...)
    if is_compiletime then
        compiletime_print(...)
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


---Converts integer or string id to integer.
---@param id integer|string
---@return integer|nil
function ID(id)
    if type(id) == 'string' then
        return string.unpack(">I4", id)
    elseif type(id) == 'number' and math.fmod(id, 1) == 0 then
        return id
    end
    print('Wrong id fromat')
    return nil
end


---@Converts integer id to string id.
---@param id integer
---@return string
function ID2str(id)
    return string.pack(">I4", id)
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

return Globals