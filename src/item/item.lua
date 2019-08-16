---@type ItemDB
local ItemDB = require('item.itemDB')

---@class Item
local Item = {}
local Item_meta = {
    __index = Item,
    __gc = Item.destroy
}

---@param self Item
---@return string
function Item_meta.__tostring(self)
    return string.format('Item %s (%s) at [%.2f, %.2f]',
                         self:getName(), ID2str(self:getId()), self:getX(), self:getY())
end

---@param id string|integer
---@param x number
---@param y number
---@return Item
function Item.new(id, x, y)
    id = ID(id)
    ---@type Item
    local item = {
        id = id,
        item_obj = CreateItem(id, x, y)
    }
    setmetatable(item, Item_meta)
    ItemDB.add(item.item_obj, item)
    return item
end

---@return nil
function Item:destroy()
    ItemDB.rm(self.item_obj)
    RemoveItem(self.item_obj)
    self.item_obj = nil
end

---@return integer
function Item:getId()
    return self.id
end

---@param x number
---@param y number
---@return nil
function Item:setPos(x, y)
    SetItemPosition(self.item_obj, x, y)
end

---@return number, number
function Item:getPos()
    return GetItemX(self.item_obj), GetItemY(self.item_obj)
end

---@return number
function Item:getX()
    return GetItemX(self.item_obj)
end

---@return number
function Item:getY()
    return GetItemY(self.item_obj)
end

---@param flag boolean
---@return nil
function Item:droppable(flag)
    SetItemDroppable(self.item_obj, flag)
end

---@param flag boolean
---@return nil
function Item:invulnerable(flag)
    SetItemInvulnerable(self.item_obj, flag)
end

---@return boolean
function Item:isInvulnerable()
    return IsItemInvulnerable(self.item_obj)
end

---@param flag boolean
---@return nil
function Item:visible(flag)
    SetItemVisible(self.item_obj, flag)
end

---@return boolean
function Item:isVisible()
    return IsItemVisible(self.item_obj)
end

---@return integer
function Item:getLevel()
    return GetItemLevel(self.item_obj)
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
    local item_class = GetItemType(self.item_obj)
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
    return GetItemCharges(self.item_obj)
end

---@param count integer
---@return nil
function Item:setCharges(count)
    SetItemCharges(self.item_obj, math.floor(count))
end

---@return string|nil
function Item:getName()
    return self._name
end

---@param tooltip string
---@return nil
function Item:setTooltip(tooltip)
    self._name = tooltip
    BlzSetItemName(self.item_obj, tooltip)
    BlzSetItemTooltip(self.item_obj, tooltip)
end

---@param ext_tooltip any
---@return nil
function Item:setExtendedTooltip(ext_tooltip)
    BlzSetItemDescription(self.item_obj,ext_tooltip)
    BlzSetItemExtendedTooltip(self.item_obj, ext_tooltip)
end

---@return string
function Item:getIcon()
    return BlzGetItemIconPath(self.item_obj)
end

---@param icon string
---@return nil
function Item:setItem(icon)
    BlzSetItemIconPath(self.item_obj, icon)
end

---@param ability Ability
---@return boolean
function Item:addAbility(ability)
    return BlzItemAddAbility(self.item_obj, ability:getId())
end

---@param ability Ability
---@return boolean
function Item:removeAbility(ability)
    return BlzItemRemoveAbility(self.item_obj, ability:getId())
end

local __replaced_functions = {
    GetSoldItem = GetSoldItem,
    GetManipulatedItem = GetManipulatedItem,
    GetOrderTargetItem = GetOrderTargetItem,
    GetSpellTargetItem = GetSpellTargetItem
}

---@return Item
function GetSoldItem() return ItemDB.get(__replaced_functions.GetSoldItem) end
---@return Item
function GetManipulatedItem() return ItemDB.get(__replaced_functions.GetManipulatedItem) end
---@return Item
function GetOrderTargetItem() return ItemDB.get(__replaced_functions.GetOrderTargetItem) end
---@return Item
function GetSpellTargetItem() return ItemDB.get(__replaced_functions.GetSpellTargetItem) end

return Item