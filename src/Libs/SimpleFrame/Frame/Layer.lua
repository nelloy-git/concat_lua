--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Handle = UtilsLib.Handle.Base

---@type FdfLayerClass
local FdfLayer = require(lib_modname..'.FdfEdit.Layer')
---@type FdfStringClass
local FdfString = require(lib_modname..'.FdfEdit.String')
---@type TextureSubrameClass
local Texture = require(lib_modname..'.Frame.Texture')
---@type FdfStringClass
local String = require(lib_modname..'.Frame.String')

--=======
-- Class
--=======

local LayerSubrame = Class.new('LayerSubrame')
---@class LayerSubrame
local public = LayerSubrame.public
---@class LayerSubrameClass
local static = LayerSubrame.static
---@type LayerSubrameClass
local override = LayerSubrame.override
local private = {}

--=========
-- Static
--=========

---@param fdf_layer FdfLayer
---@param child_instance LayerSubrame | nil
---@return LayerSubrame
function override.new(fdf_layer, child_instance)
    checkType(fdf_layer, FdfLayer, 'fdf_layer')
    if child_instance then
        checkType(child_instance, LayerSubrame, 'child_instance')
    end

    local instance = child_instance or Class.allocate(LayerSubrame)
    private.newData(instance, fdf_layer)

    return instance
end

--========
-- Public
--========

---@return FdfLayer
function public:getFdf()
    return private.data[self].fdf
end

---@param param string
---@return string
function public:getParameter(param)
    return private.data[self].fdf:getParameter(param)
end

---@param i number
---@return TextureSubrame
function public:getTexture(i)
    return private.data[self].textures[i]
end

---@param i number
---@return StringSubrame | nil
function public:getString(i)
    return private.data[self].strings[i]
end

---@param i number
---@return SimpleBaseFrame
function public:getSubframe(i)
    return private.data[self].subframes[i]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.SimpleBaseFrame = nil -- require(lib_modname..'.Frame.Base')

---@param self LayerSubrame
---@param fdf_layer FdfLayer
function private.newData(self, fdf_layer)
    local priv = {
        fdf = fdf_layer,

        textures = {},
        strings = {},
        subframes = {}
    }
    private.data[self] = priv

    local fdf_textures = fdf_layer:getTextures()
    for i = 1, #fdf_textures do
        priv.textures[i] = Texture.new(fdf_textures[i])
    end

    local fdf_strings = fdf_layer:getStrings()
    for i = 1, #fdf_strings do
        checkType(fdf_strings[i], FdfString, 'fdf_strings['..tostring(i)..']')
        priv.strings[i] = String.new(fdf_strings[i])
    end

    private.SimpleBaseFrame = private.SimpleBaseFrame or require(lib_modname..'.Frame.SimpleBase')
    local fdf_subframes = fdf_layer:getSubframes()
    for i = 1, #fdf_subframes do
        priv.subframes[i] = Handle.getLinked(BlzGetFrameByName(fdf_subframes[i]:getName(), 0))
        checkType(priv.subframes[i], private.SimpleBaseFrame, 'linked Handle')
    end
end

return static