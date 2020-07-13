require('Libs.Lib')

---@type ParameterLib
local ParameterLib = require(LibList.ParameterLib)
---@type AbilityLib
local AbilityLib = require(LibList.AbilityLib)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
---@type BuffLib
local BuffLib = require(LibList.BuffLib)
---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)

local Interface = require('Interface.Init')

FourCC = FourCC or function(id) return string.unpack(">I4", id) end

local foo_type = BinaryLib.Unit.new(FourCC('U001'), FourCC('hfoo'), 'TestFootman')
foo_type:setValue(BinaryLib.UnitDB.Name.value_id, BinaryLib.UnitDB.Name.value_type, 'TestFootman')

if IsCompiletime() then
    return
end

u = UtilsLib.Handle.Unit.new(foo_type:getId(), 0, 0, Player(0))
local param_container = ParameterLib.UnitContainer.new(u)
local buff_container = BuffLib.Container.new(u)
local abil_container = AbilityLib.Container.new(u)
abil_container:set(1, AbilityLib.TestType)
param_container:addBase(ParameterLib.PhysicalDamage, 10)
param_container:addBase(ParameterLib.Defence, 5)
param_container:addBase(ParameterLib.Health, 1000)

u2 = UtilsLib.Handle.Unit.new(FourCC('hfoo'), 0, 0, Player(1))
local param_container2 = ParameterLib.UnitContainer.new(u2)
local buff_container2 = BuffLib.Container.new(u2)
--buff_container2:addBuff(BuffLib.TestType, u)
param_container2:addBase(ParameterLib.PhysicalDamage, 10)
param_container2:addBase(ParameterLib.Defence, 5)
param_container2:addBase(ParameterLib.Health, 1000)

Interface.SkillsBar:setSkill(1, abil_container:get(1))