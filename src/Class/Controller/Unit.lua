--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type TimerClass
local Timer = require('Class.Timer.Timer')
---@type UnitObjClass
local UnitObj = require('Object.Unit')
---@type UnitAPI
local UnitAPI = require('Class.Unit.Api')
local AnimType = UnitAPI.AnimationType

--=======
-- Class
--=======

local UnitController = Class.new('UnitController')
---@class UnitController
local public = UnitController.public
---@class UnitControllerClass
local static = UnitController.static
---@type UnitControllerClass
local override = UnitController.override
local private = {}

--=========
-- Static
--=========

---@param unit Unit
---@return UnitController
function static.new(unit)
    local instance = Class.allocate(UnitController)
    private.newData(instance, unit)

    return instance
end

--========
-- Public
--========

---@param flag boolean
function public:enable(flag)
    local priv = private.data[self]
    if priv.enable ~= flag then
        priv.enable = flag
    end
end

local stop_id = 851972
local attack_id = 851983
local smart_id = 851971
local patrol_id = 851990
---@param range number
local r_size = 32
function public:move(range)
    local priv = private.data[self]
    if range >= 0 then
        priv.forward = true
    else
        priv.forward = false
    end

    ---@type Unit
    local unit = priv.unit
    local cur_angle = unit:getFacing()

    local x = unit:getX() + range * math.cos(cur_angle * bj_DEGTORAD)
    local y = unit:getY() + range * math.sin(cur_angle * bj_DEGTORAD)

    local list = EnumUnitsInRange(x, y, r_size)
    for i = 1, #list do
        if list[i] ~= unit:getObj() then
            local cur_x = GetUnitX(list[i])
            local cur_y = GetUnitY(list[i])
            if  private.range(x, y, cur_x, cur_y) < 2 * r_size then
                x = priv.x
                y = priv.y
                break
            end
        end
    end

    priv.x = x
    priv.y = y
    unit:setX(x)
    unit:setY(y)
end

---@param angle number
---@param time number | nil
function public:turn(angle, time)
    private.data[self].unit:setFacing(angle, time)
end

function public:setForwardAnimationFactor(factor)
    private.data[self].forward_anim_factor = factor
end

function public:setBackwardAnimationFactor(factor)
    private.data[self].backward_anim_factor = factor
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.update_time = 0.03125

function private.timerLoop()
    for _, priv in pairs(private.data) do
        if priv.enable then
            ---@type UnitAnimation
            local anim = priv.unit.Animation

            if priv.forward then
                anim:setSpeedFactor(priv.forward_anim_factor)
            else
                anim:setSpeedFactor(priv.backward_anim_factor)
            end

            if priv.x ~= priv.prev_x or priv.y ~= priv.prev_y then
                anim:play(AnimType.WALK)
            else
                anim:play(AnimType.STAND)
            end
        end
        priv.prev_x = priv.x
        priv.prev_y = priv.y
    end
end

function private.range(x1, y1, x2, y2)
    return ((x2-x1)^2 + (y2-y1)^2)^(0.5)
end

if not IsCompiletime() then
    private.timer = Timer.new()
    private.timer:start(private.update_time, true, private.timerLoop)
end

---@param self UnitController
---@param unit Unit
function private.newData(self, unit)
    local x = unit:getX()
    local y = unit:getY()
    unit:enableMove(false)

    local priv = {
        enable = false,

        unit = unit,
        forward = true,
        x = x,
        y = y,
        prev_x = x,
        prev_y = y,

        --collider = UnitObj.new(unit:getOwner(), private.collider_id, x, y, 0),
        forward_anim_factor = 1,
        backward_anim_factor = -0.5
    }
    private.data[self] = priv
end


--=============
-- Compiletime
--=============

private.collider_id = Compiletime(function()
    ---@type ObjectEdit
    local WeObjEdit = require('compiletime.ObjectEdit')
    local WeUnit = WeObjEdit.Unit
    local WeField = WeUnit.Field

    local id = WeObjEdit.getUnitId()
    ---@type WeUnit
    local unit_type = WeUnit.new(id, 'hfoo', 'DummyCollider')
    unit_type:setField(WeField.NormalAbilities, 'Avul')
    unit_type:setField(WeField.AttacksEnabled, 0)
    unit_type:setField(WeField.MovementSpeedBase, 510)
    --unit_type:setField(WeField.ModelScale, 0.1)
    --unit_type:setField(WeField.ModelFile, '')

    return ID(id)
end)

return static