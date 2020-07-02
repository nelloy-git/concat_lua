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

---@type SimpleImageClass
local SimpleImage = require(lib_modname..'.Frame.SimpleImage')
---@type SimpleClickerClass
local SimpleClicker = require(lib_modname..'.Frame.SimpleClicker')
---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.FdfEdit.Frame')

--=======
-- Class
--=======

local SimpleButton = Class.new('SimpleButton', SimpleImage, SimpleClicker)
---@class SimpleButton : SimpleClicker, SimpleImage
local public = SimpleButton.public
---@class SimpleButtonClass : SimpleClickerClass, SimpleImageClass
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
    checkType(fdf_simplebutton, FdfFrame, 'fdf_simpleframe')
    if child_instance then
        checkType(child_instance, SimpleButton, 'child_instance')
    end

    if fdf_simplebutton:getBaseType() ~= 'SIMPLEBUTTON' then
        Log:err('fdf_frame has wrong base type.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleButton)
    instance = SimpleImage.new(fdf_simplebutton, instance)
    instance = SimpleClicker.new(fdf_simplebutton, instance)

    return instance
end

--========
-- Public
--========

--=========
-- Private
--=========

return static