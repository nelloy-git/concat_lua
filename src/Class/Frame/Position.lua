--==========
-- Includes
--==========

---@type Frame
local Frame = require('Class.Frame.Main')

require('Class.Frame.Subframe')
require('Class.Frame.Screen')

--========
-- Module
--========

---Frame:update should be called to apply changes.
---Input: function(self:Frame):number
---@param x number | function
function Frame:setX(x)
    self.__x = x
end

---Frame:update should be called to apply changes.
---Input: function(self:Frame):number
---@param y number | function
function Frame:setY(y)
    self.__y = y
end

---@return number
function Frame:getX()
    local t = type(self.__x)
    if t == 'number' then
        return self.__x
    elseif t == 'function' then
        return self.__x(self)
    else
        return 0
    end
end

---@return number
function Frame:getY()
    local t = type(self.__y)
    if t == 'number' then
        return self.__y
    elseif t == 'function' then
        return self.__y(self)
    else
        return 0
    end
end

---@return number
function Frame:getAbsX()
    local p_x
    if not self:getParent() then
        p_x = Frame:getScreenXOffset()
    else
        p_x = self:getParent():getAbsX()
    end
    return p_x + self:getX()
end

---@return number
function Frame:getAbsY()
    local p_y
    if not self:getParent() then
        p_y = Frame.getScreenHeight()
    else
        p_y = self:getParent():getAbsY()
    end
    return p_y - self:getY()
end

---Frame:update should be called to apply changes.
---Input: function(self:Frame):number
---@param width number | function
function Frame:setWidth(width)
    self.__width = width
end

---Frame:update should be called to apply changes.
---Input: function(self:Frame):number
---@param height number | function
function Frame:setHeight(height)
    self.__height = height
end

---@return number
function Frame:getWidth()
    local t = type(self.__width)
    if t == 'number' then
        return self.__width
    elseif t == 'function' then
        return self.__width(self)
    else
        return 0
    end
end

---@return number
function Frame:getHeight()
    local t = type(self.__height)
    if t == 'number' then
        return self.__height
    elseif t == 'function' then
        return self.__height(self)
    else
        return 0
    end
end