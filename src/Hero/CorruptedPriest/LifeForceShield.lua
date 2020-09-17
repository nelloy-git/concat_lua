--=========
-- Include
--=========

---@type AbilityLib
local AbilityLib = require(LibList.AbilityExtLib) or error('')
---@type AssetLib
local AssetLib = require(LibList.AssetLib) or error('')
local Icon = AssetLib.IconDefault
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
---@type ParameterLib
local ParameterLib = require(LibList.ParameterLib) or error('')

--==========
-- Settings
--==========

local BonusPerMAtk = 0.01
local DrainLifePerSec = 0.05

--========
-- Module
--========

local LifeForceShield = AbilityLib.Type.new('LifeForceShield')

local casting_period = AbilityLib.CastingLoopPeriod
local percent_per_loop = DrainLifePerSec * casting_period
local drained_life = {}


function LifeForceShield:checkConditions(abil)
    return true
end

function LifeForceShield:onCastingStart(target, caster)
end

---@param target AbilityTargetUnit
---@param caster Unit
---@param time_left number
---@param full_time number
function LifeForceShield:onCastingLoop(target, caster, time_left, full_time)
    target = target:getUnit()
    local hp = target:getHealth()
    local max_hp = target:getMaxHealth()
    local perc = hp / max_hp

    drained_life[caster] = (drained_life[caster] or 0) + percent_per_loop * max_hp
    target:setHealth((perc - percent_per_loop) * max_hp)
end

function LifeForceShield:onCastingCancel(target, caster, time_left, full_time)
    target = target:getUnit()
    local params = ParameterLib.UnitContainer.get(caster)
    local matk = params:getResult(ParameterLib.MDMG)

    BuffLib.addShield(drained_life[caster] * (1 + BonusPerMAtk * matk), target)
    drained_life[caster] = nil
end

function LifeForceShield:onCastingInterrupt(target, caster, time_left, full_time)
    target = target:getUnit()
    local params = ParameterLib.UnitContainer.get(caster)
    local matk = params:getResult(ParameterLib.MDMG)

    BuffLib.addShield(drained_life[caster] * (1 + BonusPerMAtk * matk), target)
    drained_life[caster] = nil
end

function LifeForceShield:onCastingFinish(target, caster, time_left, full_time)
    target = target:getUnit()
    local params = ParameterLib.UnitContainer.get(caster)
    local matk = params:getResult(ParameterLib.MDMG)

    BuffLib.addShield(drained_life[caster] * (1 + BonusPerMAtk * matk), target)
    drained_life[caster] = nil
end

function LifeForceShield:getCastingTime(caster)
    return 3
end

function LifeForceShield:getChargesForUse()
    return 1
end

function LifeForceShield:getChargeCooldown(abil)
    return 10
end

function LifeForceShield:getChargesMax(abil)
    return 1
end

function LifeForceShield:getName()
    return 'Life Force Shield'
end

function LifeForceShield:getRange(owner)
    return 500
end

function LifeForceShield:getArea(owner)
    return 0
end

function LifeForceShield:getTargetingType(owner)
    return 'Unit'
end

function LifeForceShield:getTargetsAllowed(owner)
    return 'friend'
end

function LifeForceShield:getManaCost(owner)
    return 50
end

function LifeForceShield:getHealthCost(owner)
    return 0
end

function LifeForceShield:getIcon(owner)
    return Icon.BTNAbsorbMagic
end

function LifeForceShield:getTooltip(owner)
    return 'TestTooltip'
end


return LifeForceShield