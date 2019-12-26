--=========
-- Include
--=========

local Class = require('Utils.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

---@type any
local GroundItem = Class.newClass('GroundItem')

---@class GroundItem
local public = GroundItem.public
---@class GroundItemClass
local static = GroundItem.static
---@type table
local override = GroundItem.override
---@type table(GroundItem, table)
local private = {}

private.DB = DataBase.new('userdata', getClassName(GroundItem))

private.item_type = compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local WeItem = WeObjEdit.Item
    local i = WeItem.new(WeObjEdit.getItemId(), 'rre1', 'Empty item')
    i:setField(WeItem.Name, 'Empty')
    i:setField(WeItem.Description, '')
    i:setField(WeItem.Abilities, '')
    i:setField(WeItem.InterfaceIcon, 'ReplaceableTextures\\\\CommandButtons\\\\BTNRune.blp')
    i:setField(WeItem.HitPoints, 10^10)
    return i:toRuntime()
end)

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return GroundItem
function static.new(x, y, instance_data)
    local instance = instance_data or Class.newInstanceData(GroundItem)
    local priv = {
        wc3_item = CreateItem(ID(private.item_type.id), x, y),
        name = private.item_type.Name,
        description = private.item_type.Description,
        icon_path = private.item_type.InterfaceIcon
    }
    private[instance] = priv
    private.DB:set(priv.wc3_item, instance)

    return instance
end

---@param wc3_item item
---@return GroundItem
function static.get(wc3_item)
    return private.DB:get(wc3_item)
end

function public:free()
    local priv = private[self]
    RemoveItem(priv.wc3_item)

    private[self] = nil
    freeInstanceData(self)
end

---@param name string
function public:setName(name)
    local priv = private[self]
    priv.name = name
    BlzSetItemName(priv.wc3_item, name)
end

---@return string
function public:getName()
    local priv = private[self]
    return priv.name
end

---@param description string
function public:setDescription(description)
    local priv = private[self]
    priv.description = description
    BlzSetItemName(priv.wc3_item, description)
end

---@return string
function public:getDescription()
    local priv = private[self]
    return priv.description
end

---@param icon_path string
function public:setIcon(icon_path)
    local priv = private[self]
    priv.icon_path = icon_path
    BlzSetItemIconPath(priv.wc3_item, icon_path)
end

---@return string
function public:getIcon()
    local priv = private[self]
    return priv.icon_path
end

return GroundItem