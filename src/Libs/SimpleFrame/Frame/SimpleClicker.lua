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

local SimpleClicker = Class.new('SimpleClicker', SimpleBaseFrame)
---@class SimpleClicker : SimpleBaseFrame
local public = SimpleClicker.public
---@class SimpleClickerClass : SimpleBaseFrameClass
local static = SimpleClicker.static
---@type SimpleClickerClass
local override = SimpleClicker.override
local private = {}

--=========
-- Static
--=========

---@param fdf_simplebutton FdfFrame
---@param child_instance SimpleClicker | nil
---@return SimpleClicker
function override.new(fdf_simplebutton, child_instance)
    checkType(fdf_simplebutton, FdfFrame, 'fdf_simplebutton')
    if child_instance then
        checkType(child_instance, SimpleClicker, 'child_instance')
    end

    if fdf_simplebutton:getBaseType() ~= 'SIMPLEBUTTON' then
        Log:err('fdf_frame has wrong base type.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleClicker)
    instance = SimpleBaseFrame.new(fdf_simplebutton, instance)

    return instance
end

--========
-- Public
--========

--=========
-- Private
--=========

return static