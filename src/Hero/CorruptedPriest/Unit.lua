--=========
-- Include
--=========

---@type Wc3AbilityExt
local Wc3AbilityExt = require(LibManager.load('https://github.com/nelloy-git/Wc3AbilityExt.git'))
local AbilUnitContainer = Wc3AbilityExt
---@type BinaryLib
local BinaryLib = require(LibManager.load('https://github.com/nelloy-git/Wc3Binary.git'))
local BinaryUnit = 
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Unit = HandleLib.Unit or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local Value = ParamLib.ValueType or error('')


---@type AbilityExtType
--local ThrowAxe = require('Hero.Berserk.ThrowAxe') or error('')
---@type AbilityExtType
local LifeForceShield = require('Hero.CorruptedPriest.LifeForceShield') or error('')
---@type CorruptedPriestSettings
local Settings = require('Hero.CorruptedPriest.Settings') or error('')

--========
-- Module
--========

---@class CorruptedPriest
local CorruptedPriest = {}

---@param x number
---@param y number
---@param owner player
---@return Unit
function CorruptedPriest.new(x, y, owner)
    local unit = Unit.new(CorruptedPriest.Type:getId(), x, y, owner)
    BuffLib.Container.new(unit)

    -- Params
    local params = ParamLib.UnitContainer.new(unit)
    for param, value in pairs(Settings.Params) do
        params:add(param, Value.BASE, value)
    end
    
    -- Abils
    local abils = AbilLib.Container.new(unit)
    abils:set(1, LifeForceShield)
    --abils:set('W', ThrowAxe)
    --abils:set('E', LifeForceShield)
    --abils:set('R', LifeForceShield)
    --abils:set('T', LifeForceShield)
    --abils:set('D', LifeForceShield)
    --abils:set('F', LifeForceShield)

    return unit
end

CorruptedPriest.Binary = BinaryLib.Unit.new(Settings.Id, Settings.BaseId, Settings.Name)
CorruptedPriest.Binary:setName(Settings.Name)
CorruptedPriest.Binary:setIconGameInterface(Settings.Icon)
CorruptedPriest.Binary:setMana(100)
CorruptedPriest.Binary:setManaRegeneration(1)
CorruptedPriest.Binary:setNormalAbilities({})

return CorruptedPriest