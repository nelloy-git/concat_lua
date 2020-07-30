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

local AbilityDataType = Class.new('AbilityDataType')
--region Class
---@class AbilityDataType
local public = AbilityDataType.public
---@class AbilityDataTypeClass
local static = AbilityDataType.static
---@type AbilityDataTypeClass
local override = AbilityDataType.override
local private = {}
private.virtual_functions = {}
--endregion

--========
-- Static
--========

---@param name string
---@param target_type string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
---@param is_area boolean
---@param child_instance AbilityDataType | nil
---@return AbilityDataType
function override.new(name, target_type, is_area, child_instance)
    checkTypeErr(name, 'string', 'id')
    checkTypeErr(target_type, 'string', 'target_type')
    if not (target_type == 'None' or
            target_type == 'Unit' or
            target_type == 'Point' or
            target_type == 'PointOrUnit') then
        Log:err('Got wrong \"target_type\".')
    end
    checkTypeErr(is_area, 'boolean', 'is_area')
    if child_instance then checkTypeErr(child_instance, AbilityDataType, 'child_instance') end

    if private.instances[name] then
        Log:err(tostring(AbilityDataType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityDataType)
    private.newData(instance, name, target_type, is_area)

    return instance
end

--========
-- Public
--========

---@param abil AbilityData
---@return string
function public:getName(abil)
    return private.data[self].name
end

---@return string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
function public:getTargetType()
    return private.data[self].target_type
end

---@return boolean
function public:isArea()
    return private.data[self].is_area
end

--- Virtual function.
--- Return true if check is successfull.
---@param abil AbilityData
---@return boolean
function public:checkConditions(abil) end
private.virtual_functions['checkConditions'] = public.checkConditions

--- Virtual function.
---@param abil AbilityData
function public:onStart(abil) end
private.virtual_functions['onStart'] = public.onStart

--- Virtual function
---@param abil AbilityData
function public:onCasting(abil) end
private.virtual_functions['onCasting'] = public.onCasting

--- Virtual function
---@param abil AbilityData
function public:onCancel(abil) end
private.virtual_functions['onCancel'] = public.onCancel

--- Virtual function
---@param abil AbilityData
function public:onInterrupt(abil) end
private.virtual_functions['onInterrupt'] = public.onInterrupt

--- Virtual function
---@param abil AbilityData
function public:onFinish(abil) end
private.virtual_functions['onFinish'] = public.onFinish

--- Virtual function
---@param abil AbilityData
---@return number
function public:getRange(abil) end
private.virtual_functions['getRange'] = public.getRange

--- Virtual function
---@param abil AbilityData
---@return number
function public:getArea(abil) end
private.virtual_functions['getArea'] = public.getArea

--- Virtual function
--- Must return full casting time of the ability.
---@param abil AbilityData
---@return number
function public:getCastingTime(abil) end
private.virtual_functions['getCastingTime'] = public.getCastingTime

--- Virtual function
--- Must return full cooldown of one ability charge.
---@param abil AbilityData
---@return number
function public:getChargeCooldown(abil) end
private.virtual_functions['getChargeCooldown'] = public.getChargeCooldown

--- Virtual function
--- Must return maximum number of charges for ability.
---@param abil AbilityData
---@return number
function public:getMaxCharges(abil) end
private.virtual_functions['getMaxCharges'] = public.getMaxCharges

--- Virtual function
--- Must return number of charges consumed for use.
---@param abil AbilityData
---@return number
function public:getChargesForUse(abil) end
private.virtual_functions['getChargesForUse'] = public.getChargesForUse

--- Virtual function
--- Must return number of charges consumed for use.
---@param abil AbilityData
---@return number
function public:getManaCost(abil) end
private.virtual_functions['getManaCost'] = public.getManaCost

--- Virtual function
--- Must return number of charges consumed for use.
---@param abil AbilityData
---@return number
function public:getHealthCost(abil) end
private.virtual_functions['getHealthCost'] = public.getHealthCost

--- Virtual function
---@param abil AbilityData
---@return string
function public:getIcon(abil) end
private.virtual_functions['getIcon'] = public.getIcon

--- Virtual function
---@param abil AbilityData
---@return string
function public:getTooltip(abil) end
private.virtual_functions['getTooltip'] = public.getTooltip

--=========
-- Private
--=========

private.instances = {}
private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityData
---@param target_type string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
---@param is_area boolean
function private.newData(self, name, target_type, is_area)
    local priv = {
        name = name,
        target_type = target_type,
        is_area = is_area
    }
    private.data[self] = priv

    private.instances[name] = self
end

CompileFinal(function()
    for id, instance in pairs(private.instances) do
        for field, value in pairs(public) do
            local func = private.virtual_functions[field]
            if func ~= nil then
                if value == instance[field] then
                    Log:err(id..': virtual function \"'..field..'\" must be overriden.', 1)
                end
            end
        end
    end
end)

return static