--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ItemModelClass
local ItemModel = require('Item.Model')
---@type ItemModelTypeClass
local ItemModelType = require('Item.ModelType')
local ModelItemTypeEnum = ItemModelType.ItemType
---@type ParameterAPI
local ParameterAPI = require('Parameter.Api')

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

---@param x number
---@param y number
---@param child_instance Item | nil
---@return Item
function static.new(x, y, child_instance)
    local instance = child_instance or Class.allocate(Item)
    private.newData(instance, x, y)

    instance.Param = ParameterAPI.newItemContainer()

    return instance
end

---@param obj item
---@return Item | nil
function static.getInstance(obj)
    local ground_item = ItemModel.getInstance(obj)
    return private.model2item[ground_item]
end

--========
-- Public
--========

public.Param = nil

function public:updateDescription()
    local priv = private.data[self]

    local descr = self.Param:toString()
    if priv.item_model then
        priv.item_model:setDescription(descr)
    end
end

---@param x number
---@param y number
function public:placeModel(x, y)
    local priv = private.data[self]

    if priv.item_model then
        priv.item_model:setPosition(x, y)
    else
        priv.item_model = private.newModel(priv, x, y)
        private.model2item[priv.item_model] = self
    end
end

function public:destroyModel()
    local priv = private.data[self]

    if priv.item_model then
        priv.item_model:destroy()
        private.model2item[priv.item_model] = nil
        priv.item_model = nil
    end
end

---@return number | nil
function public:getModelX()
    local priv = private.data[self]

    if priv.item_model then
        return priv.item_model:getX()
    end
end

---@return number | nil
function public:getModelY()
    local priv = private.data[self]

    if priv.item_model then
        return priv.item_model:getY()
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.model2item = setmetatable({}, {__mode = 'kv'})

private.default_icon = 'ReplaceableTextures\\CommandButtons\\BTNHeroPaladin'

---@param x number
---@param y number
---@return ItemModel
function private.newModel(priv, x, y)
    local model = ItemModel.new(private.default_type, x, y)
    model:setName(priv.name)
    model:setDescription(priv.description)
    model:setModelPath(priv.model_path)
    return model
end

---@param self Item
function private.newData(self, x, y)
    local priv = {
        name = private.default_type:getName(),
        description = private.default_type:getDescription(),
        icon = private.default_icon,
        model_path = private.default_type:getModelPath(),

        item_model = nil,
    }
    priv.item_model = private.newModel(priv, x, y)

    private.data[self] = priv
    private.model2item[priv.item_model] = self
end

--=============
-- Compiletime
--=============

private.default_type = ItemModelType.new('DefaultItem', ModelItemTypeEnum.POWER_UP)

return static