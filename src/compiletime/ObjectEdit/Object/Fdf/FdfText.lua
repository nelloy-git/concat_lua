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

---@type FdfTextClass
local FdfText = newClass('FdfText', FdfObject)

---@class FdfText
local public = FdfText.public
---@class FdfTextClass
local static = FdfText.static
---@type table
local override = FdfText.override
---@type table(FdfText, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfText
function override.new(name, instance_data)
    local instance = instance_data or newInstanceData(FdfText)
    instance = FdfObject.new('TEXT', name, nil)

    return instance
end

static.FontFlags = FdfField.new('FontFlags', 'string')
static.FrameFont = FdfField.new('FrameFont', 'table')
static.FontColor = FdfField.new('FontColor', 'table')
static.FontShadowColor = FdfField.new('FontShadowColor', 'table')
static.FontShadowOffset = FdfField.new('FontShadowOffset', 'table')

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

return FdfText