local FdfEdit = {}

---@type FdfFileClass
FdfEdit.File = require('compiletime.FdfEdit.FdfFile')

-- Objects
---@type FdfBackdropClass
FdfEdit.Backdrop = require('compiletime.FdfEdit.Objects.FdfBackdrop')
---@type FdfSimpleFrameClass
FdfEdit.SimpleFrame = require('compiletime.FdfEdit.Objects.FdfSimpleFrame')
---@type FdfSimpleButtonClass
FdfEdit.SimpleButton = require('compiletime.FdfEdit.Objects.FdfSimpleButton')
---@type FdfTextClass
FdfEdit.Text = require('compiletime.FdfEdit.Objects.FdfText')

-- Subobjects
---@type FdfSimpleStringClass
FdfEdit.SimpleString = require('compiletime.FdfEdit.Subobjects.FdfSimpleString')
---@type FdfSimpleTextureClass
FdfEdit.SimpleTexture = require('compiletime.FdfEdit.Subobjects.FdfSimpleTexture')

return FdfEdit