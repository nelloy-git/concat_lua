--=========
-- Include
--=========

local Class = require(LibList.ClassLib)
---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)
local UnitType = BinaryLib.Unit
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
local Unit = UtilsLib.Handle.Unit

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

---@param unit_id number
---@param x number
---@param y number
---@param owner player
---@param child_instance Unit | nil
---@return Unit
function override.new(unit_id, x, y, owner, child_instance)


    return instance
end

--========
-- Public
--========

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Unit
function private.newData(self, owner)
    local priv = {
    }
    private.data[self] = priv
end

return static