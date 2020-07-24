--=========
-- Include
--=========

local Class = require(LibList.ClassLib)
---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)
local BinaryUnitData = BinaryLib.Unit
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
local Unit = UtilsLib.Handle.Unit

--=======
-- Class
--=======

local HeroType = Class.new('HeroType', BinaryUnitData)
---@class HeroType : BinaryDataUnit
local public = HeroType.public
---@class HeroTypeClass : BinaryDataUnitClass
local static = HeroType.static
---@type HeroTypeClass
local override = HeroType.override
local private = {}

--=========
-- Static
--=========

---@param child_instance Unit | nil
---@return Unit
function override.new(name, child_instance)
    if child_instance ~= nil then checkTypeErr(child_instance, HeroType, 'child_instance') end

    local instance = child_instance or Class.allocate(HeroType)
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