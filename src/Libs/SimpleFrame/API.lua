---@class FrameLib
local FrameLib = {}
local lib_modname = Compiletime(Lib.getModname())
Lib.start(lib_modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.Class),
    UtilsLib = require(LibList.Utils)
}

--=====
-- API
--=====

---@type FdfFileClass
FrameLib.FdfFile = require(lib_modname..'.FdfEdit.File')
FrameLib.FdfFile.init('Default')
---@type FdfFrameClass
FrameLib.FdfFrame = require(lib_modname..'.FdfEdit.Frame')
---@type FdfTextureClass
FrameLib.FdfTexture = require(lib_modname..'.FdfEdit.Texture')
---@type FdfLayerClass
FrameLib.FdfLayer = require(lib_modname..'.FdfEdit.Layer')

---@type SimpleBaseFrameClass
FrameLib.SimpleBase = require(lib_modname..'.Frame.SimpleBase')
---@type SimpleImageClass
FrameLib.SimpleImage = require(lib_modname..'.Frame.SimpleImage')


Lib.finish()
return FrameLib