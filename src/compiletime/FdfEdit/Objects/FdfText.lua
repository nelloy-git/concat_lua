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

local FdfText = Class.newClass('FdfText', FdfObject)
---@class FdfText : FdfObject
local public = FdfText.public
---@class FdfTextClass : FdfObjectClass
local static = FdfText.static
local override = FdfText.override
local private = {}
--=========
-- Static
--=========

---@param name string
---@param child_data FdfText | nil
---@return FdfText
function override.new(name, child_data)
    local instance = Class.newInstanceData(FdfText, child_data)
    instance = FdfObject.new(name, 'TEXT', instance)

    return instance
end

static.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SERIAL_DATA.EMPTY)
static.FontFlags = FdfField.new('FontFlags', 'string', FdfField.SERIAL_DATA.STRING)
static.FrameFont = FdfField.new('FrameFont', 'table', FdfField.SERIAL_DATA.LIST_WITH_QUOTES)
static.FontColor = FdfField.new('FontColor', 'table', FdfField.SERIAL_DATA.LIST)
static.FontShadowColor = FdfField.new('FontShadowColor', 'table', FdfField.SERIAL_DATA.LIST)
static.FontShadowOffset = FdfField.new('FontShadowOffset', 'table', FdfField.SERIAL_DATA.LIST)

return FdfText