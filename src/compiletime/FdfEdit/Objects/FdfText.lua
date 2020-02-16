--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FdfObjectClass
local FdfObject = require('compiletime.FdfEdit.FdfObject')
---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfText = Class.new('FdfText', FdfObject)
---@class FdfText : FdfObject
local public = FdfText.public
---@class FdfTextClass : FdfObjectClass
local static = FdfText.static
---@type FdfTextClass
local override = FdfText.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfText | nil
---@return FdfText
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfText)
    instance = FdfObject.new(name, 'TEXT', instance)

    return instance
end

static.Field = {}
static.Field.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SerialFunc.EMPTY)
static.Field.FontFlags = FdfField.new('FontFlags', 'string', FdfField.SerialFunc.STRING)
static.Field.FrameFont = FdfField.new('FrameFont', 'table', FdfField.SerialFunc.LIST_WITH_QUOTES)
static.Field.FontColor = FdfField.new('FontColor', 'table', FdfField.SerialFunc.LIST)
static.Field.FontShadowColor = FdfField.new('FontShadowColor', 'table', FdfField.SerialFunc.LIST)
static.Field.FontShadowOffset = FdfField.new('FontShadowOffset', 'table', FdfField.SerialFunc.LIST)

return static