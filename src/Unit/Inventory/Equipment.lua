--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ItemAPI
local ItemAPI = require('Item.API')
local ItemType = ItemAPI.ItemType
---@type ParameterAPI
local ParameterAPI = require('Parameter.API')
local ParamType = ParameterAPI.ParamType
local ValueType = ParameterAPI.ValueType

--=======
-- Class
--=======

local UnitInventoryEquipment = Class.new('UnitInventoryEquipment')
---@class UnitInventoryEquipment
local public = UnitInventoryEquipment.public
---@class UnitInventoryEquipmentClass
local static = UnitInventoryEquipment.static
---@type UnitInventoryEquipmentClass
local override = UnitInventoryEquipment.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child_instance UnitInventoryEquipment | nil
---@return UnitInventoryEquipment
function static.new(owner, child_instance)
    local instance = child_instance or Class.allocate(UnitInventoryEquipment)
    private.newData(instance, owner)

    return instance
end

--========
-- Public
--========

---@param item Item
---@return boolean
function public:equip(item)
    local priv = private.data[self]
    local item_type = item:getType()

    if not private.isSlotType(item_type) then
        return false
    end

    if priv.slot[item_type] then
        Log.error(self, 'previous item was not unequiped.', 2)
    end

    priv.slot[item_type] = item
    private.addParams(priv.owner, item)
    return true
end

---@param item_type ItemTypeEnum
---@return boolean
function public:unequip(item_type)
    local priv = private.data[self]

    if not private.isSlotType(item_type) then
        return false
    end

    if priv.slot[item_type] then
        private.removeParams(priv.owner, priv.slot[item_type])
        priv.slot[item_type] = nil
    end

    return true
end

---@param item_type ItemTypeEnum
function public:get(item_type)
    return private.data[self].slot[item_type]
end

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.AvailableSlotTypes = {
    [ItemType.BAG] = true,
    [ItemType.BELT] = true,
    [ItemType.BOOTS] = true,
    [ItemType.CHEST] = true,
    [ItemType.EARRING] = true,
    [ItemType.HANDS] = true,
    [ItemType.HEAD] = true,
    [ItemType.LEGS] = true,
    [ItemType.WEAPON] = true,
    [ItemType.NECKLACE] = true,
    [ItemType.RING] = true,
    [ItemType.OFFHAND] = true,
    [ItemType.SHOULDERS] = true,
}

---@param item_type any
---@return boolean
function private.isSlotType(item_type)
    if private.AvailableSlotTypes[item_type] then
        return true
    end
    return false
end

---@param owner Unit
---@param item Item
function private.addParams(owner, item)
    local item_param = item:getParameters()
    local unit_param = owner.Param

    for _, param_type in pairs(ParamType) do
        for _, value_type in pairs(ValueType) do
            unit_param:add(param_type, value_type, item_param:get(param_type, value_type))
        end
    end
end

---@param owner Unit
---@param item Item
function private.removeParams(owner, item)
    local item_param = item:getParameters()
    local unit_param = owner.Param

    for _, param_type in pairs(ParamType) do
        for _, value_type in pairs(ValueType) do
            unit_param:add(param_type, value_type, -item_param:get(param_type, value_type))
        end
    end
end

---@param self UnitInventoryEquipment
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        slot = {}
    }
    private.data[self] = priv
end


return static