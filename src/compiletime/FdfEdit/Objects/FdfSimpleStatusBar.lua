--=========
-- Include
--=========

local Class = require(Lib.Class)

---@type FdfObjectClass
local FdfObject = require('compiletime.FdfEdit.FdfObject')
---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfSimpleStatusBar = Class.new('FdfSimpleStatusBar', FdfObject)
---@class FdfSimpleStatusBar : FdfObject
local public = FdfSimpleStatusBar.public
---@class FdfSimpleStatusBarClass : FdfObjectClass
local static = FdfSimpleStatusBar.static
---@type FdfSimpleStatusBarClass
local override = FdfSimpleStatusBar.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfSimpleStatusBar | nil
---@return FdfSimpleStatusBar
function override.new(name, child)
    local instance = child or Class.allocate(FdfSimpleStatusBar)
    instance = FdfObject.new(name, 'SIMPLESTATUSBAR', instance)

    return instance
end

static.Field = {}
static.Field.Anchor = FdfField.new('Anchor', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.SetAllPoints = FdfField.new('SetAllPoints', 'string', FdfField.SerialFunc.EMPTY)
static.Field.Width = FdfField.new('Width', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Height = FdfField.new('Height', 'number', FdfField.SerialFunc.NUMBER)
static.Field.BarTexture = FdfField.new('BarTexture', 'string', FdfField.SerialFunc.STRING)
static.Field.ChildFrames = FdfField.new('', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)

return static