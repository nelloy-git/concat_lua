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
function override.new(child)
    if child then isTypeErr(child, AbilityExtType, 'child') end

    local instance = child or Class.allocate(AbilityExtType)
    private.newData(instance)    

    return instance
end

--========
-- Public
--========

---@param event AbilityExtEvent
---@param callback AbilityExtControllerCallback
function public:setCallback(event, callback)
end

---@return AbilityExtControllerCallback
function public:getCallback(event)
end

---@param name string | function(owner:Unit):string
function public:setName(name)
end

---@return string
function public:setIcon(value)
end

---@return string
function public:setTooltip(value)
end

---@return string
function public:setArea(value)
end

---@return string
function public:setRange(value)
end

---@return string
function public:setManaCost(value)
end

---@return string
function public:setCastingTime(value)
end

---@return string
function public:setChargesForUse(value)
end

---@return string
function public:setMaxCharges(value)
end

---@return string
function public:setChargeCooldown(value)
end

---@param owner Unit
function public:getName(owner)
    local name = private.data[self].name
    if type(name) == 'string' then
end

---@param owner Unit
function public:getIcon(owner)
end

---@param owner Unit
function public:getTooltip(owner)
end

---@return string
function public:setTargetingType(value)
end

---@param owner Unit
function public:getTargetingType(owner)
end

---@param owner Unit
function public:getArea(owner)
end

---@param owner Unit
function public:getRange(owner)
end

---@param owner Unit
function public:getManaCost(owner)
end

---@param owner Unit
function public:getCastingTime(owner)
end

---@param owner Unit
function public:getChargesForUse(owner)
end

---@param owner Unit
function public:getMaxCharges(owner)
end

---@param owner Unit
function public:getChargeCooldown(owner)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityExtType
function private.newData(self)
    local priv = {
        name = nil,
        icon = nil,
        tooltip = nil,
        targeting_type = nil,

        area = nil,
        range = nil,
        manacost = nil,
        casting_time = nil,
        charges_for_use = nil,
        charges_max = nil,
        charge_cooldown = nil
    }
    private.data[self] = priv
end

---@param self AbilityExtType
function private.returnPrivField(self, key, val_t)
    local val = private.data[self][key]
    if type(val) == val_t then
        return val_t
    elseif type(val) == 'function' then
        return 
end

return static