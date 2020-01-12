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

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SERIAL_DATA.EMPTY)
static.Width = FdfField.new('Width', 'number', FdfField.SERIAL_DATA.NUMBER)
static.Height = FdfField.new('Height', 'number', FdfField.SERIAL_DATA.NUMBER)
static.String = FdfField.new('String', 'table', FdfField.SERIAL_DATA.SUBOBJECT_LIST)
static.Texture = FdfField.new('Texture', 'table', FdfField.SERIAL_DATA.SUBOBJECT_LIST)

return FdfSimpleButton