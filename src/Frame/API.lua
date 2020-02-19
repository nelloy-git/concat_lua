--=========
-- Include
--=========

---@type Frame
local Frame = require('Frame.Frame')

---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleButtonTypeClass
local SimpleButtonType = require('Frame.Type.SimpleButton')
---@type SimpleTextTypeClass
local SimpleTextType = require('Frame.Type.SimpleText')
---@type SimpleStatusBarTypeClass
local SimpleStatusBarType = require('Frame.Type.SimpleStatusBar')
---@type BackdropTypeClass
local BackdropType = require('Frame.Type.Backdrop')
---@type GlueButtonTypeClass
local GlueButtonType = require('Frame.Type.GlueButton')
---@type HighlightTypeClass
local HighlightType = require('Frame.Type.Highlight')
---@type TextTypeClass
local TextType = require('Frame.Type.Text')

---@type SimpleFrameClass
local SimpleFrame = require('Frame.Default.SimpleFrame')
---@type SimpleButtonClass
local SimpleButton = require('Frame.Default.SimpleButton')
---@type SimpleTextClass
local SimpleText = require('Frame.Default.SimpleText')
---@type SimpleStatusBarClass
local SimpleStatusBar = require('Frame.Default.SimpleStatusBar')
---@type BackdropClass
local Backdrop = require('Frame.Default.Backdrop')
---@type GlueButtonClass
local GlueButton = require('Frame.Default.GlueButton')
---@type HighlightClass
local Highlight = require('Frame.Default.Highlight')
---@type TextClass
local Text = require('Frame.Default.Text')

--=============
--     API
--=============

---@class FrameAPI
local FrameAPI = {}

FrameAPI.Frame = Frame

-- Default types

FrameAPI.SimpleFrameType = SimpleFrameType
FrameAPI.SimpleButtonType = SimpleButtonType
FrameAPI.SimpleTextType = SimpleTextType
FrameAPI.SimpleStatusBarType = SimpleStatusBarType

FrameAPI.BackdropType = BackdropType
FrameAPI.GlueButtonType = GlueButtonType
FrameAPI.HighlightType = HighlightType
FrameAPI.TextType = TextType

-- Default frames

FrameAPI.SimpleFrame = SimpleFrame
FrameAPI.SimpleButton = SimpleButton
FrameAPI.SimpleText = SimpleText
FrameAPI.SimpleStatusBar = SimpleStatusBar

FrameAPI.Backdrop = Backdrop
FrameAPI.GlueButton = GlueButton
FrameAPI.Highlight = Highlight
FrameAPI.Text = Text

return FrameAPI