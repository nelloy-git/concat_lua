--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type FdfBaseClass
local FdfBase = require(lib_path..'Fdf.Base') or error('')

--=======
-- Class
--=======

local FdfSimpleLayer = Class.new('FdfSimpleLayer', FdfBase)
---@class FdfSimpleLayer : FdfBase
local public = FdfSimpleLayer.public
---@class FdfSimpleLayerClass : FdfBaseClass
local static = FdfSimpleLayer.static
---@type FdfSimpleLayerClass
local override = FdfSimpleLayer.override
local private = {}

--=========
-- Static
--=========

---@param layer_name string | "'ARTWORK'" | "'BACKGROUND'"
---@param child FdfSimpleLayer | nil
---@return FdfSimpleLayer
function override.new(layer_name, child)
    isTypeErr(layer_name, 'string', 'layer_name')
    if child then isTypeErr(child, FdfSimpleLayer, 'child') end

    if not (layer_name == 'ARTWORK' or layer_name == 'BACKGROUND') then
        Log:err('Wrong \'layer_name\'. ARTWORK and BACKGROUND are available only.', 2)
    end

    local instance = child or Class.allocate(FdfSimpleLayer)
    instance = FdfBase.new(tostring(instance), 'Layer', true, instance)
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

---@param fdf_frame FdfBase | nil
function public:setInheritance(fdf_frame)
    Log:err(tostring(FdfSimpleLayer)..' can not inherit.')
end

---@return string
function public:serialize()
    local priv = private.data[self]

    local res = string.format("Layer \"%s\" {", priv.layer_name)
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