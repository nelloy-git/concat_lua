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

local AbilityInfoType = Class.new('AbilityInfoType')
--region Class
---@class AbilityInfoType
local public = AbilityInfoType.public
---@class AbilityInfoTypeClass
local static = AbilityInfoType.static
---@type AbilityInfoTypeClass
local override = AbilityInfoType.override
local private = {}
private.virtual_functions = {}
--endregion

--========
-- Static
--========

---@param name string
---@param child_instance AbilityInfoType | nil
---@return AbilityInfoType
function override.new(name, child_instance)
    if child_instance then checkTypeErr(child_instance, AbilityInfoType, 'child_instance') end

    if private.instances[name] then
        Log:err(tostring(AbilityInfoType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityInfoType)
    private.instances[instance] = name

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.instances[self]
end

--- Virtual function
---@param owner Unit
---@return number
function public:getRange(owner) end
private.virtual_functions['getRange'] = public.getRange

--- Virtual function
---@param owner Unit
---@return number
function public:getArea(owner) end
private.virtual_functions['getArea'] = public.getArea

--- Virtual function
---@param owner Unit
---@return string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
function public:getTargetingType(owner) end
private.virtual_functions['getTargetingType'] = public.getTargetingType

--- Virtual function
---@param owner Unit
---@return string | "'friend'" | "'enemy'" | "'any'"
function public:getTargetsAllowed(owner) end
private.virtual_functions['getTargetsAllowed'] = public.getTargetsAllowed

--- Virtual function
---@param owner Unit
---@return number
function public:getManaCost(owner) end
private.virtual_functions['getManaCost'] = public.getManaCost

--- Virtual function
---@param owner Unit
---@return number
function public:getHealthCost(owner) end
private.virtual_functions['getHealthCost'] = public.getHealthCost

--- Virtual function
---@param owner Unit
---@return string
function public:getIcon(owner) end
private.virtual_functions['getIcon'] = public.getIcon

--- Virtual function
---@param owner Unit
---@return string
function public:getTooltip(owner) end
private.virtual_functions['getTooltip'] = public.getTooltip

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.instances = setmetatable({}, {__mode = 'k'})

CompileFinal(function()
    for instance, name in pairs(private.instances) do
        for field, value in pairs(public) do
            local func = private.virtual_functions[field]
            if func ~= nil then
                if value == instance[field] then
                    Log:err(name..': virtual function \"'..field..'\" must be overriden.', 1)
                end
            end
        end
    end
end)

return static