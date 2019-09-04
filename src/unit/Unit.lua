---@type UnitParameterContainer
local ParameterContainer = require('unitParameter.UnitParameterContainer')
---@type DataBase
local DataBase = require('utils.DataBase')

---@class Unit
local Unit = {
    __type = 'ClassUnit',
    __db = DataBase.new('userdata', 'Unit')
}

local Unit_meta = {
    __type = 'Unit',
    __index = Unit,
    __tostring = function(self)
        return string.format('Unit %s (%s) at [%.2f, %.2f, %.2f]',
                             self:getName(), ID2str(self:getId()), self:getX(), self:getY(), self:getZ())
    end,
    __gc = Unit.destroy
}

---@param player player
---@param id string | integer
---@param x number
---@param y number
---@param face number
---@return Unit
function Unit.new(player, id, x, y, face, is_dead)
    id = ID(id)
    local unit_obj
    if is_dead then
        unit_obj = CreateCorpse(player, id, x, y, face)
    else
        unit_obj = CreateUnit(player, id, x, y, face)
    end
    ---@type Unit
    local unit = {
        __id = id,
        __unit_obj = unit_obj
    }
    setmetatable(unit, Unit_meta)
    Unit.__db:add(unit.__unit_obj, unit)

    unit:initCustomData()

    return unit
end

---@param unit unit
function Unit.get(unit)
    Unit.__db:get(unit)
end

function Unit:destroy()
    self:destroyCustomData()

    Unit.__db:rm(self.__unit_obj)
    RemoveUnit(self.__unit_obj)
    self.__unit_obj = nil
end

---@return unit
function Unit:getObj()
    return self.__unit_obj
end

---Initialize unit custom data.
function Unit:initCustomData()
    ---@type UnitParameterContainer
    self.parameter = runFuncInDebug(ParameterContainer.new, self.__unit_obj)
end

---Destroy unit custom data.
function Unit:destroyCustomData()
end

---@return integer
function Unit:getId()
    return self.__id
end

---@return string
function Unit:getName()
    return GetUnitName(self.__unit_obj)
end

---Function sets unit color. Colors should be in range [0 : 1].
---@param red number
---@param green number
---@param blue number
---@param alpha number
function Unit:setVertexColor(red, green, blue, alpha)
    red = math.floor(255 * torange(red, 0, 1))
    green = math.floor(255 * torange(green, 0, 1))
    blue = math.floor(255 * torange(blue, 0, 1))
    alpha = math.floor(255 * torange(alpha, 0, 1))
    SetUnitVertexColor(self.__unit_obj, red, green, blue, alpha)
end

---@return integer
function Unit:getOwningPlayer()
    return GetOwningPlayer(self.__unit_obj)
end

---@param pos Vec2
function Unit:setPos2(pos)
    self:setX(pos.x)
    self:setY(pos.y)
end

---@param pos Vec3
function Unit:setPos3(pos)
    self:setX(pos.x)
    self:setY(pos.y)
    self:setZ(pos.z)
end

---@param x number
function Unit:setX(x)
    SetUnitX(self.__unit_obj, x)
end

---@param y number
function Unit:setY(y)
    SetUnitY(self.__unit_obj, y)
end

---@param z number
function Unit:setZ(z)
    self:setFlyHeight(z - GetTerrainZ(self:getX(), self:getY()))
end

---@return Vec2
function Unit:getPos2()
    return Vec2.new(self:getX(), self:getY())
end

---@return Vec3
function Unit:getPos3()
    return Vec3.new(self:getX(), self:getY(), self:getZ())
end

---@return number
function Unit:getX()
    return GetUnitX(self.__unit_obj)
end

---@return number
function Unit:getY()
    return GetUnitY(self.__unit_obj)
end

---@return number
function Unit:getZ()
    return GetTerrainZ(self:getX(), self:getY()) + self:getFlyHeight()
end

---@return number
function Unit:getFlyHeight()
    return GetUnitFlyHeight(self.__unit_obj)
end

---@return number
function Unit:setFlyHeight(height)
    return SetUnitFlyHeight(self.__unit_obj, height)
end

---@return number
function Unit:getDefaultsFlyHeight()
    return GetUnitDefaultFlyHeight(self.__unit_obj)
end

---@param angle number
---@param time number|nil
function Unit:setFacing(angle, time)
    if time == nil or time <= 0 then
        SetUnitFacing(self.__unit_obj, angle)
    else
        SetUnitFacingTimed(self.__unit_obj, angle, time)
    end
end

---@param target Vec2
---@param time number|nil
function Unit:setFacingTo(target, time)
    local x, y = self:getPos()
    local angle = 180 + (180 / math.pi) * math.atan(y - target.y, x - target.x)
    self:setFacing(angle, time)
end

---@return number
function Unit:getFacing()
    return GetUnitFacing(self.__unit_obj)
end

---@return number
function Unit:getMoveSpeed()
    return GetUnitMoveSpeed(self.__unit_obj)
end

---@param speed number
function Unit:setMoveSpeed(speed)
    SetUnitMoveSpeed(self.__unit_obj, speed)
end

---@return number
function Unit:getTurnSpeed()
    return GetUnitTurnSpeed(self.__unit_obj)
end

---@param speed number
function Unit:setTurnSpeed(speed)
    SetUnitTurnSpeed(self.__unit_obj, speed)
end

---@return number
function Unit:getDefaultTurnSpeed()
    return GetUnitDefaultTurnSpeed(self.__unit_obj)
end

---@param ability_id integer
function Unit:addAbility(ability_id)
    UnitAddAbility(self.__unit_obj, ability_id)
end

---@param ability_id integer
function Unit:removeAbility(ability_id)
    UnitRemoveAbility(self.__unit_obj, ability_id)
end

---@param ability_id integer
---@return integer
function Unit:getAbilityLevel(ability_id)
    return GetUnitAbilityLevel(self.__unit_obj, ability_id)
end

---@param ability_id integer
function Unit:setAbilityLevel(ability_id)
    SetUnitAbilityLevel(self.__unit_obj, ability_id)
end

---@param flag boolean
function Unit:setInvulnerable(flag)
    SetUnitInvulnerable(self.__unit_obj, flag)
end

---@param time number
function Unit:applyTimedLife(time)
    UnitApplyTimedLife(self.__unit_obj, 0, time)
end

---@param order_id integer
function Unit:issueImmediateOrderById(order_id)
    IssueImmediateOrderById(self.__unit_obj, order_id)
end

function Unit:orderStop()
    self:issueImmediateOrderById(851972)
end

---@param order_id integer
---@param x number
---@param y number
function Unit:issuePointOrderById(order_id, x, y)
    IssuePointOrderById(self.__unit_obj, order_id, x, y)
end

---@param speed number
function Unit:setMoveSpeed(speed)
    SetUnitMoveSpeed(self.__unit_obj, speed)
end

---@param speed number
function Unit:setTurnSpeed(speed)
    SetUnitTurnSpeed(self.__unit_obj, speed)
end

---@param animation string
function Unit:playAnimation(animation)
    SetUnitAnimation(self.__unit_obj, animation)
end

---@param scale number
function Unit:setAnimationSpeed(scale)
    SetUnitTimeScale(self.__unit_obj, scale)
end

function Unit:pause()
    PauseUnit(self.__unit_obj, true)
end

function Unit:unpause()
    PauseUnit(self.__unit_obj, false)
end

---@return Unit
function Unit.get(wc3_unit)
    return Unit.__db:get(wc3_unit)
end
---@return Unit
function Unit.GetLevelingUnit()
    return Unit.__db:get(GetLevelingUnit())
end
---@return Unit
function Unit.GetLearningUnit()
    return Unit.__db:get(GetLearningUnit())
end
---@return Unit
function Unit.GetRevivableUnit()
    return Unit.__db:get(GetRevivableUnit())
end
---@return Unit
function Unit.GetRevivingUnit()
    return Unit.__db:get(GetRevivingUnit())
end
---@return Unit
function Unit.GetAttacker()
    return Unit.__db:get(GetAttacker())
end
---@return Unit
function Unit.GetRescuer()
    return Unit.__db:get(GetRescuer())
end
---@return Unit
function Unit.GetDyingUnit()
    return Unit.__db:get(GetDyingUnit())
end
---@return Unit
function Unit.GetKillingUnit()
    return Unit.__db:get(GetKillingUnit())
end
---@return Unit
function Unit.GetDecayingUnit()
    return Unit.__db:get(GetDecayingUnit())
end
---@return Unit
function Unit.GetConstructingStructure()
    return Unit.__db:get(GetConstructingStructure())
end
---@return Unit
function Unit.GetCancelledStructure()
    return Unit.__db:get(GetCancelledStructure())
end
---@return Unit
function Unit.GetConstructedStructure()
    return Unit.__db:get(GetConstructedStructure())
end
---@return Unit
function Unit.GetResearchingUnit()
    return Unit.__db:get(GetResearchingUnit())
end
---@return Unit
function Unit.GetTrainedUnit()
    return Unit.__db:get(GetTrainedUnit())
end
---@return Unit
function Unit.GetDetectedUnit()
    return Unit.__db:get(GetDetectedUnit())
end
---@return Unit
function Unit.GetSummoningUnit()
    return Unit.__db:get(GetSummoningUnit())
end
---@return Unit
function Unit.GetSummonedUnit()
    return Unit.__db:get(GetSummonedUnit())
end
---@return Unit
function Unit.GetTransportUnit()
    return Unit.__db:get(GetTransportUnit())
end
---@return Unit
function Unit.GetLoadedUnit()
    return Unit.__db:get(GetLoadedUnit())
end
---@return Unit
function Unit.GetSellingUnit()
    return Unit.__db:get(GetSellingUnit())
end
---@return Unit
function Unit.GetSoldUnit()
    return Unit.__db:get(GetSoldUnit())
end
---@return Unit
function Unit.GetBuyingUnit()
    return Unit.__db:get(GetBuyingUnit())
end
---@return Unit
function Unit.GetChangingUnit()
    return Unit.__db:get(GetChangingUnit())
end
---@return Unit
function Unit.GetManipulatingUnit()
    return Unit.__db:get(GetManipulatingUnit())
end
---@return Unit
function Unit.GetOrderedUnit()
    return Unit.__db:get(GetOrderedUnit())
end
---@return Unit
function Unit.GetOrderTargetUnit()
    return Unit.__db:get(GetOrderTargetUnit())
end
---@return Unit
function Unit.GetSpellAbilityUnit()
    return Unit.__db:get(GetSpellAbilityUnit())
end
---@return Unit
function Unit.GetSpellTargetUnit()
    return Unit.__db:get(GetSpellTargetUnit())
end
---@return Unit
function Unit.GetTriggerUnit()
    return Unit.__db:get(GetTriggerUnit())
end
---@return Unit
function Unit.GetEventDamage()
    return Unit.__db:get(GetEventDamage())
end
---@return Unit
function Unit.GetEventDamageSource()
    return Unit.__db:get(GetEventDamageSource())
end
---@return Unit
function Unit.GetEventTargetUnit()
    return Unit.__db:get(GetEventTargetUnit())
end

return Unit