--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityOldTarget
local AbilityOldTarget = require('AbilityOld.Target.Target')

--=======
-- Class
--=======

local AbilityOldTargetPoint = Class.new('AbilityOldTargetPoint', AbilityOldTarget)
---@class AbilityOldTargetPoint
local public = AbilityOldTargetPoint.public
---@class AbilityOldTargetPointClass
local static = AbilityOldTargetPoint.static
---@type AbilityOldTargetPointClass
local override = AbilityOldTargetPoint.override
local private = {}

--=========
-- Static
--=========

---@param x number
---@param y number
---@param child_instance AbilityOldTargetPoint | nil
---@return AbilityOldTargetPoint
function override.new(x, y, child_instance)
    local instance = child_instance or Class.allocate(AbilityOldTargetPoint)
    instance = AbilityOldTarget.new(instance)
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

---@param unit Unit
---@param order number
---@return boolean
function public:order(unit, order)
    local priv = private.data[self]
    return IssuePointOrderById(unit:getObj(), order, priv.x, priv.y)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityOldTargetPoint
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