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

---@param child AbilityExtType | nil
---@return AbilityExtType
function override.new(name, child)
    if child then isTypeErr(child, AbilityExtType, 'child') end

    local instance = child or Class.allocate(AbilityExtType)
    private.data[instance] = name

    return instance
end

--========
-- Public
--========

---@param owner Unit
---@return string
function public:getName(owner) end
private.virtual_functions['getName'] = public.getName

---@param owner Unit
---@return string
function public:getIcon(owner) end
private.virtual_functions['getIcon'] = public.getIcon

---@param owner Unit
---@return string
function public:getTooltip(owner) end
private.virtual_functions['getTooltip'] = public.getTooltip

---@param owner Unit
---@return string | "'None'" | "'Unit'" | "'Point'" | "'PointOrUnit'"
function public:getTargetingType(owner) end
private.virtual_functions['setTargetingType'] = public.setTargetingType

---@param owner Unit
---@return number
function public:getArea(owner) end
private.virtual_functions['getArea'] = public.getArea

---@param owner Unit
---@return number
function public:getRange(owner) end
private.virtual_functions['getRange'] = public.getRange

---@param owner Unit
---@return number
function public:getManaCost(owner) end
private.virtual_functions['getManaCost'] = public.getManaCost

---@param owner Unit
---@return number
function public:getCastingTime(owner) end
private.virtual_functions['getCastingTime'] = public.getCastingTime

---@param owner Unit
---@return number
function public:getChargesForUse(owner) end
private.virtual_functions['getChargesForUse'] = public.getChargesForUse

---@param owner Unit
---@return number
function public:getMaxCharges(owner) end
private.virtual_functions['getMaxCharges'] = public.getMaxCharges

---@param owner Unit
---@return number
function public:getChargeCooldown(owner) end
private.virtual_functions['getChargeCooldown'] = public.getChargeCooldown

---@param abil AbilityExt
---@return boolean
function public:isStarted(abil) end
private.virtual_functions['isStarted'] = public.isStarted

---@param event AbilityExtControllerCallback
---@return AbilityExtControllerCallback
function public:getCallback(event) end
private.virtual_functions['getCallback'] = public.getCallback

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

CompileFinal(function()
    for instance, name in pairs(private.data) do
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