require('Libs.Lib')

--local Class = require(LibList.ClassLib)


---@type AbilityLib
local AbilityLib = require(LibList.AbilityLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Unit = HandleLib.Unit
---@type ParameterLib
local ParameterLib = require(LibList.ParameterLib) or error('')

---@type BuffLib
--local BuffLib = require(LibList.BuffLib)

---@type Interface
local Interface = require('Interface.Init')

---@type CorruptedPriest
local CorruptedPriest = require('Hero.CorruptedPriest.Unit')

if IsCompiletime() then
    return
end


u = CorruptedPriest.new(0, 0, Player(0))
u:setMana(0)
ParameterLib.UnitContainer.get(u):addBase(ParameterLib.Health, 100)
u3 = CorruptedPriest.new(0, 0, Player(0))
ParameterLib.UnitContainer.get(u3):addBase(ParameterLib.Health, 200)
u4 = CorruptedPriest.new(0, 0, Player(0))
ParameterLib.UnitContainer.get(u4):addBase(ParameterLib.Health, 300)

u2 = Unit.new(FourCC('hfoo'), 0, 0, Player(1))
local param_container2 = ParameterLib.UnitContainer.new(u2)
--local buff_container2 = BuffLib.Container.new(u2)
--buff_container2:addBuff(BuffLib.TestType, u)
param_container2:addBase(ParameterLib.PhysicalDamage, 10)
param_container2:addBase(ParameterLib.Defence, 5)
param_container2:addBase(ParameterLib.Health, 100)

--Interface.SkillsBar:setSkill(1, abil_container:get(1))