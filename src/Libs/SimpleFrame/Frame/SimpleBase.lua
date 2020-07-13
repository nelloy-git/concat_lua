--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Action
local checkType = UtilsLib.Functions.checkType
local Handle = UtilsLib.Handle.Base
local Timer = UtilsLib.Handle.Timer

---@type FdfFrameClass
local FdfFrame = require(lib_modname..'.FdfEdit.Frame')
---@type FdfLayerClass
local FdfLayer = require(lib_modname..'.FdfEdit.Layer')
---@type FdfTextureClass
local FdfTexture = require(lib_modname..'.FdfEdit.Texture')
---@type FdfStringClass
local FdfString = require(lib_modname..'.FdfEdit.String')

---@type LayerSubrameClass
local Layer = require(lib_modname..'.Frame.Layer')
---@type StringSubrameClass
local String = require(lib_modname..'.Frame.String')
---@type TextureSubrameClass
local Texture = require(lib_modname..'.Frame.Texture')

--=======
-- Class
--=======

local SimpleBaseFrame = Class.new('SimpleBaseFrame', Handle)
---@class SimpleBaseFrame : Handle
local public = SimpleBaseFrame.public
---@class SimpleBaseFrameClass : HandleClass
local static = SimpleBaseFrame.static
---@type SimpleBaseFrameClass
local override = SimpleBaseFrame.override
local private = {}

--=========
-- Static
--=========

---@alias SimpleFrameCallback fun(frame:SimpleBaseFrame)

---@param fdf_frame FdfFrame
---@param child_instance SimpleBaseFrame | nil
---@return SimpleBaseFrame
function override.new(fdf_frame, child_instance)
    checkType(fdf_frame, FdfFrame, 'fdf_frame')
    if child_instance then
        checkType(child_instance, SimpleBaseFrame, 'child_instance')
    end

    local instance = child_instance or Class.allocate(SimpleBaseFrame)
    local handle = instance:getHandleData() or BlzCreateSimpleFrame(fdf_frame:getName(), nil, 0, 0)
    instance = Handle.new(handle, BlzDestroyFrame, instance)
    private.newData(instance, fdf_frame)

    return instance
end

---@return number
function override.getScreenLeftX()
    return private.screen_left_x
end

---@return number
function override.getScreenWidth()
    return private.screen_width
end

---@return number
function override.getScreenHeight()
    return private.screen_height
end

--========
-- Public
--========

---@return FdfFrame
function public:getFdf()
    return private.data[self].fdf
end

---@param i number
---@return TextureSubrame | nil
function public:getTexture(i)
    return private.data[self].textures[i]
end

---@param i number
---@return StringSubrame | nil
function public:getString(i)
    return private.data[self].strings[i]
end

---@param name string
---@return LayerSubrame | nil
function public:getLayer(name)
    return private.data[self].layers[name]
end

---@param i number
---@return SimpleBaseFrame | nil
function public:getSubframe(i)
    return private.data[self].subframes[i]
end

---@param x number
---@param y number
function public:setPos(x, y)
    local priv = private.data[self]
    priv.x = x
    priv.y = y

    local handle = self:getHandleData()
    local parent = priv.parent

    if parent then
        local parent_handle = parent:getHandleData()
        BlzFrameSetPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                         parent_handle, FRAMEPOINT_BOTTOMLEFT,
                         x, y)
    else
        BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                            private.screen_left_x + x, y)
    end
end

--- Returns x offset from parent.
---@return number
function public:getX()
    return private.data[self].x
end

---@return number
function public:getAbsX()
    local priv = private.data[self]

    if priv.parent then
        return priv.parent:getAbsX() + priv.x
    else
        return priv.x
    end
end

---@param x number
function public:setX(x)
    local priv = private.data[self]
    priv.x = x

    local handle = self:getHandleData()
    local parent = priv.parent

    if parent then
        local parent_handle = parent:getHandleData()
        BlzFrameSetPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                         parent_handle, FRAMEPOINT_BOTTOMLEFT,
                         x, priv.y)
    else
        BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                            private.screen_left_x + x,
                            priv.y)
    end
end

--- Returns y offset from parent.
function public:getY()
    return private.data[self].y
end

---@return number
function public:getAbsY()
    local priv = private.data[self]

    if priv.parent then
        return priv.parent:getAbsY() + priv.y
    else
        return priv.y
    end
end

---@param y number
function public:setY(y)
    local priv = private.data[self]
    priv.y = y

    local handle = self:getHandleData()
    local parent = priv.parent

    if parent then
        local parent_handle = parent:getHandleData()
        BlzFrameSetPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                         parent_handle, FRAMEPOINT_BOTTOMLEFT,
                         priv.x, y)
    else
        BlzFrameSetAbsPoint(handle, FRAMEPOINT_BOTTOMLEFT,
                            private.screen_left_x + priv.x,
                            y)
    end
end

---@param width number
function public:setWidth(width)
    private.data[self].width = width
    BlzFrameSetSize(self:getHandleData(), width, private.data[self].height)
end

function public:getWidth()
    return private.data[self].width
end

---@param height number
function public:setHeight(height)
    private.data[self].height = height
    BlzFrameSetSize(self:getHandleData(), private.data[self].width, height)
end

function public:getHeight()
    return private.data[self].height
end

---@param width number
---@param height number
function public:setSize(width, height)
    private.data[self].width = width
    private.data[self].height = height
    BlzFrameSetSize(self:getHandleData(), width, height)
end

---@return SimpleBaseFrame | nil
function public:getParent()
    return private.data[self].parent
end

---@param parent SimpleBaseFrame | nil
function public:setParent(parent)
    private.data[self].parent = parent
    local handle = self:getHandleData()

    local parent_handle
    if parent then
        checkType(parent, SimpleBaseFrame, 'parent')
        parent_handle = parent:getHandleData()
    end

    BlzFrameSetParent(handle, parent_handle)
end

function public:getLevel()
    return private.data[self].level
end

---@param level number
function public:setLevel(level)
    private.data[self].level = level
    BlzFrameSetLevel(self:getHandleData(), level)
end

function public:getAlpha()
    return private.data[self].alpha
end

---@param alpha number
function public:setAlpha(alpha)
    private.data[self].alpha = alpha
    BlzFrameSetAlpha(self:getHandleData(), alpha)
end

function public:getVisible()
    return BlzFrameIsVisible(self:getHandleData())
end

---@param visible boolean
function public:setVisible(visible)
    BlzFrameSetVisible(self:getHandleData(), visible)
end

---@alias ScreenResolutionUpdateCallback fun(self:SimpleBaseFrame, prev_w:number, prev_h:number, new_w:number, new_h:number)
--- Override this function for resolution changed event.
---@param callback ScreenResolutionUpdateCallback | nil
function public:setUpdateResolutionCallback(callback)
    private.data[self].update_resolution_action = callback and Action.new(callback, self) or nil
end

---@return SimpleBaseFrame | nil
function public:getTooltip()
    return private.data[self].tooltip
end

---@param tooltip SimpleBaseFrame | nil
function public:setTooltip(tooltip)
    private.data[self].tooltip = tooltip
    BlzFrameSetTooltip(self:getHandleData(), tooltip:getHandleData())
    tooltip:setVisible(false)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleBaseFrame
---@param fdf_frame FdfFrame
function private.newData(self, fdf_frame)
    local priv = {
        fdf = fdf_frame,
        update_resolution_action = nil,

        x = 0,
        y = 0,
        width = fdf_frame:getParameter('Width'),
        height = fdf_frame:getParameter('Height'),
        tooltip = nil,
        parent = nil,

        level = 0,
        alpha = 0,

        textures = {},
        strings = {},
        layers = {},
        subframes = {}
    }
    private.data[self] = priv

    local fdf_textures = fdf_frame:getTextures()
    for i = 1, #fdf_textures do
        checkType(fdf_textures[i], FdfTexture, 'fdf_textures['..tostring(i)..']')
        priv.textures[i] = Texture.new(fdf_textures[i])
    end

    local fdf_strings = fdf_frame:getStrings()
    for i = 1, #fdf_strings do
        checkType(fdf_strings[i], FdfString, 'fdf_strings['..tostring(i)..']')
        priv.strings[i] = String.new(fdf_strings[i])
    end

    local fdf_layers = fdf_frame:getLayers()
    for i = 1, #fdf_layers do
        checkType(fdf_layers[i], FdfLayer, 'fdf_layers['..tostring(i)..']')
        priv.layers[fdf_layers[i]:getBaseType()] = Layer.new(fdf_layers[i])
    end

    local fdf_subframes = fdf_frame:getSubframes()
    for i = 1, #fdf_subframes do
        checkType(fdf_subframes[i], SimpleBaseFrame, 'fdf_subframes['..tostring(i)..']')
        priv.subframes[i] = Handle.getLinked(BlzGetFrameByName(fdf_subframes[i]:getName(), 0))
        checkType(priv.subframes[i], private.SimpleBaseFrame, 'linked Handle['..tostring(i)..']')
    end
end

private.screen_pixel_width = 1024
private.screen_pixel_height = 768

private.screen_width = 0.8
private.screen_height = 0.6
private.screen_left_x = 0
private.screen_ratio = private.screen_width / private.screen_height

if not IsCompiletime() then
    private.game_ui_frame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    private.updateResolutionTimer = Timer.new()
    private.updateResolutionTimer:start(3, true, function()
        local cur_screen_width = BlzGetLocalClientWidth()
        local cur_screen_height = BlzGetLocalClientHeight()

        -- No changes
        if cur_screen_width == private.screen_pixel_width and
           cur_screen_height == private.screen_pixel_height then
            return
        end
        local prev_width = private.screen_width
        local prev_height = private.screen_height

        private.screen_pixel_width = cur_screen_width
        private.screen_pixel_height = cur_screen_height

        local ui_pixel_width = cur_screen_height * 4 / 3

        private.screen_width = 0.8 * cur_screen_width / ui_pixel_width
        private.screen_left_x = -(private.screen_width - 0.8) / 2
        private.real_ratio = cur_screen_width / cur_screen_height

        -- Update all frames.
        for frame, priv in pairs(private.data) do
            if priv.update_resolution_action then
                priv.update_resolution_action:run(frame, prev_width, prev_height,
                                                  private.screen_width, private.screen_height)
            end
        end
    end)
end



return static