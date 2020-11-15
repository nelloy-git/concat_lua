--=========
-- Include
--=========

---@type Wc3AbilityExt
local Wc3AbilityExt = require(LibManager.load('https://github.com/nelloy-git/Wc3AbilityExt.git'))
local AbilityExtType = Wc3AbilityExt.Type

local Casting = require('Hero.CorruptedPriest.LifeForceShield.Casting')
local Data = require('Hero.CorruptedPriest.LifeForceShield.Data')
local Targeting = require('Hero.CorruptedPriest.LifeForceShield.Targeting')

--========
-- Module
--========

return AbilityExtType.new(Targeting, Casting, Data)