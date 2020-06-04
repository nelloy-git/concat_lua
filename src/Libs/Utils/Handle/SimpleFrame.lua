--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type ActionClass
local Action = require(lib_modname..'.Action')
---@type HandleClass
local Handle = require(lib_modname..'.Handle.Handle')
---@type TimerClass
local Timer = require(lib_modname..'.Handle.Timer')
---@type UtilsFunctions
local Functions = require(lib_modname..'.Functions')
local checkType = Functions.checkType


--=======
-- Class
--=======

local SimpleFrame = Class.new('SimpleFrame', Handle)
---@class SimpleFrame : Handle
local public = SimpleFrame.public
---@class SimpleFrameClass : HandleClass
local static = SimpleFrame.static
---@type SimpleFrameClass
local override = SimpleFrame.override
local private = {}

--=========
-- Static
--=========

---@param type_name string
---@param child_instance SimpleFrame | nil
---@return SimpleFrame
function override.new(type_name, child_instance)
    checkType(type_name, 'string', 'type_name')
    if child_instance then
        checkType(child_instance, SimpleFrame, 'child_instance')
    end

    local instance = child_instance or Class.allocate(SimpleFrame)
    instance = Handle.new(BlzCreateSimpleFrame(type_name, nil, 0), BlzDestroyFrame, instance)
    private.newData(instance, type_name)

    return instance
end

--========
-- Public
--========

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
function public:getAbsX()
    local priv = private.data[self]

    if priv.parent then
        return priv.parent:getAbsX() + priv.y
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
    BlzFrameSetSize(self:getHandleData(), width, private.data[self].height)
end

---@param height number
function public:setHeight(height)
    BlzFrameSetSize(self:getHandleData(), private.data[self].width, height)
end

---@param width number
---@param height number
function public:setSize(width, height)
    BlzFrameSetSize(self:getHandleData(), width, height)
end

---@return SimpleFrame | nil
function public:getParent()
    return private.data[self].parent
end

---@param parent SimpleFrame | nil
function public:setParent(parent)
    private.data[self].parent = parent
    local handle = self:getHandleData()

    local parent_handle
    if parent then
        checkType(parent, SimpleFrame, 'parent')
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
    return private.data[self].visible
end

---@param visible boolean
function public:setVisible(visible)
    private.data[self].visible = visible
    BlzFrameSetVisible(self:getHandleData(), visible)
end

--- Override this function for resolution changed event.
---@param callback function | nil
function public:setUpdateResolutionCallback(callback)
    private.data[self].update_resolution_action = callback and Action.new(callback, self) or nil
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self SimpleFrame
---@param type_name string
---@return table
function private.newData(self, type_name)
    local priv = {
        type_name = type_name,
        update_resolution_action = nil,

        x = 0,
        y = 0,
        parent = nil,

        level = 0,
        alpha = 0,
        visible = true,
    }
    private.data[self] = priv
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

        private.screen_pixel_width = cur_screen_width
        private.screen_pixel_height = cur_screen_height

        local ui_pixel_width = cur_screen_height * 4 / 3

        private.screen_width = 0.8 * cur_screen_width / ui_pixel_width
        private.screen_left_x = -(private.real_width - 0.8) / 2
        private.real_ratio = cur_screen_width / cur_screen_height

        -- Update all frames.
        for _, priv in pairs(private.data) do
            if priv.update_resolution_action then
                priv.update_resolution_action:run()
            end
        end
    end)
end



return static