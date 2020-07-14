--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger

---@type FdfSimpleBaseClass
local FdfSimpleBase = require(lib_modname..'.Fdf.Frame.SimpleBase')

--=======
-- Class
--=======

local FdfSimpleLayer = Class.new('FdfSimpleLayer', FdfSimpleBase)
---@class FdfSimpleLayer : FdfSimpleBase
local public = FdfSimpleLayer.public
---@class FdfSimpleLayerClass : FdfSimpleBaseClass
local static = FdfSimpleLayer.static
---@type FdfSimpleLayerClass
local override = FdfSimpleLayer.override
local private = {}

--=========
-- Static
--=========

---@param layer_name string | 'ARTWORK' | 'BACKGROUND'
---@param child_instance FdfSimpleLayer | nil
---@return FdfSimpleLayer
function override.new(layer_name, child_instance)
    checkTypeErr(layer_name, 'string', 'layer_name')
    if child_instance then checkTypeErr(child_instance, FdfSimpleLayer, 'child_instance') end

    if not (layer_name == 'ARTWORK' or
        layer_name == 'BACKGROUND') then
        Log:err('Wrong \'layer_name\'. ARTWORK and BACKGROUND are available only.', 2)
    end

    local instance = child_instance or Class.allocate(FdfSimpleLayer)
    instance = FdfSimpleBase.new(tostring(instance), 'Layer', nil, instance)
    private.newData(instance, layer_name)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].layer_name
end

---@param fdf_frame FdfFrame | nil
function public:setInheritance(fdf_frame)
    Log:err(tostring(FdfSimpleLayer)..' can not inherit.')
end

---@return string
function public:serialize()
    local priv = private.data[self]

    local res = string.format("Layer \"%s\" {\n", priv.layer_name)
    for param, value in pairs(self:getAllParameters()) do
        res = res..'    '..param..' '..value..',\n'
    end
    for _, subframe in pairs(self:getAllSubframes()) do
        res = res..'\n    '..subframe:serialize():gsub('\n', '\n    ')..'\n'
    end
    return res.."}"
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

function private.newData(self, layer_name)
    local priv = {
        layer_name = layer_name
    }
    private.data[self] = priv
end

return static