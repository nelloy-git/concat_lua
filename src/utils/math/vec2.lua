---@class Vec2
Vec2 = {}
local Vec2_meta = {
    __index = Vec2,
}

---@param self Vec2
function Vec2_meta.__tostring(self)
    return string.format('[%.2f, %.2f]', self.x, self.y)
end

---@param x number
---@param y number
---@return Vec2
function Vec2.new(x, y)
    ---@type Vec2
    local v = {
        x = x,
        y = y
    }
    setmetatable(v, Vec2_meta)
    return v
end

return Vec2