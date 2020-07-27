--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
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
---@param target_type string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
---@param is_area boolean
---@param child_instance AbilityType | nil
---@return AbilityType
function override.new(id, target_type, is_area, child_instance)
    checkTypeErr(id, 'string', 'id')
    checkTypeErr(target_type, 'string', 'target_type')
    if not (target_type == 'None' or
            target_type == 'Unit' or
            target_type == 'Point' or
            target_type == 'PointOrUnit') then
        Log:err('Got wrong \"target_type\".')
    end
    checkTypeErr(is_area, 'boolean', 'is_area')
    if child_instance then checkTypeErr(child_instance, AbilityType, 'child_instance') end

    if private.instances[id] then
        Log:err(tostring(AbilityType)..' with this id already exists.', 2)
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
--- Must return number of charges consumed for use.
---@param abil Ability
---@return number
function public:getManaCost(abil) end

--- Virtual function
--- Must return number of charges consumed for use.
---@param abil Ability
---@return number
function public:getHealthCost(abil) end

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
private.data = setmetatable({}, {__mode = 'k'})

---@param self Ability
---@param target_type string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
---@param is_area boolean
function private.newData(self, id, target_type, is_area)
    local priv = {
        id = id,
        target_type = target_type,
        is_area = is_area
    }
    private.data[self] = priv

    private.instances[id] = self
end

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