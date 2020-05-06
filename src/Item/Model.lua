--=========
-- Include
--=========


local Class = require('Utils.Class.API')

---@type ItemObjClass
local ItemObj = require('Object.Item')
---@type ItemModelTypeClass
local ItemType = require('Item.ModelType')

--=======
-- Class
--=======

local ItemModel = Class.new('ItemModel', ItemObj)
---@class ItemModel : ItemObj
local public = ItemModel.public
---@class ItemModelClass : ItemObjClass
local static = ItemModel.static
---@type ItemModelClass
local override = ItemModel.override
local private = {}

--========
-- Static
--========

---@param x number
---@param y number
---@param child_instance table | nil
---@return ItemModel
function override.new(x, y, child_instance)
    local instance = child_instance or Class.allocate(ItemModel)
    instance = ItemObj.new(private.model_type:getId(), x, y, instance)

    private.newData(instance, private.model_type, x, y)

    return instance
end

--========
-- Public
--========

function public:setPosition(x, y)
    local priv = private.data[self]
    priv.x = x
    priv.y = y

    SetItemPosition(self:getObj(), x, y)
end

---@param name string
function public:setName(name)
    local priv = private.data[self]
    priv.name = name
    BlzSetItemName(self:getObj(), name)
    BlzSetItemTooltip(self:getObj(), name)
end

---@param description string
function public:setDescription(description)
    local priv = private.data[self]
    priv.description = description
    BlzSetItemDescription(self:getObj(), description)
    BlzSetItemExtendedTooltip(self:getObj(), description)
end

---@param path string
function public:setModelPath(path)
    local priv = private.data[self]
    priv.model_path = path

    BlzSetItemStringField(self:getObj(), ITEM_SF_MODEL_USED, path)
end

---@return ItemModelType
function public:getType()
    return private.data[self].item_type
end

---@return number
function public:getX()
    return private.data[self].x
end

---@return number
function public:getY()
    return private.data[self].y
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
    return  private.data[self].model_path
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.model_type = ItemType.new('Item', ItemType.Classification.POWER_UP)

---@param self ItemModel
function private.newData(self, item_type, x, y)
    local priv = {
        x = x,
        y = y,

        item_type = item_type,
        id = item_type:getId(),
        name = item_type:getName(),
        description = item_type:getDescription(),
        model_path = item_type:getModelPath()
    }
    private.data[self] = priv
end


return static