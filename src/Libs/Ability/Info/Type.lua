--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local AbilityInfoType = Class.new('AbilityInfoType')
---@class AbilityInfoType
local public = AbilityInfoType.public
---@class AbilityInfoTypeClass
local static = AbilityInfoType.static
---@type AbilityInfoTypeClass
local override = AbilityInfoType.override
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

---@param name string
---@param child AbilityInfoType | nil
---@return AbilityInfoType
function override.new(name, child)
    if child then isTypeErr(child, AbilityInfoType, 'child') end

    if private.instances[name] then
        Log:err(tostring(AbilityInfoType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child or Class.allocate(AbilityInfoType)
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