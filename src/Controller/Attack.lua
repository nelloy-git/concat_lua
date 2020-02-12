--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type TimerClass
local Timer = require('Timer.Timer')
---@type SelectionControllerClass
local SelectionController = require('Class.Controller.Selection')

--=======
-- Class
--=======

local ControllerAttack = Class.new('ControllerAttack')
---@class ControllerAttack
local public = ControllerAttack.public
---@class ControllerAttackClass
local static = ControllerAttack.static
---@type ControllerAttackClass
local override = ControllerAttack.override
local private = {}

--=========
-- Static
--=========

---@param player player
---@return ControllerAttack
function static.new(player)
    local instance = Class.allocate(ControllerAttack)
    private.newData(instance, player)

    return instance
end

--========
-- Public
--========

---@param unit Unit
function public:lockUnit(unit, range, angle)
    local priv = private.data[self]
    priv.unit = unit
    priv.attack_range = range
    priv.square_range = range * range
    priv.attack_angle = angle

    unit:enableAttack(false)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.period = 0.03125

---@param self ControllerAttack
function private.newData(self, player)
    local priv = {
        player = player,
        unit = nil,
        target = nil,

        attack_range = 0,
        square_range = 0,
        attack_angle = 0,
        attacking = false
    }
    private.data[self] = priv

    SelectionController.addAction(player, true, private.setTarget)
    SelectionController.addAction(player, false, private.setTarget)
end

---@return boolean
function private.isAvaliable(priv)
    if not priv.target then
        --print('Target fail')
        return false
    end

    local x = priv.unit:getX()
    local y = priv.unit:getY()
    local t_x = GetUnitX(priv.target)
    local t_y = GetUnitY(priv.target)
    local dx = t_x - x
    local dy = t_y - y
    local r = dx * dx + dy * dy
    if r > priv.square_range then
        --print('Range fail')
        return false
    end

    local angle = priv.unit:getFacing()
    local max_angle = angle + priv.attack_angle
    local min_angle = angle - priv.attack_angle
    local t_angle = math.atan(dy, dx) * bj_RADTODEG
    if t_angle < 0 then
        t_angle = 360 + t_angle
    end
    if t_angle > angle + priv.attack_angle or t_angle < angle - priv.attack_angle then
        --print('Angle fail', angle, t_angle)
        return false
    end

    return true
end

function private.timerLoop()
    for _, priv in pairs(private.data) do
        if private.isAvaliable(priv) then
            if not priv.attacking then
                priv.unit:enableAttack(true)
                IssueTargetOrderById(priv.unit:getObj(), 851983, priv.target)
                priv.attacking = true
            end
        else
            if priv.attacking then
                priv.unit:enableAttack(false)
                priv.attacking = false
            end
        end
    end
end

function private.setTarget(player, selected, target)
    for _, priv in pairs(private.data) do
        if priv.player == player then
            if selected and IsUnitEnemy(target, player) then
                priv.target = target
            else
                priv.target = nil
            end
        end
    end
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.period, true, private.timerLoop)
end

return static