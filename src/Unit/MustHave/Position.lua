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

---@param target_x number
---@param target_y number
---@param time number|nil
function Unit:setFacingTo(target_x, target_y, time)
    local x = self:getX()
    local y = self:getY()
    local angle = 180 + (180 / math.pi) * math.atan(y - target_y, x - target_x)
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