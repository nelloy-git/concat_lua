--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type DataBaseClass
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

local GroundItem = Class.new('GroundItem')
---@class GroundItem
local public = GroundItem.public
---@class GroundItemClass
local static = GroundItem.static
---@type GroundItemClass
local override = GroundItem.override
local private = {}

--========
-- Static
--========

---@param x number
---@param y number
---@param child_instance table | nil
---@return GroundItem
function static.new(x, y, child_instance)
    local instance = child_instance or Class.allocate(GroundItem)
    private.newData(instance, x, y)

    return instance
end

---@param wc3_item item
---@return GroundItem
function static.get(wc3_item)
    return private.DB:get(wc3_item)
end

--========
-- Public
--========

---@param name string
function public:setName(name)
    local priv = private[self]
    priv.name = name
    BlzSetItemName(priv.wc3_item, name)
end

---@return string
function public:getName()
    return private[self].name
end

---@param description string
function public:setDescription(description)
    local priv = private[self]
    priv.description = description
    BlzSetItemName(priv.wc3_item, description)
end

---@return string
function public:getDescription()
    return private[self].description
end

---@param icon_path string
function public:setIcon(icon_path)
    local priv = private[self]
    priv.icon_path = icon_path
    BlzSetItemIconPath(priv.wc3_item, icon_path)
end

---@return string
function public:getIcon()
    return private[self].icon_path
end

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('userdata', GroundItem)

private.item_type = Compiletime(function()
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

---@param instance GroundItem
function private.newData(instance, x, y)
    local priv = {
        wc3_item = CreateItem(ID(private.item_type.id), x, y),
        name = private.item_type.Name,
        description = private.item_type.Description,
        icon_path = private.item_type.InterfaceIcon
    }
    private[instance] = priv
    private.DB:set(priv.wc3_item, instance)
end

function private.freeData(self)
    RemoveItem(private[self].wc3_item)
    private[self] = nil
end

return static