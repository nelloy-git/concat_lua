local Unit = require('baseClasses.Unit.UnitData')

function Unit:setLifetime(time)
    UnitApplyTimedLife(self:getObj(), nil, time)
end

--- Can not be canceled.
function Unit:setUntargetableAndInvulnerable()
    UnitAddAbility(self:getObj(), 'Aloc')
end

function Unit:setInvulnerable(flag)
    SetUnitInvulnerable(self:getObj(), flag)
end

--- Can not be canceled.
function Unit:setUntargetable()
    UnitAddAbility(self:getObj(), 'Aloc')
    UnitRemoveAbility(self:getObj(), 'Aloc')
end
