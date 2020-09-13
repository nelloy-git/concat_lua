--=========
-- Include
--=========

local Class = require(Lib.Class)

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
---@class FdfTextureClass : FdfSubobjectClass
local static = FdfSimpleTexture.static
---@type FdfTextureClass
local override = FdfSimpleTexture.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfSimpleTexture | nil
---@return FdfSimpleTexture
function override.new(name, child)
    local instance = child or Class.allocate(FdfSimpleTexture)
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