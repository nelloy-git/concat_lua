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

---@param item item
---@param child_instance AbilityTargetItem | nil
---@return AbilityTargetItem
function override.new(item, child_instance)
    checkType(item, 'item', 'item')
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

---@return number
function public:getX()
    return GetItemX(private.data[self].item)
end

---@return number
function public:getY()
    return GetItemY(private.data[self].item)
end

---@return item
function public:getItem()
    return private.data[self].item
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityTargetItem
---@param item item
function private.newData(self, item)
    local priv = {
        item = item
    }
    private.data[self] = priv
end

return static