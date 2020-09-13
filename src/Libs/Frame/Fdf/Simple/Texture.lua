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

local FdfSimpleTexture = Class.new('FdfSimpleTexture', FdfBase)
---@class FdfSimpleTexture : FdfBase
local public = FdfSimpleTexture.public
---@class FdfTextureClass : FdfBaseClass
local static = FdfSimpleTexture.static
---@type FdfTextureClass
local override = FdfSimpleTexture.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfSimpleTexture | nil
---@return FdfSimpleTexture
function override.new(name, child)
    isTypeErr(name, 'string', 'name')
    if child then isTypeErr(child, FdfSimpleTexture, 'child') end

    local instance = child or Class.allocate(FdfSimpleTexture)
    instance = FdfBase.new(name, 'Texture', true, instance)

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