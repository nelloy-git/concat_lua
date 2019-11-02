--=========
-- Include
--=========

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Unit
local Unit = require('Class.Unit.Main')

--=======
-- Class
--=======

---@class UnitEquipment
local UnitEquipment  = newClass("UnitEquipment")
UnitEquipment_meta = newMeta(UnitEquipment)
UnitEquipment.__db = DataBase.new('Unit', 'UnitParameterContainer')

function UnitEquipment.new(owner)
    local equipment = {
        
    }

end

return UnitEquipment