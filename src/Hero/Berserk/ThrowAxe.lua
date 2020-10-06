--=========
-- Include
--=========

---@type AbilityLib
local AbilityLib = require(LibList.AbilityExtLib) or error('')
local Event = AbilityLib.Event
---@type AssetLib
local AssetLib = require(LibList.AssetLib) or error('')
local Icon = AssetLib.IconDefault.BTNOrcMeleeUpOne or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
local UnitBuffs = BuffLib.Container or error('')
---@type DamageLib
local DamageLib = require(LibList.DamageLib) or error('')
local dealPhys = DamageLib.dealPhys or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Effect = HandleLib.Effect or error('')
local Projectile = HandleLib.Projectile or error('')
local Unit = HandleLib.Unit or error('')
local Timer = HandleLib.Timer or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamUnit = ParamLib.UnitContainer or error('')
local ParamType = ParamLib.ParamType or error('')

---@type BuffType
local Bleeding = require('Hero.Berserk.Bleeding') or error('')
---@type HeroUtils
local Utils = require('Hero.Utils') or error('')

--==========
-- Settings
--==========

local Range = 600
local AxeWidth = 150
local ManaCost = 50
local CastingTime = 0
local Cooldown = 5
local Charges = 1
local BleedingTime = 10

local ScalePAtk = 15

local AxeModel = 'Abilities\\Weapons\\Axe\\AxeMissile.mdl'
local AxeScale = 1.5
--local AxeModel = 'Objects\\Invalidmodel\\Invalidmodel.mdx'
local AxeSpeed = 500
local AxeOffsetZ = 50

--========
-- Module
--========

local ThrowAxe = Utils.newAbilPoint('Throw Axe')

local axe_dmg = {}
local axe_owner = {}
local axe_targets = {}


local axes = {}
local axe_data = setmetatable({}, {__mode = 'k'})
local cutted = setmetatable({}, {__mode = 'k'})

---@param owner Unit
---@return string
function ThrowAxe:getIcon(owner) return Icon end

---@param owner Unit
---@return string
function ThrowAxe:getTooltip(owner)
    local dmg = ScalePAtk * ParamUnit.get(owner):getResult(ParamType.PATK)
    dmg = dmg - dmg % 1 + 1

    local s_dmg = tostring(dmg)
    s_dmg = s_dmg:sub(1, (s_dmg:find('%.') or (s_dmg:len() + 1)) - 1)

    return 'Throws axe to target position, cutting enemies. Deals '..
           Utils.colorScale(s_dmg, ParamType.PATK)..' damage.'
end

---@param owner Unit
---@return number
function ThrowAxe:getArea(owner) return AxeWidth / 2 end

---@param owner Unit
---@return number
function ThrowAxe:getRange(owner) return Range end

---@param owner Unit
---@return number
function ThrowAxe:getManaCost(owner) return ManaCost end

---@param owner Unit
---@return number
function ThrowAxe:getCastingTime(owner) return CastingTime end

---@param owner Unit
---@return number
function ThrowAxe:getChargeCooldown(owner) return Cooldown end

---@param owner Unit
---@return number
function ThrowAxe:getMaxCharges(owner) return Charges end

---@param abil AbilityExt
local function doNothing(abil)
end

local function axeLoop(axe)
    local list = Unit.getInRange(axe:getX(), axe:getY(), AxeWidth / 2)

    local dmg = axe_dmg[axe]
    local owner = axe_owner[axe]
    local targets = axe_targets[axe]

    for i = 1, #list do
        ---@type Unit
        local cur = list[i]

        if not targets[cur] then
            if cur:isEnemy(owner) then
                dealPhys(dmg, cur, owner)
                UnitBuffs.get(cur):add(Bleeding, owner, BleedingTime, dmg / BleedingTime)
            end
            targets[cur] = true
        end
    end
end

---@param abil AbilityExt
local function onFinish(abil)
    local owner = abil:getOwner()
    local axe = Projectile.new(AxeModel,
                               owner:getX(),
                               owner:getY(),
                               owner:getZ() + AxeOffsetZ)
    axe:setTarget(abil:getTargetPointX(),
                  abil:getTargetPointY())
    axe:setVelocity(AxeSpeed)
    axe:addLoopAction(axeLoop)
    axe:setScale(AxeScale)

    axe_dmg[axe] = ScalePAtk * ParamUnit.get(owner):getResult(ParamType.PATK)
    axe_owner[axe] = owner
    axe_targets[axe] = {}
end

local callbacks = {
    [Event.CASTING_LOOP] = doNothing,
    [Event.CASTING_CANCEL] = doNothing,
    [Event.CASTING_INTERRUPT] = doNothing,
    [Event.CASTING_FINISH] = onFinish,

    [Event.ERROR_NO_CHARGES] = function() print('No charges') end,
}

local errHandler = ThrowAxe.getCallback
---@param event AbilityExtControllerCallback
---@return AbilityExtControllerCallback
function ThrowAxe:getCallback(event)
    local cb = errHandler(event)
    if cb ~= nil then
        return cb
    end
    return callbacks[event]
end

return ThrowAxe