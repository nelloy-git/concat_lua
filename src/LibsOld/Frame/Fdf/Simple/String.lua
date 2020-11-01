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

local FdfSimpleString = Class.new('FdfSimpleString', FdfBase)
---@class FdfSimpleString : FdfBase
local public = FdfSimpleString.public
---@class FdfSimpleStringClass : FdfBaseClass
local static = FdfSimpleString.static
---@type FdfSimpleStringClass
local override = FdfSimpleString.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfSimpleString | nil
---@return FdfSimpleString
function override.new(name, child)
    isTypeErr(name, 'string', 'name')
    if child then isTypeErr(child, FdfSimpleString, 'child') end

    local instance = child or Class.allocate(FdfSimpleString)
    instance = FdfBase.new(name, 'String', true, instance)

    return instance
end

--========
-- Public
--========

---@param path string
---@param size number
function public:setFont(path, size)
    self:setParameter('Font', '\"'..path..'\", '..tostring(size))
end

---@param r number
---@param g number
---@param b number
---@param a number
function public:setColor(r, g, b, a)
    r = r > 1 and 1 or r < 0 and 0 or r
    g = g > 1 and 1 or g < 0 and 0 or g
    b = b > 1 and 1 or b < 0 and 0 or b
    a = a > 1 and 1 or a < 0 and 0 or a

    self:setParameter('FontColor', tostring(r)..' '..tostring(g)..' '..tostring(b)..' '..tostring(a))
end

---@param text string
function public:setText(text)
    self:setParameter('Text', '\"'..text..'\"')
end

function public:addSubframe()
    Log:err(tostring(FdfSimpleString)..' can not have subframes')
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