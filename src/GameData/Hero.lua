--=========
-- Include
--=========

local Class = require(LibList.ClassLib)
---@type AbilityLib
local AbilityLib = require(LibList.AbilityLib)
local AbilContainer = AbilityLib.Container
---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)
local UnitType = BinaryLib.Unit
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
local Unit = UtilsLib.Handle.Unit

---@type DummyAbilityPool
local DummyAbilityPool = require('GameData.DummyAbilityPool')
---@type HeroTypeClass
local HeroType = require('GameData.HeroType')

--=======
-- Class
--=======

local Hero = Class.new('Hero', Unit)
---@class Hero : Unit
local public = Hero.public
---@class HeroClass : UnitClass
local static = Hero.static
---@type HeroClass
local override = Hero.override
local private = {}

--=========
-- Static
--=========

---@param hero_type HeroType
---@param x number
---@param y number
---@param owner player
---@param child_instance Unit | nil
---@return Hero
function override.new(hero_type, x, y, owner, child_instance)
    checkTypeErr(hero_type, HeroType, 'hero_type')
    checkTypeErr(x, 'number', 'x')
    checkTypeErr(y, 'number', 'y')
    checkTypeErr(owner, 'player', owner)
    if child_instance then checkTypeErr(child_instance, Hero, 'child_instance') end

    local instance = child_instance or Class.allocate(Hero)
    instance = Unit.new(hero_type:getId(), x, y, owner, instance)
    private.newData(instance, hero_type)

    return instance
end

--========
-- Public
--========

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Hero
---@param hero_type HeroType
function private.newData(self, hero_type)
    local priv = {
    }
    private.data[self] = priv
end

---@param self Hero
function private.newAbilities(self)
    local priv = private.data[self]

    priv.ability_container = AbilContainer.new(self)
    priv.ability_dummy = {}
    for i = 1, 6 do
        priv.ability_dummy[i] = DummyAbilityPool.pop()
        UnitAddAbility(self:getHandleData(), priv.ability_dummy[i]:getId())
    end
end

function private.updateAbility()
end

return static