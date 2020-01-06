--=========
-- Include
--=========

local Class = require('utils.Class')
local FdfObject = require('compiletime.FdfEdit.FdfObject')

---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfSimpleButton = Class.newClass('FdfSimpleButton', FdfObject)
---@class FdfSimpleButton : FdfObject
local public = FdfSimpleButton.public
---@class FdfSimpleButtonClass : FdfObjectClass
local static = FdfSimpleButton.static
local override = FdfSimpleButton.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_data FdfSimpleButton | nil
---@return FdfSimpleButton
function override.new(name, child_data)
    local instance = Class.newInstanceData(FdfSimpleButton, child_data)
    instance = FdfObject.new(name, 'SIMPLEBUTTON', instance)

    return instance
end

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SERIAL_DATA.EMPTY)
static.Width = FdfField.new('Width', 'number', FdfField.SERIAL_DATA.NUMBER)
static.Height = FdfField.new('Height', 'number', FdfField.SERIAL_DATA.NUMBER)
static.String = FdfField.new('String', 'table', FdfField.SERIAL_DATA.SUBOBJECT_LIST)
static.Texture = FdfField.new('Texture', 'table', FdfField.SERIAL_DATA.SUBOBJECT_LIST)

return FdfSimpleButton