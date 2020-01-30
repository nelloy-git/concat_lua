--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FdfObjectClass
local FdfObject = require('compiletime.FdfEdit.FdfObject')
---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfGluebutton = Class.new('FdfGluebutton', FdfObject)
---@class FdfGluebutton : FdfObject
local public = FdfGluebutton.public
---@class FdfGluebuttonClass : FdfObjectClass
local static = FdfGluebutton.static
---@type FdfGluebuttonClass
local override = FdfGluebutton.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfGluebutton | nil
---@return FdfGluebutton
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfGluebutton)
    instance = FdfObject.new(name, 'GLUEBUTTON', instance)

    return instance
end

static.Field = {}
static.Field.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SerialFunc.EMPTY)
static.Field.Width = FdfField.new('Width', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Height = FdfField.new('Height', 'number', FdfField.SerialFunc.NUMBER)
-- "AUTOTRACK|HIGHLIGHTONFOCUS|HIGHLIGHTONMOUSEOVER"
static.Field.ControlStype = FdfField.new('ControlStype', 'string', FdfField.SerialFunc.STRING)
static.Field.ControlBackdrop = FdfField.new('ControlBackdrop', 'string', FdfField.SerialFunc.STRING)
static.Field.ControlPushedBackdrop = FdfField.new('ControlPushedBackdrop', 'string', FdfField.SerialFunc.STRING)
static.Field.ControlDisabledBackdrop = FdfField.new('ControlDisabledBackdrop', 'string', FdfField.SerialFunc.STRING)
static.Field.ControlDisabledPushedBackdrop = FdfField.new('ControlDisabledPushedBackdrop', 'string', FdfField.SerialFunc.STRING)
static.Field.ControlMouseOverHighlight = FdfField.new('ControlMouseOverHighlight', 'string', FdfField.SerialFunc.STRING)
static.Field.ControlFocusHighlight = FdfField.new('ControlFocusHighlight', 'string', FdfField.SerialFunc.STRING)
static.Field.ChildFrames = FdfField.new('', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)

return static