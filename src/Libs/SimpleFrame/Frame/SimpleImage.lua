--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger

---@type SimpleBaseFrameClass
local SimpleBaseFrame = require(lib_modname..'.Frame.SimpleBase')
---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.FdfEdit.Frame')
---@type FdfLayerClass
local FdfTexture = require(lib_modname..'.FdfEdit.Texture')

--=======
-- Class
--=======

local SimpleImage = Class.new('SimpleImage', SimpleBaseFrame)
---@class SimpleImage : SimpleBaseFrame
local public = SimpleImage.public
---@class SimpleImageClass : SimpleBaseFrameClass
local static = SimpleImage.static
---@type SimpleImageClass
local override = SimpleImage.override
local private = {}

--=========
-- Static
--=========

---@param fdf_simpleframe FdfFrame
---@param child_instance SimpleImage | nil
---@return SimpleImage
function override.new(fdf_simpleframe, child_instance)
    if fdf_simpleframe then
        checkType(fdf_simpleframe, FdfFrame, 'fdf_simpleframe')
    else
        fdf_simpleframe = private.default_fdf
    end

    if child_instance then
        checkType(child_instance, SimpleImage, 'child_instance')
    end

    if #fdf_simpleframe:getTextures() ~= 1 then
        Log:err('fdf_frame must have one texture subframe.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleImage)
    instance = SimpleBaseFrame.new(fdf_simpleframe, instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setTextureFile(tex_file, flag, blend)
    self:getTexture(1):setTextureFile(tex_file, flag, blend)
end

--=========
-- Private
--=========

private.default_fdf = FdfFrame.new('DefaultSimpleImage', 'SIMPLEFRAME')

do
    local fdf = private.default_fdf
    fdf:setParameter('Width', '0.04')
    fdf:setParameter('Height', '0.04')
        local texture = FdfTexture.new('DefaultSimpleImageTexture')
        texture:setParameter('File', '\"\"')
        fdf:addTexture(texture)
end

return static