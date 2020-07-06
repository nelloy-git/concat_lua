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
---@type FdfStringClass
local FdfString = require(lib_modname..'.FdfEdit.String')
---@type FdfLayerClass
local FdfLayer = require(lib_modname..'.FdfEdit.Layer')

--=======
-- Class
--=======

local FdfFrame = Class.new('FdfFrame')
---@class FdfFrame
local public = FdfFrame.public
---@class FdfFrameClass
local static = FdfFrame.static
---@type FdfFrameClass
local override = FdfFrame.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_type string | 'SIMPLEFRAME' | 'SIMPLEBUTTON' | 'SIMPLECHECKBOX' | 'SIMPLESTATUSBAR'
---@param fdf_file FdfFile | nil
---@param child_instance FdfFrame | nil
---@return FdfFrame
function override.new(name, base_type, fdf_file, child_instance)
    checkType(name, 'string', 'name')
    checkType(base_type, 'string', 'base_type')
    if fdf_file then checkType(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkType(child_instance, FdfFrame, 'child_instance') end

    if not (base_type == 'SIMPLEFRAME' or
        base_type == 'SIMPLEBUTTON' or
        base_type == 'SIMPLECHECKBOX' or
        base_type == 'SIMPLESTATUSBAR') then
        Log:err('Wrong base_type.', 2)
    end

    if private.name[name] then
        Log:err('Frame with the same name already exists.', 2)
    end

    local instance = child_instance or Class.allocate(FdfFrame)
    private.newData(instance, name, base_type, fdf_file)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].name
end

---@return string
function public:getBaseType()
    return private.data[self].base_type
end

---@return string
function public:getParameter(parameter)
    return private.data[self].params[parameter]
end

--- Do nothing in runtime.
---@param parameter string
---@param value string
function public:setParameter(parameter, value)
    checkType(parameter, 'string', parameter)
    checkType(value, 'string', value)

    local priv = private.data[self]
    priv.params[parameter] = value
end

--- Do nothing in runtime.
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

--- Do nothing in runtime.
---@param string FdfString
function public:addString(string)
    checkType(string, FdfString, 'string')

    local priv = private.data[self]
    table.insert(priv.strings, string)
end

---@return table
function public:getStrings()
    local priv = private.data[self]
    local copy = {}
    for i = 1, #priv.strings do
        copy[i] = priv.strings[i]
    end

    return copy
end

--- Do nothing in runtime.
---@param layer FdfLayer
function public:addLayer(layer)
    checkType(layer, FdfLayer, 'layer')

    local priv = private.data[self]
    table.insert(priv.layers, layer)
end

---@return table
function public:getLayers()
    local priv = private.data[self]
    local copy = {}
    for i = 1, #priv.layers do
        copy[i] = priv.layers[i]
    end

    return copy
end

--- Do nothing in runtime.
---@param subframe FdfFrame
function public:addSubFrame(subframe)
    checkType(subframe, FdfFrame, 'subframe')

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

--- Do nothing in runtime.
---@return string
function public:serialize()
    local priv = private.data[self]

    local res = string.format("Frame \"%s\" \"%s\" {\n", priv.base_type, priv.name)
    for param, value in pairs(priv.params) do
        res = res..'    '..param..' '..value..',\n'
    end
    for i = 1, #priv.textures do
        res = res..'\n    '..priv.textures[i]:serialize():gsub('\n', '\n    ')..'\n'
    end
    for i = 1, #priv.layers do
        res = res..'\n    '..priv.layers[i]:serialize():gsub('\n', '\n    ')..'\n'
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
private.name = setmetatable({}, {__mode = 'k'})

---@param self FdfFrame
---@return FdfFramePrivate
function private.newData(self, name, base_type, fdf_file)
    ---@class FdfFramePrivate
    local priv = {
        base_type = base_type,
        name = name,
        params = {},
        textures = {},
        strings = {},
        layers = {},
        subframes = {},

        fdf_file = fdf_file or FdfFile.getDefault()
    }
    private.data[self] = priv
    private.name[name] = self

    priv.fdf_file:add(self)
end

return static