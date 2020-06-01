--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType

--=======
-- Class
--=======

local AbilityType = Class.new('AbilityType')
---@class AbilityType
local public = AbilityType.public
---@class AbilityTypeClass
local static = AbilityType.static
---@type AbilityTypeClass
local override = AbilityType.override
local private = {}

--========
-- Static
--========

---@return AbilityType
function override.new(child_instance)
    if child_instance then
        checkType(child_instance, AbilityType, 'child_instance')
    end

    local instance = child_instance or Class.allocate(AbilityType)

    return instance
end

--========
-- Public
--========

--- Virtual function.
--- Return true if check is successfull. Cooldown and charges are built in system.
---@param abil Ability
---@return boolean
function public:checkConditions(abil)
end

--- Virtual function.
--- Return true if started successfully.
---@param abil Ability
function public:onStart(abil)
end

--- Virtual function
---@param abil Ability
function public:onCasting(abil)
end

--- Virtual function
---@param abil Ability
function public:onCancel(abil)
end

--- Virtual function
---@param abil Ability
function public:onInterrupt(abil)
end

--- Virtual function
---@param abil Ability
function public:onFinish(abil)
end

--- Virtual function
--- Must return full casting time of the ability.
---@param abil Ability
---@return number
function public:getCastingTime(abil)
end

--- Virtual function
--- Must return full cooldown of one ability charge.
---@param abil Ability
---@return number
function public:getCooldown(abil)
end

--- Virtual function
--- Must return maximum number of charges for ability.
---@param abil Ability
---@return number
function public:getMaxCharges(abil)
end

--- Virtual function
--- Must return number of charges consumed for use.
---@param abil Ability
---@return number
function public:getChargesForUse(abil)
end

return static