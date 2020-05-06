--=========
-- Include
--=========

local Class = require(Lib.Class)

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
    if not child_instance then
        Logger.error(AbilityTarget, 'can not create instance of abstract class.', 2)
    end
    return child_instance
end

--========
-- Public
--========

--- Virtual function
---@return number
function public:getX()
    Logger.error(self, 'can not call virtual function.', 2)
end

--- Virtual function
---@return number
function public:getY()
    Logger.error(self, 'can not call virtual function.', 2)
end

---@param caster Unit
---@return number
function public:getDistance(caster)
    return ((caster:getX() - self:getX())^2 + (caster:getY() - self:getY())^2)^0.5
end

---@return any
function public:getObj()
    return nil
end

--- Virtual function
---@param unit Unit
---@param order number
---@return boolean
function public:order(unit, order)
    Logger.error(self, 'can not call virtual function.', 2)
end

--=========
-- Private
--=========

return static