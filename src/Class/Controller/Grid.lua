--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type ControllerDetectorClass
local Detector = require('Class.Controller.Detector')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Class.Frame.Types.SimpleFrame')
---@type FrameSimpleFrameClass
local SimpleFrame = require('Class.Frame.Default.SimpleFrame')

--=======
-- Class
--=======

local ControllerGrid = Class.new('ControllerGrid', SimpleFrame)
---@class ControllerGrid
local public = ControllerGrid.public
---@class ControllerGridClass
local static = ControllerGrid.static
---@type ControllerGridClass
local override = ControllerGrid.override
local private = {}

--=========
-- Static
--=========

---@param x number
---@param y number
---@param width number
---@param height number
---@return ControllerGrid
function static.new(x, y, width, height, res_x, res_y)
    local instance = Class.allocate(ControllerGrid)
    instance = SimpleFrame(private.frame_type, instance)
    private.newData(instance, width, height, res_x, res_y)

    instance:setX(x)
    instance:setY(y)
    instance:setWidth(width)
    instance:setHeight(height)

    return instance
end

--========
-- Public
--========

---@return table | nil
function public:detect()
    local priv = private.data[self]
    for x = 1, priv.res_x do
        for y = 1, priv.res_y do
            if priv.detectors[x][y]:detect() then
                local abs_x = self:getAbsX()
                local abs_y = self:getAbsY()
                local res = {
                    min_x = abs_x + priv.detector_width * (x - 1),
                    min_y = abs_y + priv.detector_height * (y - 1),
                    max_x = abs_x + priv.detector_width * x,
                    max_y = abs_y + priv.detector_height * y
                }
                return res
            end
        end
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self ControllerGrid
function private.newData(self, width, height, res_x, res_y)
    local priv = {
        res_x = res_x,
        res_y = res_y,
        detector_width = width / res_x,
        detector_height = height / res_y,

        detectors = {}
    }
    for x = 1, res_x do
        table.insert(priv.detectors, {})
        for y = 1, res_y do
            local detector = Detector.new()
            detector:setX(priv.detector_width * (x - 1))
            detector:setY(priv.detector_height * (y - 1))
            detector:setWidth(priv.detector_width)
            detector:setHeight(priv.detector_height)
            detector:setParent(self)

            priv.detectors[x][y] = detector
        end
    end

    private.data[self] = setmetatable(priv, private.metadata)
end

private.metatable = {
    __gc = function(self) end
}

return static