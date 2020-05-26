--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
---@type ObjectLib
local ObjectLib = depencies.Object
local Unit = ObjectLib.Unit

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
    checkType(unit, Unit, 'unit')
    if child_instance then
        checkType(child_instance, AbilityTargetUnit, 'child_instance')
    end

    local instance = child_instance or Class.allocate(AbilityTargetUnit)
    instance = AbilityTarget.new(instance)
    private.newData(instance, unit)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetUnitX(private.data[self].unit)
end

---@return number
function public:getY()
    return GetUnitY(private.data[self].unit)
end

---@return unit
function public:getUnit()
    return private.data[self].unit
end

---@param unit unit
---@param order number
---@return boolean
function public:order(unit, order)
    return IssueTargetOrderById(unit, order, private.data[self].unit)
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