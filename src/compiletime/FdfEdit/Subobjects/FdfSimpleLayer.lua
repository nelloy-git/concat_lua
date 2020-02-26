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

local FdfSimpleLayer = Class.new('FdfSimpleLayer', FdfSubobject)
---@class FdfSimpleLayer : FdfSubobject
local public = FdfSimpleLayer.public
---@class FdfSimpleLayerClass : FdfSubobjectClass
local static = FdfSimpleLayer.static
---@type FdfSimpleLayerClass
local override = FdfSimpleLayer.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfSimpleLayer | nil
---@return FdfSimpleLayer
function override.new(name, child_instance)
    local instance = child_instance or Class.allocate(FdfSimpleLayer, child_instance)
    instance = FdfSubobject.new(name, 'Layer', instance)

    return instance
end

static.Field = {}
static.Field.ChildFrames = FdfField.new('', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)

return static