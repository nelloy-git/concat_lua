--=========
-- Include
--=========

local Class = require('Utils.Class')
local FdfSubobject = require('compiletime.FdfEdit.FdfSubobject')

---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfSimpleString = Class.newClass('FdfSimpleString', FdfSubobject)
---@class FdfSimpleString : FdfSubobject
local public = FdfSimpleString.public
---@class FdfSimpleStringClass : FdfSubobjectClass
local static = FdfSimpleString.static
local override = FdfSimpleString.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_data FdfSimpleString | nil
---@return FdfSimpleString
function override.new(name, child_data)
    local instance = Class.newInstanceData(FdfSimpleString, child_data)
    instance = FdfSubobject.new(name, 'String', instance)

    return instance
end

static.Anchor = FdfField.new('Anchor', 'table', FdfField.SERIAL_DATA.LIST)
static.Height = FdfField.new('Height', 'number', FdfField.SERIAL_DATA.NUMBER)
static.Width = FdfField.new('Width', 'number', FdfField.SERIAL_DATA.NUMBER)
--- Example simple_string:setField(FdfSimpleString.Font, {"InfoPanelTextFont", 0.009})
static.Font = FdfField.new('Font', 'table', FdfField.SERIAL_DATA.LIST_WITH_QUOTES)

return FdfSimpleString