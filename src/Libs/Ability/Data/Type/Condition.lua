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

local AbilityDataTypeCondition = Class.new('AbilityDataTypeCondition')
--region Class
---@class AbilityDataTypeCondition
local public = AbilityDataTypeCondition.public
---@class AbilityDataTypeConditionClass
local static = AbilityDataTypeCondition.static
---@type AbilityDataTypeConditionClass
local override = AbilityDataTypeCondition.override
local private = {}
private.virtual_functions = {}
--endregion

--========
-- Static
--========

---@param name string
---@param child_instance AbilityDataTypeCondition | nil
---@return AbilityDataTypeCondition
function override.new(name, child_instance)
    if child_instance then checkTypeErr(child_instance, AbilityDataTypeCondition, 'child_instance') end

    if private.instances[name] then
        Log:err(tostring(AbilityDataTypeCondition)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityDataTypeCondition)
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
---@param target AbilityTarget
---@param caster Unit
---@return number
function public:getRange(target, caster) end
private.virtual_functions['getRange'] = public.getRange

--- Virtual function
---@param target AbilityTarget
---@param caster Unit
---@return number
function public:getArea(target, caster) end
private.virtual_functions['getArea'] = public.getArea

--- Virtual function
---@param target AbilityTarget
---@param caster Unit
---@return number
function public:getManaCost(target, caster) end
private.virtual_functions['getManaCost'] = public.getManaCost

--- Virtual function
---@param target AbilityTarget
---@param caster Unit
---@return number
function public:getHealthCost(target, caster) end
private.virtual_functions['getHealthCost'] = public.getHealthCost

--- Virtual function.
---@param target AbilityTarget
---@param caster Unit
---@return boolean
function public:checkUserConditions(target, caster) end
private.virtual_functions['checkConditions'] = public.checkConditions

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