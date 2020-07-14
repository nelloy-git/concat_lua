---@class FrameLib
local FrameLib = {}
local lib_modname = Compiletime(Lib.getModname())
Lib.start(lib_modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.ClassLib),
    UtilsLib = require(LibList.UtilsLib)
}

--=====
-- API
--=====

---@type FdfFileClass
FrameLib.FdfFile = require(lib_modname..'.Fdf.File')
FrameLib.FdfFile.init('Default')
---@type FdfFrameClass
FrameLib.FdfFrame = require(lib_modname..'.Fdf.Frame')

--============
-- Categories
--============

FrameLib.Fdf = {}
FrameLib.Fdf.Simple = {}
FrameLib.Fdf.Normal = {}

FrameLib.Frame = {}
FrameLib.Frame.Simple = {}
FrameLib.Frame.Normal = {}

--=================
-- FdfSimpleFrames
--=================

---@type FdfSimpleBaseClass
FrameLib.Fdf.Simple.Base = require(lib_modname..'.Fdf.Frame.SimpleBase')
---@type FdfSimpleFrameClass
FrameLib.Fdf.Simple.Frame = require(lib_modname..'.Fdf.Frame.SimpleFrame')
---@type FdfSimpleLayerClass
FrameLib.Fdf.Simple.Layer = require(lib_modname..'.Fdf.Frame.SimpleLayer')
---@type FdfSimpleStringClass
FrameLib.Fdf.Simple.String = require(lib_modname..'.Fdf.Frame.SimpleString')
---@type FdfSimpleTextureClass
FrameLib.Fdf.Simple.Texture = require(lib_modname..'.Fdf.Frame.SimpleTexture')

-- TODO add SimpleButton, SimpleStatusBar

-- Example
--[[
local test = FrameLib.Fdf.Simple.Frame.new('TestSimpleFrame')
test:setWidth(0.05)
test:setHeight(0.05)
    local layer = FrameLib.Fdf.Simple.Layer.new('ARTWORK')
        local texture = FrameLib.Fdf.Simple.Texture.new('TestSimpleTexture')
        texture:setFile("ReplaceableTextures\\\\CommandButtons\\\\BTNAcidBomb.blp")
        layer:addSubframe(texture)

        local string = FrameLib.Fdf.Simple.String.new('TestSimpleString')
        string:setFont('fonts\\nim_____.ttf', 0.14)
        layer:addSubframe(string)
test:addSubframe(layer)
]]

--==============
-- SimpleFrames
--==============

---@type FrameSimpleBaseClass
FrameLib.Frame.Simple.Base = require(lib_modname..'.Simple.Base')
---@type FrameSimpleImageClass
FrameLib.Frame.Simple.Image = require(lib_modname..'.Simple.Image')

-- Example
--[[
if not IsCompiletime() then
    local test = FrameLib.Frame.Simple.Image.new()
    test:setFile('', 0, true)
    test:setPos(0.4, 0.3)
end
]]

--==============
-- NormalFrames
--==============

Lib.finish()

return FrameLib