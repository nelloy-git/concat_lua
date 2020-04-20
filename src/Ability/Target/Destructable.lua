--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type AbilityTarget
local AbilityTarget = require('Ability.Target.Target')

--=======
-- Class
--=======

local AbilityTargetDestructable = Class.new('AbilityTargetDestructable', AbilityTarget)
---@class AbilityTargetDestructable
local public = AbilityTargetDestructable.public
---@class AbilityTargetDestructableClass
local static = AbilityTargetDestructable.static
---@type AbilityTargetDestructableClass
local override = AbilityTargetDestructable.override
local private = {}

--=========
-- Static
--=========

---@param destr_obj destructable
---@param child_instance AbilityTargetDestructable | nil
---@return AbilityTargetDestructable
function override.new(destr_obj, child_instance)
    local instance = child_instance or Class.allocate(AbilityTargetDestructable)
    instance = AbilityTarget.new(instance)
    private.newData(instance, destr_obj)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetDestructableX(private.data[self].destr_obj)
end

---@return number
function public:getY()
    return GetDestructableY(private.data[self].destr_obj)
end

---@return destructable
function public:getObj()
    return private.data[self].destr_obj
end

---@param unit Unit
---@param order number
---@return boolean
function public:order(unit, order)
    return IssueTargetOrderById(unit:getObj(), order, private.data[self].destr_obj)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityTargetDestructable
---@param destr_obj destructable
function private.newData(self, destr_obj)
    local priv = {
        destr_obj = destr_obj
    }
    private.data[self] = priv
end

return static