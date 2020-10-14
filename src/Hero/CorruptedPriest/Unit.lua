--=========
-- Include
--=========

---@type AbilityLib
local AbilLib = require(LibList.AbilityExtLib) or error('')
---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib) or error('')
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
    AbilLib.Container.new(unit)
    BuffLib.Container.new(unit)

    -- Params
    local params = ParamLib.UnitContainer.new(unit)
    for param, value in pairs(Settings.Params) do
        params:add(param, Value.BASE, value)
    end
    
    -- Abils
    local abils = AbilLib.Container.new(unit)
    abils:set(1, AbilLib.Targeting.Unit, LifeForceShield)
    --abils:set('W', ThrowAxe)
    --abils:set('E', LifeForceShield)
    --abils:set('R', LifeForceShield)
    --abils:set('T', LifeForceShield)
    --abils:set('D', LifeForceShield)
    --abils:set('F', LifeForceShield)

    return unit
end

CorruptedPriest.Type = BinaryLib.Unit.new(Settings.Id, Settings.BaseId, Settings.Name)
CorruptedPriest.Type:setName(Settings.Name)
CorruptedPriest.Type:setIconGameInterface(Settings.Icon)
CorruptedPriest.Type:setMana(100)
CorruptedPriest.Type:setManaRegeneration(1)
CorruptedPriest.Type:setNormalAbilities({})

return CorruptedPriest