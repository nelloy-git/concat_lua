local Unit = require('classes.Unit.UnitData')

---@return number
function Unit:getX()
    return GetUnitX(self.__unit_obj)
end

---@return number
function Unit:getY()
    return GetUnitY(self.__unit_obj)
end

---@return number
function Unit:getZ()
    return GetTerrainZ(self:getX(), self:getY()) + self:getFlyHeight()
end

---@param x number
function Unit:setX(x)
    SetUnitX(self.__unit_obj, x)
end

---@param y number
function Unit:setY(y)
    SetUnitY(self.__unit_obj, y)
end

---@param z number
function Unit:setZ(z)
    self:setFlyHeight(z - GetTerrainZ(self:getX(), self:getY()))
end

---@return Vec2
function Unit:getPos2()
    return Vec2(self:getX(), self:getY())
end

---@return Vec3
function Unit:getPos3()
    return Vec3(self:getX(), self:getY(), self:getZ())
end

---@param pos Vec2
function Unit:setPos2(pos)
    self:setX(pos.x)
    self:setY(pos.y)
end

---@param pos Vec3
function Unit:setPos3(pos)
    self:setX(pos.x)
    self:setY(pos.y)
    self:setZ(pos.z)
end

---@return number
function Unit:getFlyHeight()
    return GetUnitFlyHeight(self.__unit_obj)
end

---@return number
function Unit:setFlyHeight(height)
    return SetUnitFlyHeight(self.__unit_obj, height)
end

---@return number
function Unit:getDefaultsFlyHeight()
    return GetUnitDefaultFlyHeight(self.__unit_obj)
end

---@return number
function Unit:getFacing()
    return GetUnitFacing(self.__unit_obj)
end

---@param angle number
---@param time number|nil
function Unit:setFacing(angle, time)
    SetUnitFacingTimed(self.__unit_obj, angle, time | 0)
end

---@param target Vec2
---@param time number|nil
function Unit:setFacingTo(target, time)
    local x = self:getX()
    local y = self:getY()
    local angle = 180 + (180 / math.pi) * math.atan(y - target.y, x - target.x)
    self:setFacing(angle, time)
end