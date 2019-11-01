--=========
-- Include
--=========

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Widget
local Widget = require('Class.Widget.Main')
require('Class.Widget.Position')

--========
-- Module
--========

local addChild --Predefined
local noparent_db = DataBase.new('Widget', 'table')

---Overrides default constructor.
local default_constructor = Widget.new
function

---Widget:update should be called to apply changes.
---@param parent Widget
function Widget:setParent(parent)
    local prev_parent = self:getParent()

    if not prev_parent then
        Debug("Frame error: Frame.GAME_UI's parent can not be changed.")
        return nil
    end

    -- Remove child from previous parent.
    local parents_chilrens = prev_parent:getChildrens()
    for i = 1, #parents_chilrens do
        if parents_chilrens[i] == self then
            table.remove(self.__parent.__childrens, i)
            break
        end
    end

    self.__parent = parent
    addChild(self.__parent, self)
end

---@return Widget | nil
function Widget:getParent()
    return self.__parent
end

---Do not change this table manually.
---@return Widget[]
function Widget:getChildrens()
    if not self.__childrens then
        self.__childrens = {}
    end
    return self.__childrens
end

---@param parent Widget
---@param child Widget
addChild = function(parent, child)
    local childrens = parent:getChildrens()
    table.insert(childrens, #childrens + 1, child)
    BlzFrameSetParent(child:getObj(), parent:getObj())
end

---@param key string
---@param widget Widget
function Widget:setSubframe(key, widget)
    if not self.__subframes then
        self.__subframes = DataBase.new('string', 'Frame')
    end

    self.__subframes:add(key, widget)
    widget:setParent(self)
end

---@param key string
---@return Widget | nil
function Widget:getSubframe(key)
    if not self.__subframes then
        self.__subframes = DataBase.new('string', 'Frame')
    end

    return self.__subframes:get(key)
end

---@param key string
---@return Widget | nil
function Widget:removeSubframe(key)
    if not key then return nil end

    local sub = self:getSubframe(key)
    if not sub then return nil end

    self.__subframes:remove(key)
    sub:setParent(nil)
    return sub
end

---@return number
function Widget:getAbsX()
    local p_x
    if not self:getParent() then
        p_x = 0
    else
        p_x = self:getParent():getAbsX()
    end
    return p_x + self:getX()
end

---@return number
function Widget:getAbsY()
    local p_y
    if not self:getParent() then
        p_y = Widget.getScreenHeight()
    else
        p_y = self:getParent():getAbsY()
    end
    return p_y - self:getY()
end