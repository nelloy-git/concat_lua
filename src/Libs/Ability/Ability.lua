--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Timer = UtilsLib.Timer

---@type AbilityTypeClass
local AbilityType = require(lib_modname..'.Type')

--=======
-- Class
--=======

local Ability = Class.new('Ability')
---@class Ability
local public = Ability.public
---@class AbilityClass
local static = Ability.static
---@type AbilityClass
local override = Ability.override
local private = {}

--=========
-- Static
--=========

---@param owner unit
---@param ability_type AbilityType
---@param lvl number
---@param child_instance Ability | nil
---@return Ability
function override.new(owner, ability_type, lvl, child_instance)
    checkType(owner, 'unit', 'owner')
    checkType(ability_type, AbilityType, 'ability_type')
    checkType(lvl, 'number', 'lvl')
    if child_instance then
        checkType(child_instance, Ability, 'child_instance')
    end

    local instance = child_instance or Class.allocate(Ability)
    private.newData(instance, owner, ability_type, lvl)

    return instance
end

---@param unit unit
---@return Ability | nil
function static.getCastingAbility(unit)
    return private.caster_list[unit]
end

--========
-- Public
--========

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

---@return unit
function public:getOwner()
    return private.data[self].owner
end

---@return AbilityTarget
function public:getTarget()
    return private.data[self].cur_target
end

---@return AbilityType
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

---@param target AbilityTarget
---@return boolean
function public:use(target)
    local priv = private.data[self]
    priv.cur_target = target
    ---@type AbilityType
    local abil_type = priv.ability_type

    if not abil_type:checkConditions(self) then
        return false
    end

    if abil_type:getChargesForUse(self) < priv.charges then
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

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.caster_list = setmetatable({}, {__mode = 'kv'})
private.casting_list = setmetatable({}, {__mode = 'kv'})
private.cooldown_list = setmetatable({}, {__mode = 'kv'})

---@param self Ability
---@param owner unit
---@param lvl number
---@param ability_type AbilityType
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
function private.castingLoop()
    local cur_time = private.casting_current_time + 0.05
    private.casting_current_time = cur_time

    for abil, priv in pairs(private.casting_list) do
        ---@type AbilityType
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
function private.cooldownLoop()
    local cur_time = private.cooldown_current_time + 0.05
    private.cooldown_current_time = cur_time

    for abil, priv in pairs(private.cooldown_list) do
        ---@type AbilityType
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
    private.cooldown_timer:start(0.05, true, private.cooldownLoop)

    private.casting_timer = Timer.new()
    private.casting_timer:start(0.05, true, private.castingLoop)
end

return static