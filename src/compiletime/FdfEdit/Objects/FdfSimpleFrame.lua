--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FdfObjectClass
local FdfObject = require('compiletime.FdfEdit.FdfObject')
---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfSimpleFrame = Class.new('FdfSimpleFrame', FdfObject)
---@class FdfSimpleFrame
local public = FdfSimpleFrame.public
---@class FdfSimpleFrameClass
local static = FdfSimpleFrame.static
---@type FdfSimpleFrameClass
local override = FdfSimpleFrame.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfSimpleFrame | nil
---@return FdfSimpleFrame
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfSimpleFrame)
    instance = FdfObject.new(name, 'SIMPLEFRAME', instance)

    return instance
end

static.Field = {}
static.Field.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SerialFunc.EMPTY)
static.Field.Width = FdfField.new('Width', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Height = FdfField.new('Height', 'number', FdfField.SerialFunc.NUMBER)
static.Field.String = FdfField.new('String', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)
static.Field.Texture = FdfField.new('Texture', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)
static.Field.ChildFrames = FdfField.new('', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)

return static