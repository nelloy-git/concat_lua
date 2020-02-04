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

local FdfHighlight = Class.new('FdfHighlight', FdfObject)
---@class FdfHighlight : FdfObject
local public = FdfHighlight.public
---@class FdfHighlightClass : FdfObjectClass
local static = FdfHighlight.static
---@type FdfHighlightClass
local override = FdfHighlight.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfHighlight | nil
---@return FdfHighlight
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfHighlight)
    instance = FdfObject.new(name, 'HIGHLIGHT', instance)

    return instance
end

static.Field = {}
static.Field.DecorateFileNames = FdfField.new('DecorateFileNames', 'nil', FdfField.SerialFunc.EMPTY)
-- "EscMenuButtonMouseOverHighlight" | "EscMenuCheckBoxCheckHighlight" | "EscMenuDisabledRadioButtonSelectedHighlight"
-- | "UI\Glues\ScoreScreen\scorescreen-tab-hilight.blp" | "UI\Widgets\Glues\GlueScreen-Button-KeyboardHighlight.blp"
-- | "UI\Widgets\Glues\GlueScreen-Checkbox-Check.blp" | "UI\Widgets\Glues\GlueScreen-Checkbox-CheckDisabled.blp"
-- | "UI\Widgets\Glues\GlueScreen-RadioButton-ButtonDisabled.blp"
static.Field.HighlightAlphaFile = FdfField.new('HighlightAlphaFile', 'string', FdfField.SerialFunc.STRING)
-- "ADD" | "BLEND"
static.Field.HighlightAlphaMode = FdfField.new('HighlightAlphaMode', 'string', FdfField.SerialFunc.STRING)
-- Example {0.0, 0.0, 1.0, 0.1}
static.Field.HighlightColor = FdfField.new('HighlightColor', 'table', FdfField.SerialFunc.LIST)
-- "FILETEXTURE" | "SHADE"
static.Field.HighlightType = FdfField.new('HighlightType', 'string', FdfField.SerialFunc.STRING)

return static