--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityTarget
local AbilityTarget = require('Ability.Target.Target')

--=======
-- Class
--=======

local AbilityTargetPoint = Class.new('AbilityTargetPoint', AbilityTarget)
---@class AbilityTargetPoint
local public = AbilityTargetPoint.public
---@class AbilityTargetPointClass
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
function static.new(x, y, child_instance)
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