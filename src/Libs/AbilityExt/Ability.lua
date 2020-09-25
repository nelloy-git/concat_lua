--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Timer = HandleLib.Timer or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityExtControllerClass
local AbilityExtController = require(lib_path..'Controller') or error('')
local AbilityExtControllerPublic = Class.getPublic(AbilityExtController)
---@type AbilityExtDummyClass
local AbilityExtDummy = require(lib_path..'Dummy.Base') or error('')
local AbilityExtDummyPublic = Class.getPublic(AbilityExtDummy)
---@type AbilityExtEventModule
local AbilityExtEventModule = require(lib_path..'Event') or error('')
local Event = AbilityExtEventModule.Enum
---@type AbilityExtTypeClass
local AbilityExtType = require(lib_path..'Type') or error('')

--=======
-- Class
--=======

local AbilityExt = Class.new('AbilityExt', AbilityExtController, AbilityExtDummy)
-- Copy AbilityExtDummy methods because EmmyLua does not support multiple inheritance.
-- Some of methods are blocked
---@class AbilityExt : AbilityExtController, AbilityExtDummy
---@field getOwner fun(self:AbilityExt):Unit
---@field setTargetingType fun(self:AbilityExt, target_type:string)
---@field setArea fun(self:AbilityExt, area:number)
---@field setRange fun(self:AbilityExt, range:number)
---@field setOptions fun(self:AbilityExt, options:any)
---@field setName fun(self:AbilityExt, name:string)
---@field setTooltip fun(self:AbilityExt, tooltip:string)
---@field setIcon fun(self:AbilityExt, icon:string)
---@field setManaCost fun(self:AbilityExt, mana_cost:number)
---@field getManaCost fun(self:AbilityExt):number
---@field destroy fun(self:AbilityExt)
---@blocked setCooldownRemaining fun(self:AbilityExt, cooldown:number)
---@blocked getCooldownRemaining fun(self:AbilityExt):number
---@blocked setCooldown fun(self:AbilityExt, cooldown:number)
---@blocked setEffectAction fun(self:AbilityExt, callback:AbilityExtDummyCallback)
local public = AbilityExt.public
---@class AbilityExtClass : AbilityExtControllerClass, AbilityExtDummy
local static = AbilityExt.static
---@type AbilityExtClass
local override = AbilityExt.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param abil_type AbilityExtType
---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param child AbilityExt | nil
---@return AbilityExt
function override.new(owner, abil_type, hotkey, child)
    isTypeErr(owner, Unit, 'owner')
    isTypeErr(abil_type, AbilityExtType, 'abil_type')
    isTypeErr(hotkey, 'string', 'hotkey')
    if child then isTypeErr(child, AbilityExt, 'child') end

    local instance = child or Class.allocate(AbilityExt)
    instance = AbilityExtDummy.new(owner, hotkey, instance)
    instance = AbilityExtController.new(instance)

    private.newData(instance, abil_type)

    return instance
end



--========
-- Public
--========

---@param unit Unit
---@param x number
---@param y number
---@return boolean
function public:use(unit, x, y)
    local priv = private.data[self]

    priv.target_unit = unit
    priv.target_x = x
    priv.target_y = y

    local started = priv.abil_type:isStarted(self)
    if not started then
        local owner = self:getOwner()
        private.chargesChanged(self)
        local t = Timer.new()
        t:start(0, false, function()
            owner:setMana(owner:getMana() + self:getManaCost())
            t:destroy()
        end)
        return false
    end

    started = AbilityExtControllerPublic.use(self)
    if not started then
        local owner = self:getOwner()
        private.chargesChanged(self)
        local t = Timer.new()
        t:start(0, false, function()
            owner:setMana(owner:getMana() + self:getManaCost())
            t:destroy()
        end)
        return false
    end

    return true
end

---@return AbilityExtType
function public:getType()
    return private.data[self].abil_type
end

---@return Unit | nil
function public:getTargetUnit()
    return private.data[self].target_unit
end

---@return number
function public:getTargetPointX()
    return private.data[self].target_x
end

---@return number
function public:getTargetPointY()
    return private.data[self].target_y
end

function public:update()
    local abil_type = private.data[self].abil_type
    local owner = self:getOwner()

    self:setName(abil_type:getName(owner))
    self:setIcon(abil_type:getIcon(owner) or '')
    self:setTooltip(abil_type:getTooltip(owner))
    self:setTargetingType(abil_type:getTargetingType(owner))
    self:setArea(abil_type:getArea(owner))
    self:setRange(abil_type:getRange(owner))
    self:setManaCost(abil_type:getManaCost(owner))
    self:setCastingTime(abil_type:getCastingTime(owner))
    self:setChargesForUse(abil_type:getChargesForUse(owner))
    self:setMaxCharges(abil_type:getMaxCharges(owner))

    local cd = abil_type:getChargeCooldown(owner)
    self:setChargeCooldown(cd)
    AbilityExtDummyPublic.setCooldown(self, cd)
end

public.setCooldownRemaining = 0
public.getCooldownRemaining = 0
public.setCooldown = 0
public.setEffectAction = 0

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self AbilityExt
---@param abil_type AbilityExtType
function private.newData(self, abil_type)
    local priv = {
        target_unit = nil,
        target_x = 0,
        target_y = 0,

        abil_type = abil_type,
    }
    private.data[self] = priv

    self:addAction(Event.CHARGES_CHANGED, private.chargesChanged)
    AbilityExtDummyPublic.setEffectAction(self, private.dummyEffect)

    for _, event in pairs(Event) do
        local cb = abil_type:getCallback(event)
        if cb then self:addAction(event, cb) end
    end
    self:update()
end

---@param self AbilityExt
---@param _ AbilityExtEvent
function private.chargesChanged(self, _)
    local left = self:getCharges()

    if left <= 0 then
        AbilityExtDummyPublic.setCooldown(self, self:getChargeCooldown() + 0.1)
        AbilityExtDummyPublic.setCooldownRemaining(self, self:getChargeTimeLeft() + 0.1)
    else
        AbilityExtDummyPublic.setCooldown(self, 0)
        AbilityExtDummyPublic.setCooldownRemaining(self, 0)
    end
end

---@param self AbilityExt
function private.dummyEffect(self)
    local unit = Unit.getLinked(GetSpellTargetUnit())
    local x = GetSpellTargetX()
    local y = GetSpellTargetY()

    self:use(unit, x, y)
end

return static