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

local AbilityExtType = Class.new('AbilityExtType')
---@class AbilityExtType
local public = AbilityExtType.public
---@class AbilityExtTypeClass
local static = AbilityExtType.static
---@type AbilityExtTypeClass
local override = AbilityExtType.override
local private = {}
private.virtual_functions = {}

--========
-- Static
--========

---@param name string
---@param child AbilityExtType | nil
---@return AbilityExtType
function override.new(name, child)
    isTypeErr(name, 'string', 'id')
    if child then isTypeErr(child, AbilityExtType, 'child') end

    if private.instances[name] then
        Log:err(tostring(AbilityExtType)..' with name \"'..name..'\" already exists.', 2)
    end

    local instance = child or Class.allocate(AbilityExtType)

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