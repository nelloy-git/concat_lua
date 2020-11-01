--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type FdfBaseClass
local FdfBase = require(lib_path..'Fdf.Base') or error('')

--=======
-- Class
--=======

local FdfSimpleFrame = Class.new('FdfSimpleFrame', FdfBase)
---@class FdfSimpleFrame : FdfBase
local public = FdfSimpleFrame.public
---@class FdfSimpleFrameClass : FdfBaseClass
local static = FdfSimpleFrame.static
---@type FdfSimpleFrameClass
local override = FdfSimpleFrame.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfSimpleFrame | nil
---@return FdfSimpleFrame
function override.new(name, child)
    isTypeErr(name, 'string', 'name')
    if child then isTypeErr(child, FdfSimpleFrame, 'child') end

    local instance = child or Class.allocate(FdfSimpleFrame)
    instance = FdfBase.new(name, 'SIMPLEFRAME', true, instance)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    local str_width = tostring(width)
    self:setParameter('Width', str_width)
end

---@param height number
function public:setHeight(height)
    local str_height = tostring(height)
    self:setParameter('Height', str_height)
end

function public:setAllPoints(flag)
    if flag then
        self:setParameter('SetAllPoints')
    else
        self:removeParameter('SetAllPoints')
    end
end

--- Look-Up FileNames in some String table (for example gameinterface)
---@param flag boolean
function public:setDecorateFileNames(flag)
    if flag then
        self:setParameter('DecorateFileNames')
    else
        self:removeParameter('DecorateFileNames')
    end
end

--=========
-- Private
--=========

return static