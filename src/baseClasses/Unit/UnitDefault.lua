local Unit = require('baseClasses.Unit.UnitData')

---@param animation string
function Unit:playAnimation(animation)
    SetUnitAnimation(self.__unit_obj, animation)
end