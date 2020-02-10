--=========
-- Include
--=========

local Class = require('utils.Class.Class')

---@type FrameAPI
local FrameAPI = require('Frame.Api')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleButtonType = FrameAPI.SimpleButtonType
local SimpleFrame = FrameAPI.SimpleFrame
local SimpleButton = FrameAPI.SimpleButton

--=======
-- Class
--=======

local InterfaceUnitBag = Class.new('InterfaceUnitBag', SimpleFrame)
---@class InterfaceUnitBag
local public = InterfaceUnitBag.public
---@class InterfaceUnitBagClass
local static = InterfaceUnitBag.static
---@type InterfaceUnitBagClass
local override = InterfaceUnitBag.override
local private = {}

--=========
-- Static
--=========

---@param cols number
---@param rows number
---@param child_instance InterfaceUnitBag | nil
---@return InterfaceUnitBag
function static.new(cols, rows, child_instance)
    local instance = child_instance or Class.allocate(InterfaceUnitBag)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance, cols, rows)

    return instance
end

--========
-- Public
--========

---@param bag UnitInventoryBag
function public:loadBag(bag)
    local priv
end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.background_type = SimpleFrameType.new('InterfaceUnitBagBackground')

---@param self InterfaceUnitBag
function private.newData(self, cols, rows)
    local priv = {
        size = cols * rows,
        slot = {}
    }
    private.data[self] = priv

    for i = 1, cols do
        priv.slot[i] = {}
    end
end


return static