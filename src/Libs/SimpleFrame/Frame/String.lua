--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType

---@type FdfStringClass
local FdfString = require(lib_modname..'.FdfEdit.String')

--=======
-- Class
--=======

local StringSubrame = Class.new('StringSubrame')
---@class StringSubrame
local public = StringSubrame.public
---@class StringSubrameClass
local static = StringSubrame.static
---@type StringSubrameClass
local override = StringSubrame.override
local private = {}

--=========
-- Static
--=========

---@param fdf_string FdfString
---@param child_instance StringSubrame | nil
---@return StringSubrame
function override.new(fdf_string, child_instance)
    checkType(fdf_string, FdfString, 'fdf_string')
    if child_instance then
        checkType(child_instance, StringSubrame, 'child_instance')
    end

    local instance = child_instance or Class.allocate(StringSubrame)
    private.newData(instance, fdf_string)

    return instance
end

--========
-- Public
--========

---@return FdfString
function public:getFdf()
    return private.data[self].fdf
end

---@return framehandle
function public:getHandleData()
    return private.data[self].handle
end

---@param text string
function public:setText(text)
    BlzFrameSetText(self:getHandleData(), text)
end

---@return string
function public:getText()
    return BlzFrameGetText(self:getHandleData())
end

---@param red number
---@param green number
---@param blue number
---@param alpha number
function public:setColor(red, green, blue, alpha)
    BlzFrameSetTextColor(self:getHandleData(), BlzConvertColor(red, green, blue, 255-alpha))
end

---@param font_file string
---@param height number
---@param flags number
function public:setFont(font_file, height, flags)
    BlzFrameSetFont(self:getHandleData(), font_file, height, flags)
end

---@param vert textaligntype
---@param horz textaligntype
function public:setAlignment(vert, horz)
    BlzFrameSetTextAlignment(self:getHandleData(), vert, horz)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self StringSubrame
---@param fdf_string FdfTexture
function private.newData(self, fdf_string)
    local priv = {
        fdf = fdf_string,
        handle = BlzGetFrameByName(fdf_string:getName(), 0)
    }
    private.data[self] = priv
end

return static