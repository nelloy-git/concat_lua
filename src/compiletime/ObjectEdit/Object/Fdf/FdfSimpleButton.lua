--=========
-- Include
--=========

local Class = require('Utils.Class')

---@type FdfFieldClass
local FdfField = require('compiletime.ObjectEdit.FdfField')
---@type FdfObjectClass
local FdfObject = require('compiletime.ObjectEdit.FdfObject')

--=======
-- Class
--=======

local FdfSimpleButton = Class.newClass('FdfSimpleButton', FdfObject)

---@class FdfSimpleButton
local public = FdfSimpleButton.public
---@class FdfSimpleButtonClass
local static = FdfSimpleButton.static
---@type table
local override = FdfSimpleButton.override

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfSimpleButton
function override.new(name, instance_data)
    local instance = instance_data or Class.newInstanceData(FdfSimpleButton)
    instance = FdfObject.new('SIMPLEBUTTON', name, instance)

    return instance
end

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.serialize_NoArgs)
static.Width = FdfField.new('Width', 'number', FdfField.serialize_Number)
static.Height = FdfField.new('Height', 'number', FdfField.serialize_Number)
static.String = FdfField.new('String', getClassName(FdfObject), FdfField.serialize_Subobject)
static.Texture = FdfField.new('Texture', getClassName(FdfObject), FdfField.serialize_Subobject)

--========
-- Public
--========

function public:free()
    freeInstanceData(self)
end


return FdfSimpleButton