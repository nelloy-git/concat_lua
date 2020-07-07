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
---@type FdfTextureClass
local FdfTexture = require(lib_modname..'.FdfEdit.Texture')
---@type FdfStringClass
local FdfString = require(lib_modname..'.FdfEdit.String')
---@type FdfLayerClass
local FdfLayer = require(lib_modname..'.FdfEdit.Layer')

--=======
-- Class
--=======

local SimpleBar = Class.new('SimpleBar', SimpleBaseFrame)
---@class SimpleBar : SimpleBaseFrame
local public = SimpleBar.public
---@class SimpleBarClass : SimpleBaseFrameClass
local static = SimpleBar.static
---@type SimpleBarClass
local override = SimpleBar.override
local private = {}

--=========
-- Static
--=========

---@param fdf_simplebar FdfFrame
---@param child_instance SimpleBar | nil
---@return SimpleBar
function override.new(fdf_simplebar, child_instance)
    if fdf_simplebar then
        checkType(fdf_simplebar, FdfFrame, 'fdf_simplebar')
    else
        fdf_simplebar = private.default_fdf
    end

    if child_instance then
        checkType(child_instance, SimpleBar, 'child_instance')
    end

    if fdf_simplebar:getBaseType() ~= 'SIMPLESTATUSBAR' then
        Log:err('fdf_simplebar has wrong base type.', 2)
    end

    local layers = fdf_simplebar:getLayers()
    if #layers ~= 2 then
        Log:err('fdf_frame must have two layer subframes.', 2)
    end

    for i = 1, #layers do
        if #layers[i]:getTextures() ~= 1 then
            Log:err('layer must have one testure subframe.', 2)
        end
    end

    local instance = child_instance or Class.allocate(SimpleBar)
    instance = SimpleBaseFrame.new(fdf_simplebar, instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setBarTextureFile(tex_file, flag, blend)
    BlzFrameSetTexture(self:getHandleData(), tex_file, flag, blend)
end

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setBackgroundTextureFile(tex_file, flag, blend)
    local texture = self:getLayer('BACKGROUND'):getTexture(1)
    texture:setTextureFile(tex_file, flag, blend)
end

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setBackgroundTextureFile(tex_file, flag, blend)
    local texture = self:getLayer('ARTWORK'):getTexture(1)
    texture:setTextureFile(tex_file, flag, blend)
end

--- Value should be in 0..100 range.
---@param value number
function public:setValue(value)
    BlzFrameSetValue(self:getHandleData(), value)
end

---@param text string
function public:setText(text)
    local string = self:getLayer('ARTWORK'):getString(1)
    string:setText(text)
end

---@param font_file string
---@param height number
---@param flags number
function public:setFont(font_file, height, flags)
    local string = self:getLayer('ARTWORK'):getString(1)
    string:setFont(font_file, height, flags)
end

--=========
-- Private
--=========

private.default_fdf = FdfFrame.new('DefaultSimpleBar', 'SIMPLESTATUSBAR')

do
    local fdf = private.default_fdf
    fdf:setParameter('Width', '0.12')
    fdf:setParameter('Height', '0.03')
    fdf:setParameter('BarTexture', '\"Replaceabletextures\\Teamcolor\\Teamcolor00.blp\"')
        local layer_background = FdfLayer.new('BACKGROUND')
            local texture = FdfTexture.new('DefaultSimpleBarBackgroundTexture')
            texture:setParameter('File', '\"Replaceabletextures\\Teamcolor\\Teamcolor27.blp\"')
            layer_background:addTexture(texture)
        fdf:addLayer(layer_background)

        local layer_artwork = FdfLayer.new('ARTWORK')
            local texture = FdfTexture.new('DefaultSimpleBarArtworkTexture')
            texture:setParameter('File', '\"war3mapImported\\Icons\\Transparent32x32.tga\"')
            layer_artwork:addTexture(texture)

            local text = FdfString.new('DefaultSimpleBarArtworkText')
            text:setParameter('Anchor', 'CENTER, 0, 0')
            layer_artwork:addString(text)
        fdf:addLayer(layer_artwork)
end

return static