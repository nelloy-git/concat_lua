--=========
-- Include
--=========

---@type AbilityLib
local AbilityLib = require(LibList.AbilityExtLib) or error('')
local TargetingFriend = AbilityLib.Targeting.Friend or error('')
local Casting = AbilityLib.Casting.Type or error('')
local Data = AbilityLib.Data.Type or error('')
---@type AssetLib
local AssetLib = require(LibList.AssetLib) or error('')
local Icon = AssetLib.IconDefault.BTNAbsorbMagic or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
local UnitBuffs = BuffLib.Container or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local TimedObj = HandleLib.TimedObj or error('')
local Unit = HandleLib.Unit or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamUnit = ParamLib.UnitContainer or error('')
local paramToColor = ParamLib.paramToColor or error('')
local ParamType = ParamLib.ParamType or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isType = UtilsLib.isType or error('')

---@type BuffType
local BuffEffect = require('Hero.CorruptedPriest.LifeForceShieldBuff') or error('')

--==========
-- Settings
--==========

local CastingPeriod = TimedObj.getPeriod()

local DrainLifePerSec = 0.05
local BonusPerMAtk = 0.01

--======
-- Data
--======

local LifeDrained = {}

--========
-- Module
--========

local DataType = Data.new()
function DataType:getName(abil) return 'Life Force Shield' end
function DataType:getIcon(abil) return Icon end
function DataType:getTooltip(abil)
    local percent = 100 * DrainLifePerSec
    percent = percent - percent % 1
    local bonus = 100 * BonusPerMAtk * ParamUnit.get(abil:getOwner()):getResult(ParamType.MATK)
    bonus = bonus - bonus % 1 + 1

    return 'Consumes '..tostring(percent)..'% of target ally unit per second.'..
           'At the end of the cast gives shield to the target for '..
           'drained life increased by |c'..paramToColor(ParamType.MATK)..tostring(bonus)..'|r%'
end
function DataType:getManaCost(abil) return 20 end
function DataType:getCooldown(abil) return 10 end
function DataType:getCastingTime(abil) return 5 end

---@param abil AbilityExt
function DataType:isAvailable(abil)
    return (abil:getOwner():getMana() > self:getManaCost(abil)) and
           (abil:getCharges():get() >= self:getChargesForUse(abil))
end

---@param abil AbilityExt
function DataType:consume(abil)
    local owner = abil:getOwner()
    owner:setMana(owner:getMana() - self:getManaCost())

    local charges = abil:getCharges()
    charges:set(charges:get() - 1)
end

---@param abil AbilityExt
function DataType:checkTarget(abil, target)
    if isType(target, Unit) and
       not abil:getOwner():isEnemy(target) then
        return true
    end
    return false
end








local CastingType = Casting.new()

---@param abil AbilityExt
function CastingType:loop(abil)
    local target = abil:getTarget()

    local hp = target:getHealth()
    local max_hp = target:getMaxHealth()
    local perc = hp / max_hp

    LifeDrained[abil] = (LifeDrained[abil] or 0) + DrainLifePerSec * CastingPeriod * max_hp
    target:setHealth((perc - DrainLifePerSec * CastingPeriod) * max_hp)
end

---@param abil AbilityExt
local function endCasting(abil)
    local owner = abil:getOwner()
    local target = abil:getTarget()

    local buffs = UnitBuffs.get(target)
    local matk = ParamUnit.get(owner):getResult(ParamType.MATK)
    buffs:add(BuffEffect, owner, 10, LifeDrained[abil] * (1 + BonusPerMAtk * matk))
    LifeDrained[abil] = nil
end

function CastingType:cancel(abil)
    endCasting(abil)
end

function CastingType:interrupt(abil)
    endCasting(abil)
end

function CastingType:finish(abil)
    endCasting(abil)
end

return AbilityLib.Type.new(TargetingFriend, CastingType, DataType)