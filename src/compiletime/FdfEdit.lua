---@class FdfEdit
local FdfEdit = {}

---@type FdfFileClass
FdfEdit.File = require('compiletime.FdfEdit.FdfFile')

-- Objects
----@type FdfBackdropClass
FdfEdit.Backdrop = require('compiletime.FdfEdit.Objects.FdfBackdrop')
----@type FdfHighlightClass
FdfEdit.Highlight = require('compiletime.FdfEdit.Objects.FdfHighlight')
----@type FdfButtonClass
FdfEdit.GlueButton = require('compiletime.FdfEdit.Objects.FdfGlueButton')
---@type FdfSimpleFrameClass
FdfEdit.SimpleFrame = require('compiletime.FdfEdit.Objects.FdfSimpleFrame')
---@type FdfSimpleButtonClass
FdfEdit.SimpleButton = require('compiletime.FdfEdit.Objects.FdfSimpleButton')
---@type FdfSimpleStatusBarClass
FdfEdit.SimpleStatusBar = require('compiletime.FdfEdit.Objects.FdfSimpleStatusBar')
----@type FdfTextClass
FdfEdit.Text = require('compiletime.FdfEdit.Objects.FdfText')

-- Subobjects
---@type FdfSimpleStringClass
FdfEdit.SimpleString = require('compiletime.FdfEdit.Subobjects.FdfSimpleString')
---@type FdfSimpleTextureClass
FdfEdit.SimpleTexture = require('compiletime.FdfEdit.Subobjects.FdfSimpleTexture')
---@type FdfSimpleLayerClass
FdfEdit.SimpleLayer = require('compiletime.FdfEdit.Subobjects.FdfSimpleLayer')

return FdfEdit