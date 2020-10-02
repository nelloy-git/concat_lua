--=========
-- Include
--=========

---@type AssetLib
local AssetLib = require(LibList.AssetLib) or error('')
local Icon = AssetLib.IconDefault.BTNGhoulFrenzy or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
local BuffLoopPeriod = BuffLib.getBuffLoopPeriod() or error('')
local BuffType = BuffLib.Type or error('')
---@type DamageLib
local DamageLib = require(LibList.DamageLib) or error('')
local dealPhys = DamageLib.dealPhys or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Effect = HandleLib.Effect or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamType = ParamLib.ParamType or error('')

---@type HeroUtils
local Utils = require('Hero.Utils') or error('')

--==========
-- Settings
--==========

local period = 0.5
local s_period = tostring(period)
s_period = s_period:sub(1, s_period:find('%.') + 1)

local effect_model = ''
local effect_z = 50

--========
-- Module
--========

local Bleeding = BuffType.new('Bleeding Effect')

local time = {}
local perSec = {}
local bloodEffect = {}

---@param buff Buff
function Bleeding:onStart(buff)
    local target = buff:getTarget()

    perSec[buff] = buff:getUserData()
    time[buff] = 0
    bloodEffect[buff] = Effect.new(effect_model,
                                   target:getX(),
                                   target:getY(),
                                   target:getZ() + effect_z)
end

---@param buff Buff
function Bleeding:onLoop(buff)
    local target = buff:getTarget()

    time[buff] = time[buff] + BuffLoopPeriod
    if time[buff] > period then
        time[buff] = time[buff] - period
        dealPhys(perSec[buff] * period, target, buff:getSource())
    end

    bloodEffect[buff]:setPos(target:getX(),
                             target:getY(),
                             target:getZ() + effect_z)
end

---@param buff Buff
function Bleeding:onCancel(buff)
    perSec[buff] = nil
    time[buff] = nil

    bloodEffect[buff]:destroy()
    bloodEffect[buff] = nil
end

---@param buff Buff
function Bleeding:onFinish(buff)
    perSec[buff] = nil
    time[buff] = nil

    bloodEffect[buff]:destroy()
    bloodEffect[buff] = nil
end

---@param buff Buff
function Bleeding:getName(buff)
    return 'Bleeding'
end

---@param buff Buff
function Bleeding:getIcon(buff)
    return Icon
end

---@param buff Buff
function Bleeding:getTooltip(buff)
    local dmg_per_sec = perSec[buff]
    local s_dmg = tostring(dmg_per_sec * period)
    s_dmg = s_dmg:sub(1, (s_dmg:find('%.') or (s_dmg:len() + 1)) - 1)
    return 'This unit bleeds and takes '..Utils.colorScale(s_dmg, ParamType.PATK)..' damage every '..s_period..' seconds.'
end



return Bleeding