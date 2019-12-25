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

---@type FdfSimpleButtonClass
local FdfSimpleButton = newClass('FdfSimpleButton', FdfObject)

---@class FdfSimpleButton
local public = FdfSimpleButton.public
---@class FdfSimpleButtonClass
local static = FdfSimpleButton.static
---@type table
local override = FdfSimpleButton.override
---@type table(FdfSimpleButton, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfSimpleButton
function override.new(name, instance_data)
    local instance = instance_data or newInstanceData(FdfSimpleButton)
    instance = FdfObject.new('SIMPLEBUTTON', name, instance)

    return instance
end

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.serialize_NoArgs)
static.Width = FdfField.new('Width', 'number', FdfField.serialize_Number)
static.Height = FdfField.new('Height', 'number', FdfField.serialize_Number)
static.String = FdfField.new('', 'table', FdfField.serialize_SubobjectList)
static.Texture = FdfField.new('', 'table', FdfField.serialize_SubobjectList)

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end


return FdfSimpleButton