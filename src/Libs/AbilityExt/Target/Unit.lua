--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityTarget
local AbilityTarget = require(lib_path..'Target.Base') or error('')

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
---@param child AbilityTargetUnit | nil
---@return AbilityTargetUnit
function override.new(unit, child)
    isTypeErr(unit, Unit, 'unit')
    if child then
        isTypeErr(child, AbilityTargetUnit, 'child')
    end

    local instance = child or Class.allocate(AbilityTargetUnit)
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