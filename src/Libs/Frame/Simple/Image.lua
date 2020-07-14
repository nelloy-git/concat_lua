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

---@type FdfSimpleFrameClass
local FdfSimpleFrame = require(lib_modname..'.Fdf.Frame.SimpleFrame')
---@type FdfSimpleTextureClass
local FdfSimpleTexture = require(lib_modname..'.Fdf.Frame.SimpleTexture')

---@type FrameSimpleBaseClass
local FrameSimpleBase = require(lib_modname..'.Simple.Base')
---@type FrameSimpleTextureClass
local FrameSimpleTexture = require(lib_modname..'.Simple.Texture')

--=======
-- Class
--=======

local FrameSimpleImage = Class.new('FrameSimpleImage', FrameSimpleBase)
---@class FrameSimpleImage : FrameSimpleBase
local public = FrameSimpleImage.public
---@class FrameSimpleImageClass : FrameSimpleBaseClass
local static = FrameSimpleImage.static
---@type FrameSimpleImageClass
local override = FrameSimpleImage.override
local private = {}

--=========
-- Static
--=========

---@param handle framehandle
---@param child_instance FrameSimpleImage | nil
---@return FrameSimpleImage
function override.new(handle, child_instance)
    if handle then checkTypeErr(handle, 'framehandle', 'handle') end
    if child_instance then checkTypeErr(child_instance, FrameSimpleImage, 'child_instance') end

    local instance = child_instance or Class.allocate(FrameSimpleImage)
    instance = FrameSimpleBase.new(private.fdf, instance)

    --- convert FrameBase -> FrameSimpleTexture
    instance:setSubframeClass(private.fdf_texture_name, FrameSimpleTexture)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setFile(tex_file, flag, blend)
    self:getSubframe(private.fdf_texture_name):setFile(tex_file, flag, blend)
end

--=========
-- Private
--=========

private.fdf_name = 'FrameSimpleImage'
private.fdf_texture_name = 'FrameSimpleImageTexture'

private.fdf = FdfSimpleFrame.new(private.fdf_name)
private.fdf:setWidth(0.04)
private.fdf:setHeight(0.04)
    local fdf_texture = FdfSimpleTexture.new(private.fdf_texture_name)
    fdf_texture:setFile("ReplaceableTextures\\\\CommandButtons\\\\BTNAcidBomb.blp")
private.fdf:addSubframe(fdf_texture)

return static