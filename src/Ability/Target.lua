--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

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

---@alias AbilityTargetTypeEnum number

---@type table<string, AbilityTargetTypeEnum>
static.TargetType = {}
---@type AbilityTargetTypeEnum
static.TargetType.None = 1
---@type AbilityTargetTypeEnum
static.TargetType.Point = 2
---@type AbilityTargetTypeEnum
static.TargetType.Unit = 3
---@type AbilityTargetTypeEnum
static.TargetType.Destructable = 4
---@type AbilityTargetTypeEnum
static.TargetType.Item = 5
---@type AbilityTargetTypeEnum
static.TargetType.Uninitialized = 6


---@param child_instance AbilityTarget | nil
---@return AbilityTarget
function static.new(child_instance)
    local instance = child_instance or Class.allocate(AbilityTarget)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:initNone()
    private.data[self].target_type = static.TargetType.None
end

---@param x number
---@param y number
function public:initPoint(x, y)
    local priv = private.data[self]
    priv.target_type = static.TargetType.Point
    priv.x = x
    priv.y = y
end

---@param unit_obj unit
function public:initUnit(unit_obj)
    local priv = private.data[self]
    priv.target_type = static.TargetType.Unit
    priv.unit_obj = unit_obj
end

---@param destr_obj destructable
function public:initDestructable(destr_obj)
    local priv = private.data[self]
    priv.target_type = static.TargetType.Destructable
    priv.destr_obj = destr_obj
end

---@param item_obj item
function public:initItem(item_obj)
    local priv = private.data[self]
    priv.target_type = static.TargetType.Item
    priv.item_obj = item_obj
end

---@return number
function public:getX()
    local priv = private.data[self]
    return private.getX[priv.target_type](priv)
end

---@return number
function public:getY()
    local priv = private.data[self]
    return private.getY[priv.target_type](priv)
end

---@param unit Unit
---@param order number
---@return boolean
function public:order(unit, order)
    local priv = private.data[self]
    return private.IssueOrder[priv.target_type](priv, unit:getObj(), order)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.IssueOrder = {
    [static.TargetType.None] = function(_, unit_obj, order) return IssueImmediateOrderById(unit_obj, order) end,
    [static.TargetType.Point] = function(priv, unit_obj, order) return IssuePointOrderById(unit_obj, order, priv.x, priv.y) end,
    [static.TargetType.Unit] = function(priv, unit_obj, order) return IssueTargetOrderById(unit_obj, order, priv.unit_obj) end,
    [static.TargetType.Destructable] = function(priv, unit_obj, order) return IssueTargetOrderById(unit_obj, order, priv.destr_obj) end,
    [static.TargetType.Item] = function(priv, unit_obj, order) return IssueTargetOrderById(unit_obj, order, priv.item_obj) end,
}

private.getX = {
    [static.TargetType.None] = function(_) return 0 end,
    [static.TargetType.Point] = function(priv) return priv.x end,
    [static.TargetType.Unit] = function(priv) return GetUnitX(priv.unit_ob) end,
    [static.TargetType.Destructable] = function(priv) GetDestructableX(priv.destr_obj) end,
    [static.TargetType.Item] = function(priv) GetItemX(priv.item_obj) end,
}

private.getY = {
    [static.TargetType.None] = function(_) return 0 end,
    [static.TargetType.Point] = function(priv) return priv.y end,
    [static.TargetType.Unit] = function(priv) return GetUnitY(priv.unit_ob) end,
    [static.TargetType.Destructable] = function(priv) GetDestructableY(priv.destr_obj) end,
    [static.TargetType.Item] = function(priv) GetItemY(priv.item_obj) end,
}

---@param self AbilityTarget
function private.newData(self)
    local priv = {
        target_type = static.TargetType.Uninitialized
    }
    private.data[self] = priv
end

return static