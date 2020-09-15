---@class FrameLib
local FrameLib = {}
Lib.start('FrameLib', {
    Class = Lib.load(LibList.ClassLib) or error(''),
    Handle = Lib.load(LibList.HandleLib) or error(''),
    Types = Lib.load(LibList.TypesLib) or error(''),
    Utils = Lib.load(LibList.UtilsLib) or error(''),
})
local path = Lib.curPath()

-- Check Warcraft version.
if not IsCompiletime() then
    if not BlzFrameGetChild then
        error('FrameLib: BlzFrameGetChild function wan not found.')
    end
end

--=====
-- API
--=====

--========
-- Screen
--========

---@type FrameScreen
FrameLib.Screen = require(path..'Screen') or error('')

----------------
-- FdfGenerator
----------------

FrameLib.Fdf = {}

---@type FdfBaseClass
FrameLib.Fdf.Base = require(path..'Fdf.Base') or error('')

-- Simple

FrameLib.Fdf.Simple = {}
---@type FdfSimpleFrameClass
FrameLib.Fdf.Simple.Frame = require(path..'Fdf.Simple.Frame') or error('')
---@type FdfSimpleLayerClass
FrameLib.Fdf.Simple.Layer = require(path..'Fdf.Simple.Layer') or error('')
---@type FdfSimpleStatusBarClass
FrameLib.Fdf.Simple.StatusBar = require(path..'Fdf.Simple.StatusBar') or error('')
---@type FdfSimpleStringClass
FrameLib.Fdf.Simple.String = require(path..'Fdf.Simple.String') or error('')
---@type FdfTextureClass
FrameLib.Fdf.Simple.Texture = require(path..'Fdf.Simple.Texture') or error('')

-- Normal

FrameLib.Fdf.Normal = {}
---@type FdfBackdropClass
FrameLib.Fdf.Normal.Backdrop = require(path..'Fdf.Normal.Backdrop') or error('')
---@type FdfGlueTextButtonClass
FrameLib.Fdf.Normal.GlueTextButton = require(path..'Fdf.Normal.GlueTextButton') or error('')
---@type FdfHighlightClass
FrameLib.Fdf.Normal.Highlight = require(path..'Fdf.Normal.Highlight') or error('')
---@type FdfTextClass
FrameLib.Fdf.Normal.Text = require(path..'Fdf.Normal.Text') or error('')

----------
-- Frames
----------

-- Simple

FrameLib.Simple = {}
---@type FrameSimpleImageClass
FrameLib.Simple.Image = require(path..'Simple.Image') or error('')
---@type FrameSimpleStatusBarClass
FrameLib.Simple.StatusBar = require(path..'Simple.StatusBar') or error('')
---@type FrameSimpleStringClass
FrameLib.Simple.String = require(path..'Simple.String') or error('')
---@type FrameSimpleTextClass
FrameLib.Simple.Text = require(path..'Simple.Text') or error('')
---@type FrameSimpleTextureClass
FrameLib.Simple.Texture = require(path..'Simple.Texture') or error('')

-- Normal

FrameLib.Normal = {}
---@type FrameNormalButtonClass
FrameLib.Normal.Button = require(path..'Normal.Button') or error('')
---@type FrameNormalImageClass
FrameLib.Normal.Image = require(path..'Normal.Image') or error('')
---@type FrameNormalTextClass
FrameLib.Normal.Text = require(path..'Normal.Text') or error('')

--========
-- Origin
--========

FrameLib.Origin = {}
---@type FrameOriginChatBox
FrameLib.Origin.ChatBox = require(path..'Origin.ChatBox') or error('')
--- Can not be moved outside of default 0.8x0.6 box.
---@type FrameOriginChatEditBox
FrameLib.Origin.ChatEditBox = require(path..'Origin.ChatEditBox') or error('')
---@type FrameOriginInventory
FrameLib.Origin.Inventory = require(path..'Origin.Inventory') or error('')
---@type FrameOriginMinimap
FrameLib.Origin.Minimap = require(path..'Origin.Minimap') or error('')
---@type FrameOriginPortrait
FrameLib.Origin.Portrait = require(path..'Origin.Portrait') or error('')
---@type table<number,FrameOriginSkillButton>
FrameLib.Origin.SkillButton = require(path..'Origin.SkillButton') or error('')

Lib.finish()

return FrameLib