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
function static.new(child_instance)
    local instance = child_instance or Class.allocate(InterfaceAbilityCastingBar)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

function public:setStatus(pos, status)
    local priv = private.data[self]

    priv.bar[pos]:setVisible(status ~= 0)
    priv.bar[pos]:setStatus(status)
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
        bar:setVisible(false)

        priv.bar[i] = bar
    end
end

return static