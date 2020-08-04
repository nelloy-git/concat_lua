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

local AbilityDataTypeCasting = Class.new('AbilityDataTypeCasting')
--region Class
---@class AbilityDataTypeCasting
local public = AbilityDataTypeCasting.public
---@class AbilityDataTypeCastingClass
local static = AbilityDataTypeCasting.static
---@type AbilityDataTypeCastingClass
local override = AbilityDataTypeCasting.override
local private = {}
private.virtual_functions = {}
--endregion

--========
-- Static
--========

---@param name string
---@param child_instance AbilityDataTypeCasting | nil
---@return AbilityDataTypeCasting
function override.new(name, child_instance)
    if child_instance then checkTypeErr(child_instance, AbilityDataTypeCasting, 'child_instance') end

    if private.instances[name] then
        Log:err(tostring(AbilityDataTypeCasting)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityDataTypeCasting)
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
function public:getCastingTime(target, caster) end
private.virtual_functions['getCastingTime'] = public.getCastingTime

--- Virtual function.
---@param target AbilityTarget
---@param caster Unit
function public:onCastingStart(target, caster) end
private.virtual_functions['onCastingStart'] = public.onCastingStart

--- Virtual function
---@param target AbilityTarget
---@param caster Unit
---@param time_left number
---@param full_time number
function public:onCastingLoop(target, caster, time_left, full_time) end
private.virtual_functions['onCastingLoop'] = public.onCastingLoop

--- Virtual function
---@param target AbilityTarget
---@param caster Unit
---@param time_left number
---@param full_time number
function public:onCastingCancel(target, caster, time_left, full_time) end
private.virtual_functions['onCancel'] = public.onCancel

--- Virtual function
---@param target AbilityTarget
---@param caster Unit
---@param time_left number
---@param full_time number
function public:onCastingInterrupt(target, caster, time_left, full_time) end
private.virtual_functions['onInterrupt'] = public.onInterrupt

--- Virtual function
---@param target AbilityTarget
---@param caster Unit
---@param time_left number
---@param full_time number
function public:onCastingFinish(target, caster, time_left, full_time) end
private.virtual_functions['onFinish'] = public.onFinish

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