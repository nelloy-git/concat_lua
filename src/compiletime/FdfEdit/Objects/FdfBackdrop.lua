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

print(FdfField.SerialFunc.NUMBER)
static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SerialFunc.EMPTY)
static.TileBackground = FdfField.new('BackdropTileBackground', 'nil', FdfField.SerialFunc.EMPTY)
static.Background = FdfField.new('BackdropBackground', 'string', FdfField.SerialFunc.STRING)
static.CornerFlags = FdfField.new('BackdropCornerFlags', 'string', FdfField.SerialFunc.STRING)
static.CornerSize = FdfField.new('BackdropCornerSize', 'number', FdfField.SerialFunc.NUMBER)
static.BackgroundInsets = FdfField.new('BackdropBackgroundInsets', 'table', FdfField.SerialFunc.LIST)
static.EdgeFile = FdfField.new('BackdropEdgeFile', 'string', FdfField.SerialFunc.STRING)
static.BlendAll = FdfField.new('BackdropBlendAll', 'nil', FdfField.SerialFunc.EMPTY)

return FdfBackdrop