--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type TriggerClass
local Trigger = require('Class.Trigger')
---@type TimerClass
local Timer = require('Class.Timer.Timer')
---@type KeyboardControllerClass
local Keyboard = require('Class.Controller.Keyboard')
---@type ParameterTypeClass
local Param = require('Class.ParameterType')
---@type UnitParametersContainerClass
local UnitParam = require('Class.Unit.Parameters.Container')

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

function public:lockUnit(unit, walk_anim_id, stand_anim_id)
    local priv = private.data[self]
    UnitRemoveAbility(unit, ID('Amov'))
    priv.unit = unit
    priv.walk_id = walk_anim_id
    priv.stand_id = stand_anim_id
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.update_time = 0.01

local GetTriggerPlayer = GetTriggerPlayer
local BlzGetTriggerPlayerKey = BlzGetTriggerPlayerKey
local BlzGetTriggerPlayerIsKeyDown = BlzGetTriggerPlayerIsKeyDown
function private.setKey(pl, key, meta, is_down)
    for _, priv in pairs(private.data) do
        if pl == priv.player then
            if is_down then
                if key == OSKEY_W or key == OSKEY_S then
                    priv.started_walk = true
                end
                priv.pressed[key] = 1
            else
                if key == OSKEY_W or key == OSKEY_S then
                    priv.finished_walk = true
                end
                priv.pressed[key] = 0
            end
        end
    end
end

function private.timerLoop()
    for _, priv in pairs(private.data) do
        private.moveUnit(priv, priv.unit, priv.walk_id, priv.stand_id)
    end
end

function private.moveUnit(priv, unit, walk_id, stand_id)
    local speed = UnitParam.get(unit):getResult(Param.MS) * private.update_time
    local w_speed = 2 * GetUnitTurnSpeed(unit) * private.update_time

    local range = (priv.pressed[OSKEY_W] - priv.pressed[OSKEY_S]) * speed
    local angle = (priv.pressed[OSKEY_A] - priv.pressed[OSKEY_D]) * w_speed

    local cur_angle = GetUnitFacing(unit)
    if angle ~= 0 then
        cur_angle = cur_angle + 360 * angle * (1 - 2 * priv.pressed[OSKEY_S])
        SetUnitFacingTimed(unit, cur_angle, private.update_time)
    end

    local speed_factor = 1
    if priv.started_walk and (range > 1 or range < -1) then
        if range > 1 then
            SetUnitTimeScale(unit, 1)
        elseif range < -1 then
            SetUnitTimeScale(unit, -0.7)
            speed_factor = 0.7
        end

        SetUnitAnimationByIndex(unit, walk_id)
        priv.started_walk = false
    end

    if priv.finished_walk then
        SetUnitTimeScale(unit, 1)
        SetUnitAnimationByIndex(unit, stand_id)
        priv.finished_walk = false
    end

    local x = GetUnitX(unit) + range * math.cos(cur_angle * bj_DEGTORAD) * speed_factor
    local y = GetUnitY(unit) + range * math.sin(cur_angle * bj_DEGTORAD) * speed_factor

    SetUnitX(unit, x)
    SetUnitY(unit, y)
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.update_time, true, private.timerLoop)

    --[[
    private.move_trigger = Trigger.new()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        private.move_trigger:addPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, Player(i))
    end

    local stop_id = 851972
    local move_id = 851986
    local attack_id = 851983
    local smart_id = 851971
    local patrol_id = 851990
    private.move_trigger:addAction(function()
        local unit = GetOrderedUnit()
        local order_id = GetIssuedOrderId()
        if order_id == move_id or order_id == attack_id or order_id == smart_id or order_id == patrol_id then
            IssueImmediateOrderById(unit, stop_id)
        end
    end)
    ]]

    Keyboard.addAction(Player(0), OSKEY_W, 0, true, private.setKey)
    Keyboard.addAction(Player(0), OSKEY_A, 0, true, private.setKey)
    Keyboard.addAction(Player(0), OSKEY_S, 0, true, private.setKey)
    Keyboard.addAction(Player(0), OSKEY_D, 0, true, private.setKey)

    Keyboard.addAction(Player(0), OSKEY_W, 0, false, private.setKey)
    Keyboard.addAction(Player(0), OSKEY_A, 0, false, private.setKey)
    Keyboard.addAction(Player(0), OSKEY_S, 0, false, private.setKey)
    Keyboard.addAction(Player(0), OSKEY_D, 0, false, private.setKey)
end

---@param self ControllerWASD
function private.newData(self, player)
    local priv = {
        player = player,
        unit = nil,
        walk_id = nil,
        stand_id = nil,

        started_walk = false,
        finished_walk = false,

        pressed = {
            [OSKEY_W] = 0,
            [OSKEY_A] = 0,
            [OSKEY_S] = 0,
            [OSKEY_D] = 0,
        }
    }

    private.data[self] = setmetatable(priv, private.metadata)
end

private.metatable = {
    __gc = function(self) end
}

return static