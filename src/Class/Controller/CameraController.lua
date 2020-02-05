--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type BetterTimerClass
local Timer = require('Class.Timer.BetterTimer')
local gl_timer
if not IsCompiletime() then
    gl_timer = Timer.getGlobalTimer()
end

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
static.Field.TARGET_DISTANCE = CAMERA_FIELD_TARGET_DISTANCE
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

---@param unit unit | nil
function public:lockUnit(unit)
    private.data[self].locked_unit = unit
end

---@param x number
---@param y number
function public:setUnitOffsets(x, y)
    local priv = private.data[self]
    priv.offset_x = x
    priv.offset_y = y
end

---@param dist number
function public:setUnitDistance(dist)
    private.data[self].distance = distance
end

---@param field camerafield
---@param value number
---@param time number
function public:set(field, value, time)
    local priv = private.data[self]
    if priv.player == private.local_player then
        priv[field] = value
        SetCameraField(field, value, time)
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

private.check_height_range = 25
private.unit_height_weight = 0.5
private.cam_height_weight = 1 - private.unit_height_weight
private.update_time = 0.2
function private.followUnit()
    -- Iterate all intances
    for _, priv in pairs(private.data) do
        if priv.locked_unit then
            local unit = priv.locked_unit

            local a = GetUnitFacing(unit)
            local cos_a = math.cos(a * bj_DEGTORAD)
            local sin_a = math.sin(a * bj_DEGTORAD)

            local x = GetUnitX(unit)
            local y = GetUnitY(unit)
            local z = GetUnitFlyHeight(unit) + priv.offset_z

            local range = private.check_height_range
            local dx = range * cos_a
            local dy = range * sin_a

            local z_behind_unit = private.getZ(x + dx, y + dy)
            local z_ahead_unit = private.getZ(x - dx, y - dy)
            local z_behind_cam = private.getZ(GetCameraTargetPositionX() + dx, GetCameraTargetPositionY() + dy)
            local z_ahead_cam = private.getZ(GetCameraTargetPositionX() - dx, GetCameraTargetPositionY() - dy)

            local k_z = ((z_ahead_unit - z_behind_unit) * private.unit_height_weight +
                         (z_ahead_cam - z_behind_cam) * private.cam_height_weight) / 2

            local cam_x = x - (priv.distance + k_z) * cos_a
            local cam_y = y - (priv.distance + k_z) * sin_a
            local cam_z = private.getZ(cam_x, cam_y)

            local z_angle = priv.z_angle + k_z
            local z_offset = z + priv[static.Field.ZOFFSET] + cam_z + math.abs(k_z) - GetCameraEyePositionZ()
            if priv.player == private.local_player then
                PanCameraToTimed(cam_x, cam_y, private.update_time);

                priv[static.Field.ZOFFSET] = z_offset
                SetCameraField(static.Field.ZOFFSET, z_offset, private.update_time)

                priv[static.Field.ANGLE_OF_ATTACK] = z_angle
                SetCameraField(static.Field.ANGLE_OF_ATTACK, z_angle, private.update_time)

                priv[static.Field.ROTATION] = a
                SetCameraField(static.Field.ROTATION, a, private.update_time)

                priv[static.Field.TARGET_DISTANCE] = priv.distance + k_z
                SetCameraField(static.Field.TARGET_DISTANCE, priv.distance + k_z, private.update_time)
            end
        end
    end
    private.action = gl_timer:addAction(0, private.followUnit)
end

if not IsCompiletime() then
    private.local_player = GetLocalPlayer()
    private.action = gl_timer:addAction(0, private.followUnit)

    local loc = Location(0,0)
    function private.getZ(x, y)
        MoveLocation(loc, x, y)
        return GetLocationZ(loc)

    end
end

---@param self CameraController
function private.newData(self, player)
    local priv = {
        player = player,
        x = GetCameraTargetPositionX(),
        y = GetCameraTargetPositionY(),
        z = GetCameraTargetPositionZ(),

        locked_unit = nil,
        offset_x = 0,
        offset_y = 0,
        offset_z = 350,
        distance = 300,
        z_angle = 340,
    }

    for _, field in pairs(static.Field) do
        priv[field] = GetCameraField(field)
    end

    private.data[self] = setmetatable(priv, private.metatable)
end

private.metatable = {
    __gc = function(self) end
}

return static
--[[
library CameraSystem requires optional CameraKeyboardMovement
    {
        //////////////////////////////////////////////////////////////////////////
        //
        //      Configuration area
       
        //          - Just default variables which the system will use when no other ones are specified by the user.
        //constant    real    CAMERA_DEFAULT_X        =   0,
                            CAMERA_DEFAULT_Y        =   0,
                            CAMERA_DEFAULT_ZANGLE   =   350,
                            CAMERA_DEFAULT_ZHEIGHT  =   190,
                            CAMERA_DEFAULT_ROTATION =   0,
                            CAMERA_DEFAULT_DISTANCE =   175,
                           
        //          - This is tricky. It defines the weight the measurements of the z position have. This system measures
        //            out 4 locations to get a neat z height, 2 of them are at the unit's location and 2 are at the camera
        //            location which is a bit further away. Those values define which measure has more weight - if you have
        //            low terrain with less cliff heights you should probably give the unit's measurement more weight.
        //            If you don't understand a bit of what I'm trying to explain, just play around a bit with those values
        //            and look what effect they might have.
                            CAMERA_TARGET_WEIGHT    =   1,
                            CAMERA_CAMERA_WEIGHT    =   2 - CAMERA_TARGET_WEIGHT,
        //          - What difference the measures have, if you have really steep cliffs (I'm not talking about blizzard cliffs)
        //            you should probably decrease this.
                            CAMERA_ZDIST_MEASURE    =   50,
                           
        //          - Pretty much self-explaining. You don't really have to change anything here.
                            CAMERA_LOOP_INTERVAL    =   0.01,
                            CAMERA_UPDATE_INTERVAL  =   0.2;
        //////////////////////////////////////////////////////////////////////////
        //
        //      Struct area
       
        public struct CAMERA
        {
       
        //////////////////////////////////////////////////////////////////////////
        //
        //      Struct variable area
       
            public
            {
                real x = CAMERA_DEFAULT_X, y = CAMERA_DEFAULT_Y,
                     zAngle = CAMERA_DEFAULT_ZANGLE, zHeight = CAMERA_DEFAULT_ZHEIGHT,
                     rotation = CAMERA_DEFAULT_ROTATION, distanceToTarget = CAMERA_DEFAULT_DISTANCE;
               
                player applyFor = null;
                unit   toFollow = null;
            }
           
            private
            {
                integer node;
                boolean activated = false;
           
                static timer t = CreateTimer();
                static integer count = 0;
                static thistype data[];
               
                static location loc = Location(0,0);
            }
           
            optional module CameraKeyboardMovement;
           
        //////////////////////////////////////////////////////////////////////////
        //
        //      Struct method area
           
            static method create(player p) -> thistype
            {
                thistype this = thistype.allocate();
                applyFor = p;
                static if (thistype.movementInit.exists) { movementInit(); }
                return this;
            }
           
            method apply()
            {
                if (count == 0)
                    TimerStart(t, CAMERA_LOOP_INTERVAL, true, static method thistype.cameraLoop);
                   
                data[count] = this;
                node = count;
                count += 1;
               
                activated = true;
            }
           
            private static method cameraLoop()
            {
                real tX = 0, tY = 0, tZ[], tzAngle = 0, tzHeight = 0, tRotation = 0;
                thistype this;
                integer i = 0;
               
                while (i < count)
                {
                    this = data[i];
                    static if (thistype.movement.exists) { movement(); }
                   
                    if (toFollow != null)
                    {
                        x = GetUnitX(toFollow); y = GetUnitY(toFollow);
                        tRotation = GetUnitFacing(toFollow)*bj_DEGTORAD;
                        tzHeight = GetUnitFlyHeight(toFollow);
                    }
                   
                    tX = x; tY = y;
                   
                    tX += CAMERA_ZDIST_MEASURE/2 * Cos(tRotation);
                    tY += CAMERA_ZDIST_MEASURE/2 * Sin(tRotation);
                    MoveLocation(loc, tX, tY);
                    tZ[0] = GetLocationZ(loc);
                   
                    tX -= CAMERA_ZDIST_MEASURE * Cos(tRotation);
                    tY -= CAMERA_ZDIST_MEASURE * Sin(tRotation);
                    MoveLocation(loc, tX, tY);
                    tZ[1] = GetLocationZ(loc);
                   
                    tX = GetCameraTargetPositionX() + CAMERA_ZDIST_MEASURE/2 * Cos(tRotation);
                    tY = GetCameraTargetPositionY() + CAMERA_ZDIST_MEASURE/2 * Sin(tRotation);
                    MoveLocation(loc, tX, tY);
                    tZ[2] = GetLocationZ(loc);
                   
                    tX -= CAMERA_ZDIST_MEASURE * Cos(tRotation);
                    tY -= CAMERA_ZDIST_MEASURE * Sin(tRotation);
                    MoveLocation(loc, tX, tY);
                    tZ[3] = GetLocationZ(loc);
                   
                    tZ[2] = ((tZ[0]-tZ[1])*CAMERA_TARGET_WEIGHT+(tZ[2]-tZ[3])*CAMERA_CAMERA_WEIGHT)/4;
                   
                    tX = x; tY = y;
                   
                    tRotation += rotation*bj_DEGTORAD;
                    tX -= (distanceToTarget+tZ[2]) * Cos(tRotation);
                    tY -= (distanceToTarget+tZ[2]) * Sin(tRotation);
                    MoveLocation(loc, tX, tY);
                   
                    tzAngle = zAngle + tZ[2];
                    tzHeight += zHeight + GetCameraField(CAMERA_FIELD_ZOFFSET) + GetLocationZ(loc) + RAbsBJ(tZ[2]) - GetCameraEyePositionZ();
                   
                    if (GetLocalPlayer() == applyFor)
                    {
                        PanCameraToTimed(tX, tY, CAMERA_UPDATE_INTERVAL);
                        SetCameraField(CAMERA_FIELD_ZOFFSET, tzHeight, CAMERA_UPDATE_INTERVAL);
                        SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, tzAngle, CAMERA_UPDATE_INTERVAL);
                        SetCameraField(CAMERA_FIELD_ROTATION, tRotation*bj_RADTODEG, CAMERA_UPDATE_INTERVAL);
                        SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, distanceToTarget+tZ[2], CAMERA_UPDATE_INTERVAL);
                    }
                   
                    i += 1;
                }
            }
           
            method operator active() -> boolean
                { return activated; }
           
            method operator active=(boolean b)
            {
                if (b && !activated)
                    apply();
                else if (!b && activated)
                {
                    data[node] = data[count-1];
                    data[node].node = node;
                    count -= 1;
                   
                    if (count == 0)
                        PauseTimer(t);
                       
                    activated = false;
                }
            }
           
            method destroy()
            {
                if (activated)
                {
                    data[node] = data[count-1];
                    data[node].node = node;
                    count -= 1;
                   
                    if (count == 0)
                        PauseTimer(t);
                }
               
                deallocate();
            }
        }
    }
    ]]