--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

--=======
-- Class
--=======

local AbilityOldTarget = Class.new('AbilityOldTarget')
---@class AbilityOldTarget
local public = AbilityOldTarget.public
---@class AbilityOldTargetClass
local static = AbilityOldTarget.static
---@type AbilityOldTargetClass
local override = AbilityOldTarget.override
local private = {}

--=========
-- Static
--=========

---@param child_instance AbilityOldTarget
---@return AbilityOldTarget
function override.new(child_instance)
    if not child_instance then
        Log.error(AbilityOldTarget, 'can not create instance of abstract class.', 2)
    end
    return child_instance
end

--========
-- Public
--========

--- Virtual function
---@return number
function public:getX()
    Log.error(self, 'can not call virtual function.', 2)
end

--- Virtual function
---@return number
function public:getY()
    Log.error(self, 'can not call virtual function.', 2)
end

---@param caster Unit
---@return number
function public:getRange(caster)
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
    Log.error(self, 'can not call virtual function.', 2)
end

--=========
-- Private
--=========

return static