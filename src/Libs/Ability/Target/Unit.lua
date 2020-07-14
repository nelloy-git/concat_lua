--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Unit = UtilsLib.Handle.Unit

---@type AbilityTarget
local AbilityTarget = require(lib_modname..'.Target.Target')

--=======
-- Class
--=======

local AbilityTargetUnit = Class.new('AbilityTargetUnit', AbilityTarget)
---@class AbilityTargetUnit : AbilityTarget
local public = AbilityTargetUnit.public
---@class AbilityTargetUnitClass : AbilityTargetClass
local static = AbilityTargetUnit.static
---@type AbilityTargetUnitClass
local override = AbilityTargetUnit.override
local private = {}

--=========
-- Static
--=========

---@param unit Unit
---@param child_instance AbilityTargetUnit | nil
---@return AbilityTargetUnit
function override.new(unit, child_instance)
    checkTypeErr(unit, Unit, 'unit')
    if child_instance then
        checkTypeErr(child_instance, AbilityTargetUnit, 'child_instance')
    end

    local instance = child_instance or Class.allocate(AbilityTargetUnit)
    instance = AbilityTarget.new(instance)
    private.newData(instance, unit)

    return instance
end

--========
-- Public
--========

---@return Unit
function public:getUnit()
    return private.data[self].unit
end

---@return number
function public:getX()
    return self:getUnit():getX()
end

---@return number
function public:getY()
    return self:getUnit():getY()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityTargetUnit
---@param unit unit
function private.newData(self, unit)
    local priv = {
        unit = unit
    }
    private.data[self] = priv
end

return static