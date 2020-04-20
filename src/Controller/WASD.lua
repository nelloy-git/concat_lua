--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type TimerClass
local Timer = require('Timer.Timer')
---@type KeyboardControllerClass
local Keyboard = require('Class.Controller.Keyboard')
---@type UnitControllerClass
local UnitController = require('Class.Controller.Unit')

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
---@param unit Unit
---@return ControllerWASD
function override.new(player, unit)
    local instance = Class.allocate(ControllerWASD)
    private.newData(instance, player, unit)

    unit:enableMove(false)

    return instance
end

--========
-- Public
--========

function public:enable(flag)
    local priv = private.data[self]
    --UnitAddAbility(unit, ID('Abun'))
    --UnitRemoveAbility(unit, ID('Amov'))
    priv.enable = flag
    priv.unit_controller:enable(flag)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.update_time = 0.03125

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
        if priv.enable then
            private.moveUnit(priv, priv.unit, priv.unit_controller)
        end
    end
end

---@param priv table
---@param unit Unit
---@param controller UnitController
function private.moveUnit(priv, unit, controller)
    local speed = unit:getMoveSpeed() * private.update_time
    local w_speed = unit:getTurnSpeed() * private.update_time

    local range = (priv.pressed[OSKEY_W] - priv.pressed[OSKEY_S]) * speed
    local angle = (priv.pressed[OSKEY_A] - priv.pressed[OSKEY_D]) * w_speed

    controller:move(range)
    controller:turn(unit:getFacing() + 360 * angle * (1 - 2 * priv.pressed[OSKEY_S]))
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.update_time, true, private.timerLoop)

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
---@param player player
---@param unit Unit
function private.newData(self, player, unit)
    local priv = {
        enable = false,

        player = player,
        unit = unit,
        unit_controller = UnitController.new(unit),

        pressed = {
            [OSKEY_W] = 0,
            [OSKEY_A] = 0,
            [OSKEY_S] = 0,
            [OSKEY_D] = 0,
        }
    }
    private.data[self] = priv
end

return static