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

if not IsCompiletime() then
    local is_v1_32_7 = BlzFrameGetChild and true or false
    if not is_v1_32_7 then
        Lib.current().depencies.UtilsLib.DefaultLogger:err('FrameLib need at least 1.32.7 patch.')
        Lib.finish()
        return nil
    end
end

--=====
-- API
--=====

--============
-- Categories
--============

FrameLib.Fdf = {}
---@type FdfFileClass
FrameLib.Fdf.File = require(lib_modname..'.Fdf.File')
FrameLib.Fdf.File.init('Default')

FrameLib.Fdf.Simple = {}
FrameLib.Fdf.Normal = {}

FrameLib.Frame = {}
FrameLib.Frame.Simple = {}
FrameLib.Frame.Normal = {}

FrameLib.Screen = {}

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

--=================
-- FdfNormalFrames
--=================


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
    --test:setFile('', 0, true)
    test:setPos(0.2, 0.3)
end
]]

--==============
-- NormalFrames
--==============

---@type FrameNormalBaseClass
FrameLib.Frame.Normal.Base = require(lib_modname..'.Normal.Base')
---@type FrameNormalImageClass
FrameLib.Frame.Normal.Image = require(lib_modname..'.Normal.Image')
---@type FrameNormalButtonClass
FrameLib.Frame.Normal.Button = require(lib_modname..'.Normal.Button')
---@type FrameNormalButtonDefaultClass
FrameLib.Frame.Normal.ButtonDefault = require(lib_modname..'.Normal.ButtonDefault')

-- Example
--[[
if not IsCompiletime() then
    local test = FrameLib.Frame.Normal.Image.new()
    --test:setFile('', 0, true)
    test:setPos(-0.1, 0.3)
    test:setSize(0.04, 0.04)
end
]]

--========
-- Screen
--========

---@type FrameScreen
local Screen = require(lib_modname..'.Screen')
FrameLib.Screen.addResolutionChangedAction = Screen.addResolutionChangedAction

Lib.finish()

return FrameLib