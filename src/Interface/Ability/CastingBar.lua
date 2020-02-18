--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleButton = FrameAPI.SimpleButton
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleTextType = FrameAPI.SimpleTextType
local SimpleText = FrameAPI.SimpleText
local FramePublic = Class.getPublic(FrameAPI.Frame)

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



--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceAbilityCastingBar
function private.newData(self)
    local priv = {
    }
    private.data[self] = priv
end

return static