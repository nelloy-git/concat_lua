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

local FdfSimpleString = Class.new('FdfSimpleString', FdfSimpleBase)
---@class FdfSimpleString : FdfSimpleBase
local public = FdfSimpleString.public
---@class FdfSimpleStringClass : FdfSimpleBaseClass
local static = FdfSimpleString.static
---@type FdfSimpleStringClass
local override = FdfSimpleString.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfSimpleString | nil
---@return FdfSimpleString
function override.new(name, child_instance)
    checkTypeErr(name, 'string', 'name')
    if child_instance then checkTypeErr(child_instance, FdfSimpleString, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfSimpleString)
    instance = FdfSimpleBase.new(name, 'String', nil, instance)

    return instance
end

--========
-- Public
--========

---@param path string
---@param size number
function public:setFont(path, size)
    self:setParameter('File', '\"'..path..'\", '..tostring(size))
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