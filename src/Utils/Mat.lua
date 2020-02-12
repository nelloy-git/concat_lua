local Mat = {}

local function get(mat, x, y)
    local w = mat.width
    local index = x + w * (y - 1)
    return mat.data[index]
end

local function set(mat, value, x, y)
    local w = mat.width
    local index = x + w * (y - 1)
    mat.data[index] = value
end


function Mat.new(width, height)
    ---@class Mat
    local mat = {
        get = get,
        set = set,

        width = width,
        height = height,

        data = {}
    }
end

return Mat