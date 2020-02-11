--=========
-- Include
--=========

---@type Frame
local Frame = require('Frame.Frame')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleButtonTypeClass
local SimpleButtonType = require('Frame.Type.SimpleButton')
---@type SimpleButtonTypeClass
local SimpleTextType = require('Frame.Type.SimpleText')
---@type SimpleFrameClass
local SimpleFrame = require('Frame.Default.SimpleFrame')
---@type SimpleButtonClass
local SimpleButton = require('Frame.Default.SimpleButton')
---@type SimpleTextClass
local SimpleText = require('Frame.Default.SimpleText')

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

-- Default frames

FrameAPI.SimpleFrame = SimpleFrame
FrameAPI.SimpleButton = SimpleButton
FrameAPI.SimpleText = SimpleText


return FrameAPI