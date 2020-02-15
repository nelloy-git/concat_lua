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

local FdfBackdrop = Class.new('FdfBackdrop', FdfObject)
---@class FdfBackdrop : FdfObject
local public = FdfBackdrop.public
---@class FdfBackdropClass : FdfObjectClass
local static = FdfBackdrop.static
---@type FdfBackdropClass
local override = FdfBackdrop.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfBackdrop | nil
---@return FdfBackdrop
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfBackdrop)
    instance = FdfObject.new(name, 'BACKDROP', instance)

    return instance
end

static.Field = {}
static.Field.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SerialFunc.EMPTY)
static.Field.Width = FdfField.new('Width', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Height = FdfField.new('Height', 'number', FdfField.SerialFunc.NUMBER)
static.Field.TileBackground = FdfField.new('BackdropTileBackground', 'nil', FdfField.SerialFunc.EMPTY)
static.Field.Background = FdfField.new('BackdropBackground', 'string', FdfField.SerialFunc.STRING)
static.Field.CornerFlags = FdfField.new('BackdropCornerFlags', 'string', FdfField.SerialFunc.STRING)
static.Field.CornerSize = FdfField.new('BackdropCornerSize', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Insets = FdfField.new('BackdropBackgroundInsets', 'table', FdfField.SerialFunc.LIST)
static.Field.EdgeFile = FdfField.new('BackdropEdgeFile', 'string', FdfField.SerialFunc.STRING)
static.Field.BlendAll = FdfField.new('BackdropBlendAll', 'nil', FdfField.SerialFunc.EMPTY)
static.Field.ChildFrames = FdfField.new('', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)

return static