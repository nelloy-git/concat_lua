--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type TriggerClass
local Trigger = require('Class.Trigger')
---@type BetterTimerClass
local Timer = require('Class.Timer.BetterTimer')
local gl_timer
local gl_period
if not IsCompiletime() then
    gl_timer = Timer.getGlobalTimer()
    gl_period = gl_timer:getPeriod()
end

--=======
-- Class
--=======

local ControllerWASD = Class.new('ControllerWASD')
---@class ControllerWASD
local public = ControllerWASD.public
---@class ControllerWASDClass
local static = ControllerWASD.static
---@type ControllerWASDClass
local override = ControllerWASD.override
local private = {}

--=========
-- Static
--=========

---@param player player
---@return ControllerWASD
function static.new(player)
    local instance = Class.allocate(ControllerWASD)
    private.newData(instance, player)

    return instance
end

--========
-- Public
--========

function public:addUnit(unit)
    table.insert(private.data[self].units, unit)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
if not IsCompiletime() then
    private.trigger = Trigger.new()

    for i = 0, bj_MAX_PLAYER_SLOTS do
        private.trigger:addPlayerKeyEvent(Player(i), OSKEY_W, 0, true)
        private.trigger:addPlayerKeyEvent(Player(i), OSKEY_A, 0, true)
        private.trigger:addPlayerKeyEvent(Player(i), OSKEY_S, 0, true)
        private.trigger:addPlayerKeyEvent(Player(i), OSKEY_D, 0, true)

        private.trigger:addPlayerKeyEvent(Player(i), OSKEY_W, 0, false)
        private.trigger:addPlayerKeyEvent(Player(i), OSKEY_A, 0, false)
        private.trigger:addPlayerKeyEvent(Player(i), OSKEY_S, 0, false)
        private.trigger:addPlayerKeyEvent(Player(i), OSKEY_D, 0, false)
    end

end

local GetTriggerPlayer = GetTriggerPlayer
local BlzGetTriggerPlayerKey = BlzGetTriggerPlayerKey
local BlzGetTriggerPlayerIsKeyDown = BlzGetTriggerPlayerIsKeyDown
function private.setKey()
    local pl = GetTriggerPlayer()
    local key = BlzGetTriggerPlayerKey()
    local is_down = BlzGetTriggerPlayerIsKeyDown()

    for _, priv in pairs(private.data) do
        if pl == priv.player then
            priv.pressed[key] = is_down
        end
    end
end

local const_range = 50
local const_angle = 135 * (gl_period or 0)
local conts_r = 20
function private.timerLoop()
    for _, priv in pairs(private.data) do
        for i = 1, #priv.units do
            local range = 0
            local angle = 0

            if priv.pressed[OSKEY_W] then
                range = range + const_range
            end
            if priv.pressed[OSKEY_S] then
                range = range - const_range
            end
            if priv.pressed[OSKEY_D] then
                angle = angle + const_angle
            end
            if priv.pressed[OSKEY_A] then
                angle = angle - const_angle
            end

            local a = GetUnitFacing(priv.units[i])
            if angle ~= 0 then
                a = a - angle
                SetUnitFacingTimed(priv.units[i], a, gl_period)
            end

            if range ~= 0 then
                local x = GetUnitX(priv.units[i]) + range * math.cos(a * bj_DEGTORAD)
                local y = GetUnitY(priv.units[i]) + range * math.sin(a * bj_DEGTORAD)

                local r = (x - priv.prev_x)^2 + (y - priv.prev_y)^2
                if r > conts_r then
                    IssuePointOrder(priv.units[i], 'move', x, y)

                    priv.prev_x = x
                    priv.prev_y = y
                end
            end
        end
    end
    gl_timer:addAction(0, private.timerLoop)
end
if not IsCompiletime() then
    gl_timer:addAction(0, private.timerLoop)
    private.trigger:addAction(private.setKey)
end

---@param self ControllerWASD
function private.newData(self, player)
    local priv = {
        player = player,
        units = {},

        prev_x = 0,
        prev_y = 0,

        pressed = {
            [OSKEY_W] = false,
            [OSKEY_A] = false,
            [OSKEY_S] = false,
            [OSKEY_D] = false,
        }
    }

    private.data[self] = setmetatable(priv, private.metadata)
end

private.metatable = {
    __gc = function(self) end
}

return static