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

local FdfSimpleTexture = Class.new('FdfSimpleTexture', FdfSimpleBase)
---@class FdfSimpleTexture : FdfSimpleBase
local public = FdfSimpleTexture.public
---@class FdfSimpleTextureClass : FdfSimpleBaseClass
local static = FdfSimpleTexture.static
---@type FdfSimpleTextureClass
local override = FdfSimpleTexture.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfSimpleTexture | nil
---@return FdfSimpleTexture
function override.new(name, child_instance)
    checkTypeErr(name, 'string', 'name')
    if child_instance then checkTypeErr(child_instance, FdfSimpleTexture, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfSimpleTexture)
    instance = FdfSimpleBase.new(name, 'Texture', nil, instance)

    return instance
end

--========
-- Public
--========

---@param path string
function public:setFile(path)
    self:setParameter('File', '\"'..path..'\"')
end

function public:addSubframe()
    Log:err(tostring(FdfSimpleTexture)..' can not have subframes')
end

---@return string
function public:serialize()
    local res = string.format("%s \"%s\" {\n", self:getBaseType(), self:getName())
    for param, value in pairs(self:getAllParameters()) do
        res = res..'    '..param..' '..value..',\n'
    end
    return res.."}"
end

--=========
-- Private
--=========

return static