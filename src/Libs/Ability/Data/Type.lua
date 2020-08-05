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

---@type AbilityCastingType
local AbilityCastingType = require(lib_modname..'.Casting.Type')
---@type AbilityInfoTypeClass
local AbilityInfoType = require(lib_modname..'.Info.Type')
---@type AbilityCooldownTypeClass
local AbilityCooldownType = require(lib_modname..'.Cooldown.Type')
---@type AbilityDataTypeUIClass
local AbilityDataTypeUI = require(lib_modname..'.Data.Type.UI')
--endregion

--=======
-- Class
--=======

local AbilityDataType = Class.new('AbilityDataType', AbilityCastingType,
                                                     AbilityInfoType,
                                                     AbilityCooldownType,
                                                     AbilityDataTypeUI)
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
---@param child_instance AbilityDataType | nil
---@return AbilityDataType
function override.new(name, child_instance)
    checkTypeErr(name, 'string', 'id')
    if child_instance then checkTypeErr(child_instance, AbilityDataType, 'child_instance') end

    if private.instances[name] then
        Log:err(tostring(AbilityDataType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child_instance or Class.allocate(AbilityDataType)
    instance = AbilityDataTypeUI.new(name, instance)
    instance = AbilityCooldownType.new(name, instance)
    instance = AbilityInfoType.new(name, instance)
    instance = AbilityCastingType.new(name, instance)

    private.instances[instance] = name

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].name
end

--- Virtual function.
--- Return true if check is successfull.
---@param abil AbilityData
---@return boolean
function public:checkConditions(abil) end
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