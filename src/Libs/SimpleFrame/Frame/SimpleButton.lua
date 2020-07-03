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

local SimpleButton = Class.new('SimpleButton', SimpleImage)
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
    private.newData(instance)

    return instance
end

--========
-- Public
--========

--=========
-- Tracker
--=========

---@return boolean
function public:isMouseOver()
    return private.data[self].controller:isMouseOver()
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseEnterAction(callback)
    return private.data[self].controller:addMouseEnterAction(callback)
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseLeaveAction(callback)
    return private.data[self].controller:addMouseLeaveAction(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    return private.data[self].controller:removeAction(action)
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseDownAction(mouse_btn, callback)
    return private.data[self].controller:addMouseDownAction(mouse_btn, callback)
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseUpAction(mouse_btn, callback)
    return private.data[self].controller:addMouseUpAction(mouse_btn, callback)
end

---@param callback SimpleFrameCallback
---@return Action
function public:addMouseClickAction(mouse_btn, callback)
    return private.data[self].controller:addMouseClickAction(mouse_btn, callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    return private.data[self].controller:removeAction(action)
end


--=========
-- Clicker
--=========


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

function private.newData(self)
    local priv = {controller = SimpleClicker.new(self)}
    private.data[self] = priv
end

return static