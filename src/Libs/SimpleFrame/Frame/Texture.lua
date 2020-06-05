--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType

---@type FdfTextureClass
local FdfTexture = require(lib_modname..'.FdfEdit.Texture')

--=======
-- Class
--=======

local TextureSubrame = Class.new('TextureSubrame')
---@class TextureSubrame
local public = TextureSubrame.public
---@class TextureSubrameClass
local static = TextureSubrame.static
---@type TextureSubrameClass
local override = TextureSubrame.override
local private = {}

--=========
-- Static
--=========

---@param fdf_texture FdfTexture
---@param child_instance TextureSubrame | nil
---@return TextureSubrame
function override.new(fdf_texture, child_instance)
    checkType(fdf_texture, FdfTexture, 'fdf_texture')
    if child_instance then
        checkType(child_instance, TextureSubrame, 'child_instance')
    end

    local instance = child_instance or Class.allocate(TextureSubrame)
    private.newData(instance, fdf_texture)

    return instance
end

--========
-- Public
--========

---@return FdfTexture
function public:getFdf()
    return private.data[self].fdf
end

---@return framehandle
function public:getHandleData()
    return private.data[self].handle
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self TextureSubrame
---@param fdf_texture FdfTexture
function private.newData(self, fdf_texture)
    local priv = {
        fdf = fdf_texture,
        handle = BlzGetFrameByName(fdf_texture:getName(), 0)
    }
    private.data[self] = priv
end

return static