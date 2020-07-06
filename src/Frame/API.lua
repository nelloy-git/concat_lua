--=========
-- Include
--=========

---@type FrameClass
local Frame = require('Frame.Frame')
---@type FrameTypeClass
local FrameType = require('Frame.Type')

---@type SimpleButtonTypeClass
local SimpleButtonType = require('Frame.Type.SimpleButton')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleLayerTypeClass
local SimpleLayerType = require('Frame.Type.SimpleLayer')
---@type SimpleStatusBarTypeClass
local SimpleStatusBarType = require('Frame.Type.SimpleStatusBar')
---@type SimpleStringTypeClass
local SimpleStringType = require('Frame.Type.SimpleString')
---@type SimpleTextureTypeClass
local SimpleTextureType = require('Frame.Type.SimpleTexture')

---@type SimpleButtonClass
local SimpleButton = require('Frame.Default.SimpleButton')
local SimpleButtonEvent = SimpleButton.ActionType
---@type SimpleImageClass
local SimpleImage = require('Frame.Default.SimpleImage')
---@type SimpleStatusBarClass
local SimpleStatusBar = require('Frame.Default.SimpleStatusBar')
---@type SimpleTextClass
local SimpleText = require('Frame.Default.SimpleText')

--=============
--     API
--=============

---@class FrameAPI
local FrameAPI = {}

-- Base classes

FrameAPI.Frame = Frame
FrameAPI.Type = FrameType

-- Default types

FrameAPI.SimpleButtonType = SimpleButtonType
FrameAPI.SimpleFrameType = SimpleFrameType
FrameAPI.SimpleLayerType = SimpleLayerType
FrameAPI.SimpleStatusBarType = SimpleStatusBarType
FrameAPI.SimpleStringType = SimpleStringType
FrameAPI.SimpleTextureType = SimpleTextureType

-- Default frames

FrameAPI.SimpleButton = SimpleButton
FrameAPI.SimpleImage = SimpleImage
FrameAPI.SimpleStatusBar = SimpleStatusBar
FrameAPI.SimpleText = SimpleText

-- Other

FrameAPI.SimpleButtonEvent = SimpleButtonEvent

return FrameAPI