--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type EffectClass
local Effect = require(lib_path..'Types.Effect') or error('')
---@type TimerClass
local Timer = require(lib_path..'Types.Timer') or error('')

--=======
-- Class
--=======

local Projectile = Class.new('Projectile', Effect)
---@class Projectile : Effect
local public = Projectile.public
---@class ProjectileClass : EffectClass
local static = Projectile.static
---@type ProjectileClass
local override = Projectile.override
local private = {}

--=========
-- Static
--=========

---@param model string
---@param x number
---@param y number
---@param z number
---@param child Projectile | nil
---@return Projectile
function override.new(model, x, y, z, child)
    isTypeErr(model, 'string', 'model')
    isTypeErr(x, 'number', 'x')
    isTypeErr(y, 'number', 'y')
    isTypeErr(z, 'number', 'z')
    if child then isTypeErr(child, Projectile, 'child') end

    local instance = child or Class.allocate(Projectile)
    instance = Effect.new(model, x, y, z, instance)

    private.newData(instance)

    return instance
end

---@return number
function static:getLoopPeriod()
    return private.period
end

--========
-- Public
--========

--- Recomends use after creation.
---@param x number
---@param y number
function public:setTarget(x, y)
    local priv = private.data[self]

    priv.targ_x = x
    priv.targ_y = y

    private.updVel(self)
end

--- Recomends use after creation.
---@param vel number
function public:setVelocity(vel)
    local priv = private.data[self]

    priv.vel = vel

    private.updVel(self)
end

function public:setTrajectory()
    -- TODO
end

---@alias ProjectileCallback fun(proj:Projectile)

---@param callback ProjectileCallback
---@return Action
function public:addLoopAction(callback)
    return private.data[self].loop_actions:add(callback)
end

---@param callback ProjectileCallback
---@return Action
function public:addFinishAction(callback)
    return private.data[self].finish_actions:add(callback)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Projectile
function private.newData(self)
    local priv = {
        targ_x = 0,
        targ_y = 0,

        vel = 0,
        vel_x = 0,
        vel_y = 0,

        loop_actions = ActionList.new(self),
        finish_actions = ActionList.new(self),
    }
    private.data[self] = priv
end

---@param self Projectile
function private.updVel(self)
    local priv = private.data[self]

    local dx = priv.targ_x - self:getX()
    local dy = priv.targ_y - self:getY()
    local r = (dx * dx + dy * dy) ^ 0.5

    self:setAngles(math.atan(dy, dx), 0, 0)

    priv.vel_x = private.period * priv.vel * dx / r
    priv.vel_y = private.period * priv.vel * dy / r
end

private.period = 0.02
if not IsCompiletime() then
    Timer.new():start(private.period, true, function()
        local new_data = setmetatable({}, {__mode = 'k'})

        for self, priv in pairs(private.data) do
            local vel_x = priv.vel_x
            local vel_y = priv.vel_y

            local x = self:getX() + vel_x
            local y = self:getY() + vel_y

            local dx = priv.targ_x - x
            dx = dx >= 0 and dx or -dx
            local dy = priv.targ_y - y
            dy = dy >= 0 and dy or -dy

            local abs_vel_x = vel_x >= 0 and vel_x or -vel_x
            local abs_vel_y = vel_y >= 0 and vel_y or -vel_y

            if dx <= abs_vel_x and dy <= abs_vel_y then
                priv.finish_actions:run(self)
                self:destroy()
            else
                self:setPos(x, y, self:getZ())
                priv.loop_actions:run(self)

                new_data[self] = priv
            end
        end

        private.data = new_data
    end)
end

return static