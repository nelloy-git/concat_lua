--=========
-- Include
--=========

local Class = require('Utils.Class')
local FdfObject = require('compiletime.FdfEdit.FdfObject')

---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfBackdrop = Class.newClass('FdfBackdrop', FdfObject)
---@class FdfBackdrop : FdfObject
local public = FdfBackdrop.public
---@class FdfBackdropClass : FdfObjectClass
local static = FdfBackdrop.static
local override = FdfBackdrop.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_data FdfBackdrop | nil
---@return FdfBackdrop
function override.new(name, child_data)
    local instance = Class.newInstanceData(FdfBackdrop, child_data)
    instance = FdfObject.new(name, 'BACKDROP', instance)

    return instance
end

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SERIAL_DATA.EMPTY)
static.TileBackground = FdfField.new('BackdropTileBackground', 'nil', FdfField.SERIAL_DATA.EMPTY)
static.Background = FdfField.new('BackdropBackground', 'string', FdfField.SERIAL_DATA.STRING)
static.CornerFlags = FdfField.new('BackdropCornerFlags', 'string', FdfField.SERIAL_DATA.STRING)
static.CornerSize = FdfField.new('BackdropCornerSize', 'number', FdfField.SERIAL_DATA.NUMBER)
static.BackgroundInsets = FdfField.new('BackdropBackgroundInsets', 'table', FdfField.SERIAL_DATA.LIST)
static.EdgeFile = FdfField.new('BackdropEdgeFile', 'string', FdfField.SERIAL_DATA.STRING)
static.BlendAll = FdfField.new('BackdropBlendAll', 'nil', FdfField.SERIAL_DATA.EMPTY)

return FdfBackdrop