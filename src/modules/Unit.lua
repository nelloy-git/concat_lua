local Unit = {}

require('blizzard.common')

local Unit_mt = {__index = Unit}

function Unit.new(player, unitId, x, y, face)
    local u = {}
    setmetatable(u, Unit_mt)
    u.unit = CreateUnit(player, unitId, x, y, face)
    return u
end

function Unit:show(this, bool) ShowUnit(this.unit, bool) end
function Unit:setX(x) SetUnitX(self.unit, x) end
function Unit:setY(y) SetUnitY(self.unit, y) end
function Unit:setPos(x, y) SetUnitPosition(self.unit, x, y) end
function Unit:setFacing(angle) SetUnitFacing(self.unit, angle) end
function Unit:setFacingTimed(angle, duration) SetUnitFacingTimed(self.unit, angle, duration) end
function Unit:setMoveSpeed(speed) SetUnitMoveSpeed(self.unit, speed) end
function Unit:setFlyHeight(height, rate) SetUnitFlyHeight(self.unit, height, rate) end
function Unit:setTurnSpeed(turnSpeed) SetUnitTurnSpeed(self.unit, turnSpeed) end
function Unit:setPropWindowAngle(angle) SetUnitPropWindow(self.unit, angle) end
function Unit:setAcquireRange(range) SetUnitAcquireRange(self.unit, range) end

return unit
