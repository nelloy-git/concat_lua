--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger
--endregion

--=======
-- Class
--=======

local AbilityType = Class.new('AbilityType')
--region Class
---@class AbilityType
local public = AbilityType.public
---@class AbilityTypeClass
local static = AbilityType.static
---@type AbilityTypeClass
local override = AbilityType.override
local private = {}
--endregion

--========
-- Static
--========

---@param id string
---@param child_instance AbilityType | nil
---@return AbilityType
function override.new(id, child_instance)
    checkType(id, 'string', 'id')
    if child_instance then
        checkType(child_instance, AbilityType, 'child_instance')
    end

    if private.instances[id] then
        Log:err(tostring(AbilityType)..' with this id already exists.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityType)
    private.instances[id] = instance

    return instance
end

--========
-- Public
--========

--- Virtual function.
--- Return true if check is successfull. Cooldown and charges are built in system.
---@param abil Ability
---@return boolean
function public:checkConditions(abil) end

--- Virtual function.
---@param abil Ability
function public:onStart(abil) end

--- Virtual function
---@param abil Ability
function public:onCasting(abil) end

--- Virtual function
---@param abil Ability
function public:onCancel(abil) end

--- Virtual function
---@param abil Ability
function public:onInterrupt(abil) end

--- Virtual function
---@param abil Ability
function public:onFinish(abil) end

--- Virtual function
--- Must return full casting time of the ability.
---@param abil Ability
---@return number
function public:getCastingTime(abil) end

--- Virtual function
--- Must return full cooldown of one ability charge.
---@param abil Ability
---@return number
function public:getChargeCooldown(abil) end

--- Virtual function
--- Must return maximum number of charges for ability.
---@param abil Ability
---@return number
function public:getMaxCharges(abil) end

--- Virtual function
--- Must return number of charges consumed for use.
---@param abil Ability
---@return number
function public:getChargesForUse(abil) end

--- Virtual function
---@param abil Ability
---@return string
function public:getName(abil) end

--- Virtual function
---@param abil Ability
---@return string
function public:getIcon(abil) end

--- Virtual function
---@param abil Ability
---@return string
function public:getTooltip(abil) end

--=========
-- Private
--=========

private.instances = {}

CompileFinal(function()
    for id, instance in pairs(private.instances) do
        for field, value in pairs(public) do
            if value == instance[field] then
                Log:err(id..': virtual function \"'..field..'\" must be overriden.', 1)
            end
        end
    end
end)

return static