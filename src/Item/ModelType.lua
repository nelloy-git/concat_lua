--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type CompiletimeDataClass
local CompiletimeData = require('Class.CompiletimeData')

--=======
-- Class
--=======

local ItemModelType = Class.new('ItemModelType')
---@class ItemModelType
local public = ItemModelType.public
---@class ItemModelTypeClass
local static = ItemModelType.static
---@type ItemModelTypeClass
local override = ItemModelType.override
local private = {}

--=========
-- Static
--=========

---@alias ItemModelTypeEnum number

---@type table<string, ItemModelTypeEnum>
static.ItemType = {}
---@type ItemModelTypeEnum
static.ItemType.PERMANENT = 1
---@type ItemModelTypeEnum
static.ItemType.CHARGED = 2
---@type ItemModelTypeEnum
static.ItemType.POWER_UP = 3
---@type ItemModelTypeEnum
static.ItemType.ARTIFACT = 4
---@type ItemModelTypeEnum
static.ItemType.PURCHASABLE = 5
---@type ItemModelTypeEnum
static.ItemType.COMPAIGN = 6
---@type ItemModelTypeEnum
static.ItemType.MISCELLANEOUS = 7

---@param uniq_name string
---@param item_type ItemModelTypeEnum
---@param child_instance ItemModelType | nil
---@return ItemModelType
function static.new(uniq_name, item_type, child_instance)
    local instance = child_instance or Class.allocate(ItemModelType)
    private.newData(instance, uniq_name, item_type)

    return instance
end

--========
-- Public
--========

---@return number
function public:getId()
    return private.data[self].id
end

---@return string
function public:getName()
    return private.data[self].name
end

---@return string
function public:getDescription()
    return private.data[self].description
end

---@return string
function public:getModelPath()
    return private.data[self].model_path
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.CompiletimeData = CompiletimeData.new(ItemModelType)

---@param item_type any
---@return boolean
function private.isItemType(item_type)
    for _, v in pairs(static.ItemType) do
        if item_type == v then
            return true
        end
    end
    return false
end

---@param self ItemModelType
function private.newData(self, uniq_name, item_type)
    local priv = {}

    if IsCompiletime() then
        if private.CompiletimeData:get(uniq_name) then
            Log.error(ItemModelType, 'name is not unique.', 3)
        end
        priv.we_item = private.createWc3Item(uniq_name, item_type)
        private.CompiletimeData:set(uniq_name, priv.we_item:getId())
    end

    priv.name = uniq_name
    priv.description = ''
    priv.model_path = private.Model[item_type]
    priv.id = ID(private.CompiletimeData:get(uniq_name))

    private.data[self] = priv
end

--=============
-- Compiletime
--=============

private.BaseId = {
    [static.ItemType.PERMANENT] = 'rat6',
    [static.ItemType.CHARGED] = 'pnvu',
    [static.ItemType.POWER_UP] = 'rhe2',
    [static.ItemType.ARTIFACT] = 'ratf',
    [static.ItemType.PURCHASABLE] = 'moon',
    [static.ItemType.COMPAIGN] = 'engs',
    [static.ItemType.MISCELLANEOUS] = 'amrc',
}

private.Classification = {
    [static.ItemType.PERMANENT] = 'Permanent',
    [static.ItemType.CHARGED] = 'Charged',
    [static.ItemType.POWER_UP] = 'PowerUp',
    [static.ItemType.ARTIFACT] = 'Artifact',
    [static.ItemType.PURCHASABLE] = 'Purchasable',
    [static.ItemType.COMPAIGN] = 'Compaign',
    [static.ItemType.MISCELLANEOUS] = 'Miscellaneous',
}

private.Model = {
    [static.ItemType.PERMANENT] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.ItemType.CHARGED] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.ItemType.POWER_UP] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.ItemType.ARTIFACT] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.ItemType.PURCHASABLE] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.ItemType.COMPAIGN] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.ItemType.MISCELLANEOUS] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
}

local _ = Compiletime(function()
    private.ObjEdit = require('compiletime.ObjectEdit')
end)

function private.createWc3Item(name, item_type)
    if not private.isItemType(item_type) then
        Log.error(ItemModelType, 'unknown ItemModelTypeEnum.', 4)
    end

    ---@type ObjectEdit
    local ObjEdit = private.ObjEdit
    local WeItem = ObjEdit.Item
    local Field = WeItem.Field

    local id = ObjEdit.getItemId()
    local item = WeItem.new(id, private.BaseId[item_type], name)

    item:setField(Field.Name, name)
    item:setField(Field.TooltipBasic, name)
    item:setField(Field.Description, '')
    item:setField(Field.Abilities, '')
    item:setField(Field.ModelUsed, private.Model[item_type])
    item:setField(Field.Classification, private.Classification[item_type])
    item:setField(Field.HitPoints, 100000)

    return item
end

return static