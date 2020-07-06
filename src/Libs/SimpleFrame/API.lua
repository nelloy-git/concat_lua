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
FrameLib.FdfFile = require(lib_modname..'.FdfEdit.File')
FrameLib.FdfFile.init('Default')
---@type FdfFrameClass
FrameLib.FdfFrame = require(lib_modname..'.FdfEdit.Frame')
---@type FdfTextureClass
FrameLib.FdfTexture = require(lib_modname..'.FdfEdit.Texture')
---@type FdfStringClass
FrameLib.FdfString = require(lib_modname..'.FdfEdit.String')
---@type FdfLayerClass
FrameLib.FdfLayer = require(lib_modname..'.FdfEdit.Layer')

---@type SimpleBarClass
FrameLib.SimpleBar = require(lib_modname..'.Frame.SimpleBar')
---@type SimpleBaseFrameClass
FrameLib.SimpleBase = require(lib_modname..'.Frame.SimpleBase')
---@type SimpleButtonClass
FrameLib.SimpleButton = require(lib_modname..'.Frame.SimpleButton')
---@type SimpleClickerClass
FrameLib.SimpleClicker = require(lib_modname..'.Frame.SimpleClicker')
FrameLib.SimpleClicker.Init()
---@type SimpleImageClass
FrameLib.SimpleImage = require(lib_modname..'.Frame.SimpleImage')
---@type SimpleTrackerClass
FrameLib.SimpleTracker = require(lib_modname..'.Frame.SimpleTracker')
FrameLib.SimpleTracker.Init(0.1)


Lib.finish()

return FrameLib