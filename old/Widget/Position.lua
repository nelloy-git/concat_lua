--==========
-- Includes
--==========

---@type Widget
local Widget = require('Class.Widget.Main')

--========
-- Module
--========

---Widget:update should be called to apply changes.
---Input: function(self:Frame, data:any):number
---@param x number | function
---@param data any
function Widget:setX(x, data)
    self.__x = x
    self.__x_data = data
end

---Widget:update should be called to apply changes.
---Input: function(self:Frame, data:any):number
---@param y number | function
---@param data any
function Widget:setY(y, data)
    self.__y = y
    self.__y_data = data
end

---Returns x position relative to parent.
---@return number
function Widget:getX()
    local t = type(self.__x)
    if t == 'number' then
        return self.__x
    elseif t == 'function' then
        return self.__x(self, self.__x_data)
    else
        return 0
    end
end

---Returns x position relative to parent.
---@return number
function Widget:getY()
    local t = type(self.__y)
    if t == 'number' then
        return self.__y
    elseif t == 'function' then
        return self.__y(self, self.__y_data)
    else
        return 0
    end
end

---Widget:update should be called to apply changes.
---Input: function(self:Frame, data:any):number
---@param width number | function
---@param data any
function Widget:setWidth(width, data)
    self.__width = width
    self.__width_data = data
end

---Widget:update should be called to apply changes.
---Input: function(self:Frame, data:any):number
---@param height number | function
---@param data any
function Widget:setHeight(height, data)
    self.__height = height
    self.__height_data = data
end

---@return number
function Widget:getWidth()
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
function Widget:getHeight()
    local t = type(self.__height)
    if t == 'number' then
        return self.__height
    elseif t == 'function' then
        return self.__height(self. self.__height_data)
    else
        return 0
    end
end