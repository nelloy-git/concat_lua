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

local AbilityTarget = Class.new('AbilityTarget')
---@class AbilityTarget
local public = AbilityTarget.public
---@class AbilityTargetClass
local static = AbilityTarget.static
---@type AbilityTargetClass
local override = AbilityTarget.override
local private = {}

--=========
-- Static
--=========

---@param child AbilityTarget
---@return AbilityTarget
function override.new(child)
    if child then
        isTypeErr(child, AbilityTarget, 'child')
    else
        Log:err('Can not create instance of abstract class.', 2)
    end

    private.instances[child] = true

    return child
end

--========
-- Public
--========

--- Virtual function
---@return number
function public:getX()
    Log:err('Can not call virtual function.', 2)
end

--- Virtual function
---@return number
function public:getY()
    Log:err('Can not call virtual function.', 2)
end

---@param caster Unit
---@return number
function public:getDistance(caster)
    return ((caster:getX() - self:getX())^2 + (caster:getY() - self:getY())^2)^0.5
end

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