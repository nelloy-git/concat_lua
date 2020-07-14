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

---@type SimpleImageClass
local SimpleImage = require(lib_modname..'.Frame.SimpleImage')
---@type SimpleClickerClass
local SimpleClicker = require(lib_modname..'.Frame.SimpleClicker')
---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.FdfEdit.Frame')
---@type FdfLayerClass
local FdfTexture = require(lib_modname..'.FdfEdit.Texture')

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

---@param fdf_simplebutton FdfFrame | nil
---@param child_instance SimpleButton | nil
---@return SimpleButton
function override.new(fdf_simplebutton, child_instance)
    if fdf_simplebutton then
        checkTypeErr(fdf_simplebutton, FdfFrame, 'fdf_simpleframe')
    else
        fdf_simplebutton = private.default_fdf
    end
    if child_instance then
        checkTypeErr(child_instance, SimpleButton, 'child_instance')
    end

    if fdf_simplebutton:getBaseType() ~= 'SIMPLEBUTTON' then
        Log:err('fdf_simplebutton has wrong base type.', 2)
    end

    local instance = child_instance or Class.allocate(SimpleButton)
    instance = SimpleImage.new(fdf_simplebutton, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

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
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.default_fdf = FdfFrame.new('DefaultSimpleButton', 'SIMPLEBUTTON')
do
    local fdf = private.default_fdf
    fdf:setParameter('Width', '0.04')
    fdf:setParameter('Height', '0.04')
        local texture = FdfTexture.new('DefaultSimpleButtonTexture')
        texture:setParameter('File', '\"\"')
        fdf:addTexture(texture)
end

function private.newData(self)
    local priv = {controller = SimpleClicker.new(self)}
    private.data[self] = priv
end

return static