--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type FrameUtils
local FrameUtils = require(lib_path..'Utils') or error('')
local newFrame = FrameUtils.newFrameFromFdf or error('')

---@type FdfSimpleFrameClass
local FdfSimpleFrame = require(lib_path..'Fdf.Simple.Frame') or error('')
---@type FdfTextureClass
local FdfSimpleTexture = require(lib_path..'Fdf.Simple.Texture') or error('')

---@type FrameSimpleTextureClass
local FrameSimpleTexture = require(lib_path..'Simple.Texture') or error('')

--=======
-- Class
--=======

local FrameSimpleImage = Class.new('FrameSimpleImage', Frame)
---@class FrameSimpleImage : Frame
local public = FrameSimpleImage.public
---@class FrameSimpleImageClass : FrameClass
local static = FrameSimpleImage.static
---@type FrameSimpleImageClass
local override = FrameSimpleImage.override
local private = {}

--=========
-- Static
--=========

---@param child FrameSimpleImage | nil
---@return FrameSimpleImage
function override.new(child)
    if child then isTypeErr(child, FrameSimpleImage, 'child') end

    local instance = child or Class.allocate(FrameSimpleImage)
    instance = newFrame(private.fdf, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setTexture(tex_file, flag, blend)
    private.data[self].texture:setTexture(tex_file, flag, blend)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.fdf = FdfSimpleFrame.new('FrameSimpleImage')
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
    local fdf_texture = FdfSimpleTexture.new('FrameSimpleImageTexture')
    fdf_texture:setFile("ReplaceableTextures\\\\CommandButtons\\\\BTNAcidBomb.blp")
private.fdf:addSubframe(fdf_texture)

---@param self FrameSimpleImage
function private.newData(self)
    local priv = {
        texture = FrameSimpleTexture.new(BlzGetFrameByName('FrameSimpleImageTexture', 0)),
    }
    private.data[self] = priv
end

return static