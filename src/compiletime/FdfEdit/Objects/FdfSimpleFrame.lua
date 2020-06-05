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

local FdfSimpleFrame1 = Class.new('FdfSimpleFrame1', FdfObject)
---@class FdfSimpleFrame1
local public = FdfSimpleFrame1.public
---@class FdfSimpleFrame1Class
local static = FdfSimpleFrame1.static
---@type FdfSimpleFrame1Class
local override = FdfSimpleFrame1.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfSimpleFrame1 | nil
---@return FdfSimpleFrame1
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfSimpleFrame1)
    instance = FdfObject.new(name, 'SIMPLEFRAME', instance)

    return instance
end

static.Field = {}
static.Field.SetAllPoints = FdfField.new('SetAllPoints', 'string', FdfField.SerialFunc.EMPTY)
static.Field.Anchor = FdfField.new('Anchor', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.Width = FdfField.new('Width', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Height = FdfField.new('Height', 'number', FdfField.SerialFunc.NUMBER)
static.Field.ChildFrames = FdfField.new('', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)

return static