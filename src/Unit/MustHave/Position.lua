local Class = require(Lib.Class)

---@type Unit
local Unit = require('Unit.Unit')

local static = Unit
local public = Class.getPublic(Unit)

--========
-- Static
--========



--========
-- Public
--========

---@param x number
function public:setX(x)
    SetUnitX(self:getObj(), x)
end

---@param y number
function public:setY(y)
    SetUnitY(self:getObj(), y)
end

---@param angle number
---@param time number | nil
function public:setFacing(angle, time)
    SetUnitFacingTimed(self:getObj(), angle, time or 0)
end

---@param x number
---@param y number
---@param time number | nil
function Unit:setFacingTo(x, y, time)
    local self_x = GetUnitX(self:getObj())
    local self_y = GetUnitY(self:getObj())
    local angle = 180 + (180 / math.pi) * math.atan(self_y - y, self_x - x)
    SetUnitFacingTimed(self:getObj(), angle, time or 0)
end

---@return number
function public:getX()
    return GetUnitX(self:getObj())
end

---@return number
function public:getY()
    return GetUnitY(self:getObj())
end

---@return number
function public:getFacing()
    return GetUnitFacing(self:getObj())
end