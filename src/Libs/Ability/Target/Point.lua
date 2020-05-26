--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType

---@type AbilityTarget
local AbilityTarget = require(lib_modname..'.Target.Target')

--=======
-- Class
--=======

local AbilityTargetPoint = Class.new('AbilityTargetPoint', AbilityTarget)
---@class AbilityTargetPoint : AbilityTarget
local public = AbilityTargetPoint.public
---@class AbilityTargetPointClass : AbilityTargetClass
local static = AbilityTargetPoint.static
---@type AbilityTargetPointClass
local override = AbilityTargetPoint.override
local private = {}

--=========
-- Static
--=========

---@param x number
---@param y number
---@param child_instance AbilityTargetPoint | nil
---@return AbilityTargetPoint
function override.new(x, y, child_instance)
    checkType(x, 'number', 'x')
    checkType(y, 'number', 'y')
    if child_instance then
        checkType(child_instance, AbilityTargetPoint, 'child_instance')
    end

    local instance = child_instance or Class.allocate(AbilityTargetPoint)
    instance = AbilityTarget.new(instance)
    private.newData(instance, x, y)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return private.data[self].x
end

---@return number
function public:getY()
    return private.data[self].y
end

---@param unit unit
---@param order number
---@return boolean
function public:order(unit, order)
    local priv = private.data[self]
    return IssuePointOrderById(unit, order, priv.x, priv.y)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityTargetPoint
---@param x number
---@param y number
function private.newData(self, x, y)
    local priv = {
        x = x,
        y = y
    }
    private.data[self] = priv
end

return static