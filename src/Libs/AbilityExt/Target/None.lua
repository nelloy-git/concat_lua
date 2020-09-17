--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityTarget
local AbilityTarget = require(lib_path..'Target.Base') or error('')

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

---@param child AbilityTargetNone | nil
---@return AbilityTargetNone
function override.new(child)
    if child then
        isTypeErr(child, AbilityTargetNone, 'child')
    end

    local instance = child or Class.allocate(AbilityTargetNone)
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
function public:getDistance(caster)
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