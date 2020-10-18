--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Timer = HandleLib.Timer
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Action = UtilsLib.Action or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local AbilityExtTypeCasting = Class.new('AbilityExtTypeCasting')
---@class AbilityExtTypeCasting
local public = AbilityExtTypeCasting.public
---@class AbilityExtTypeCastingClass
local static = AbilityExtTypeCasting.static
---@type AbilityExtTypeCastingClass
local override = AbilityExtTypeCasting.override
local virtual = {}
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

function override.new(child)
    if child then isTypeErr(child, AbilityExtTypeCasting, 'child') end

    local instance = child or Class.allocate(AbilityExtTypeCasting)

    return instance
end

--========
-- Public
--========

--- Should consume resources.
---@param abil AbilityExt
function public:start(abil)
    print('Casting start')
end

---@param abil AbilityExt
function public:loop(abil)
    print('Casting loop')
end

---@param abil AbilityExt
function public:cancel(abil)
    print('Casting cancel')
end

---@param abil AbilityExt
function public:interrupt(abil) end

---@param abil AbilityExt
function public:finish(abil) end

--=========
-- Private
--=========

return static