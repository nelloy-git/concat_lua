--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Destructable = UtilsLib.Handle.Destructable

---@type AbilityTarget
local AbilityTarget = require(lib_modname..'.Target.Base')

--=======
-- Class
--=======

local AbilityTargetDestructable = Class.new('AbilityTargetDestructable', AbilityTarget)
---@class AbilityTargetDestructable : AbilityTarget
local public = AbilityTargetDestructable.public
---@class AbilityTargetDestructableClass : AbilityTargetClass
local static = AbilityTargetDestructable.static
---@type AbilityTargetDestructableClass
local override = AbilityTargetDestructable.override
local private = {}

--=========
-- Static
--=========

---@param destr Destructable
---@param child_instance AbilityTargetDestructable | nil
---@return AbilityTargetDestructable
function override.new(destr, child_instance)
    checkTypeErr(destr, Destructable, 'destr')
    if child_instance then checkTypeErr(child_instance, AbilityTargetDestructable, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityTargetDestructable)
    instance = AbilityTarget.new(instance)
    private.newData(instance, destr)

    return instance
end

--========
-- Public
--========

---@return Destructable
function public:getDestructable()
    return private.data[self].destr
end

---@return number
function public:getX()
    return self:getDestructable():getX()
end

---@return number
function public:getY()
    return self:getDestructable():getY()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityTargetDestructable
---@param destr destructable
function private.newData(self, destr)
    local priv = {
        destr = destr
    }
    private.data[self] = priv
end

return static