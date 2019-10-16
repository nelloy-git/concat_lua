--==========
-- Includes
--==========

---@type DataBase
local Frame = require('Class.Frame.Main')

--========
-- Module
--========

function Frame:update()
    BlzFrameSetPoint(self:getObj(), FRAMEPOINT_TOPLEFT,
                     self.__parent:getObj(), FRAMEPOINT_TOPLEFT,
                     self.__x * self.__parent:getAbsWidth(), self.__y * self.__parent:getAbsHeight())
    BlzFrameSetSize(self:getObj(), self:getAbsWidth(), self:getAbsWidth())

    local childrens = self:getChildrens()
    for i = 1, #childrens do
        childrens[i]:update()
    end
end

---Relative to parent's width
---@param x number
function Frame:setX(x)
    self.__x = x
    self:update()
end

---Relative to parent's height
---@param y number
function Frame:setY(y)
    self.__y = y
    self:update()
end

---Relative to parent's width
---@return number
function Frame:getX()
    return self.__x
end

---Relative to parent's height
---@return number
function Frame:getY()
    return self.__y
end

---@return number
function Frame:getAbsX()
    local p_x
    local p_w
    if not self.__parent then
        p_x = 0
        p_w = Frame:getScreenWidth()
    else
        p_x = self.__parent:getAbsX()
        p_w = self.__parent:getAbsWidth()
    end

    return p_x + self.__x * p_w
end

---@return number
function Frame:getAbsY()
    local p_y
    if not self.__parent then
        p_y = Frame.getScreenHeight()
    else
        p_y = self.__parent:getAbsY()
    end
    local y = self.__y
    return p_y - y
end

---Relative to parent's height
---@param width number
function Frame:setWidth(width)
    self.__width = width
    self:update()
end

---Relative to parent's width
---@param height number
function Frame:setHeight(height)
    self.__height = height
    self:update()
end

---Relative to parent's width
---@return number
function Frame:getWidth()
    return self.__width
end

---Relative to parent's height
---@return number
function Frame:getHeight()
    return self.__height
end

---@return number
function Frame:getAbsWidth()
    local p_w
    if not self._parent then
        p_w = Frame.getScreenWidth()
    else
        p_w = self.__parent:getAbsWidth()
    end
    return self.__x * p_w
end

---@return number
function Frame:getAbsHeight()
    local p_h
    if not self._parent then
        p_h = Frame.getScreenHeight()
    else
        p_h = self.__parent:getAbsHeight()
    end
    return self.__y * p_h
end