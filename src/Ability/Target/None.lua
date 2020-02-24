--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityTarget
local AbilityTarget = require('Ability.Target.Target')

--=======
-- Class
--=======

local AbilityTargetNone = Class.new('AbilityTargetNone', AbilityTarget)
---@class AbilityTargetNone
local public = AbilityTargetNone.public
---@class AbilityTargetNoneClass
local static = AbilityTargetNone.static
---@type AbilityTargetNoneClass
local override = AbilityTargetNone.override
local private = {}

--=========
-- Static
--=========

---@param child_instance AbilityTargetNone | nil
---@return AbilityTargetNone
function override.new(child_instance)
    local instance = child_instance or Class.allocate(AbilityTargetNone)
    instance = AbilityTarget.new(instance)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return 0
end

---@return number
function public:getY()
    return 0
end

---@param unit Unit
---@param order number
---@return boolean
function public:order(unit, order)
    return IssueImmediateOrderById(unit:getObj(), order)
end

--=========
-- Private
--=========

return static