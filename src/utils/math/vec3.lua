---@class Vec3
Vec3 = {}
local Vec3_meta = {
    __index = Vec3,
}

---@param self Vec3
function Vec3_meta.__tostring(self)
    return string.format('[%.2f, %.2f, %.2f]', self.x, self.y, self.z)
end

local loc = nil
function Vec3.init()
    loc = Location(0, 0)
end

---@param x number
---@param y number
---@return number
function GetTerrainZ(x, y)
    MoveLocation(loc, x, y)
    return GetLocationZ(loc)
end

---@param x number
---@param y number
---@param z number
---@return Vec3
function Vec3.new(x, y, z)
    ---@type Vec3
    local v = {
        x = x,
        y = y,
        z = z
    }
    setmetatable(v, Vec3_meta)
    return v
end

return Vec3