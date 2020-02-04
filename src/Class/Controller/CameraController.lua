--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type BetterTimerClass
local Timer = require('Class.Timer.BetterTimer')
local gl_timer = Timer.getGlobalTimer()
local gl_period = gl_timer:getPeriod()

--=======
-- Class
--=======

local CameraController = Class.new('CameraController')
---@class CameraController
local public = CameraController.public
---@class CameraControllerClass
local static = CameraController.static
---@type CameraControllerClass
local override = CameraController.override
local private = {}

--=========
-- Static
--=========

static.Field = {}
---@type camerafield
static.Field.DISTANCE = CAMERA_FIELD_TARGET_DISTANCE
---@type camerafield
static.Field.FARZ = CAMERA_FIELD_FARZ
---@type camerafield
static.Field.ANGLE_OF_ATTACK = CAMERA_FIELD_ANGLE_OF_ATTACK
---@type camerafield
static.Field.FIELD_OF_VIEW = CAMERA_FIELD_FIELD_OF_VIEW
---@type camerafield
static.Field.ROLL = CAMERA_FIELD_ROLL
---@type camerafield
static.Field.ROTATION = CAMERA_FIELD_ROTATION
---@type camerafield
static.Field.ZOFFSET = CAMERA_FIELD_ZOFFSET
---@type camerafield
static.Field.NEARZ = CAMERA_FIELD_NEARZ
---@type camerafield
static.Field.LOCAL_PITCH = CAMERA_FIELD_LOCAL_PITCH
---@type camerafield
static.Field.LOCAL_YAW = CAMERA_FIELD_LOCAL_YAW
---@type camerafield
static.Field.LOCAL_ROLL = CAMERA_FIELD_LOCAL_ROLL

---@param player player
---@return CameraController
function static.new(player)
    local instance = Class.allocate(CameraController)
    private.newData(instance, player)

    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
---@param z number
---@param time number
function public:setPos(x, y, z, time)
    local priv = private.data[self]
    if priv.player == private.local_player then
        priv.x = x
        priv.y = y
        priv.z = z
        PanCameraToTimedWithZ(x, y, z, time)
    end
end

---@param unit unit
function public:lockUnit(unit)
    local priv = private.data[self]
    if priv.player == private.local_player then
        priv.locked_unit_action = gl_timer:addAction(function() private.followUnit(priv, unit) end)
    end
end

function public:unlockUnit()
    local priv = private.data[self]
    if priv.player == private.local_player then
        gl_timer:removeAction(priv.locked_unit_action)
        priv.locked_unit_action = nil
    end
end

---@param field camerafield
---@param value number
function public:set(field, value)
    local priv = private.data[self]
    if priv.player == private.local_player then
        priv[field] = value
        SetCameraField(field, value)
    end
end

---@return number | nil
function public:get(field)
    local priv = private.data[self]
    if priv.player ~= private.local_player then
        return
    end
    return priv[field]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
if not IsCompiletime() then
    private.local_player = GetLocalPlayer()
end

function private.followUnit(priv, unit)
    if priv.player == private.local_player then
        priv.x = GetUnitX(unit)
        priv.y = GetUnitY(unit)
        priv.z = GetUnitFlyHeight(unit)
        priv[static.Field.ROTATION] = GetUnitFacing(unit)

        PanCameraToTimedWithZ(priv.x, priv.y, priv.z, gl_period)
        SetCameraField(static.Field.ROTATION, priv[static.Field.ROTATION], gl_period)
        priv.locked_unit_action = gl_timer:addAction(function() private.followUnit(priv, unit) end)
    end
end

---@param self CameraController
function private.newData(self, player)
    local priv = {
        player = player,
        x = GetCameraTargetPositionX(),
        y = GetCameraTargetPositionY(),
        z = GetCameraTargetPositionZ(),

        locked_unit_action = nil,
    }

    for _, field in pairs(static.Field) do
        priv[field] = GetCameraField(field)
    end

    priv.private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(self) end
}

return static