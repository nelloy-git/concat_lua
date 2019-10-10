--==========
-- Includes
--==========

--=======
-- Class
--=======

---@class EquipType
local EquipType = newClass('EquipType')
local EquipType_meta = newMeta(EquipType)

EquipType.Id  = {
    HEAD      = 1,
    NECKLACE  = 2,
    SHOULDER  = 3,
    CHEST     = 4,
    BELT      = 5,
    LEGS      = 6,
    BOOTS     = 7,
    WEAPON    = 8,
    EARRING_1 = 9,
    EARRING_2 = 10,
    RING_1    = 11,
    RING_2    = 12,
    BRACERS   = 13,
    GLOVES    = 14,
    BAG       = 15,
    OFFHAND   = 16,
    USABLE    = 17
}

---@param id number
---@return EquipType
local function newEquipType(id)
    local param_type = {
        __id = id
    }
    setmetatable(param_type, EquipType_meta)

    return param_type
end

function EquipType.init()
    EquipType.HEAD      = newEquipType(EquipType.Id.HEAD)
    EquipType.NECKLACE  = newEquipType(EquipType.Id.NECKLACE)
    EquipType.SHOULDER  = newEquipType(EquipType.Id.SHOULDER)
    EquipType.CHEST     = newEquipType(EquipType.Id.CHEST)
    EquipType.BELT      = newEquipType(EquipType.Id.BELT)
    EquipType.LEGS      = newEquipType(EquipType.Id.LEGS)
    EquipType.BOOTS     = newEquipType(EquipType.Id.BOOTS)
    EquipType.WEAPON    = newEquipType(EquipType.Id.WEAPON)
    EquipType.EARRING_1 = newEquipType(EquipType.Id.EARRING_1)
    EquipType.EARRING_2 = newEquipType(EquipType.Id.EARRING_2)
    EquipType.RING_1    = newEquipType(EquipType.Id.RING_1)
    EquipType.RING_2    = newEquipType(EquipType.Id.RING_2)
    EquipType.BRACERS   = newEquipType(EquipType.Id.BRACERS)
    EquipType.GLOVES    = newEquipType(EquipType.Id.GLOVES)
    EquipType.BAG       = newEquipType(EquipType.Id.BAG)
    EquipType.OFFHAND   = newEquipType(EquipType.Id.OFFHAND)
    EquipType.OFFHAND   = newEquipType(EquipType.Id.USABLE)
end

---@return number
function EquipType:getId()
    return self.__id
end

return EquipType