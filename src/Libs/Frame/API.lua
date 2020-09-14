---@class FrameLib
local FrameLib = {}
Lib.start('FrameLib', {
    Class = Lib.load(LibList.ClassLib) or error(''),
    Handle = Lib.load(LibList.HandleLib) or error(''),
    Type = Lib.load(LibList.TypesLib) or error(''),
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

--============
-- Categories
--============


--FrameLib.Fdf.Normal = {}

FrameLib.Frame = {}
FrameLib.Frame.Simple = {}
FrameLib.Frame.Normal = {}

FrameLib.Screen = {}

-- Runtime only.
if not IsCompiletime() then
    FrameLib.Origin = {}
end

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
FrameLib.Fdf.Normal.Backdrop = require(path..'Fdf.Normal.Backdrop')
---@type FdfGlueTextButtonClass
FrameLib.Fdf.Normal.GlueTextButton = require(path..'Fdf.Normal.GlueTextButton')
---@type FdfHighlightClass
FrameLib.Fdf.Normal.Highlight = require(path..'Fdf.Normal.Highlight')
---@type FdfTextClass
FrameLib.Fdf.Normal.Text = require(path..'Fdf.Normal.Text')

----------
-- Frames
----------

-- Simple

FrameLib.Simple = {}
---@type FrameSimpleImageClass
FrameLib.Simple.Image = require(path..'Simple.Image')
---@type FrameSimpleStatusBarClass
FrameLib.Simple.StatusBar = require(path..'Simple.StatusBar')
---@type FrameSimpleStringClass
FrameLib.Simple.String = require(path..'Simple.String')
---@type FrameSimpleTextClass
FrameLib.Simple.Text = require(path..'Simple.Text')
---@type FrameSimpleTextureClass
FrameLib.Simple.Texture = require(path..'Simple.Texture')

-- Normal

FrameLib.Normal = {}
---@type FrameNormalButtonClass
FrameLib.Normal.Button = require(path..'Normal.Button')
---@type FrameNormalButtonDefaultClass
FrameLib.Normal.ButtonDefault = require(path..'Normal.ButtonDefault')
---@type FrameNormalImageClass
FrameLib.Normal.Image = require(path..'Normal.Image')
---@type FrameNormalTextClass
FrameLib.Normal.Text = require(path..'Normal.Text')

--[[
--==============
-- SimpleFrames
--==============

---@type FrameSimpleImageClass
FrameLib.Frame.Simple.Image = require(path..'Simple.Image')
---@type FrameSimpleStatusBarClass
FrameLib.Frame.Simple.StatusBar = require(path..'Simple.StatusBar')
---@type FrameSimpleTextClass
FrameLib.Frame.Simple.Text = require(path..'Simple.Text')

--==============
-- NormalFrames
--==============

--========
-- Screen
--========

---@type FrameScreen
local Screen = require(path..'.Screen')
FrameLib.Screen.getX0 = Screen.getX0
FrameLib.Screen.addResolutionChangedAction = Screen.addResolutionChangedAction

--========
-- Origin
--========

local ChatBox = require(path..'Origin.ChatBox')
local ChatEditBox = require(path..'Origin.ChatEditBox')
local Inventory = require(path..'Origin.Inventory')
local Minimap = require(path..'Origin.Minimap')
local Portrait = require(path..'Origin.Portrait')
local SkillButton = require(path..'Origin.SkillButton')
if not IsCompiletime() then
    ---@type FrameOriginChatBox
    FrameLib.Origin.ChatBox = ChatBox
    --- Can not be moved outside of default 0.8x0.6 box.
    ---@type FrameOriginChatEditBox
    FrameLib.Origin.ChatEditBox = ChatEditBox
    ---@type FrameOriginInventory
    FrameLib.Origin.Inventory = Inventory
    ---@type FrameOriginMinimap
    FrameLib.Origin.Minimap = Minimap
    ---@type FrameOriginPortrait
    FrameLib.Origin.Portrait = Portrait
    ---@type table<number,FrameOriginSkillButton>
    FrameLib.Origin.SkillButton = SkillButton
end
]]
Lib.finish()

return FrameLib