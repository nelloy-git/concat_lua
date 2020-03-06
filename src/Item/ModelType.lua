--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type CompiletimeDataClass
local CompiletimeData = require('Utils.CompiletimeData')

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

---@alias ItemModelClassificationEnum number

---@type table<string, ItemModelClassificationEnum>
static.Classification = {}
---@type ItemModelClassificationEnum
static.Classification.PERMANENT = 1
---@type ItemModelClassificationEnum
static.Classification.CHARGED = 2
---@type ItemModelClassificationEnum
static.Classification.POWER_UP = 3
---@type ItemModelClassificationEnum
static.Classification.ARTIFACT = 4
---@type ItemModelClassificationEnum
static.Classification.PURCHASABLE = 5
---@type ItemModelClassificationEnum
static.Classification.COMPAIGN = 6
---@type ItemModelClassificationEnum
static.Classification.MISCELLANEOUS = 7

---@param uniq_name string
---@param item_class ItemModelClassificationEnum
---@param child_instance ItemModelType | nil
---@return ItemModelType
function override.new(uniq_name, item_class, child_instance)
    local instance = child_instance or Class.allocate(ItemModelType)
    private.newData(instance, uniq_name, item_class)

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

---@param item_class any
---@return boolean
function private.isClass(item_class)
    for _, v in pairs(static.Classification) do
        if item_class == v then
            return true
        end
    end
    return false
end

---@param self ItemModelType
function private.newData(self, uniq_name, item_class)
    local priv = {}

    if IsCompiletime() then
        if private.CompiletimeData:get(uniq_name) then
            Log.error(ItemModelType, 'name is not unique.', 3)
        end
        priv.we_item = private.createWc3Item(uniq_name, item_class)
        private.CompiletimeData:set(uniq_name, priv.we_item:getId())
    end

    priv.name = uniq_name
    priv.description = ''
    priv.model_path = private.Model[item_class]
    priv.id = ID(private.CompiletimeData:get(uniq_name))

    private.data[self] = priv
end

--=============
-- Compiletime
--=============

private.BaseId = {
    [static.Classification.PERMANENT] = 'rat6',
    [static.Classification.CHARGED] = 'pnvu',
    [static.Classification.POWER_UP] = 'rhe2',
    [static.Classification.ARTIFACT] = 'ratf',
    [static.Classification.PURCHASABLE] = 'moon',
    [static.Classification.COMPAIGN] = 'engs',
    [static.Classification.MISCELLANEOUS] = 'amrc',
}

private.ClassificationName = {
    [static.Classification.PERMANENT] = 'Permanent',
    [static.Classification.CHARGED] = 'Charged',
    [static.Classification.POWER_UP] = 'PowerUp',
    [static.Classification.ARTIFACT] = 'Artifact',
    [static.Classification.PURCHASABLE] = 'Purchasable',
    [static.Classification.COMPAIGN] = 'Compaign',
    [static.Classification.MISCELLANEOUS] = 'Miscellaneous',
}

private.Model = {
    [static.Classification.PERMANENT] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.Classification.CHARGED] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.Classification.POWER_UP] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.Classification.ARTIFACT] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.Classification.PURCHASABLE] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.Classification.COMPAIGN] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
    [static.Classification.MISCELLANEOUS] = 'Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl',
}

local _ = Compiletime(function()
    private.ObjEdit = require('compiletime.ObjectEdit')
end)

function private.createWc3Item(name, item_class)
    if not private.isClass(item_class) then
        Log.error(ItemModelType, 'unknown ItemModelClassificationEnum.', 4)
    end

    ---@type ObjectEdit
    local ObjEdit = private.ObjEdit
    local WeItem = ObjEdit.Item
    local Field = WeItem.Field

    local id = ObjEdit.getItemId()
    local item = WeItem.new(id, private.BaseId[item_class], name)

    item:setField(Field.Name, name)
    item:setField(Field.TooltipBasic, name)
    item:setField(Field.Description, '')
    item:setField(Field.Abilities, '')
    item:setField(Field.ModelUsed, private.Model[item_class])
    item:setField(Field.Classification, private.ClassificationName[item_class])
    item:setField(Field.HitPoints, 100000)

    return item
end

return static