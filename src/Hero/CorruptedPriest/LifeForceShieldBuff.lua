--=========
-- Include
--=========

---@type AssetLib
local AssetLib = require(LibList.AssetLib) or error('')
local Icon = AssetLib.IconDefault.BTNAbsorbMagic or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
local BuffType = BuffLib.Type or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamUnit = ParamLib.UnitContainer or error('')
local ParamType = ParamLib.ParamType or error('')

--==========
-- Settings
--==========

local BonusPerMAtk = 0.01

--========
-- Module
--========

local LifeForceShieldBuff = BuffType.new('Life Force Shield Effect')
local stored_shield = {}

---@param buff Buff
function LifeForceShieldBuff:onStart(buff)
    local matk = ParamUnit.get(buff:getSource()):getResult(ParamType.MATK)
    stored_shield[buff] = buff:getUserData() * (1 + BonusPerMAtk * matk)
    BuffLib.addShield(stored_shield[buff], buff:getTarget())
end

---@param buff Buff
function LifeForceShieldBuff:onLoop(buff)
end

---@param buff Buff
function LifeForceShieldBuff:onCancel(buff)
    BuffLib.addShield(-stored_shield[buff], buff:getTarget())
    stored_shield[buff] = nil
end

---@param buff Buff
function LifeForceShieldBuff:onFinish(buff)
    BuffLib.addShield(-stored_shield[buff], buff:getTarget())
    stored_shield[buff] = nil
end

---@param buff Buff
function LifeForceShieldBuff:getName(buff)
    return 'Life Force Shield'
end

---@param buff Buff
function LifeForceShieldBuff:getIcon(buff)
    return Icon
end

---@param buff Buff
function LifeForceShieldBuff:getTooltip(buff)
    local shield = stored_shield[buff]
    local s_shield = tostring(shield)
    s_shield = s_shield:sub(1, s_shield:find('.') + 1)
    return 'This unit has shield based on maximum life ('..s_shield..').'
end



return LifeForceShieldBuff