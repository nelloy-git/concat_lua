---@type Player
--local Player = require('player.player')
--if not is_compiletime then
--    Player.init()
--end

local Settings = require('utils.settings')
require('utils.math.vec2')
require('utils.math.vec3')

--require('utils.globalTimer')
--require('ability.abilityEvent')
--require('player.playerEvent')
--require('unit.unitEvent')

---@class Utils
local Utils = {}

---@return string
--function  getErrorPos()
--    local str = ''
--    local i = 2
--    while debug.getinfo(i, 'ln') ~= nil do
--        local func = debug.getinfo(i, 'lnS')
--        local source_type = func.source:sub(#func.source - 3, #func.source)
--        if func.source:sub(#func.source - 3, #func.source) == '.lua' then
--            str = '  ' .. func.source .. ':' .. tostring(func.currentline) .. '\n' .. str
--        end
--        i = i + 1
--    end
--    return str
--end

local __real_print = print
function print(...)
    if is_compiletime == true then
        __real_print(...)
    else
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
            elseif t == 'integer' or t == 'number' or t == 'table' or t == 'function' then
                v = tostring(v)
            else
                v = ''
            end

            s = s..' '..v
        end

        for i = 0, 23 do
            DisplayTimedTextToPlayer(Player(i):getObj(), 0, 0, 30, s)
        end
    end
end

local compiletime_print = print
---Function prints data to local player.
function Debug(...)
    if is_compiletime then
        __real_print(...)
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

        DisplayTimedTextToPlayer(Player.getLocal():getObj(), 0, 0, 30, '[Debug]: '..s)
    end
end


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

---@param player userdata
---@return integer
function player2index(player)
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        if Player(i) == player then return i end
    end
    return -1
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

return Utils