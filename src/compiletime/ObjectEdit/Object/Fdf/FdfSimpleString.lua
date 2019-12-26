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

local FdfSimpleString = Class.newClass('FdfSimpleString', FdfSubobject)

---@class FdfSimpleString
local public = FdfSimpleString.public
---@class FdfSimpleStringClass
local static = FdfSimpleString.static
---@type table
local override = FdfSimpleString.override
---@type table(FdfSimpleString, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FdfSimpleString
function override.new(name, instance_data)
    local instance = instance_data or Class.newInstanceData(FdfSimpleString)
    instance = FdfSubobject.new('String', name, instance)

    return instance
end

static.Anchor = FdfField.new('Anchor', 'table', FdfField.serialize_List)
static.Height = FdfField.new('Height', 'number', FdfField.serialize_Number)
static.Width = FdfField.new('Width', 'number', FdfField.serialize_Number)
--- Example simple_string:setField(FdfSimpleString.Font, {"InfoPanelTextFont", 0.009})
static.Font = FdfField.new('Font', 'table', FdfField.serialize_ListWithQuotes)

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end


return FdfSimpleString