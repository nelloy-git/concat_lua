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
local Width = 100
local ManaCost = 50
local CastingTime = 0
local Cooldown = 5
local Charges = 1
local BleedingTime = 10

local ScalePAtk = 15

local AxeModel = 'Objects\\Invalidmodel\\Invalidmodel.mdx'
local AxeSpeed = 1000
local AxeOffsetZ = 50

--========
-- Module
--========

local ThrowAxe = Utils.newAbilPoint('Throw Axe')

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
function ThrowAxe:getArea(owner) return Width end

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

---@param abil AbilityExt
local function onFinish(abil)
    local owner = abil:getOwner()
    local axe =  Effect.new(AxeModel,
                            owner:getX(),
                            owner:getY(),
                            owner:getZ() + AxeOffsetZ)
    table.insert(axes, axe)

    local dx = abil:getTargetPointX() - owner:getX()
    local dy = abil:getTargetPointY() - owner:getY()
    local r = (dx * dx + dy * dy)^0.5

    axe_data[axe] = {owner = owner,
                     dmg = ScalePAtk * ParamUnit.get(owner):getResult(ParamType.PATK),
                     r_x = dx,
                     r_y = dy,
                     vel_x = AxeSpeed * dx / r,
                     vel_y = AxeSpeed * dy / r}
    cutted[axe] = {}
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

local period = 0.02
if not IsCompiletime() then
    Timer.new():start(period, true, function()
        local new_axes = {}

        for i = 1, #axes do
            ---@type Effect
            local axe = axes[i]
            local data = axe_data[axe]

            local vel_x = period * data.vel_x
            local vel_y = period * data.vel_y
            data.r_x = data.r_x - vel_x
            data.r_y = data.r_y - vel_y

            local x = axe:getX() + vel_x
            local y = axe:getY() + vel_y

            -- Finish
            if (math.abs(data.r_x - vel_x) <= vel_x) or
               (math.abs(data.r_y - vel_y) <= vel_y) then
                data.r_x = 0
                data.r_y = 0

                x = x + (data.r_x - vel_x)
                y = y + (data.r_y - vel_y)

                axe:destroy()
            else
                axe:setPos(x, y, axe:getZ())
                table.insert(new_axes, axe)
            end

            local list = Unit.getInRange(x, y, Width)
            local cut = cutted[axe]
            for j = 1, #list do
                ---@type Unit
                local u = list[j]
                if not cut[u] then
                    if not u:isAlly(data.owner) then
                        dealPhys(data.dmg, u, data.owner)
                        UnitBuffs.get(u):add(Bleeding, data.owner, BleedingTime, data.dmg / BleedingTime)
                    end
                    cut[u] = true
                end
            end
        end

        axes = new_axes
    end)
end

return ThrowAxe