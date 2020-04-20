--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type AbilityOldTarget
local AbilityOldTarget = require('AbilityOld.Target.Target')

--=======
-- Class
--=======

local AbilityOldTargetUnit = Class.new('AbilityOldTargetUnit', AbilityOldTarget)
---@class AbilityOldTargetUnit
local public = AbilityOldTargetUnit.public
---@class AbilityOldTargetUnitClass
local static = AbilityOldTargetUnit.static
---@type AbilityOldTargetUnitClass
local override = AbilityOldTargetUnit.override
local private = {}

--=========
-- Static
--=========

---@param unit_obj unit
---@param child_instance AbilityOldTargetUnit | nil
---@return AbilityOldTargetUnit
function override.new(unit_obj, child_instance)
    local instance = child_instance or Class.allocate(AbilityOldTargetUnit)
    instance = AbilityOldTarget.new(instance)
    private.newData(instance, unit_obj)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetUnitX(private.data[self].unit_obj)
end

---@return number
function public:getY()
    return GetUnitY(private.data[self].unit_obj)
end

---@return unit
function public:getObj()
    return private.data[self].unit_obj
end

---@param unit Unit
---@param order number
---@return boolean
function public:order(unit, order)
    --print(unit:getObj(), order, priv.unit_obj)
    return IssueTargetOrderById(unit:getObj(), order, private.data[self].unit_obj)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityOldTargetUnit
---@param unit_obj unit
function private.newData(self, unit_obj)
    local priv = {
        unit_obj = unit_obj
    }
    private.data[self] = priv
end

return static