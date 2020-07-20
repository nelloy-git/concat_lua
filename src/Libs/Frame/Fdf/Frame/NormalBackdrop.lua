--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

---@type FdfFileClass
local FdfFile = require(lib_modname..'.Fdf.File')
---@type FdfNormalBaseClass
local FdfNormalBase = require(lib_modname..'.Fdf.Frame.NormalBase')

--=======
-- Class
--=======

local FdfNormalBackdrop = Class.new('FdfNormalBackdrop', FdfNormalBase)
---@class FdfNormalBackdrop : FdfNormalBase
local public = FdfNormalBackdrop.public
---@class FdfNormalBackdropClass : FdfNormalBaseClass
local static = FdfNormalBackdrop.static
---@type FdfNormalBackdropClass
local override = FdfNormalBackdrop.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param fdf_file FdfFile | nil
---@param child_instance FdfNormalBackdrop | nil
---@return FdfNormalBackdrop
function override.new(name, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfNormalBackdrop, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfNormalBackdrop)
    instance = FdfNormalBase.new(name, 'BACKDROP', fdf_file, instance)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    local str_width = tostring(width)
    self:setParameter('Width', str_width)
end

---@param height number
function public:setHeight(height)
    local str_height = tostring(height)
    self:setParameter('Height', str_height)
end

--- Look-Up FileNames in some String table (for example gameinterface)
---@param flag boolean
function public:setDecorateFileNames(flag)
    if flag then
        self:setParameter('DecorateFileNames')
    else
        self:removeParameter('DecorateFileNames')
    end
end

---@param flag boolean
function public:setAllPoints(flag)
    if flag then
        self:setParameter('SetAllPoints')
    else
        self:removeParameter('SetAllPoints')
    end
end

--- Fills the Frame with tiles of the texture. Without the background file is stretched
---@param flag boolean
function public:setBackgroundTileMode(flag)
    if flag then
        self:setParameter('BackdropTileBackground')
    else
        self:removeParameter('BackdropTileBackground')
    end
end

--- In Tile mode, the size of each tile. Rnage [0, 1]
---@param size number
function public:setBackgroundSize(size)
    if self:getParameter('BackdropTileBackground') then
        Log:wrn('Parameter \"BackdropBackgroundSize\" works in tile mode only')
    end

    size = size > 1 and 1 or size
    size = size < 0 and 0 or size

    self:setParameter('BackdropBackgroundSize', tostring(size))
end

--- Main image
---@param path string
function public:setBackground(path)
    self:setParameter('BackdropBackground', '\"'..path..'\"')
end

--- Cuts in the background from the frames outside, granting space between
--- the edge and the background. Right Top Bottom Left. The numbers can be
--- Negative to extend this side over the edge into the outside.
---@param right number
---@param top number
---@param bottom number
---@param left number
function public:setInsets(right, top, bottom, left)
    self:setParameter('BackdropBackgroundInsets',
                      string.format('%f %f %f %f', right, top, bottom, left))
end

--- FRAMEPOINTS having borders (edgefile). Order does not matter
--- "UL|UR|BL|BR|T|L|B|R"
---@param flags string
function public:setCornerFlags(flags)
    self:setParameter('BackdropCornerFlags', '\"'..flags..'\"')
end

--- Size of the border/edge.
---@param size number
function public:setCornerSize(size)
    size = size > 1 and 1 or size
    size = size < 0 and 0 or size

    self:setParameter('BackdropCornerSize', tostring(size))
end

--- The border File, this texture having the border as fragments
--- next to each other (gameinterface). You don't need the single
--- ones if you have this one.
---@param path string
function public:setEdgeFile(path)
    self:setParameter('BackdropEdgeFile', '\"'..path..'\"')
end

---@param path string
function public:setCornerEdgeFile(path)
    self:setParameter('BackdropCornerFile', '\"'..path..'\"')
end

---@param path string
function public:setLeftEdgeFile(path)
    self:setParameter('BackdropLeftFile', '\"'..path..'\"')
end

---@param path string
function public:setTopEdgeFile(path)
    self:setParameter('BackdropTopFile', '\"'..path..'\"')
end

---@param path string
function public:setRightEdgeFile(path)
    self:setParameter('BackdropRightFile', '\"'..path..'\"')
end

---@param path string
function public:setBottomEdgeFile(path)
    self:setParameter('BackdropBottomFile', '\"'..path..'\"')
end

--- Use transparency by alpha channels. An image with alpha channel
--- transparency but without this will look wierd and wrong. It also
--- allows to see the things behind the frame.
---@param flag boolean
function public:setBlendAll(flag)
    if flag then
        self:setParameter('BackdropBlendAll')
    else
        self:removeParameter('BackdropBlendAll')
    end
end

--- Vertical, a face looking to the left will look with this option enabled to the right.
---@param flag boolean
function public:setMirrired(flag)
    if flag then
        self:setParameter('BackdropMirrored')
    else
        self:removeParameter('BackdropMirrored')
    end
end

--=========
-- Private
--=========

return static