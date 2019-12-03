--=========
-- Include
--=========

---@type DataBaseClass
local DataBase = require('Class.DataBase')

--================
-- Abstract Class
--================

---@type FrameClass
local Frame = newClass('Frame')

---@class FrameClass
local static = Frame.static
---@class Frame
local public = Frame.public
---@type table
local override = Frame.override
---@type table(Frame, table)
local private = {}

--=========
-- Methods
--=========

function public:update() Log(Log.Err, getClassName(Frame), 'function \"update\" is not redeclared in child.') end---@param parent Frame

function public:setParent(parent)
    private[self].parent = parent
    self:update()
end

---@return Frame
function public:getParent()
    return private[self].parent
end

---@param x number
function public:setX(x)
    private[self].x = x
    self:update()
end

---@return number
function public:getX()
    return private[self].x
end

---@param y number
function public:setY(y)
    private[self].y = y
    self:update()
end

---@return number
function public:getY()
    return private[self].y
end

---@param width number
function public:setWidth(width)
    private[self].width = width
    self:update()
end

---@return number
function public:getWidth()
    return private[self].width
end

---@param height number
function public:setHeight(height)
    private[self].height = height
    self:update()
end

---@reutrn number
function public:getHeight()
    return private[self].height
end

---@param lvl number
function public:setLevel(lvl)
    private[self].level = lvl
    self:update()
end

---@return number
function public:getLevel()
    return private[self].level
end

return Frame