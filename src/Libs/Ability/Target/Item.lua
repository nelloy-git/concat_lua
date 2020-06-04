--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Item = UtilsLib.Handle.Item

---@type AbilityTarget
local AbilityTarget = require(lib_modname..'.Target.Target')

--=======
-- Class
--=======

local AbilityTargetItem = Class.new('AbilityTargetItem', AbilityTarget)
---@class AbilityTargetItem : AbilityTarget
local public = AbilityTargetItem.public
---@class AbilityTargetItemClass : AbilityTargetClass
local static = AbilityTargetItem.static
---@type AbilityTargetItemClass
local override = AbilityTargetItem.override
local private = {}

--=========
-- Static
--=========

---@param item Item
---@param child_instance AbilityTargetItem | nil
---@return AbilityTargetItem
function override.new(item, child_instance)
    checkType(item, Item, 'item')
    if child_instance then
        checkType(child_instance, AbilityTargetItem, 'child_instance')
    end

    local instance = child_instance or Class.allocate(AbilityTargetItem)
    instance = AbilityTarget.new(instance)
    private.newData(instance, item)

    return instance
end

--========
-- Public
--========

---@return Item
function public:getItem()
    return private.data[self].item
end

---@return number
function public:getX()
    return self:getItem():getX()
end

---@return number
function public:getY()
    return self:getItem():getY()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityTargetItem
---@param item Item
function private.newData(self, item)
    local priv = {
        item = item
    }
    private.data[self] = priv
end

return static