local FdfEdit = {}

FdfEdit.File = require('compiletime.FdfEdit.FdfFile')

-- Objects
FdfEdit.Backdrop = require('compiletime.FdfEdit.Objects.FdfBackdrop')
FdfEdit.SimpleFrame = require('compiletime.FdfEdit.Objects.FdfSimpleFrame')
FdfEdit.SimpleButton = require('compiletime.FdfEdit.Objects.FdfSimpleButton')
FdfEdit.Text = require('compiletime.FdfEdit.Objects.FdfText')

-- Subobjects
FdfEdit.SimpleString = require('compiletime.FdfEdit.Subobjects.FdfSimpleString')
FdfEdit.SimpleTexture = require('compiletime.FdfEdit.Subobjects.FdfSimpleTexture')

return FdfEdit