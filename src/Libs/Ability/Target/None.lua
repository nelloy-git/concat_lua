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

local AbilityTargetNone = Class.new('AbilityTargetNone', AbilityTarget)
---@class AbilityTargetNone : AbilityTarget
local public = AbilityTargetNone.public
---@class AbilityTargetNoneClass AbilityTargetClass
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
    if child_instance then
        checkType(child_instance, AbilityTargetNone, 'child_instance')
    end

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