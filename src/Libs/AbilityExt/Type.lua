--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local AbilityExtType = Class.new('AbilityExtType')
---@class AbilityExtType
local public = AbilityExtType.public
---@class AbilityExtTypeClass
local static = AbilityExtType.static
---@type AbilityExtTypeClass
local override = AbilityExtType.override
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

---@param child AbilityExtType | nil
---@return AbilityExtType
function override.new(child)
    if child then isTypeErr(child, AbilityExtType, 'child') end

    local instance = child or Class.allocate(AbilityExtType)

    return instance
end

--========
-- Public
--========

---------------
-- Information
---------------

---@param abil AbilityExt
---@return string
function public:getName(abil) return 'Noname' end

---@param abil AbilityExt
---@return string
function public:getIcon(abil) return '' end

---@param abil AbilityExt
---@return string
function public:getTooltip(abil) return 'Notooltip' end

-------------
-- Resources
-------------

---@param abil AbilityExt
---@return number
function public:getLifeCost(abil) return 0 end

---@param abil AbilityExt
---@return number
function public:getManaCost(abil) return 0 end

---@param abil AbilityExt
---@return number
function public:getSpecialCost(abil) return 0 end

---@param abil AbilityExt
---@return number
function public:getChargesForUse(abil) return 1 end

---@param abil AbilityExt
---@return number
function public:getMaxCharges(abil) return 1 end

---@param abil AbilityExt
---@return number
function public:getCooldown(abil) return 0 end

---@param abil AbilityExt
---@return number
function public:getCastingTime(abil) return 0 end

-------------
-- Targeting
-------------

--- Should check if all conditions are correct.
---@param abil AbilityExt
---@return boolean
function public:targetingCanStart(abil) return true end

---@param abil AbilityExt
function public:targetingStart(abil) end

---@param abil AbilityExt
---@return any
function public:targetingEnd(abil) end

-----------
-- Casting
-----------

--- Should check if all conditions are correct again and consume resources.
---@param abil AbilityExt
---@return boolean
function public:castingCanStart(abil) return true end

---@param abil AbilityExt
function public:castingStart(abil) end

---@param abil AbilityExt
function public:castingLoop(abil) end

---@param abil AbilityExt
function public:castingCancel(abil) end

---@param abil AbilityExt
function public:castingInterrupt(abil) end

---@param abil AbilityExt
function public:castingFinish(abil) end

-------------
-- Callbacks
-------------

---@param abil AbilityExt
function public:notEnoughCharges(abil) end

--=========
-- Private
--=========

return static