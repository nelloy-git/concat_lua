--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type HandleClass
local Handle = require(lib_path..'Base') or error('')

--=======
-- Class
--=======

local Image = Class.new('Image', Handle)
---@class Image : Handle
local public = Image.public
---@class ImageClass : HandleClass
local static = Image.static
---@type ImageClass
local override = Image.override
local private = {}

--=========
-- Static
--=========

---@param file string
---@param size_x number
---@param size_y number
---@param size_z number
---@param child Image | nil
---@return Image
function override.new(file, size_x, size_y, size_z, child)
    isTypeErr(file, 'string', 'file')
    isTypeErr(size_x, 'number', 'size_x')
    isTypeErr(size_y, 'number', 'size_y')
    isTypeErr(size_z, 'number', 'size_z')
    if child then isTypeErr(child, Image, 'child') end

    local handle = CreateImage(file,
                               size_x, size_y, size_z,
                               0, 0, -5000,
                               size_x / 2, size_y / 2, size_z / 2, 4)

    local instance = child or Class.allocate(Image)
    instance = Handle.new(handle, DestroyImage, instance)

    return instance
end

--========
-- Public
--========

---@param x number
---@param y number
---@param z number
---@overload fun(self:Image, target:Unit, z:number)
function public:setPos(x, y, z)
    SetImagePosition(self:getData(), x, y, z)
end

--- [0, 1]
---@param r number
---@param g number
---@param b number
---@param a number
function public:setColor(r, g, b, a)
    r = r < 0 and 0 or r > 1 and 1 or r
    g = g < 0 and 0 or g > 1 and 1 or g
    b = b < 0 and 0 or b > 1 and 1 or b
    a = a < 0 and 0 or a > 1 and 1 or a

    SetImageColor(self:getData(),
                  math.floor(255 * r),
                  math.floor(255 * g),
                  math.floor(255 * b),
                  math.floor(255 * a))
end

---@param flag boolean
function public:renderAlways(flag)
    SetImageRenderAlways(self:getData(), flag)
end

---@param flag boolean
function public:setVisible(flag)
    ShowImage(self:getData(), flag)
end

--=========
-- Private
--=========


return static