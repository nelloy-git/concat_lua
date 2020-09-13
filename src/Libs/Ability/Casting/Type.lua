--=========
-- Include
--=========

--region Include
local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')
--endregion

--=======
-- Class
--=======

local AbilityCastingType = Class.new('AbilityCastingType')
--region Class
---@class AbilityCastingType
local public = AbilityCastingType.public
---@class AbilityCastingTypeClass
local static = AbilityCastingType.static
---@type AbilityCastingTypeClass
local override = AbilityCastingType.override
local private = {}
private.virtual_functions = {}
--endregion

--========
-- Static
--========

---@param name string
---@param child AbilityCastingType | nil
---@return AbilityCastingType
function override.new(name, child)
    if child then isTypeErr(child, AbilityCastingType, 'child') end

    if private.instances[name] then
        Log:err(tostring(AbilityCastingType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child or Class.allocate(AbilityCastingType)
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
---@param caster Unit
---@return number
function public:getCastingTime(caster) end
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