--=========
-- Include
--=========

local Class = require(Lib.Class)

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
function override.new(owner, child_instance)
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

    if not ItemAPI.isTypeEquipable(item_type) then
        return false
    end

    if priv.slot[item_type] then
        Logger.error(self, 'slot is not empty.', 2)
    end

    private.applyParams(priv.owner, item, true)
    priv.slot[item_type] = item
    return true
end

---@param item_type ItemTypeEnum
---@return boolean
function public:unequip(item_type)
    local priv = private.data[self]

    if not ItemAPI.isTypeEquipable(item_type) then
        return false
    end

    if priv.slot[item_type] then
        private.applyParams(priv.owner, priv.slot[item_type], false)
    end

    priv.slot[item_type] = nil
    return true
end

---@param item_type ItemTypeEnum
function public:get(item_type)
    if type(self) == 'number' then
        error('', 2)
    end
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

---@param unit Unit
---@param item Item
---@param add boolean
function private.applyParams(unit, item, add)
    local item_param = item:getParameters()
    local unit_param = unit:getParameters()
    local mult = 1
    if not add then
        mult = -1
    end

    for _, param_type in pairs(ParamType) do
        for _, value_type in pairs(ValueType) do
            unit_param:add(param_type, value_type, mult * item_param:get(param_type, value_type))
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