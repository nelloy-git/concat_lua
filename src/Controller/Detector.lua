--=========
-- Include
--=========

local Class = require('Utils.Class.API')

---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleFrameTypeClass
local SimpleButtonType = require('Frame.Type.SimpleButton')
---@type SimpleFrameClass
local SimpleFrame = require('Frame.Default.SimpleFrame')
---@type SimpleButtonClass
local SimpleButton = require('Frame.Default.SimpleButton')

--=======
-- Class
--=======

local ControllerDetector = Class.new('ControllerDetector', SimpleButton)
---@class ControllerDetector : SimpleFrame
local public = ControllerDetector.public
---@class ControllerDetectorClass : SimpleFrameClass
local static = ControllerDetector.static
---@type ControllerDetectorClass
local override = ControllerDetector.override
local private = {}

--=========
-- Static
--=========

---@return ControllerDetector
function override.new()
    local instance = Class.allocate(ControllerDetector)
    instance = SimpleButton.new(private.frame_type, instance)
    private.newData(instance)

    return instance
end

--========
-- Public
--========

--- Returns true if mouse inside.
function public:detect()
    return private.data[self].tooltip:isVisible()
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.frame_type = SimpleButtonType.new('ControllerDetectorButton')
private.tooltip_type = SimpleFrameType.new('ControllerDetectorTooltip')

---@param self ControllerDetector
function private.newData(self)
    local priv = {
        tooltip = SimpleFrame.new(private.tooltip_type)
    }
    --priv.tooltip:setParent(self)
    priv.tooltip:setX(-0.2)
    priv.tooltip:setY(0)
    priv.tooltip:setWidth(0.05)
    priv.tooltip:setHeight(0.05)
    priv.tooltip:setTexture('')

    self:setTooltip(priv.tooltip)

    private.data[self] = priv
end

return static