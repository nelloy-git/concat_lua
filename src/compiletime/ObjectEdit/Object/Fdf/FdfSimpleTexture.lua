--=========
-- Include
--=========

local Class = require('Utils.Class')

---@type FdfFieldClass
local FdfField = require('compiletime.ObjectEdit.FdfField')
---@type FdfSubobjectClass
local FdfSubobject = require('compiletime.ObjectEdit.FdfSubobject')

--=======
-- Class
--=======

local FdfSimpleTexture = Class.newClass('FdfSimpleTexture', FdfSubobject)

---@class FdfSimpleTexture
local public = FdfSimpleTexture.public
---@class FdfSimpleTextureClass
local static = FdfSimpleTexture.static
---@type table
local override = FdfSimpleTexture.override
---@type table(FdfSimpleTexture, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfSimpleTexture
function override.new(name, instance_data)
    local instance = instance_data or Class.newInstanceData(FdfSimpleTexture)
    instance = FdfSubobject.new('Texture', name, instance)

    return instance
end

static.Alpha = FdfField.new('Alpha', 'string', FdfField.serialize_String)
static.Anchor = FdfField.new('Anchor', 'table', FdfField.serialize_List)
static.File = FdfField.new('File', 'string', FdfField.serialize_String)
static.Height = FdfField.new('Height', 'number', FdfField.serialize_Number)
static.Width = FdfField.new('Width', 'number', FdfField.serialize_Number)
static.TexCoord = FdfField.new('TexCoord', 'table', FdfField.serialize_List)

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end


return FdfSimpleTexture