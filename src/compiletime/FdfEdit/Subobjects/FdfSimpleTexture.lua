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

local FdfSimpleTexture = Class.new('FdfSimpleTexture', FdfSubobject)
---@class FdfSimpleTexture : FdfSubobject
local public = FdfSimpleTexture.public
---@class FdfSimpleTextureClass : FdfSubobjectClass
local static = FdfSimpleTexture.static
---@type FdfSimpleTextureClass
local override = FdfSimpleTexture.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfSimpleTexture | nil
---@return FdfSimpleTexture
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfSimpleTexture)
    instance = FdfSubobject.new(name, 'Texture', instance)

    return instance
end

static.Field = {}
static.Field.Anchor = FdfField.new('Anchor', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)
static.Field.SetAllPoints = FdfField.new('SetAllPoints', 'string', FdfField.SerialFunc.EMPTY)
static.Field.Height = FdfField.new('Height', 'number', FdfField.SerialFunc.NUMBER)
static.Field.Width = FdfField.new('Width', 'number', FdfField.SerialFunc.NUMBER)
static.Field.File = FdfField.new('File', 'string', FdfField.SerialFunc.STRING)
static.Field.TexCoord = FdfField.new('TexCoord', 'table', FdfField.SerialFunc.LIST_WITH_COMMAS)

return static