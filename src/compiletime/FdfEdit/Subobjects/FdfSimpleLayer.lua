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
---@param child FdfSimpleLayer | nil
---@return FdfSimpleLayer
function override.new(name, child)
    local instance = child or Class.allocate(FdfSimpleLayer, child)
    instance = FdfSubobject.new(name, 'Layer', instance)

    return instance
end

static.Field = {}
static.Field.ChildFrames = FdfField.new('', 'table', FdfField.SerialFunc.SUBOBJECT_LIST)

return static