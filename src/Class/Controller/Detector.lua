--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type SimpleFrameTypeClass
local SimpleFrameType = require('Class.Frame.Types.SimpleFrame')
---@type FrameSimpleFrameClass
local SimpleFrame = require('Class.Frame.Default.SimpleFrame')

--=======
-- Class
--=======

local ControllerDetector = Class.new('ControllerDetector', SimpleFrame)
---@class ControllerDetector : FrameSimpleFrame
local public = ControllerDetector.public
---@class ControllerDetectorClass : FrameSimpleFrameClass
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
    instance = SimpleFrame(private.frame_type, instance)
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
private.frame_type = SimpleFrameType.new('ControllerDetectorFrame')
private.tooltip_type = SimpleFrameType.new('ControllerDetectorTooltip')

---@param self ControllerDetector
function private.newData(self)
    local priv = {
        tooltip = SimpleFrame.new(private.tooltip_type)
    }
    priv.tooltip:setX(-1)
    priv.tooltip:setY(-1)
    self:setTooltip(priv.tooltip)

    private.data[self] = setmetatable(priv, private.metadata)
end

private.metatable = {
    __gc = function(self) end
}

return static