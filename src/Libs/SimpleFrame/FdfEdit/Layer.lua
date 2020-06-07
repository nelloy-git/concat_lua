--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger
---@type FdfFileClass
local FdfFile = require(lib_modname..'.FdfEdit.File')
---@type FdfTextureClass
local FdfTexture = require(lib_modname..'.FdfEdit.Texture')

--=======
-- Class
--=======

local FdfLayer = Class.new('FdfLayer')
---@class FdfLayer
local public = FdfLayer.public
---@class FdfLayerClass
local static = FdfLayer.static
---@type FdfLayerClass
local override = FdfLayer.override
local private = {}

--=========
-- Static
--=========

---@param base_type string | 'ARTWORK' | 'BACKGROUND'
---@param child_instance FdfLayer | nil
---@return FdfLayer
function override.new(base_type, child_instance)
    checkType(base_type, 'string', 'base_type')
    if child_instance then checkType(child_instance, FdfLayer, 'child_instance') end

    if not (base_type == 'ARTWORK' or
        base_type == 'BACKGROUND') then
        Log:err('Wrong base_type.', 2)
    end

    local instance = child_instance or Class.allocate(FdfLayer)
    private.newData(instance, base_type)

    return instance
end

--========
-- Public
--========

---@return string
function public:getBaseType()
    return private.data[self].base_type
end

---@param parameter string
---@param value string
function public:setParameter(parameter, value)
    checkType(parameter, 'string', parameter)
    checkType(value, 'string', value)

    local priv = private.data[self]
    priv.params[parameter] = value
end

---@return string
function public:getParameter(parameter)
    return private.data[self].params[parameter]
end

---@param texture FdfTexture
function public:addTexture(texture)
    checkType(texture, FdfTexture, 'texture')

    local priv = private.data[self]
    table.insert(priv.textures, texture)
end

---@return table
function public:getTextures()
    local priv = private.data[self]
    local copy = {}
    for i = 1, #priv.textures do
        copy[i] = priv.textures[i]
    end

    return copy
end

---@param subframe FdfLayer
function public:addSubframe(subframe)
    checkType(subframe, FdfLayer, 'subframe')

    local priv = private.data[self]
    table.insert(priv.subframes, subframe)
    private.data[self].fdf_file:remove(subframe)
end

---@return table
function public:getSubframes()
    local priv = private.data[self]
    local copy = {}
    for i = 1, #priv.subframes do
        copy[i] = priv.subframes[i]
    end

    return copy
end

---@return string
function public:serialize()
    local priv = private.data[self]

    local res = string.format("Layer \"%s\" {\n", priv.base_type)
    for param, value in pairs(priv.params) do
        res = res..'    '..param..' '..value..',\n'
    end
    for i = 1, #priv.textures do
        res = res..'\n'..priv.textures[i]:serialize():gsub('\n', '\n    ')..'\n'
    end
    for i = 1, #priv.subframes do
        ---@type string
        local sub_res = priv.subframes[i]:serialize()
        sub_res = '    '..sub_res:gsub('\n', '\n    ')
        res = res..'\n'..sub_res..'\n'
    end
    return res.."}"
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FdfLayer
---@return FdfLayerPrivate
function private.newData(self, base_type)
    ---@class FdfLayerPrivate
    local priv = {
        base_type = base_type,
        params = {},
        textures = {},
        subframes = {},
    }
    private.data[self] = priv
end

return static