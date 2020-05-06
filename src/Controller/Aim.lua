--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type ControllerDetectorClass
local Grid = require('Class.Controller.Grid')
---@type TimerClass
local Timer = require('Timer.Timer')
---@type SimpleFrameClass
local SimpleFrame = require('Frame.Default.SimpleFrame')
---@type ControllerScreenClass
local ScreenController = require('Class.Controller.Screen')

--=======
-- Class
--=======

local ControllerAim = Class.new('ControllerAim')
---@class ControllerAim
local public = ControllerAim.public
---@class ControllerAimClass
local static = ControllerAim.static
---@type ControllerAimClass
local override = ControllerAim.override
local private = {}

--=========
-- Static
--=========

---@param child_instance ControllerAim | nil
---@return ControllerAim
function override.new(child_instance)
    local instance = child_instance or Class.allocate(ControllerAim)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:lockUnit(unit)
    private.data[self].unit = unit
end

function public:enable(flag)
    local priv = private.data[self]
    priv.enable = flag
    if flag then
        priv.grid:setX(ScreenController.getRealZeroX())
    else
        priv.grid:setX(-10)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.res_x = 11
private.mid_x = private.res_x // 2 + 1
private.res_y = 11
private.mid_y = private.res_y // 2 + 1
local _ = Compiletime(function()
    private.icon = require('Resources.Icon').BTNSteelMelee
end)
private.period = 0.03125

private.w_speed = 5

local time = 0
function private.timerLoop()
    for _, priv in pairs(private.data) do
        if priv.unit and priv.enable then
            local x, y = priv.grid:detect()
            local dx = x - private.mid_x
            SetUnitFacingTimed(priv.unit:getObj(), GetUnitFacing(priv.unit:getObj()) + dx * private.w_speed, private.period)
            BlzSetMousePos(BlzGetLocalClientWidth()//2, BlzGetLocalClientHeight()//2)
        end
    end
    time = time + private.period
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.period, true, private.timerLoop )
end

---@param self ControllerAim
function private.newData(self)
    local grid_width = ScreenController.getRealWidth()
    local grid_x = 0.4 - grid_width / 2
    local grid_height = 0.6


    local priv = {
        unit = nil,
        enable = false,
        grid = Grid.new(-10, 0,
                        grid_width, grid_height,
                        private.res_x, private.
                        res_y)
    }
    private.data[self] = priv
end


return static