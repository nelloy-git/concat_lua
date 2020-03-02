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

---@type SimpleImageClass
local SimpleImage = require('Frame.Default.SimpleImage')
---@type SimpleButtonClass
local SimpleButton = require('Frame.Default.SimpleButton')
local SimpleButtonEvent = SimpleButton.ActionType
---@type SimpleStatusBarClass
local SimpleStatusBar = require('Frame.Default.SimpleStatusBar')

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

FrameAPI.SimpleImage = SimpleImage
FrameAPI.SimpleButton = SimpleButton
FrameAPI.SimpleStatusBar = SimpleStatusBar

-- Other

FrameAPI.SimpleButtonEvent = SimpleButtonEvent

return FrameAPI