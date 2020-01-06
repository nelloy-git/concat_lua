--=========
-- Include
--=========

local Class = require('utils.Class')
local FdfSubobject = require('compiletime.FdfEdit.FdfSubobject')

---@type FdfFieldClass
local FdfField = require('compiletime.FdfEdit.FdfField')

--=======
-- Class
--=======

local FdfSimpleTexture = Class.newClass('FdfSimpleTexture', FdfSubobject)
---@class FdfSimpleTexture : FdfSubobject
local public = FdfSimpleTexture.public
---@class FdfSimpleTextureClass : FdfSubobjectClass
local static = FdfSimpleTexture.static
local override = FdfSimpleTexture.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_data FdfSimpleTexture | nil
---@return FdfSimpleTexture
function override.new(name, child_data)
    local instance = child_data or Class.newInstanceData(FdfSimpleTexture, child_data)
    instance = FdfSubobject.new(name, 'Texture', instance)

    return instance
end

static.Alpha = FdfField.new('Alpha', 'string', FdfField.SERIAL_DATA.STRING)
static.Anchor = FdfField.new('Anchor', 'table', FdfField.SERIAL_DATA.LIST)
static.File = FdfField.new('File', 'string', FdfField.SERIAL_DATA.STRING)
static.Height = FdfField.new('Height', 'number', FdfField.SERIAL_DATA.NUMBER)
static.Width = FdfField.new('Width', 'number', FdfField.SERIAL_DATA.NUMBER)
static.TexCoord = FdfField.new('TexCoord', 'table', FdfField.SERIAL_DATA.LIST)

return FdfSimpleTexture