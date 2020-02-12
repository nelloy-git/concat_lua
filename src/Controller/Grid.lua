--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type ControllerDetectorClass
local Detector = require('Class.Controller.Detector')
---@type SimpleFrameTypeClass
local SimpleFrameType = require('Frame.Type.SimpleFrame')
---@type SimpleFrameClass
local SimpleFrame = require('Frame.Default.SimpleFrame')

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
function override.new(x, y, width, height, res_x, res_y)
    local instance = Class.allocate(ControllerGrid)
    instance = SimpleFrame.new(private.frame_type, instance)
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
                return x, y
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

    self:setTexture('war3mapImported\\frameFiles\\Transparent32x32.tga')
    for x = 1, res_x do
        table.insert(priv.detectors, {})
        for y = 1, res_y do
            local detector = Detector.new()
            detector:setParent(self)
            detector:setX(priv.detector_width * (x - 1))
            detector:setY(priv.detector_height * (y - 1))
            detector:setWidth(priv.detector_width)
            detector:setHeight(priv.detector_height)
            detector:setTexture('war3mapImported\\frameFiles\\Transparent32x32.tga')

            priv.detectors[x][y] = detector
        end
    end

    private.data[self] = priv
end


private.frame_type = SimpleFrameType.new('ControllerGrid')

return static