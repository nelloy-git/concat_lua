local Unit = require('baseClasses.Unit.Main')

---@param animation string
function Unit:playAnimation(animation)
    SetUnitAnimation(self.__unit_obj, animation)
end

---@param animation string
function Unit:queueAnimation(animation)
    QueueUnitAnimation(self:getObj(), animation)
end

---@param scale number
function Unit:setAnimationSpeed(scale)
    SetUnitTimeScale(self.__unit_obj, scale)
end