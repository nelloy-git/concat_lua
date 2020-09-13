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

local AbilityCooldownType = Class.new('AbilityCooldownType')
--region Class
---@class AbilityCooldownType
local public = AbilityCooldownType.public
---@class AbilityCooldownTypeClass
local static = AbilityCooldownType.static
---@type AbilityCooldownTypeClass
local override = AbilityCooldownType.override
local private = {}
private.virtual_functions = {}
--endregion

--========
-- Static
--========

---@param name string
---@param child AbilityCooldownType | nil
---@return AbilityCooldownType
function override.new(name, child)
    if child then isTypeErr(child, AbilityCooldownType, 'child') end

    if private.instances[name] then
        Log:err(tostring(AbilityCooldownType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child or Class.allocate(AbilityCooldownType)
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
function public:getChargesForUse(owner) end
private.virtual_functions['getChargesForUse'] = public.getChargesForUse

--- Virtual function
---@param owner Unit
---@return number
function public:getChargesMax(owner) end
private.virtual_functions['getChargesMax'] = public.getChargesMax

--- Virtual function
---@param owner Unit
---@return number
function public:getChargeCooldown(owner) end
private.virtual_functions['getChargeCooldown'] = public.getChargeCooldown

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