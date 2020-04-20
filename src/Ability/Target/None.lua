--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type AbilityOldTarget
local AbilityOldTarget = require('AbilityOld.Target.Target')

--=======
-- Class
--=======

local AbilityOldTargetNone = Class.new('AbilityOldTargetNone', AbilityOldTarget)
---@class AbilityOldTargetNone
local public = AbilityOldTargetNone.public
---@class AbilityOldTargetNoneClass
local static = AbilityOldTargetNone.static
---@type AbilityOldTargetNoneClass
local override = AbilityOldTargetNone.override
local private = {}

--=========
-- Static
--=========

---@param child_instance AbilityOldTargetNone | nil
---@return AbilityOldTargetNone
function override.new(child_instance)
    local instance = child_instance or Class.allocate(AbilityOldTargetNone)
    instance = AbilityOldTarget.new(instance)

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

---@param caster Unit
---@return number
function public:getRange(caster)
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