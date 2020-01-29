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

local FdfButton = Class.new('FdfButton', FdfObject)
---@class FdfButton : FdfObject
local public = FdfButton.public
---@class FdfButtonClass : FdfObjectClass
local static = FdfButton.static
---@type FdfButtonClass
local override = FdfButton.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfButton | nil
---@return FdfButton
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfButton)
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

return FdfButton