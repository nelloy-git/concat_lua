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

---@type AbilityCastingType
local AbilityCastingType = require(lib_path..'.Casting.Type') or error('')
---@type AbilityInfoTypeClass
local AbilityInfoType = require(lib_path..'.Info.Type') or error('')
---@type AbilityCooldownTypeClass
local AbilityCooldownType = require(lib_path..'.Cooldown.Type') or error('')
--endregion

--=======
-- Class
--=======

local AbilityDataType = Class.new('AbilityDataType', AbilityCastingType,
                                                     AbilityInfoType,
                                                     AbilityCooldownType)
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
---@param child AbilityDataType | nil
---@return AbilityDataType
function override.new(name, child)
    isTypeErr(name, 'string', 'id')
    if child then isTypeErr(child, AbilityDataType, 'child') end

    if private.instances[name] then
        Log:err(tostring(AbilityDataType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child or Class.allocate(AbilityDataType)
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