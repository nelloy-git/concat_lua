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

local FdfSimpleButton = Class.new('FdfSimpleButton', FdfObject)
---@class FdfSimpleButton : FdfObject
local public = FdfSimpleButton.public
---@class FdfSimpleButtonClass : FdfObjectClass
local static = FdfSimpleButton.static
---@type FdfSimpleButtonClass
local override = FdfSimpleButton.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfSimpleButton | nil
---@return FdfSimpleButton
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfSimpleButton)
    instance = FdfObject.new(name, 'SIMPLEBUTTON', instance)

    return instance
end

static.Field = {}
static.Field.SetAllPoints = FdfField.new('SetAllPoints', 'string', FdfField.SerialFunc.EMPTY)
static.Field.Anchor = FdfField.new('Anchor', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.Width = FdfField.new('Width', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Height = FdfField.new('Height', 'number', FdfField.SerialFunc.NUMBER)
static.Field.ChildFrames = FdfField.new('', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)

return static