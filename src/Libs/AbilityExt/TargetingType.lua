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
local isTypeErr = UtilsLib.isTypeErr or error('')

--=======
-- Class
--=======

local AbilityExtTargetingType = Class.new('AbilityExtTargetingType')
---@class AbilityExtTargetingType
local public = AbilityExtTargetingType.public
---@class AbilityExtTargetingTypeClass
local static = AbilityExtTargetingType.static
---@type AbilityExtTargetingTypeClass
local override = AbilityExtTargetingType.override
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

---@param child AbilityExtTargetingType | nil
---@return AbilityExtTargetingType
function override.new(child)
    if child then isTypeErr(child, AbilityExtTargetingType, 'child') end

    local instance = child or Class.allocate(AbilityExtTargetingType)

    return instance
end

--========
-- Public
--========

---@param abil AbilityExt
---@return boolean
function public:start(abil)
    -- Example
    private.abil_data[abil] = Timer.new()
    private.abil_data[abil]:start(3, false, function()
        self:finish(abil, abil:getOwner())

        private.abil_data[abil]:destroy()
        private.abil_data[abil] = nil
    end)
end

---@param abil AbilityExt
function public:cancel(abil)
    private.abil_data[abil]:destroy()
    private.abil_data[abil] = nil
end

function public:finish(abil, target)
    private.abil_callback[abil]:run(target)
end

function public:setFinishAction(abil, callback)
    private.abil_callback[abil] = Action.new()
end

--=========
-- Private
--=========

private.abil_data = {}
private.abil_callback = {}

return static