--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Item = HandleLib.Item or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityTarget
local AbilityTarget = require(lib_path..'Target.Base')

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
---@param child AbilityTargetItem | nil
---@return AbilityTargetItem
function override.new(item, child)
    isTypeErr(item, Item, 'item')
    if child then isTypeErr(child, AbilityTargetItem, 'child') end

    local instance = child or Class.allocate(AbilityTargetItem)
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