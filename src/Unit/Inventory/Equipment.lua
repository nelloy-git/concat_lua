--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

--=======
-- Class
--=======

local UnitInventoryEquipment = Class.new('UnitInventoryEquipment')
---@class UnitInventoryEquipment
local public = UnitInventoryEquipment.public
---@class UnitInventoryEquipmentClass
local static = UnitInventoryEquipment.static
---@type UnitInventoryEquipmentClass
local override = UnitInventoryEquipment.override
local private = {}

--=========
-- Static
--=========



---@param child_instance UnitInventoryEquipment | nil
---@return UnitInventoryEquipment
function static.new(child_instance)
    local instance = child_instance or Class.allocate(UnitInventoryEquipment)
    private.newData(instance)

    return instance
end

function static.isUnitInventoryEquipmentType(equpment_type)
end

--========
-- Public
--========



--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self UnitInventoryEquipment
function private.newData(self)
    local priv = {
        slot = {},
        usable = {}
    }
    private.data[self] = priv
end


return static