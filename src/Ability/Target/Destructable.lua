--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type AbilityOldTarget
local AbilityOldTarget = require('AbilityOld.Target.Target')

--=======
-- Class
--=======

local AbilityOldTargetDestructable = Class.new('AbilityOldTargetDestructable', AbilityOldTarget)
---@class AbilityOldTargetDestructable
local public = AbilityOldTargetDestructable.public
---@class AbilityOldTargetDestructableClass
local static = AbilityOldTargetDestructable.static
---@type AbilityOldTargetDestructableClass
local override = AbilityOldTargetDestructable.override
local private = {}

--=========
-- Static
--=========

---@param destr_obj destructable
---@param child_instance AbilityOldTargetDestructable | nil
---@return AbilityOldTargetDestructable
function override.new(destr_obj, child_instance)
    local instance = child_instance or Class.allocate(AbilityOldTargetDestructable)
    instance = AbilityOldTarget.new(instance)
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

---@param self AbilityOldTargetDestructable
---@param destr_obj destructable
function private.newData(self, destr_obj)
    local priv = {
        destr_obj = destr_obj
    }
    private.data[self] = priv
end

return static