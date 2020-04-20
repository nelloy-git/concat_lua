--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type AbilityOldTarget
local AbilityOldTarget = require('AbilityOld.Target.Target')

--=======
-- Class
--=======

local AbilityOldTargetItem = Class.new('AbilityOldTargetItem', AbilityOldTarget)
---@class AbilityOldTargetItem
local public = AbilityOldTargetItem.public
---@class AbilityOldTargetItemClass
local static = AbilityOldTargetItem.static
---@type AbilityOldTargetItemClass
local override = AbilityOldTargetItem.override
local private = {}

--=========
-- Static
--=========

---@param item_obj item
---@param child_instance AbilityOldTargetItem | nil
---@return AbilityOldTargetItem
function override.new(item_obj, child_instance)
    local instance = child_instance or Class.allocate(AbilityOldTargetItem)
    instance = AbilityOldTarget.new(instance)
    private.newData(instance, item_obj)

    return instance
end

--========
-- Public
--========

---@return number
function public:getX()
    return GetItemX(private.data[self].item_obj)
end

---@return number
function public:getY()
    return GetItemY(private.data[self].item_obj)
end

---@return item
function public:getObj()
    return private.data[self].item_obj
end

---@param unit Unit
---@param order number
---@return boolean
function public:order(unit, order)
    return IssueTargetOrderById(unit:getObj(), order, private.data[self].item_obj)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityOldTargetItem
---@param item_obj item
function private.newData(self, item_obj)
    local priv = {
        item_obj = item_obj
    }
    private.data[self] = priv
end

return static