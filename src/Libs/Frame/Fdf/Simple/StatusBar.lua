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
local FdfBase = require(lib_path..'.Fdf.Base') or error('')

--=======
-- Class
--=======

local FdfSimpleStatusBar = Class.new('FdfSimpleStatusBar', FdfBase)
---@class FdfSimpleStatusBar : FdfBase
local public = FdfSimpleStatusBar.public
---@class FdfSimpleStatusBarClass : FdfBaseClass
local static = FdfSimpleStatusBar.static
---@type FdfSimpleStatusBarClass
local override = FdfSimpleStatusBar.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child FdfSimpleStatusBar | nil
---@return FdfSimpleStatusBar
function override.new(name, child)
    isTypeErr(name, 'string', 'name')
    if child then isTypeErr(child, FdfSimpleStatusBar, 'child') end

    local instance = child or Class.allocate(FdfSimpleStatusBar)
    instance = FdfBase.new(name, 'SIMPLESTATUSBAR', true, instance)

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

---@param tex_file string
function public:setBarTexture(tex_file)
    self:setParameter('BarTexture', '\"'..tex_file..'\"')
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