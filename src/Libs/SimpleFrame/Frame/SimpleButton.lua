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

---@type SimpleBaseFrameClass
local SimpleBaseFrame = require(lib_modname..'.Frame.SimpleBase')
---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.FdfEdit.Frame')

--=======
-- Class
--=======

local SimpleButton = Class.new('SimpleButton', SimpleBaseFrame)
---@class SimpleButton : SimpleBaseFrame
local public = SimpleButton.public
---@class SimpleButtonClass : SimpleBaseFrameClass
local static = SimpleButton.static
---@type SimpleButtonClass
local override = SimpleButton.override
local private = {}

--=========
-- Static
--=========

---@param fdf_simplebutton FdfFrame
---@param child_instance SimpleButton | nil
---@return SimpleButton
function override.new(fdf_simplebutton, child_instance)
    checkType(fdf_simplebutton, FdfFrame, 'fdf_simplebutton')
    if child_instance then
        checkType(child_instance, SimpleButton, 'child_instance')
    end

    if fdf_simplebutton:getBaseType() ~= 'SIMPLEBUTTON' then
        Log:err('fdf_frame has wrong base type.', 2)
    end

    if #fdf_simplebutton:getTextures() ~= 1 then
        Log:err('fdf_frame must have one texture subframe.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleButton)
    instance = SimpleBaseFrame.new(fdf_simplebutton, instance)

    return instance
end

--========
-- Public
--========

---@param tex_file string
---@param flag number
---@param blend boolean
function public:setTextureFile(tex_file, flag, blend)
    self:getTexture(1):setTextureFile(tex_file, flag, blend)
end

--=========
-- Private
--=========

return static