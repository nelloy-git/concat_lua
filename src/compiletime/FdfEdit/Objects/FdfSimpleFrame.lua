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

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SERIAL_DATA.EMPTY)
static.Width = FdfField.new('Width', 'number', FdfField.SERIAL_DATA.NUMBER)
static.Height = FdfField.new('Height', 'number', FdfField.SERIAL_DATA.NUMBER)
static.String = FdfField.new('String', 'table', FdfField.SERIAL_DATA.SUBOBJECT_LIST)
static.Texture = FdfField.new('Texture', 'table', FdfField.SERIAL_DATA.SUBOBJECT_LIST)

return FdfSimpleFrame