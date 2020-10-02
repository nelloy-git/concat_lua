--=========
-- Include
--=========

---@type AbilityLib
local AbilityLib = require(LibList.AbilityExtLib) or error('')
local Event = AbilityLib.Event
---@type AssetLib
local AssetLib = require(LibList.AssetLib) or error('')
local Icon = AssetLib.IconDefault.BTNAbsorbMagic or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
local UnitBuffs = BuffLib.Container or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamUnit = ParamLib.UnitContainer or error('')
local ParamType = ParamLib.ParamType or error('')

---@type BuffType
local BuffEffect = require('Hero.CorruptedPriest.LifeForceShieldBuff') or error('')
---@type HeroUtils
local Utils = require('Hero.Utils') or error('')

--==========
-- Settings
--==========

local DrainLifePerSec = 0.05
local BonusPerMAtk = 0.01

--========
-- Module
--========

local LifeForceShield = Utils.newAbilAlly('Life Force Shield')

local casting_period = AbilityLib.getLoopPeriod()
local percent_per_loop = DrainLifePerSec * casting_period
local drained_life = {}

---@param owner Unit
---@return string
function LifeForceShield:getIcon(owner) return Icon end

---@param owner Unit
---@return string
function LifeForceShield:getTooltip(owner)
    local percent = 100 * DrainLifePerSec
    percent = percent - percent % 1

    local bonus = 100 * BonusPerMAtk * ParamUnit.get(owner):getResult(ParamType.MATK)
    bonus = bonus - bonus % 1 + 1

    return 'Consumes '..tostring(percent)..'% of target ally unit per second.'..
           'At the end of the cast gives shield to the target for '..
           'drained life increased by '..Utils.colorScale(bonus, ParamType.MATK)..'%'
end

---@param owner Unit
---@return number
function LifeForceShield:getArea(owner) return 0 end

---@param owner Unit
---@return number
function LifeForceShield:getRange(owner) return 500 end

---@param owner Unit
---@return number
function LifeForceShield:getManaCost(owner) return 20 end

---@param owner Unit
---@return number
function LifeForceShield:getCastingTime(owner) return 4 end

---@param owner Unit
---@return number
function LifeForceShield:getChargeCooldown(owner) return 10 end

---@param owner Unit
---@return number
function LifeForceShield:getMaxCharges(owner) return 5 end

---@param abil AbilityExt
local function onCasting(abil)
    local owner = abil:getOwner()
    local target = abil:getTargetUnit()

    local hp = target:getHealth()
    local max_hp = target:getMaxHealth()
    local perc = hp / max_hp

    drained_life[owner] = (drained_life[owner] or 0) + percent_per_loop * max_hp
    target:setHealth((perc - percent_per_loop) * max_hp)
end

---@param abil AbilityExt
local function onEnd(abil)
    local owner = abil:getOwner()
    local target = abil:getTargetUnit()

    local buffs = UnitBuffs.get(target)
    local matk = ParamUnit.get(owner):getResult(ParamType.MATK)
    buffs:add(BuffEffect, owner, 10, drained_life[owner] * (1 + BonusPerMAtk * matk))
    drained_life[owner] = nil
end

local callbacks = {
    [Event.CASTING_LOOP] = onCasting,
    [Event.CASTING_CANCEL] = onEnd,
    [Event.CASTING_INTERRUPT] = onEnd,
    [Event.CASTING_FINISH] = onEnd,

    [Event.ERROR_NO_CHARGES] = function() print('No charges') end,
}

local errHandler = LifeForceShield.getCallback
---@param event AbilityExtControllerCallback
---@return AbilityExtControllerCallback
function LifeForceShield:getCallback(event)
    local cb = errHandler(event)
    if cb ~= nil then
        return cb
    end
    return callbacks[event]
end

return LifeForceShield