--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ItemModelClass
local ItemModel = require('Item.Model')
---@type ItemModelTypeClass
local ItemModelType = require('Item.ModelType')
local ModelItemTypeEnum = ItemModelType.ItemType
---@type ParameterAPI
local ParameterAPI = require('Parameter.API')

--=======
-- Class
--=======

local Item = Class.new('Item')
---@class Item
local public = Item.public
---@class ItemClass
local static = Item.static
---@type ItemClass
local override = Item.override
local private = {}

--=========
-- Static
--=========

---@alias ItemTypeEnum number

---@type ItemTypeEnum[]
static.Type = {}
---@type ItemTypeEnum
static.Type.BAG = 1
---@type ItemTypeEnum
static.Type.BELT = 2
---@type ItemTypeEnum
static.Type.BOOTS = 3
---@type ItemTypeEnum
static.Type.CHEST = 4
---@type ItemTypeEnum
static.Type.EARRING = 5
---@type ItemTypeEnum
static.Type.HANDS = 6
---@type ItemTypeEnum
static.Type.HEAD = 7
---@type ItemTypeEnum
static.Type.LEGS = 8
---@type ItemTypeEnum
static.Type.WEAPON = 9
---@type ItemTypeEnum
static.Type.NECKLACE = 10
---@type ItemTypeEnum
static.Type.RING = 11
---@type ItemTypeEnum
static.Type.OFFHAND = 12
---@type ItemTypeEnum
static.Type.SHOULDERS = 13
---@type ItemTypeEnum
static.Type.USABLE = 14
---@type ItemTypeEnum
static.Type.MISCELLANEOUS = 15

---@param item_type ItemTypeEnum
---@param child_instance Item | nil
---@return Item
function static.new(item_type, child_instance)
    local instance = child_instance or Class.allocate(Item)
    private.newData(instance, item_type)

    instance.Param = ParameterAPI.newItemContainer()

    return instance
end

---@param obj item
---@return Item
function static.getInstance(obj)
    local model = ItemModel.getInstance(obj)
    if model then
        return private.model2item[model]
    end
end

--========
-- Public
--========

---@type ParameterItem
public.Param = nil
---@type ItemFrame
public.Frame = nil
---@type ItemTooltip
public.Tooltip = nil

---@param name string
function public:setName(name)
    private.data[self].name = name
end

---@param item_type ItemTypeEnum
function public:setType(item_type)
    private.data[self].item_type = item_type
end

---@param icon string
function public:setIcon(icon)
    private.data[self].icon = icon
end

---@param model ItemModel | nil
function public:setModel(model)
    private.data[self].model = model
    if model then
        private.model2item[model] = self
        model:setName(private.data[self].name)
    end
end

---@return string
function public:getName()
    return private.data[self].name
end

---@return ItemTypeEnum
function public:getType()
    return private.data[self].item_type
end

---@return string
function public:getIcon()
    return private.data[self].icon
end

function public:update()
    if not self.Param then
        Log.error(self, 'must have ParameterItem instance in public \'Param\' field.', 2)
    end

    local priv = private.data[self]

    if self.Frame then
        local frame = self.Frame
        frame:setItemIcon(priv.icon)
    end

    if self.Tooltip then
        local tooltip = self.Tooltip
        tooltip:setIcon(priv.icon)
        tooltip:setTitle(priv.name)
        tooltip:setDescription(priv.description)
        tooltip:setParameters(self.Param)
    end
end

function public:getModel()
    return private.data[self].model
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.model2item = setmetatable({},  {__mode = 'kv'})

private.TooltipIcon = {
    [static.Type.BAG] = 'war3mapImported\\Icons\\Inventory\\Bag.blp',
    [static.Type.BELT] = 'war3mapImported\\Icons\\Inventory\\Belt.blp',
    [static.Type.BOOTS] = 'war3mapImported\\Icons\\Inventory\\Boots.blp',
    [static.Type.CHEST] = 'war3mapImported\\Icons\\Inventory\\Chest.blp',
    [static.Type.EARRING] = 'war3mapImported\\Icons\\Inventory\\Earring.blp',
    [static.Type.HANDS] = 'war3mapImported\\Icons\\Inventory\\Gloves.blp',
    [static.Type.HEAD] = 'war3mapImported\\Icons\\Inventory\\Head.blp',
    [static.Type.LEGS] = 'war3mapImported\\Icons\\Inventory\\Legs.blp',
    [static.Type.WEAPON] = 'war3mapImported\\Icons\\Inventory\\MeleeWeapon.blp',
    [static.Type.NECKLACE] = 'war3mapImported\\Icons\\Inventory\\',
    [static.Type.RING] = 'war3mapImported\\Icons\\Inventory\\',
    [static.Type.OFFHAND] = 'war3mapImported\\Icons\\Inventory\\',
    [static.Type.SHOULDERS] = 'war3mapImported\\Icons\\Inventory\\',
    [static.Type.USABLE] = 'war3mapImported\\Icons\\Inventory\\',
    [static.Type.MISCELLANEOUS] = 'war3mapImported\\Icons\\Inventory\\',
}


---@param self Item
function private.newData(self, item_type)
    local priv = {
        name = 'Noname',
        description = 'Empty description',
        item_type = item_type,
        icon = 'ReplaceableTextures\\CommandButtons\\BTNHeroPaladin',

        model = nil
    }
    private.data[self] = priv
end

return static