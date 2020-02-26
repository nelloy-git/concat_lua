--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FdfSubobjectClass
local FdfSubobject = require('compiletime.FdfEdit.FdfSubobject')
---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfSimpleString = Class.new('FdfSimpleString', FdfSubobject)
---@class FdfSimpleString : FdfSubobject
local public = FdfSimpleString.public
---@class FdfSimpleStringClass : FdfSubobjectClass
local static = FdfSimpleString.static
---@type FdfSimpleStringClass
local override = FdfSimpleString.override
local private = {}

--=========
-- Static
--=========

---@param name string

---@param child_instance FdfSimpleString | nil
---@return FdfSimpleString
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfSimpleString, child_instance)
    instance = FdfSubobject.new(name, 'String', instance)

    return instance
end

static.Field = {}
static.Field.Anchor = FdfField.new('Anchor', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.SetAllPoints = FdfField.new('SetAllPoints', 'string', FdfField.SerialFunc.EMPTY)
static.Field.SetPoint = {}
static.Field.SetPoint[1] = FdfField.new('SetPoint', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.SetPoint[2] = FdfField.new('SetPoint', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.SetPoint[3] = FdfField.new('SetPoint', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.SetPoint[4] = FdfField.new('SetPoint', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.Width = FdfField.new('Width', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Height = FdfField.new('Height', 'number', FdfField.SerialFunc.NUMBER)
--- Example simple_string:setField(FdfSimpleString.Font, {"InfoPanelTextFont", 0.009})
static.Field.Font = FdfField.new('Font', 'table', FdfField.SerialFunc.LIST_WITH_QUOTES)
--static.Field.FontColor = FdfField.new('FontColor', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
--static.Field.FontShadowColor = FdfField.new('FontShadowColor', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
--static.Field.FontShadowOffset = FdfField.new('FontShadowOffset', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)

return static