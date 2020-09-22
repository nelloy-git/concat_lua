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
local ParameterLib = require(LibList.ParameterLib) or error('')
local UnitParam = ParameterLib.UnitContainer or error('')
local Param = ParameterLib.Enum or error('')

---@type BuffType
local BuffEffect = require('Hero.CorruptedPriest.LifeForceShieldBuff') or error('')
---@type HeroUtils
local Utils = require('Hero.Utils') or error('')

--==========
-- Settings
--==========

local DrainLifePerSec = 0.05

--========
-- Module
--========

local LifeForceShield = Utils.newAbilAlly('Life Force Shield')
--local LifeForceShield = AbilityLib.Type.new('LifeForceShield')

local casting_period = AbilityLib.TimerPeriod
local percent_per_loop = DrainLifePerSec * casting_period
local drained_life = {}

---@param owner Unit
---@return string
function LifeForceShield:getIcon(owner) return Icon end

---@param owner Unit
---@return string
function LifeForceShield:getTooltip(owner) return 'Tooltip' end

---@param owner Unit
---@return number
function LifeForceShield:getArea(owner) return 0
 end

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
    buffs:add(BuffEffect, owner, 10, drained_life[owner])
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