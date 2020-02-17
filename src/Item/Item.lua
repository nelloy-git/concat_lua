--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ItemModelClass
local ItemModel = require('Item.Model')
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

    return instance
end

---@param obj_or_id item | number
---@return Item | nil
function static.getIntance(obj_or_id)
    if type(obj_or_id) == 'number' then
        return private.id2item[obj_or_id]
    end
    local model = ItemModel.getInstance(obj_or_id)
    if model then
        return private.model2item[model]
    end
end

--========
-- Public
--========

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

---@param description string
function public:setDescription(description)
    private.data[self].description = description
end

---@param model ItemModel | nil
function public:setModel(model)
    private.data[self].model = model
    if model then
        private.model2item[model] = self
        model:setName(private.data[self].name)
    end
end

---@param owner unit
function public:setOwner(owner)
    private.data[self].owner = owner
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

---@return string
function public:getDescription()
    return private.data[self].description
end

---@return ItemModel
function public:getModel()
    return private.data[self].model
end

---@return ParameterItem
function public:getParameters()
    return private.data[self].param
end

---@return number
function public:getId()
    return private.data[self].id
end

---@return unit
function public:getOwner()
    return private.data[self].owner
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.model2item = setmetatable({},  {__mode = 'kv'})

private.cur_id = 1
private.id2item = setmetatable({},  {__mode = 'v'})

---@param item Item
---@return number
function private.newId(item)
    local id = private.cur_id
    private.cur_id = id + 1

    private.id2item[id] = item
    return id
end

---@param self Item
function private.newData(self, item_type)
    local priv = {
        name = 'Noname',
        description = 'Empty description',
        item_type = item_type,
        icon = 'ReplaceableTextures\\CommandButtons\\BTNHeroPaladin',
        id = private.newId(self),

        model = nil,
        param = ParameterAPI.newItemContainer(),

        owner = nil,
    }
    private.data[self] = priv
end

return static