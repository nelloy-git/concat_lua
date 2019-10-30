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
---Input: function(self:Frame, data:any):number
---@param x number | function
function Frame:setX(x, data)
    self.__x = x
    self.__x_data = data
end

---Frame:update should be called to apply changes.
---Input: function(self:Frame, data:any):number
---@param y number | function
function Frame:setY(y, data)
    self.__y = y
    self.__y_data = data
end

---@return number
function Frame:getX()
    local t = type(self.__x)
    if t == 'number' then
        return self.__x
    elseif t == 'function' then
        return self.__x(self, self.__x_data)
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
        return self.__y(self, self.__y_data)
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
---Input: function(self:Frame, data:any):number
---@param width number | function
function Frame:setWidth(width, data)
    self.__width = width
    self.__width_data = data
end

---Frame:update should be called to apply changes.
---Input: function(self:Frame, data:any):number
---@param height number | function
function Frame:setHeight(height, data)
    self.__height = height
    self.__height_data = data
end

---@return number
function Frame:getWidth()
    local t = type(self.__width)
    if t == 'number' then
        return self.__width
    elseif t == 'function' then
        return self.__width(self, self.__width_data)
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
        return self.__height(self. self.__height_data)
    else
        return 0
    end
end