---@type ItemDB
local DataBase = require('utils.DataBase')

---@class Item
local Item = {
    __type = "ItemClass",
    __db = DataBase.new('userdata', 'Item')
}
local Item_meta = {
    __type = "Item",
    __index = Item,
    __gc = Item.destroy
}

---@param self Item
---@return string
function Item_meta.__tostring(self)
    return string.format('Item %s (%s) at %s',
                         self:getName(), ID2str(self:getId()), self:getPos())
end

---@param id string|integer
---@param x number
---@param y number
---@return Item
function Item.new(id, x, y)
    id = ID(id)
    ---@type Item
    local item = {
        __id = id,
        __item_obj = CreateItem(id, x, y)
    }
    setmetatable(item, Item_meta)
    Item.__db:add(item.__item_obj, item)

    return item
end

---@return nil
function Item:destroy()
    Item.__db:remove(self.__item_obj)
    RemoveItem(self.__item_obj)
    self.__item_obj = nil
end

---@return integer
function Item:getId()
    return self.__id
end

---@param x number
---@param y number
---@return nil
function Item:setPos(x, y)
    SetItemPosition(self.__item_obj, x, y)
end

---@return number, number
function Item:getPos()
    return Vec2(GetItemX(self.__item_obj), GetItemY(self.__item_obj))
end

---@return number
function Item:getX()
    return GetItemX(self.__item_obj)
end

---@return number
function Item:getY()
    return GetItemY(self.__item_obj)
end

---@param flag boolean
---@return nil
function Item:droppable(flag)
    SetItemDroppable(self.__item_obj, flag)
end

---@param flag boolean
---@return nil
function Item:invulnerable(flag)
    SetItemInvulnerable(self.__item_obj, flag)
end

---@return boolean
function Item:isInvulnerable()
    return IsItemInvulnerable(self.__item_obj)
end

---@param flag boolean
---@return nil
function Item:visible(flag)
    SetItemVisible(self.__item_obj, flag)
end

---@return boolean
function Item:isVisible()
    return IsItemVisible(self.__item_obj)
end

---@return integer
function Item:getLevel()
    return GetItemLevel(self.__item_obj)
end

---@alias ItemClass string
---| '"permanent"'
---| '"charged"'
---| '"powerup"'
---| '"artifact"'
---| '"purchasable"'
---| '"campaign"'
---| '"miscellaneous"'
---| '"unknown"'
---| '"any"'

---@return ItemClass
function Item:getClass()
    local item_class = GetItemType(self.__item_obj)
    if item_class == ITEM_TYPE_PERMANENT then return "permanent" end
    if item_class == ITEM_TYPE_CHARGED then return "charged" end
    if item_class == ITEM_TYPE_POWERUP then return "powerup" end
    if item_class == ITEM_TYPE_ARTIFACT then return "artifact" end
    if item_class == ITEM_TYPE_PURCHASABLE then return "purchasable" end
    if item_class == ITEM_TYPE_CAMPAIGN then return "campaign" end
    if item_class == ITEM_TYPE_MISCELLANEOUS then return "miscellaneous" end
    if item_class == ITEM_TYPE_UNKNOWN then return "unknown" end
    if item_class == ITEM_TYPE_ANY then return "any" end
end

---@return integer
function Item:getCharges()
    return GetItemCharges(self.__item_obj)
end

---@param count integer
---@return nil
function Item:setCharges(count)
    SetItemCharges(self.__item_obj, math.floor(count))
end

---@return string|nil
function Item:getName()
    return self._name
end

---@param tooltip string
---@return nil
function Item:setTooltip(tooltip)
    self._name = tooltip
    BlzSetItemName(self.__item_obj, tooltip)
    BlzSetItemTooltip(self.__item_obj, tooltip)
end

---@param ext_tooltip any
---@return nil
function Item:setExtendedTooltip(ext_tooltip)
    BlzSetItemDescription(self.__item_obj,ext_tooltip)
    BlzSetItemExtendedTooltip(self.__item_obj, ext_tooltip)
end

---@return string
function Item:getIcon()
    return BlzGetItemIconPath(self.__item_obj)
end

---@param icon string
---@return nil
function Item:setItem(icon)
    BlzSetItemIconPath(self.__item_obj, icon)
end

---@param ability Ability
---@return boolean
function Item:addAbility(ability)
    return BlzItemAddAbility(self.__item_obj, ability:getId())
end

---@param ability Ability
---@return boolean
function Item:removeAbility(ability)
    return BlzItemRemoveAbility(self.__item_obj, ability:getId())
end

---@return Item
function Item.GetSoldItem() return Item.__db:get(GetSoldItem()) end
---@return Item
function Item.GetManipulatedItem() return Item.__db:get(GetManipulatedItem()) end
---@return Item
function Item.GetOrderTargetItem() return Item.__db:get(GetOrderTargetItem()) end
---@return Item
function Item.GetSpellTargetItem() return Item.__db:get(GetSpellTargetItem()) end

return Item