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

static.TileBackground = FdfField.new('BackdropTileBackground', 'nil')
static.Background = FdfField.new('BackdropBackground', 'string')
static.CornerFlags = FdfField.new('BackdropCornerFlags', 'string')
static.CornerSize = FdfField.new('BackdropCornerSize', 'number')
static.BackgroundInsets = FdfField.new('BackdropBackgroundInsets', 'table')
static.EdgeFile = FdfField.new('BackdropEdgeFile', 'string')
static.BlendAll = FdfField.new('BackdropBlendAll', 'nil')

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end


return FdfBackdrop