--=========
-- Include
--=========

---@type FdfFieldClass
local FdfField = require('compiletime.ObjectEdit.FdfField')
---@type FdfObjectClass
local FdfObject = require('compiletime.ObjectEdit.FdfObject')

--=======
-- Class
--=======

---@type FdfBackdropClass
local FdfBackdrop = newClass('FdfBackdrop', FdfObject)

---@class FdfBackdrop
local public = FdfBackdrop.public
---@class FdfBackdropClass
local static = FdfBackdrop.static
---@type table
local override = FdfBackdrop.override
---@type table(FdfBackdrop, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfBackdrop
function override.new(name, instance_data)
    local instance = instance_data or newInstanceData(FdfBackdrop)
    instance = FdfObject.new('BACKDROP', name, nil)

    return instance
end

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.serialize_NoArgs)
static.TileBackground = FdfField.new('BackdropTileBackground', 'nil', FdfField.serialize_NoArgs)
static.Background = FdfField.new('BackdropBackground', 'string', FdfField.serialize_String)
static.CornerFlags = FdfField.new('BackdropCornerFlags', 'string', FdfField.serialize_String)
static.CornerSize = FdfField.new('BackdropCornerSize', 'number', FdfField.serialize_Number)
static.BackgroundInsets = FdfField.new('BackdropBackgroundInsets', 'table', FdfField.serialize_List)
static.EdgeFile = FdfField.new('BackdropEdgeFile', 'string', FdfField.serialize_String)
static.BlendAll = FdfField.new('BackdropBlendAll', 'nil', FdfField.serialize_NoArgs)

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end


return FdfBackdrop