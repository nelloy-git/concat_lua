require('Libs.Lib')

--local Class = require(LibList.ClassLib)


---@type AbilityLib
local AbilityLib = require(LibList.AbilityExtLib) or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Unit = HandleLib.Unit
---@type ParameterLib
local ParameterLib = require(LibList.ParameterLib) or error('')
local Param = ParameterLib.Enum
local UnitParam = ParameterLib.UnitContainer

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
u3 = CorruptedPriest.new(0, 0, Player(0))
u4 = CorruptedPriest.new(0, 0, Player(0))

u2 = CorruptedPriest.new(0, 0, Player(1))
local param_container2 = UnitParam.get(u2)
--local buff_container2 = BuffLib.ContPDMG
--buff_container2:addBuff(BuffLib.TestPDEF)
param_container2:addBase(Param.PDMG, 10)
param_container2:addBase(Param.MDEF, 5)
param_container2:addBase(Param.LIFE, 1000)

--Interface.SkillsBar:setSkill(1, abil_container:get(1))