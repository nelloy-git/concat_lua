--=========
-- Include
--=========

---@type Wc3AbilityExt
local Wc3AbilityExt = require(LibManager.load('https://github.com/nelloy-git/Wc3AbilityExt.git'))
local DataType = Wc3AbilityExt.DataType
---@type Wc3Handle
local Wc3Handle = require(LibManager.load('https://github.com/nelloy-git/Wc3Handle.git'))
local Unit = Wc3Handle.Unit
---@type Wc3Parameter
local Wc3Parameter = require(LibManager.load('https://github.com/nelloy-git/Wc3Parameter.git'))
local ParamUnit = Wc3Parameter.UnitContainer
local ParamMATK = Wc3Parameter.ParameterType.enum.MATK
---@type Wc3Utils
local Wc3Utils = require(LibManager.load('https://github.com/nelloy-git/Wc3Utils.git'))
local isType = Wc3Utils.isType or error('')

---@type LifeForceShieldSettings
local Settings = require('Hero.CorruptedPriest.LifeForceShield.Settings')
local LifeDrainPerSec = Settings.LifeDrainPerSec
local BonusShieldPerMAtk = Settings.BonusShieldPerMAtk

--========
-- Module
--========

local AbilData = DataType.new()

function AbilData:getName(abil)
    return 'Life Force Shield'
end

function AbilData:getIcon(abil)
    return ''
end

function AbilData:getTooltip(abil)
    local percent = 100 * LifeDrainPerSec
    percent = percent - percent % 1
    local matk = ParamUnit.get(abil:getOwner()):getResult(ParamMATK)
    local bonus = 100 * BonusShieldPerMAtk * matk
    bonus = bonus - bonus % 1 + 1

    return 'Consumes '..tostring(percent)..'% of target ally unit per second.'..
           'At the end of the cast gives shield to the target for '..
           'drained life increased by |c'..ParamMATK:getStrColor()..tostring(bonus)..'|r%'
end

function AbilData:getManaCost(abil)
    return 20
end
function AbilData:getCooldown(abil)
    return 10
end

function AbilData:getCastingTime(abil)
    return 5
end

---@param abil AbilityExt
function AbilData:isAvailable(abil)
    return (abil:getOwner():getMana() > self:getManaCost(abil)) and
           (abil:getCharges():get() >= self:getChargesForUse(abil))
end

---@param abil AbilityExt
function AbilData:consume(abil)
    local owner = abil:getOwner()
    owner:setMana(owner:getMana() - self:getManaCost())

    local charges = abil:getCharges()
    charges:set(charges:get() - 1)
end

---@param abil AbilityExt
function AbilData:checkTarget(abil, target)
    if isType(target, Unit) and
       not abil:getOwner():isEnemy(target) then
        return true
    end
    return false
end

return AbilData