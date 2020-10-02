--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type EffectClass
local Effect = require(lib_path..'Types.Effect') or error('')

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
---@param size number
---@param child Projectile | nil
---@return Projectile
function override.new(model, x, y, z, size, child)
    isTypeErr(model, 'string', 'model')
    isTypeErr(x, 'number', 'x')
    isTypeErr(y, 'number', 'y')
    isTypeErr(z, 'number', 'z')
    isTypeErr(size, 'number', 'size')
    if child then isTypeErr(child, Projectile, 'child') end

    local instance = child or Class.allocate(Projectile)
    instance = Effect.new(model, x, y, z, instance)

    private.newData()

    return instance
end

--========
-- Public
--========


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Projectile
---@param size number
function private.newData(self, size)
    local priv = {
        size = size
    }
    private.data[self] = priv

    UnitAddAbility(self:getData(), id2int('Arav'))
    UnitRemoveAbility(self:getData(), id2int('Arav'))
end

return static