--=========
-- Include
--=========

---@type FdfFieldClass
local FdfField = require('compiletime.ObjectEdit.FdfField')
---@type FdfSubobjectClass
local FdfSubobject = require('compiletime.ObjectEdit.FdfSubobject')

--=======
-- Class
--=======

---@type FdfSimpleTextureClass
local FdfSimpleTexture = newClass('FdfSimpleTexture', FdfSubobject)

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
    local instance = instance_data or newInstanceData(FdfSimpleTexture)
    instance = FdfSubobject.new('String', name, nil)

    return instance
end

static.Width = FdfField.new('Width', 'number', FdfField.serialize_Number)
static.Height = FdfField.new('Height', 'number', FdfField.serialize_Number)
static.Anchor = FdfField.new('Anchor', 'table', FdfField.serialize_List)
static.File = FdfField.new('File', 'string', FdfField.serialize_String)

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end


return FdfSimpleTexture