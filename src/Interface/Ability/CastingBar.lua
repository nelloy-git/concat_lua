--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleStatusBarType = FrameAPI.SimpleStatusBarType
local SimpleStatusBar = FrameAPI.SimpleStatusBar

--=======
-- Class
--=======

local InterfaceAbilityCastingBar = Class.new('InterfaceAbilityCastingBar')
---@class InterfaceAbilityCastingBar
local public = InterfaceAbilityCastingBar.public
---@class InterfaceAbilityCastingBarClass
local static = InterfaceAbilityCastingBar.static
---@type InterfaceAbilityCastingBarClass
local override = InterfaceAbilityCastingBar.override
local private = {}

--=========
-- Static
--=========

---@param child_instance InterfaceAbilityCastingBar | nil
---@return InterfaceAbilityCastingBar
function static.new(max_bars, child_instance)
    local instance = child_instance or Class.allocate(InterfaceAbilityCastingBar)
    private.newData(instance, max_bars)

    return instance
end

--========
-- Public
--========

---@param x number
function public:setX(x)
    private.data[self].bar[1]:setX(x)
end

---@param y number
function public:setY(y)
    private.data[self].bar[1]:setY(y)
end

---@param width number
function public:setWidth(width)
    private.data[self].bar[1]:setWidth(width)
end

---@param height number
function public:setHeight(height)
    private.data[self].bar[1]:setHeight(height)
end

function public:setStatus(pos, status)
    local priv = private.data[self]

    priv.bar[pos]:setVisible(status ~= 0)
    priv.bar[pos]:setStatus(status)
end

function public:getSize()
    return private.data[self].max_bars
end

function public:setText(text)
    private.data[self].bar[1]:setText(text)
end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.bar_type = SimpleStatusBarType.new('CastingBar', true)
private.bar_type:setWidth(0.2)
private.bar_type:setHeight(0.04)

---@param self InterfaceAbilityCastingBar
function private.newData(self, max_bars)
    local priv = {
        max_bars = max_bars,
        bar = {}
    }
    private.data[self] = priv

    for i = 1, max_bars do
        local bar = SimpleStatusBar.new(private.bar_type)
        bar:setX(0.4)
        bar:setY(0.3)
        bar:setWidth(0.2)
        bar:setHeight(0.05)
        bar:setText('Casting')
        bar:setVisible(false)

        priv.bar[i] = bar
    end
end

return static