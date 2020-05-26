--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger

--=======
-- Class
--=======

local AbilityTarget = Class.new('AbilityTarget')
---@class AbilityTarget
local public = AbilityTarget.public
---@class AbilityTargetClass
local static = AbilityTarget.static
---@type AbilityTargetClass
local override = AbilityTarget.override
local private = {}

--=========
-- Static
--=========

---@param child_instance AbilityTarget
---@return AbilityTarget
function override.new(child_instance)
    if child_instance then
        checkType(child_instance, AbilityTarget, 'child_instance')
    else
        Log:err('Can not create instance of abstract class.', 2)
    end
    return child_instance
end

--========
-- Public
--========

--- Virtual function
---@return number
function public:getX()
    Log:err('Can not call virtual function.', 2)
end

--- Virtual function
---@return number
function public:getY()
    Log:err('Can not call virtual function.', 2)
end

---@param caster unit
---@return number
function public:getDistance(caster)
    return ((GetUnitX(caster) - self:getX())^2 + (GetUnitY(caster) - self:getY())^2)^0.5
end

--- Virtual function
---@param unit unit
---@param order number
---@return boolean
function public:order(unit, order)
    Log:err(self, 'can not call virtual function.', 2)
end

--=========
-- Private
--=========

return static