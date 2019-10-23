--==========
-- Includes
--==========

---@type Frame
local Frame = require('Class.Frame.Main')

require('Class.Frame.Subframe')

--========
-- Module
--========

function Frame:update()
    local parent = self:getParent()
    
    --if parent then
    --    BlzFrameSetPoint(self:getObj(), FRAMEPOINT_TOPLEFT,
    --                     parent:getObj(), FRAMEPOINT_TOPLEFT,
    --                     self:getX() * parent:getAbsWidth(), -self:getY() * parent:getAbsHeight())
    --else
        Debug(self:getX(), Frame.getScreenWidth(), Frame.getScreenXOffset())
        BlzFrameSetAbsPoint(self:getObj(), FRAMEPOINT_TOPLEFT,
                            self:getAbsX(),
                            self:getAbsY())
    --end
    BlzFrameSetSize(self:getObj(), self:getAbsWidth(), self:getAbsHeight())

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
    if not self:getParent() then
        p_x = -Frame:getScreenXOffset()
        p_w = Frame.getScreenWidth()
    else
        p_x = self.__parent:getAbsX()
        p_w = self.__parent:getAbsWidth()
    end

    return p_x + self.__x * p_w
end

---@return number
function Frame:getAbsY()
    local p_y
    local p_h
    if not self:getParent() then
        p_y = Frame.getScreenHeight()
        p_h = Frame.getScreenHeight()
    else
        p_y = self.__parent:getAbsY()
        p_h = self.__parent:getAbsHeight()
    end
    local y = self.__y
    return p_y - self.__y * p_h
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
    local parent = self:getParent()

    if not parent then
        p_w = Frame.getScreenWidth()
    else
        p_w = parent:getAbsWidth()
    end
    return self:getWidth() * p_w
end

---@return number
function Frame:getAbsHeight()
    local p_h
    local parent = self:getParent()

    if not parent then
        p_h = Frame.getScreenHeight()
    else
        p_h = parent:getAbsHeight()
    end
    return self:getHeight() * p_h
end