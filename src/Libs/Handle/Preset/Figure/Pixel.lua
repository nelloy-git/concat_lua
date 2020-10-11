-- https://xgm.guru/p/wc3/250655

--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ImportFile = UtilsLib.ImportFile or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type HandleSettings
local Settings = require(lib_path..'Settings') or error('')
---@type ImageClass
local Image = require(lib_path..'Types.Image') or error('')

--=======
-- Class
--=======

local FigurePixel = Class.new('FigurePixel', Image)
---@class FigurePixel : Image
local public = FigurePixel.public
---@class FigurePixelClass : ImageClass
local static = FigurePixel.static
---@type FigurePixelClass
local override = FigurePixel.override
local private = {}

--=========
-- Static
--=========

---@param child FigurePixel | nil
---@return FigurePixel
function override.new(child)
    if child then isTypeErr(child, FigurePixel, 'child') end

    local instance = child or Class.allocate(FigurePixel)
    instance = Image.new(private.pixel_texture,
                         Settings.FigurePixelSize, Settings.FigurePixelSize, Settings.FigurePixelSize,
                         instance)

    return instance
end

--========
-- Public
--========

--=========
-- Private
--=========

local sep = Compiletime(package.config:sub(1,1))
ImportFile.load(lib_path:gsub('%.', sep)..'Preset'..sep..'Figure'..sep..'pixel.dds',
                'war3mapImported'..sep..'Figure'..sep..'pixel.dds')
private.pixel_texture = 'war3mapImported\\Figure\\pixel.dds'


return static