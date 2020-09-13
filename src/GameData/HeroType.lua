--=========
-- Include
--=========

local Class = require(LibList.ClassLib)
---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)
local BinaryUnitData = BinaryLib.Unit
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local isTypeErr = UtilsLib.isTypeErr
local Log = UtilsLib.Log
local Unit = UtilsLib.Handle.Unit

--=======
-- Class
--=======

local HeroType = Class.new('HeroType', BinaryUnitData)
---@class HeroType : BinaryUnit
local public = HeroType.public
---@class HeroTypeClass : BinaryUnitClass
local static = HeroType.static
---@type HeroTypeClass
local override = HeroType.override
local private = {}

--=========
-- Static
--=========

---@param child Unit | nil
---@return Unit
function override.new(child)
    if child ~= nil then isTypeErr(child, HeroType, 'child') end

    local instance = child or Class.allocate(HeroType)
    instance = BinaryUnitData.new(BinaryLib.getHeroId(), 'HPal', ('Hero%d'):format(#private.data))
    private.newData(instance)

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
function private.newData(self)
    local priv = {
    }
    private.data[self] = priv
end

return static