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
local Timer = UtilsLib.Handle.Timer
local Unit = UtilsLib.Handle.Unit

---@type AbilityDataTypeClass
local AbilityDataType = require(lib_modname..'.Data.Type')
--endregion

--=======
-- Class
--=======

local AbilityDataInstanceOld = Class.new('AbilityDataInstanceOld')
--region Class
---@class AbilityDataInstanceOld
local public = AbilityDataInstanceOld.public
---@class AbilityDataInstanceOldClass
local static = AbilityDataInstanceOld.static
---@type AbilityDataInstanceOldClass
local override = AbilityDataInstanceOld.override
local private = {}
--endregion

--=========
-- Static
--=========

---@alias AbilityDataInstanceOldRunError number

static.RunError = {}
---@type AbilityDataInstanceOldRunError
static.RunError.NoCharges = 1
---@type AbilityDataInstanceOldRunError
static.RunError.OutOfRange = 2
---@type AbilityDataInstanceOldRunError
static.RunError.NoMana = 3
---@type AbilityDataInstanceOldRunError
static.RunError.NoHealth = 4
---@type AbilityDataInstanceOldRunError
static.RunError.UserError = 5

---@param owner Unit
---@param ability_type AbilityDataType
---@param child_instance AbilityDataInstanceOld | nil
---@return AbilityDataInstanceOld
function override.new(owner, ability_type, lvl, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    checkTypeErr(ability_type, AbilityDataType, 'ability_type')
    if child_instance then
        checkTypeErr(child_instance, AbilityDataInstanceOld, 'child_instance')
    end

    local instance = child_instance or Class.allocate(AbilityDataInstanceOld)
    private.newData(instance, owner, ability_type, lvl)

    return instance
end

---@param caster Unit
---@return AbilityDataInstanceOld | nil
function static.getCastingAbilityDataInstanceOld(caster)
    return private.caster_list[caster]
end

---@return number
function static.getCooldownPeriod()
    return private.cooldown_period
end

---@return number
function static.getCastingPeriod()
    return private.casting_period
end

--========
-- Public
--========

---@param target AbilityTarget
---@param ignore_charges boolean | nil
---@param ignore_range boolean | nil
---@param ignore_manacost boolean | nil
---@param ignore_healthcost boolean | nil
---@param ignore_users_conditions boolean | nil
---@return AbilityDataInstanceOldRunError | nil
function public:use(target,
                    ignore_charges,
                    ignore_range,
                    ignore_manacost,
                    ignore_healthcost,
                    ignore_users_conditions)
    local priv = private.data[self]
    priv.cur_target = target

    ---@type AbilityDataType
    local abil_type = priv.ability_type

    if not ignore_charges then
        if abil_type:getChargesForUse(self) < priv.charges then
            print('No charges')
            return false
        end
    end

    if abil_type:getRange(self) < target:getDistance(priv.owner) then
        print('Out of range')
        return false
    end

    if abil_type:getManaCost(self) < priv.owner:getMana() then
        print('No mana')
        return false
    end

    if abil_type:getHealthCost(self) > priv.owner:getHealth() then
        print('No health')
        return false
    end

    if not abil_type:checkConditions(self) then
        print('User\'s conditions failed')
        return false
    end

    abil_type:onStart(self)
    priv.charges = priv.charges - priv.ability_type:getChargesForUse(self)
    priv.casting_end_time = private.casting_current_time + abil_type:getCastingTime(self)
    priv.cooldown_end_time = private.cooldown_current_time + abil_type:getChargeCooldown(self)
    private.caster_list[priv.owner] = self
    private.casting_list[self] = priv
    private.cooldown_list[self] = priv

    return true
end

function public:cancel()
    local priv = private.data[self]

    priv.ability_type:onCancel(self)
    private.casting_list[self] = nil
    private.caster_list[priv.owner] = nil
end

function public:interrupt()
    local priv = private.data[self]

    priv.ability_type:onInterrupt(self)
    private.casting_list[self] = nil
    private.caster_list[priv.owner] = nil
end

---@return number
function public:getLevel()
    return private.data[self].lvl
end

---@param lvl number
function public:setLevel(lvl)
    private.data[self].lvl = lvl
end

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@return AbilityTarget | nil
function public:getTarget()
    return private.data[self].cur_target
end

---@return AbilityDataType
function public:getType()
    return private.data[self].ability_type
end

---@return number
function public:getCastingTimeLeft()
    local t = private.data[self].casting_end_time - private.casting_current_time
    if t < 0 then t = 0 end
    return t
end

---@param casting_time number
function public:setCastingTime(casting_time)
    private.data[self].casting_end_time = private.casting_current_time + casting_time
end

---@return number
function public:getChargesLeft()
    return private.data[self].charges
end

---@param charges number
function public:setCharges(charges)
    private.data[self].charges = charges
end

---@return number
function public:getCooldownTimeLeft()
    local t = private.data[self].cooldown_end_time - private.cooldown_current_time
    if t < 0 then t = 0 end
    return t
end

---@param cooldown number
function public:setCooldownTime(cooldown)
    private.data[self].cooldown_end_time = private.cooldown_current_time + cooldown
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.caster_list = setmetatable({}, {__mode = 'kv'})
private.casting_list = setmetatable({}, {__mode = 'kv'})
private.cooldown_list = setmetatable({}, {__mode = 'kv'})

---@param self AbilityDataInstanceOld
---@param owner Unit
---@param lvl number
---@param ability_type AbilityDataType
function private.newData(self, owner, ability_type, lvl)
    local priv = {
        owner = owner,
        ability_type = ability_type,
        lvl = lvl,

        cur_target = nil,
        casting_end_time = 0,

        charges = 0,
        cooldown_end_time = 0,
    }
    private.data[self] = priv
end

private.casting_current_time = 0
private.casting_period = 0.05
function private.castingLoop()
    local cur_time = private.casting_current_time + private.casting_period
    private.casting_current_time = cur_time

    for abil, priv in pairs(private.casting_list) do
        ---@type AbilityDataType
        local abil_type = priv.ability_type

        if priv.casting_end_time <= cur_time then
            abil_type:onFinish(abil)
            private.casting_list[abil] = nil
            private.caster_list[priv.owner] = nil
            priv.cur_target = nil
        else
            abil_type:onCasting(abil)
        end
    end
end

private.cooldown_current_time = 0
private.cooldown_period = 0.05
function private.cooldownLoop()
    local cur_time = private.cooldown_current_time + private.cooldown_period
    private.cooldown_current_time = cur_time

    for abil, priv in pairs(private.cooldown_list) do
        ---@type AbilityDataType
        local abil_type = priv.ability_type

        -- Cancel cooldown if has max charges.
        if priv.charges >= abil_type:getMaxCharges(abil) then
            private.cooldown_list[abil] = nil
        end

        -- Add charge
        if priv.cooldown_end_time <= cur_time then
            priv.charges = priv.charges + 1
            priv.cooldown_end_time = priv.cooldown_end_time + abil_type:getChargeCooldown(abil)
        end
    end
end

if not IsCompiletime() then
    private.cooldown_timer = Timer.new()
    private.cooldown_timer:start(private.cooldown_period, true, private.cooldownLoop)

    private.casting_timer = Timer.new()
    private.casting_timer:start(private.casting_period, true, private.castingLoop)
end

return static