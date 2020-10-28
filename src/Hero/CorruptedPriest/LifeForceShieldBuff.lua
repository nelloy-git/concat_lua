--=========
-- Include
--=========

---@type AssetLib
local AssetLib = require(LibList.AssetLib) or error('')
local Icon = AssetLib.IconDefault.BTNAbsorbMagic or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
local BuffType = BuffLib.Type or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Effect = HandleLib.Effect or error('')

--==========
-- Settings
--==========

local model = 'Abilities\\Spells\\Human\\ManaFlare\\ManaFlareTarget.mdl'
local model_r = 1
local model_g = 1
local model_b = 1
local model_a = 0.3

--======
-- Data
--======

local stored_shield = {}
local effect = {}


--========
-- Module
--========

local LifeForceShieldBuff = BuffType.new('Life Force Shield Effect')

---@param buff Buff
function LifeForceShieldBuff:onStart(buff)
    local target = buff:getTarget()

    stored_shield[buff] = buff:getUserData()
    effect[buff] = Effect.new(model, target:getX(), target:getY(), target:getZ())
    effect[buff]:setScale(4)
    effect[buff]:setColor(model_r, model_g, model_b, model_a)

    BuffLib.addShield(stored_shield[buff], target)
end

---@param buff Buff
function LifeForceShieldBuff:onLoop(buff)
    local target = buff:getTarget()
    effect[buff]:setPos(target:getX(), target:getY(), target:getZ())
end

---@param buff Buff
function LifeForceShieldBuff:onCancel(buff)
    BuffLib.addShield(-stored_shield[buff], buff:getTarget())
    stored_shield[buff] = nil
    effect[buff]:destroy()
    effect[buff] = nil
end

---@param buff Buff
function LifeForceShieldBuff:onFinish(buff)
    BuffLib.addShield(-stored_shield[buff], buff:getTarget())
    stored_shield[buff] = nil
    effect[buff]:destroy()
    effect[buff] = nil
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
    s_shield = s_shield:sub(1, s_shield:find('%.') - 1)
    return 'This unit has shield based on maximum life ('..s_shield..').'
end



return LifeForceShieldBuff